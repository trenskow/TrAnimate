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

#pragma mark TrCurveLinear
TrCurve const TrCurveLinear = ^(double t) {
    return t;
};

#pragma mark TrCurveEaseInQuad
TrCurve const TrCurveEaseInQuad = ^(double t) {
    return pow(t, 2.0);
};

#pragma mark TrCurveEaseOutQuad
TrCurve const TrCurveEaseOutQuad = ^(double t) {
    return -1.0 * t * (t - 2.0);
};

#pragma mark TrCurveEaseInOutQuad
TrCurve const TrCurveEaseInOutQuad = ^(double t) {
    t /= .5;
    if (t < 1.0) return .5*pow(t, 2.0);
    t -= 1.0;
    return -.5 * (t*(t - 2.0) - 1.0);
};

#pragma mark TrCurveEaseInCubic
TrCurve const TrCurveEaseInCubic = ^(double t) {
    return pow(t, 3.0);
};

#pragma mark TrCurveEaseOutCubic
TrCurve const TrCurveEaseOutCubic = ^(double t) {
    t = t - 1.0;
    return pow(t, 3.0) + 1;
};

#pragma mark TrCurveEaseInOutCubic
TrCurve const TrCurveEaseInOutCubic = ^(double t) {
    if (t < .5) return (TrCurveEaseInCubic(t * 2.0) / 2.0);
    return (TrCurveEaseOutCubic((t - .5) * 2.0) / 2.0 + .5);
};

#pragma mark TrCurveEaseInQuart
TrCurve const TrCurveEaseInQuart = ^(double t) {
    return pow(t, 4.0);
};

#pragma mark TrCurveEaseOutQuart
TrCurve const TrCurveEaseOutQuart = ^(double t) {
    t -= 1.0;
    return -1.0 * (pow(t, 4.0) - 1);
};

#pragma mark TrCurveEaseInOutQuart
TrCurve const TrCurveEaseInOutQuart = ^(double t) {
    t /= .5;
    if (t < 1.0) return .5 * pow(t, 4.0);
    t -= 2.0;
    return -.5 * (pow(t, 4.0) - 2.0);
};

#pragma mark TrCurveEaseInQuint
TrCurve const TrCurveEaseInQuint = ^(double t) {
    return pow(t, 5.0);
};

#pragma mark TrCurveEaseOutQuint
TrCurve const TrCurveEaseOutQuint = ^(double t) {
    t -= 1.0;
    return 1.0 * (pow(t, 5.0) + 1.0);
};

#pragma mark TrCurveEaseInOutQuint
TrCurve const TrCurveEaseInOutQuint = ^(double t) {
    t /= .5;
    if (t < 1) return .5*pow(t, 5.0);
    t -= 2.0;
    return .5 * (pow(t, 5.0) + 2.0);
};

#pragma mark TrCurveEaseInSine
TrCurve const TrCurveEaseInSine = ^(double t) {
    return (-1.0 * cos(t * M_PI_2) + 1.0);
};

#pragma mark TrCurveEaseOutSine
TrCurve const TrCurveEaseOutSine = ^(double t) {
    return sin(t * M_PI_2);
};

#pragma mark TrCurveEaseInOutSine
TrCurve const TrCurveEaseInOutSine = ^(double t) {
    return (-.5 * cos(M_PI*t) + .5);
};

#pragma mark TrCurveEaseInExpo
TrCurve const TrCurveEaseInExpo = ^(double t) {
    return (t == 0 ? .0 : pow(2.0, 10.0 * (t - 1.0)));
};

#pragma mark TrCurveEaseOutExpo
TrCurve const TrCurveEaseOutExpo = ^(double t) {
    return -pow(2.0, -10.0 * t) + 1.0;
};

#pragma mark TrCurveEaseInOutExpo
TrCurve const TrCurveEaseInOutExpo = ^(double t) {
    if (t == .0) return .0;
    if (t == 1.0) return 1.0;
    t /= .5;
    if (t < 1) return .5 * pow(2, 10 * (t - 1));
    return .5 * (-pow(2, -10 * --t) + 2);
};

#pragma mark TrCurveEaseInCirc
TrCurve const TrCurveEaseInCirc = ^(double t) {
    return -1.0 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
};

#pragma mark TrCurveEaseOutCirc
TrCurve const TrCurveEaseOutCirc = ^(double t) {
    return sqrt(1.0 - pow(t-1.0, 2));
};

#pragma mark TrCurveEaseInOutCirc
TrCurve const TrCurveEaseInOutCirc = ^(double t) {
    t /= .5;
    if (t < 1.0) return -.5 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
    return .5 * (sqrt(1.0 - pow(t - 2.0, 2.0)) + 1.0);
};

#pragma mark TrCurveEaseInElastic
TrCurve const TrCurveEaseInElastic = ^(double t) {
    
    double s = 1.70158;
    double p = .0;
    double a = 1.0;
    
    if (t == 0.0)
        return .0;
    if (t == 1.0)
        return 1.0;
    if (!p)
        p = .3;
    if (a < 1.0) {
        a = 1.0;
        s=p / 4.0;
    } else
        s = p / (2.0 * M_PI) * asin(1.0/a);
    
    t -= 1.0;
    
    return -(a * pow(2.0, 10.0 * t) * sin((t - s) * (2.0 * M_PI) / p));
    
};

#pragma mark TrCurveEaseOutElastic
TrCurve const TrCurveEaseOutElastic = ^(double t) {
    
    double s = 1.70158;
    double p = .0;
    double a = 1.0;
    if (t==0)
        return .0;
    if (t==1)
        return 1.0;
    if (!p)
        p=.3;
    if (a < 1.0) {
        a=1.0;
        s=p/4;
    } else
        s = p / (2.0 * M_PI) * asin(1.0 / a);
    return a * pow(2.0, -10.0 * t) * sin((t - s) * (2 * M_PI) / p) + 1.0;
    
};

#pragma mark TrCurveEaseInOutElastic
TrCurve const TrCurveEaseInOutElastic = ^(double t) {
    double s = 1.70158;
    double p = 0;
    double a = 1.0;
    if (t == 0.0)
        return .0;
    t /= .5;
    if (t == 2.0)
        return 1.0;
    if (!p)
        p = (.3 * 1.5);
    
    if (a < 1.0) {
        a = 1.0;
        s = p / 4.0;
    }
    else
        s = p / (2.0 * M_PI) * asin (1.0 / a);
    if (t < 1) {
        t -= 1.0;
        return -.5 * (a * pow(2.0,10.0 * t) * sin((t - s) * (2.0 * M_PI) / p));
    }
    t -= 1.0;
    return a * pow(2.0, -10.0 * t) * sin((t - s) * (2.0 * M_PI) / p) *.5 + 1.0;
};

#pragma mark TrCurveEaseInBack
TrCurve const TrCurveEaseInBack = ^(double t) {
    return t*t*(2.70158*t - 1.70158);
};

#pragma mark TrCurveEaseOutBack
TrCurve const TrCurveEaseOutBack = ^(double t) {
    t -= 1.0;
    return t*t*((1.70158f+1)*t + 1.70158f) + 1;
    
};

#pragma mark TrCurveEaseInOutBack
TrCurve const TrCurveEaseInOutBack = ^(double t) {
    
    double s = 1.70158f * 1.525f;
    t /= .5;
    
    if (t < 1.0)
        return (.5*(t*t*(((s)+1)*t - s)));
    
    t -= 2;
    return .5* ((t * t * ((s+1) * t + s) + 2));
    
};

#pragma mark TrCurveEaseInBounce
TrCurve const TrCurveEaseInBounce = ^(double t) {
    return 1.0 - TrCurveEaseOutBounce(1.0 - t);
};

#pragma mark TrCurveEaseOutBounce
TrCurve const TrCurveEaseOutBounce = ^(double t) {
    
    double r = 0.0;
    
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

#pragma mark TrCurveEaseInOutBounce
TrCurve const TrCurveEaseInOutBounce = ^(double t) {
    if (t < .5) return TrCurveEaseInBounce(t * 2.0) * .5;
    return TrCurveEaseOutBounce(t * 2.0 - 1.0) * .5 + .5;
};

#pragma mark -

@interface TrCustomCurvedAnimation () {
    
    TrCurve _curve;
    
}

@end

@implementation TrCustomCurvedAnimation

#pragma mark - Creating an Animation

+ (instancetype)animationWithKeyPath:(NSString *)path {
    
    TrCustomCurvedAnimation* animation = [super animationWithKeyPath:path];
    
    if (animation)
        animation.curve = TrCurveLinear;
    
    return animation;
    
}

#pragma mark - Private Methods

- (void)applyInterpolationIfSetupComplete {
    
    if (self.curve && self.fromValue && self.toValue) {
        
        TrCurve curve = self.curve;
        id<TrValueTransition> fromValue = self.fromValue;
        id<TrValueTransition> toValue = self.toValue;
        
        self.interpolation = ^(double t) {
            return [fromValue transitionToValue:toValue withProgress:curve(t)];
        };
    
    } else
        self.interpolation = nil;
    
}

#pragma mark - Keyframe Timing

- (void)setCurve:(TrCurve)curve {
    
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
