//
//  TrCurve.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 18/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import "TrCurve+Private.h"

@interface TrCurve () {
    
    double (^_block)(double t);
    
}

- (instancetype)initWithBlock:(double (^)(double t))block;

@end

@implementation TrCurve

#pragma mark - Build-in Curves

+ (TrCurve *)linear {
    return [TrCurve curveWithBlock:^(double t) {
        return t;
    }];
}

+ (TrCurve *)easeInQuad {
    return [TrCurve curveWithBlock:^(double t) {
        return pow(t, 2.0);
    }];
}

+ (TrCurve *)easeOutQuad {
    return [TrCurve curveWithBlock:^(double t) {
        return -1.0 * t * (t - 2.0);
    }];
}

+ (TrCurve *)easeInOutQuad {
    return [TrCurve curveWithBlock:^(double t) {
        t /= .5;
        if (t < 1.0) return .5*pow(t, 2.0);
        t -= 1.0;
        return -.5 * (t*(t - 2.0) - 1.0);
    }];
}

+ (TrCurve *)easeInCubic {
    return [TrCurve curveWithBlock:^(double t) {
        return pow(t, 3.0);
    }];
}

+ (TrCurve *)easeOutCubic {
    return [TrCurve curveWithBlock:^(double t) {
        t = t - 1.0;
        return pow(t, 3.0) + 1;
    }];
}

+ (TrCurve *)easeInOutCubic {
    
    TrCurve *easeInCubic = [self easeInCubic];
    TrCurve *easeOutCubic = [self easeOutCubic];
    
    return [TrCurve curveWithBlock:^(double t) {
        if (t < .5) return [easeInCubic transform:t * 2.0] / 2.0;
        return [easeOutCubic transform:(t - .5) * 2.0] / 2.0 + .5;
    }];
}

+ (TrCurve *)easeInQuart {
    return [TrCurve curveWithBlock:^(double t) {
        return pow(t, 4.0);
    }];
}

+ (TrCurve *)easeOutQuart {
    return [TrCurve curveWithBlock:^(double t) {
        t -= 1.0;
        return -1.0 * (pow(t, 4.0) - 1);
    }];
}

+ (TrCurve *)easeInOutQuart {
    return [TrCurve curveWithBlock:^(double t) {
        t /= .5;
        if (t < 1.0) return .5 * pow(t, 4.0);
        t -= 2.0;
        return -.5 * (pow(t, 4.0) - 2.0);
    }];
}

+ (TrCurve *)easeInQuint {
    return [TrCurve curveWithBlock:^(double t) {
        return pow(t, 5.0);
    }];
}

+ (TrCurve *)easeOutQuint {
    return [TrCurve curveWithBlock:^(double t) {
        t -= 1.0;
        return 1.0 * (pow(t, 5.0) + 1.0);
    }];
}

+ (TrCurve *)easeInOutQuint {
    return [TrCurve curveWithBlock:^(double t) {
        t /= .5;
        if (t < 1) return .5*pow(t, 5.0);
        t -= 2.0;
        return .5 * (pow(t, 5.0) + 2.0);
    }];
}

+ (TrCurve *)easeInSine {
    return [TrCurve curveWithBlock:^(double t) {
        return (-1.0 * cos(t * M_PI_2) + 1.0);
    }];
}

+ (TrCurve *)easeOutSine {
    return [TrCurve curveWithBlock:^(double t) {
        return sin(t * M_PI_2);
    }];
}

+ (TrCurve *)easeInOutSine {
    return [TrCurve curveWithBlock:^(double t) {
        return (-.5 * cos(M_PI*t) + .5);
    }];
}

+ (TrCurve *)easeInExpo {
    return [TrCurve curveWithBlock:^(double t) {
        return (t == 0 ? .0 : pow(2.0, 10.0 * (t - 1.0)));
    }];
}

+ (TrCurve *)easeOutExpo {
    return [TrCurve curveWithBlock:^(double t) {
        return -pow(2.0, -10.0 * t) + 1.0;
    }];
}

+ (TrCurve *)easeInOutExpo {
    return [TrCurve curveWithBlock:^(double t) {
        if (t == .0) return .0;
        if (t == 1.0) return 1.0;
        t /= .5;
        if (t < 1) return .5 * pow(2, 10 * (t - 1));
        return .5 * (-pow(2, -10 * --t) + 2);
    }];
}

+ (TrCurve *)easeInCirc {
    return [TrCurve curveWithBlock:^(double t) {
        return -1.0 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
    }];
}

+ (TrCurve *)easeOutCirc {
    return [TrCurve curveWithBlock:^(double t) {
        return sqrt(1.0 - pow(t-1.0, 2));
    }];
}

+ (TrCurve *)easeInOutCirc {
    return [TrCurve curveWithBlock:^(double t) {
        t /= .5;
        if (t < 1.0) return -.5 * (sqrt(1.0 - pow(t, 2.0)) - 1.0);
        return .5 * (sqrt(1.0 - pow(t - 2.0, 2.0)) + 1.0);
    }];
}

+ (TrCurve *)easeInElastic {
    return [TrCurve curveWithBlock:^(double t) {
        
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
        
    }];
}

+ (TrCurve *)easeOutElastic {
    return [TrCurve curveWithBlock:^(double t) {
        
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
        
    }];
}

+ (TrCurve *)easeInOutElastic {
    return [TrCurve curveWithBlock:^(double t) {
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
    }];
}

+ (TrCurve *)easeInBack {
    return [TrCurve curveWithBlock:^(double t) {
        return t*t*(2.70158*t - 1.70158);
    }];
}

+ (TrCurve *)easeOutBack {
    return [TrCurve curveWithBlock:^(double t) {
        t -= 1.0;
        return t*t*((1.70158f+1)*t + 1.70158f) + 1;
        
    }];
}

+ (TrCurve *)easeInOutBack {
    return [TrCurve curveWithBlock:^(double t) {
        
        double s = 1.70158f * 1.525f;
        t /= .5;
        
        if (t < 1.0)
            return (.5*(t*t*(((s)+1)*t - s)));
        
        t -= 2;
        return .5* ((t * t * ((s+1) * t + s) + 2));
        
    }];
}

+ (TrCurve *)easeInBounce {
    
    TrCurve *easeOutBounceCurve = [self easeOutBounce];
    
    return [TrCurve curveWithBlock:^(double t) {
        return 1.0 - [easeOutBounceCurve transform:1.0 - t];
    }];
    
}

+ (TrCurve *)easeOutBounce {
    return [TrCurve curveWithBlock:^(double t) {
        
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
        
    }];
}

+ (TrCurve *)easeInOutBounce {
    
    TrCurve *easeInBounceCurve = [self easeInBounce];
    TrCurve *easeOutBounceCurve = [self easeOutBounce];
    
    return [TrCurve curveWithBlock:^(double t) {
        if (t < .5) return [easeInBounceCurve transform:t * 2.0] * .5;
        return [easeOutBounceCurve transform:t * 2.0 - 1.0] * .5 + .5;
    }];
    
}

#pragma mark - Setup / Tear down

+ (instancetype)curveWithBlock:(double (^)(double))block {
    
    if (!block) return [TrCurve linear];
    
    return [[self alloc] initWithBlock:[block copy]];
    
}

- (instancetype)initWithBlock:(double (^)(double))block {
    
    if ((self = [super init]))
        _block = block;
    
    return block;
    
}

#pragma mark - Protected Methods

- (double)transform:(double)t {
    
    return _block(t);
    
}

#pragma mark - Public Methods

- (id)objectForKeyedSubscript:(id<NSCopying>)t {
    
    return @([self transform:[(id)t doubleValue]]);
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    TrCurve *curve = [[TrCurve alloc] init];
    
    curve->_block = [_block copy];
    
    return curve;
    
}

@end
