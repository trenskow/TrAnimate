//
//  NSNumber+TrCustomCurvedAnimationAdditions.m
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

#import "NSNumber+TrAnimateAdditions.h"

@interface NSNumber (TrAnimatePrivateAdditions)

@property (nonatomic,readonly) BOOL isKindOfFloat;

@end

@implementation NSNumber (TrAnimateAdditions)

#pragma mark - Private Properties

- (BOOL)isKindOfFloat {
    
    const char* valType = [self objCType];
    return (0 == strcmp(valType, @encode(float)) || 0 == strcmp(valType, @encode(double)));
    
}

#pragma mark - Transitioning

- (id<TrInterpolatable>)interpolateWithValue:(id<TrInterpolatable>)value atPosition:(double)position {
    
    id val = value;
    
    NSAssert([val isKindOfClass:[NSNumber class]], @"NSNumber cannot interpolate to value of class %@", NSStringFromClass([NSNumber class]));
    
    if (self.isKindOfFloat && ((NSNumber *)val).isKindOfFloat) {
        
        double val1 = [self doubleValue];
        double val2 = [val doubleValue];
        
        return @(((val2 - val1) * position) + val1);
        
    }
    
    NSAssert(NO, @"NSValue only support float and doubles.");
    return nil;
    
}

@end
