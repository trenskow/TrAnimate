//
//  TrFadeOutAnimation.m
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

#import <QuartzCore/QuartzCore.h>

#import "TrAnimationSubclass.h"
#import "TrFadeAnimation.h"

@interface TrFadeAnimation () {
    
    TrCustomCurveBlock _curve;
    CGFloat _startValue;
    CGFloat _endValue;
    
}

@end

@implementation TrFadeAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    CGFloat endValue = (_endValue - _startValue) * _curve(1.0f) + _startValue;
    
    self.layer.hidden = NO;
    self.layer.opacity = endValue;
    
}

- (void)animationCompleted:(BOOL)finished {
    
    [super animationCompleted:finished];
    
    if (!(self.options & kTrAnimationOptionReversed))
        self.layer.hidden = YES;
    
}

- (void)setupAnimations {
    
    _startValue = 1.0;
    _endValue = 0.0;
    
    if (self.options & kTrAnimationOptionReversed) {
        _startValue = 0.0;
        _endValue = 1.0;
    }
    
    TrCustomCurvedAnimation *fadeAnimation = [TrCustomCurvedAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.curve = _curve;
    fadeAnimation.fromValue = @(_startValue);
    fadeAnimation.toValue = @(_endValue);
    
    self.layer.opacity = (_endValue - _startValue) * _curve(0.0f) + _startValue;
    
    [self prepareAnimation:fadeAnimation usingKey:@"fadeAnimation"];
    
    [self.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOnView:(UIView *)view {
    
    return ([view.layer animationForKey:@"fadeAnimation"] != nil);
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve fadesIn:(BOOL)fadesIn completion:(void (^)(BOOL))completion {
    
    TrFadeAnimation *animation = [self animate:viewOrLayer
                                      duration:duration
                                         delay:delay
                                       options:(fadesIn ? kTrAnimationOptionReversed : 0)
                                    completion:completion];
    
    if (animation)
        animation->_curve = curve;
    
    return animation;
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay fadesIn:(BOOL)fadesIn completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                   curve:kTrAnimationCurveLinear
                 fadesIn:fadesIn
              completion:completion];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay fadesIn:(BOOL)fadesIn {
    
    return [self animate:viewOrLayer duration:duration delay:delay fadesIn:fadesIn completion:nil];
    
}

@end
