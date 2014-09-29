//
//  UIColor+TrAnimateAdditions.m
//  TrAnimate
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//  this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

#import "UIColor+TrAnimateAdditions.h"

@implementation UIColor (TrAnimateAdditions)

#pragma mark - Interpolation

- (id<TrInterpolatable>)interpolateWithValue:(id<TrInterpolatable>)value atPosition:(double)position {
    
    if (![(id)value isKindOfClass:[UIColor class]])
        [NSException raise:@"InvalidInterpolatableTypeException" format:@"UIColor instances can only interpolate with other instances of UIColor."];
    
    UIColor *val1 = self;
    UIColor *val2 = (UIColor *)value;
    
    CGFloat red1, red2, green1, green2, blue1, blue2, alpha1, alpha2;
    
    [val1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    [val2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    return [UIColor colorWithRed:(red2 - red1) * position + red1
                           green:(green2 - green1) * position + green1
                            blue:(blue2 - blue1) * position + blue1
                           alpha:(alpha2 - alpha1) * position + alpha1];
    
}

@end
