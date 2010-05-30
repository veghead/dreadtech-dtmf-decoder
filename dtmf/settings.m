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

#import "settings.h"


@implementation settings
@synthesize masterController, switchState;


- (void)setup {
	NSLog(@"erewego");
	powerMethods = [[NSArray arrayWithObjects:@"Peak Value RMS", @"Sqrt Sum Squares", @"Sum Abs", nil] retain];
}

- (void)drawRect:(CGRect)rect {
	[self setSwitchState:1];
}


- (void)dealloc {
	[powerMethods release];
	[super dealloc];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	return [powerMethods count];
}



- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [powerMethods objectAtIndex:row];
}



- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component
{
	
}


- (IBAction) flipBack
{
	NSLog(@"flipBack");
	[(dtmfdecodeViewController *) masterController setNoiseLevel:[backgroundLevel value]];
	[(dtmfdecodeViewController *) masterController flipBack];
}


- (void) setPowerMethod:(NSInteger)method
{
}


- (void) setNoiseLevel:(NSInteger)level
{
}


@end
