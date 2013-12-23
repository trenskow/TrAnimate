//
//  TrCustomCurvedAnimation.m
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

#import "TrCustomCurvedAnimation.h"

#pragma mark - Build-in Curves -

#pragma mark kTrAnimationCurveLinear
TrCustomCurveBlock kTrAnimationCurveLinear = ^(CGFloat t) {
    return (CGFloat)t;
};

#pragma mark kTrAnimationCurveEaseInSine

TrCustomCurveBlock kTrAnimationCurveEaseInSine = ^(CGFloat t) {
    return (CGFloat)(-1.0f * cos(t * M_PI_2) + 1.0f);
};

#pragma mark kTrAnimationCurveEaseOutSine
TrCustomCurveBlock kTrAnimationCurveEaseOutSine = ^(CGFloat t) {
    return (CGFloat)sin(t * M_PI_2);
};

#pragma mark kTrAnimationCurveEaseInOutSine
TrCustomCurveBlock kTrAnimationCurveEaseInOutSine = ^(CGFloat t) {
    return (CGFloat)(-.5f * cos(M_PI*t) + .5f);
};

#pragma mark kTrAnimationCurveEaseInCubic
TrCustomCurveBlock kTrAnimationCurveEaseInCubic = ^(CGFloat t) {
    return t*t*t;
};

#pragma mark kTrAnimationCurveEaseOutCubic
TrCustomCurveBlock kTrAnimationCurveEaseOutCubic = ^(CGFloat t) {
    t = t - 1.0;
    return t*t*t + 1;
};

#pragma mark kTrAnimationCurveEaseOutBounce
TrCustomCurveBlock kTrAnimationCurveEaseOutBounce = ^(CGFloat t) {
    
    CGFloat r = 0.0;
    
    if (t < (1/2.75)) {
        r = 7.5625*t*t;
    } else if (t < (2/2.75)) {
        t -= 1.5 / 2.75;
        r = 7.5625*t*t + .75;
    } else if (t < (2.5/2.75)) {
        t -= 2.25 / 2.75;
        r = 7.5625*t*t + .9375;
    } else {
        t -= 2.625 / 2.75;
        r = 7.5625*t*t + .984375;
    }
    
    return r;
    
};

#pragma mark kTrAnimationCurveEaseInExpo
TrCustomCurveBlock kTrAnimationCurveEaseInExpo = ^(CGFloat t) {
    return (CGFloat)(t == 0 ? .0f : pow(2.0f, 10.0f * (t - 1.0f)));
};

#pragma mark kTrAnimationCurveEaseOutExpo
TrCustomCurveBlock kTrAnimationCurveEaseOutExpo = ^(CGFloat t) {
    return (CGFloat)(-pow(2.0f, -10.0f * t) + 1.0f);
};

#pragma mark kTrAnimationCurveEaseInBack
TrCustomCurveBlock kTrAnimationCurveEaseInBack = ^(CGFloat t) {
    return (CGFloat)(t*t*(2.70158*t - 1.70158));
};

#pragma mark kTrAnimationCurveEaseOutBack
TrCustomCurveBlock kTrAnimationCurveEaseOutBack = ^(CGFloat t) {
    
    t -= 1.0f;
    return (CGFloat)(t*t*((1.70158f+1)*t + 1.70158f) + 1);
    
};

#pragma mark kTrAnimationCurveEaseInOutBack
TrCustomCurveBlock kTrAnimationCurveEaseInOutBack = ^(CGFloat t) {
    
    CGFloat s = 1.70158f * 1.525f;
    t /= .5f;
    
    if (t < 1.0f)
        return (.5f*(t*t*(((s)+1)*t - s))); //.5f * (t * t * (s+1) * t - s);
    
    t -= 2;
    return .5f* ((t * t * ((s+1) * t + s) + 2));
    
};

#pragma mark kTrAnimationCurveEaseOutElastic
TrCustomCurveBlock kTrAnimationCurveEaseOutElastic = ^(CGFloat t) {
    
    CGFloat s = 1.70158f;
    CGFloat p = .0f;
    CGFloat a = 1.0f;
    if (t==0)
        return .0f;
    if (t==1)
        return 1.0f;
    if (!p)
        p=.3f;
    if (a < fabs(1.0f)) {
        a=1.0f;
        s=p/4;
    } else
        s = p/(2*M_PI) * asin(1.0f/a);
    return (CGFloat)(a*pow(2.0f,-10.0f*t) * sin((t-s)*(2*M_PI)/p) + 1.0f);
    
};

#pragma mark -

@interface TrCustomCurvedAnimation () {
    
    TrCustomCurveBlock _curve;
    
}

@end

@implementation TrCustomCurvedAnimation

#pragma mark - Creating an Animation

+ (id)animationWithKeyPath:(NSString *)path {
    
    TrCustomCurvedAnimation* animation = [super animationWithKeyPath:path];
    
    if (animation)
        animation.curve = kTrAnimationCurveLinear;
    
    return animation;
    
}

#pragma mark - Private Methods

- (void)applyInterpolationIfSetupComplete {
    
    if (self.curve && self.fromValue && self.toValue) {
        
        TrCustomCurveBlock curve = self.curve;
        id<TrValueTransition> fromValue = self.fromValue;
        id<TrValueTransition> toValue = self.toValue;
        
        self.interpolation = ^(CGFloat t) {
            return [fromValue transitionToValue:toValue withProgress:curve(t)];
        };
    
    } else
        self.interpolation = nil;
    
}

#pragma mark - Keyframe Timing

- (void)setCurve:(TrCustomCurveBlock)curve {
    
    [self willChangeValueForKey:@"curve"];
    _curve = [curve copy];
    [self didChangeValueForKey:@"curve"];
    
    [self applyInterpolationIfSetupComplete];
    
}

- (void)setFromValue:(id<TrValueTransition>)fromValue {
    
    [self willChangeValueForKey:@"fromValue"];
    _fromValue = fromValue;
    [self didChangeValueForKey:@"fromValue"];
    
    [self applyInterpolationIfSetupComplete];
    
}

- (void)setToValue:(id<TrValueTransition>)toValue {
    
    [self willChangeValueForKey:@"toValue"];
    _toValue = toValue;
    [self didChangeValueForKey:@"toValue"];
    
    [self applyInterpolationIfSetupComplete];
    
}

@end
