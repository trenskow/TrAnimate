//
//  TrCurve.m
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

// Convinience macro for returning a singleton in build-in the curve class methods.
#define RETURN_SINGLETON(b) \
    static TrCurve *curve; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        curve = [TrCurve curveWithBlock:b]; \
    }); \
    return curve

#import "TrCurve.h"

@interface TrCurve () {
    
    double (^_block)(double t);
    
}

- (instancetype)initWithBlock:(double (^)(double t))block;

@end

@implementation TrCurve

#pragma mark - Build-in Curves

+ (TrCurve *)linear {
    RETURN_SINGLETON(^(double t) {
        return t;
    });
}

+ (TrCurve *)easeInQuad {
    RETURN_SINGLETON(^(double t) {
        return pow(t, 2.0);
    });
}

+ (TrCurve *)easeOutQuad {
    RETURN_SINGLETON(^(double t) {
        return -1.0 * t * (t - 2.0);
    });
}

+ (TrCurve *)easeInOutQuad {
    RETURN_SINGLETON(^(double t) {
        t /= .5;
        if (t < 1.0) return .5 * pow(t, 2.0);
        t -= 1.0;
        return -.5 * (t*(t - 2.0) - 1.0);
    });
}

+ (TrCurve *)easeInCubic {
    RETURN_SINGLETON(^(double t) {
        return pow(t, 3.0);
    });
}

+ (TrCurve *)easeOutCubic {
    RETURN_SINGLETON(^(double t) {
        t = t - 1.0;
        return pow(t, 3.0) + 1;
    });
}

+ (TrCurve *)easeInOutCubic {
    
    TrCurve *easeInCubic = [self easeInCubic];
    TrCurve *easeOutCubic = [self easeOutCubic];
    
    RETURN_SINGLETON(^(double t) {
        if (t < .5) return [easeInCubic transform:t * 2.0] / 2.0;
        return [easeOutCubic transform:(t - .5) * 2.0] / 2.0 + .5;
    });
    
}

+ (TrCurve *)easeInQuart {
    RETURN_SINGLETON(^(double t) {
        return pow(t, 4.0);
    });
}

+ (TrCurve *)easeOutQuart {
    RETURN_SINGLETON(^(double t) {
        t -= 1.0;
        return -1.0 * (pow(t, 4.0) - 1);
    });
}

+ (TrCurve *)easeInOutQuart {
    RETURN_SINGLETON(^(double t) {
        t /= .5;
        if (t < 1.0) return .5 * pow(t, 4.0);
        t -= 2.0;
        return -.5 * (pow(t, 4.0) - 2.0);
    });
}

+ (TrCurve *)easeInQuint {
    RETURN_SINGLETON(^(double t) {
        return pow(t, 5.0);
    });
}

+ (TrCurve *)easeOutQuint {
    RETURN_SINGLETON(^(double t) {
        t -= 1.0;
        return 1.0 * (pow(t, 5.0) + 1.0);
    });
}

+ (TrCurve *)easeInOutQuint {
    RETURN_SINGLETON(^(double t) {
        t /= .5;
        if (t < 1) return .5*pow(t, 5.0);
        t -= 2.0;
        return .5 * (pow(t, 5.0) + 2.0);
    });
}

+ (TrCurve *)easeInSine {
    RETURN_SINGLETON(^(double t) {
        return (-1.0 * cos(t * M_PI_2) + 1.0);
    });
}

+ (TrCurve *)easeOutSine {
    RETURN_SINGLETON(^(double t) {
        return sin(t * M_PI_2);
    });
}

+ (TrCurve *)easeInOutSine {
    RETURN_SINGLETON(^(double t) {
        return (-.5 * cos(M_PI*t) + .5);
    });
}

+ (TrCurve *)easeInExpo {
    RETURN_SINGLETON(^(double t) {
        return (t == 0 ? .0 : pow(2.0, 10.0 * (t - 1.0)));
    });
}

+ (TrCurve *)easeOutExpo {
    RETURN_SINGLETON(^(double t) {
        return -pow(2.0, -10.0 * t) + 1.0;
    });
}

+ (TrCurve *)easeInOutExpo {
    RETURN_SINGLETON(^(double t) {
        if (t == .0) return .0;
        if (t == 1.0) return 1.0;
        t /= .5;
        if (t < 1) return .5 * pow(2, 10 * (t - 1));
        return .5 * (-pow(2, -10 * --t) + 2);
    });
}

+ (TrCurve *)easeInCirc {
    RETURN_SINGLETON(^(double t) {
        return -1.0 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
    });
}

+ (TrCurve *)easeOutCirc {
    RETURN_SINGLETON(^(double t) {
        return sqrt(1.0 - pow(t-1.0, 2));
    });
}

+ (TrCurve *)easeInOutCirc {
    RETURN_SINGLETON(^(double t) {
        t /= .5;
        if (t < 1.0) return -.5 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
        return .5 * (sqrt(1.0 - pow(t - 2.0, 2.0)) + 1.0);
    });
}

+ (TrCurve *)easeInElastic {
    RETURN_SINGLETON(^(double t) {
        
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
        
    });
}

+ (TrCurve *)easeOutElastic {
    RETURN_SINGLETON(^(double t) {
        
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
        
    });
}

+ (TrCurve *)easeInOutElastic {
    RETURN_SINGLETON(^(double t) {
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
    });
}

+ (TrCurve *)easeInBack {
    RETURN_SINGLETON(^(double t) {
        return t*t*(2.70158*t - 1.70158);
    });
}

+ (TrCurve *)easeOutBack {
    RETURN_SINGLETON(^(double t) {
        t -= 1.0;
        return t*t*((1.70158f+1)*t + 1.70158f) + 1;
        
    });
}

+ (TrCurve *)easeInOutBack {
    RETURN_SINGLETON(^(double t) {
        
        double s = 1.70158f * 1.525f;
        t /= .5;
        
        if (t < 1.0)
            return (.5*(t*t*(((s)+1)*t - s)));
        
        t -= 2;
        return .5* ((t * t * ((s+1) * t + s) + 2));
        
    });
}

+ (TrCurve *)easeInBounce {
    
    TrCurve *easeOutBounceCurve = [self easeOutBounce];
    
    RETURN_SINGLETON(^(double t) {
        return 1.0 - [easeOutBounceCurve transform:1.0 - t];
    });
    
}

+ (TrCurve *)easeOutBounce {
    RETURN_SINGLETON(^(double t) {
        
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
        
    });
}

+ (TrCurve *)easeInOutBounce {
    
    TrCurve *easeInBounceCurve = [self easeInBounce];
    TrCurve *easeOutBounceCurve = [self easeOutBounce];
    
    RETURN_SINGLETON(^(double t) {
        if (t < .5) return [easeInBounceCurve transform:t * 2.0] * .5;
        return [easeOutBounceCurve transform:t * 2.0 - 1.0] * .5 + .5;
    });
    
}

#pragma mark - Setup / Tear down

+ (instancetype)curveWithBlock:(double (^)(double))block {
    
    if (!block) return [TrCurve linear];
    
    return [[self alloc] initWithBlock:block];
    
}

- (instancetype)initWithBlock:(double (^)(double))block {
    
    if ((self = [super init]))
        _block = [block copy];
    
    return self;
    
}

#pragma mark - Calculating Curve

- (double)transform:(double)positionInTime {
    
    return _block(MIN(1.0, MAX(.0, positionInTime)));
    
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    TrCurve *curve = [[TrCurve alloc] init];
    
    curve->_block = [_block copy];
    
    return curve;
    
}

@end
