//
//  TrBasicAnimation.m
//  TrAnimate
//
//  Copyright (c) 2013-2014, Kristian Trenskow
//  All rights reserved.
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

#import "TrInterpolation.h"
#import "TrCurve.h"

#import "TrBasicAnimation.h"

@implementation TrBasicAnimation

#pragma mark - Private Methods

- (void)applyInterpolationIfSetupComplete {
    
    if (self.duration && self.fromValue && self.toValue) {
        
        TrCurve *useCurve = (self.curve ?: [TrCurve linear]);
        TrInterpolation *useInterpolation = (self.interpolation ?: [TrInterpolation new]);
        
        NSMutableArray *keyTimes = [[NSMutableArray alloc] init];
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (NSTimeInterval t = .0 ; t <= 1.0 ; t += 1.0 / (60.0 * (self.duration / self.speed))) {
            
            [keyTimes addObject:@(t)];
            [values addObject:[useInterpolation interpolateFromValue:self.fromValue
                                                             toValue:self.toValue
                                                          atPosition:[useCurve transform:t]]];
            
        }
        
        self.keyTimes = keyTimes;
        self.values = values;
        
    } else
        self.keyTimes = self.values = nil;
    
}

#pragma mark - Keyframe Timing

- (void)setSpeed:(float)speed {
    
    [super setSpeed:speed];
    
    [self applyInterpolationIfSetupComplete];
    
}

- (void)setDuration:(CFTimeInterval)duration {
    
    [super setDuration:duration];
    
    [self applyInterpolationIfSetupComplete];
    
}


- (void)setFromValue:(id<TrInterpolatable>)fromValue {
    
    _fromValue = fromValue;
    
    [self applyInterpolationIfSetupComplete];
    
}

- (void)setToValue:(id<TrInterpolatable>)toValue {
    
    _toValue = toValue;
    
    [self applyInterpolationIfSetupComplete];
    
}

- (void)setInterpolation:(TrInterpolation *)interpolation {
    
    _interpolation = interpolation;
    
    [self applyInterpolationIfSetupComplete];
    
}

@end
