//
//  DTMFDecoder.m
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DTMFDecoder.h"

/**
 * @brief Callback for audio handling.
 */
static void recCallback (void *aqData,
						 AudioQueueRef inAQ,
						 AudioQueueBufferRef inBuffer,
						 const AudioTimeStamp *inStartTime,
						 UInt32 inNumPackets,
						 const AudioStreamPacketDescription  *inPacketDesc) {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	{
		SInt16 *data = inBuffer->mAudioData;
		DTMFDecoder *decoder = aqData;
		for(int i=0; i<inNumPackets; i++) {
			if ([decoder running]) {
				[decoder goertzel:data[i]];
			}
		}
		
		// "plot" points for waveform and fft spectrum
		AudioQueueEnqueueBuffer(inAQ,inBuffer,0,NULL);
	}
	[pool release];
}



@implementation DTMFDecoder

@synthesize currentFreqs, detectBuffer, running;

-(id) init
{
	[super init];
	[self setCurrentFreqs:nil];
	AudioQueueBufferRef qref[10];
	currentFreqs = nil;
	detectBuffer = (char *)calloc(1,DETECTBUFFERLEN);
		
	// these statements define the audio stream basic description
	// for the file to record into.
	audioFormat.mSampleRate			= SAMPLING_RATE;
	audioFormat.mFormatID			= kAudioFormatLinearPCM;
	audioFormat.mFormatFlags		= kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
	audioFormat.mFramesPerPacket	= 1;
	audioFormat.mChannelsPerFrame	= 1;
	audioFormat.mBitsPerChannel		= 16;
	audioFormat.mBytesPerPacket		= 2;
	audioFormat.mBytesPerFrame		= 2;
	AudioQueueRef queueObject;
	
	// Create the new audio queue
	AudioQueueNewInput (&audioFormat,
						recCallback,
						self, // User Data
						NULL,
						NULL,
						0, // Reserved
						&queueObject
						);
	
	// Get the *actual* recording format back from the queue's audio converter.
	// We may not have been given what we asked for.
	UInt32 fsize = sizeof(audioFormat);
	
	AudioQueueGetProperty(queueObject,
						  kAudioQueueProperty_StreamDescription,	// this constant is only available in iPhone OS
						  &audioFormat,
						  &fsize
						  );
	
	if (audioFormat.mSampleRate != SAMPLING_RATE) {
		NSLog(@"Wrong sample rate !");
	}
	
	for (int i = 0; i < 6; ++i) {
		//Allocate buffer. Size is in bytes.
		AudioQueueAllocateBuffer(queueObject, 4096, &qref[i]);
		AudioQueueEnqueueBuffer(queueObject, qref[i] , 0, NULL);			
	}

	last = ' ';
	[self resetBuffer];
	
	AudioQueueStart(queueObject,NULL);
	NSLog(@"started queue");
	running = YES;
	return self;
	// Animation timer	
}


/**
 * @brief calculate the correct co-efficients.
 */
- (void) calc_coeffs
{
	int n;
	char z[1024];
	for(n = 0; n < MAX_BINS; n++) {
		coefs[n] = 2.0 * cos(2.0 * 3.141592654 * currentFreqs[n] / SAMPLING_RATE);
		snprintf(z,sizeof(z),"%lf %d coefs", coefs[n],n);
		NSLog([[NSString alloc] initWithCString: z]);
	}
}


- (void) setDTMF:(int)freqset
{
	[self setRunning: NO];
	if (currentFreqs) {
		free(currentFreqs);
	}
	double *dtfreq = calloc(MAX_BINS,sizeof(double));
	double freqs[] = 	{
		697,
		770,
		852,
		941,
		1209,
		1336,
		1477,
		1633
	};
	memcpy(dtfreq,freqs,MAX_BINS * sizeof(double));
	double *oldfreqs = currentFreqs;
	if (oldfreqs) free(oldfreqs);
	[self setCurrentFreqs:dtfreq];
	[self calc_coeffs];
	[self resetBuffer];
	[self setRunning:YES];
}


/**
  *
  *
  */
- (bool) post_testing
{
	int         row, col, see_digit;
	int         peak_count, max_index;
	double      maxval, t;
	int         i;
	char *  row_col_ascii_codes[4][4] = {
		{"1", "2", "3", "A"},
		{"4", "5", "6", "B"},
		{"7", "8", "9", "C"},
		{"*", "0", "#", "D"}};

	if (![self running] ) return false;
	
	// Find the largest in the row group.
	row = 0;
	maxval = 0.0;
	for ( i=0; i<4; i++ ) {
		if ( r[i] > maxval ) {
			maxval = r[i];
			row = i;
		}
	}


	// Find the largest in the column group.
	col = 4;
	maxval = 0.0;
	for ( i=4; i<8; i++ ) {
		if ( r[i] > maxval ) {
			maxval = r[i];
			col = i;
		}
	}

	
	/* Check for minimum energy */
	
	if ( r[row] < 4.0e5 )  {
		//NSLog(@"row Low");
		/* energy not high enough */
	} else if ( r[col] < 4.0e5 ) {
		//NSLog(@"Col low");
		/* energy not high enough */
	} else {
		see_digit = TRUE;
		
		/* Twist check
		 * CEPT => twist < 6dB
		 * AT&T => forward twist < 4dB and reverse twist < 8dB
		 *  -ndB < 10 log10( v1 / v2 ), where v1 < v2
		 *  -4dB < 10 log10( v1 / v2 )
		 *  -0.4  < log10( v1 / v2 )
		 *  0.398 < v1 / v2
		 *  0.398 * v2 < v1
		 */
		if ( r[col] > r[row] ) {
			// Normal twist
			max_index = col;
			if ( r[row] < (r[col] * 0.398) )  {  /* twist > 4dB, error */
				see_digit = FALSE;
				//NSLog(@"col twist");
			}
		} else { 
		    // if ( r[row] > r[col] ) 
			// Reverse twist 
			max_index = row;
			if ( r[col] < (r[row] * 0.158) ) {   /* twist > 8db, error */
				see_digit = FALSE;
				//NSLog(@"row twist");
			}
		}
		
		// Signal to noise test
		// AT&T states that the noise must be 16dB down from the signal.
		// Here we count the number of signals above the threshold and
		// there ought to be only two.
		//
		if ( r[max_index] > 1.0e9 ) {
			t = r[max_index] * 0.158;
		} else {
			t = r[max_index] * 0.010;
		}
		peak_count = 0;
		for ( i=0; i<8; i++ ) {
			if ( r[i] > t )
				peak_count++;
		}
		if ( peak_count > 2 ) {
			see_digit = FALSE;
		}

		if ( see_digit ) {
			if (last != *row_col_ascii_codes[row][col-4]) {
				if ((DETECTBUFFERLEN - strlen(detectBuffer) > 5) && (' ' != *row_col_ascii_codes[row][col-4])) { 
					strncat(detectBuffer,row_col_ascii_codes[row][col-4],DETECTBUFFERLEN);
				}
				last = *row_col_ascii_codes[row][col-4];
			}
			//NSLog([[NSString alloc] initWithCString: row_col_ascii_codes[row][col-4]]);
			return true;
		} else {
			last = ' ';
			//NSLog(@"Nothing");
		}
	}
	return false;
}


/**
  *  goertzel
  */
- (bool) goertzel:(short)sample
{
	double      q0;
	UInt32       i;
	sample_count++;
	bool ret = false;
	
	if (![self running]) return false;
	/*q1[0] = q2[0] = 0;*/
	for ( i=0; i<MAX_BINS; i++ ) {
		q0 = coefs[i] * q1[i] - q2[i] + sample;
		q2[i] = q1[i];
		q1[i] = q0;
	}
	
	if (sample_count == GOERTZEL_N) {
		for ( i=0; i<MAX_BINS; i++ ) {
			r[i] = (q1[i] * q1[i]) + (q2[i] * q2[i]) - (coefs[i] * q1[i] * q2[i]);
			q1[i] = 0.0;
			q2[i] = 0.0;
		}
		ret = [self post_testing];
		sample_count = 0;
	}
	return ret;
}


- (void) resetBuffer
{
	if ([self running]) {
		[self setRunning: NO];
		memset(detectBuffer, '\0', sizeof(detectBuffer));
		last = ' ';
		[self setRunning: YES];
	}
}

@end
