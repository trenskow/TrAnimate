//
//  TrPopInAnimation.m
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

#import "TrAnimatable.h"

#import "TrCurve.h"
#import "TrScaleAnimation.h"
#import "TrFadeAnimation.h"

#import "TrPopInAnimation.h"

@implementation TrPopInAnimation

#pragma mark - Creating Animation

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic
             completion:(void (^)(BOOL))completion {
    
    TrCurve *curve = (elastic ? [TrCurve easeOutElastic] : [TrCurve easeOutBack]);
    
    TrScaleAnimation *scaleAnimation = [TrScaleAnimation animate:viewOrLayer
                                                        duration:duration
                                                           delay:delay
                                                 fromScaleFactor:0.01
                                                   toScaleFactor:1.0
                                                           curve:curve];
    
    TrOpacityAnimation *opacityAnimation = [TrFadeAnimation animate:viewOrLayer
                                                           duration:duration * (elastic ? .1 : .3)
                                                              delay:delay
                                                        fromOpacity:.0
                                                          toOpacity:1.0];
    
    return [self animationGroupWithAnimations:@[scaleAnimation, opacityAnimation]
                                   completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 elastic:elastic
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 elastic:NO
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:.0
                 elastic:NO
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer {
    
    return [self animate:viewOrLayer
                duration:.2
                   delay:.0
                 elastic:NO
              completion:nil];
    
}

@end
