//
//  TrCustomInterpolationAnimation.m
//  TrAnimate
//
//  Copyright (c) 2013, Kristian Trenskow All rights reserved.
//
//  Redistribution and use in source and binary forms, with or
//  without modification, are permitted provided that the following
//  conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following
//  disclaimer in the documentation and/or other materials provided
//  with the distribution. THIS SOFTWARE IS PROVIDED BY THE
//  COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
//  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "TrCustomInterpolationAnimation.h"

@implementation TrCustomInterpolationAnimation

#pragma mark - Private Methods

- (void)applyKeyTimesAndValuesIfSetupIsComplete {
    
    if (self.interpolation && self.duration) {
        
        NSTimeInterval duration = self.duration;
        float speed = self.speed;
        
        NSMutableArray *keyTimes = [[NSMutableArray alloc] init];
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (NSTimeInterval t = .0f ; t <= 1.0f ; t += 1.0f / (50.0f * (duration / speed))) {
            
            [keyTimes addObject:@(t)];
            [values addObject:self.interpolation(t)];
            
        }
        
        self.keyTimes = keyTimes;
        self.values = values;
        
    }
    
}

#pragma mark - Keyframe Timing

- (void)setDuration:(CFTimeInterval)duration {
    
    [super setDuration:duration];
    
    [self applyKeyTimesAndValuesIfSetupIsComplete];
    
}

- (void)setInterpolation:(TrCustomInterpolationBlock)interpolation {
    
    [self willChangeValueForKey:@"interpolation"];
    _interpolation = interpolation;
    [self didChangeValueForKey:@"interpolation"];
    
    [self applyKeyTimesAndValuesIfSetupIsComplete];
    
}

@end
