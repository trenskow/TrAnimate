//
//  NSNumber+TrCustomCurvedAnimationAdditions.m
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

#import "NSNumber+TrCustomCurvedAnimationAdditions.h"

@implementation NSNumber (TrCustomCurvedAnimationAdditions)

#pragma mark - Transitioning

- (id)transitionToValue:(id)val withProgress:(CGFloat)p {
    
    NSAssert([val isKindOfClass:[NSNumber class]], @"NSNumber cannot transition to value of class %@", NSStringFromClass([NSNumber class]));
    const char* valType = [val objCType];
    NSAssert(0 == strcmp(valType, [self objCType]), @"NSNumber of Obj-C type %s cannot transition to NSValue of Ojb-C type %s", [self objCType], valType);
    
    if (0 == strcmp(valType, @encode(CGFloat))) {
        
        CGFloat val1 = [self doubleValue];
        CGFloat val2 = [val doubleValue];
        
        return [NSNumber numberWithDouble:((val2 - val1) * p) + val1];
        
    }
    
    NSAssert(YES, @"NSValue cannot transition values of type %s", valType);
    return nil;
    
}

@end
