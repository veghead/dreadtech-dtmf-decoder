/*
 $Id$
 Dreadtech DTMF Decoder - Copyright 2009 Martin Wellard
 
 This file is part of Dreadtech DTMF Decoder.
 
 Dreadtech DTMF Decoder is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 Dreadtech DTMF Decoder is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with Dreadtech DTMF Decoder.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioFile.h>

#define SAMPLING_RATE       8000
#define MAX_BINS            8
#define GOERTZEL_N          93
#define DETECTBUFFERLEN		8192
#define DEBOUNCELEN			2
#define GAPLEN				2

/* From Wikipedia:
 * coef = 2.0 * cos( (2.0 * PI * k) / (float)GOERTZEL_N)) ;
 * Where k = (int) (0.5 + ((float)GOERTZEL_N * target_freq) / SAMPLING_RATE));
 * 
 * More simply: coef = 2.0 * cos( (2.0 * PI * target_freq) / SAMPLING_RATE );
 */

@interface DTMFDecoder : NSObject {	
	AudioStreamBasicDescription audioFormat;
	int         sample_count;
	double      q1[ MAX_BINS ];
	double      q2[ MAX_BINS ];
	double      freqpower[ MAX_BINS ];
	double      coefs[ MAX_BINS ] ;
	double		*currentFreqs;
	int			lastcount;
	int			gaplen;
	char		last;
	int			ledbin;
	char		*detectBuffer;
	bool		running;
}

@property (assign) int lastcount;
@property (assign) double *currentFreqs;
@property (assign) char *detectBuffer;
@property (assign) int ledbin;
@property (readwrite) bool running;

- (id) init;
- (void) calc_coeffs;
- (bool) goertzel:(short)sample;
- (void) setDTMF:(int)freqset;
- (void) resetBuffer;
- (bool) post_testing;
@end
