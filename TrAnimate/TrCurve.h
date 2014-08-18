//
//  TrCurve.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 18/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrCurve : NSObject <NSCopying>

+ (TrCurve *)linear;
+ (TrCurve *)easeInQuad;
+ (TrCurve *)easeOutQuad;
+ (TrCurve *)easeInOutQuad;
+ (TrCurve *)easeInCubic;
+ (TrCurve *)easeOutCubic;
+ (TrCurve *)easeInOutCubic;
+ (TrCurve *)easeInQuart;
+ (TrCurve *)easeOutQuart;
+ (TrCurve *)easeInOutQuart;
+ (TrCurve *)easeInQuint;
+ (TrCurve *)easeOutQuint;
+ (TrCurve *)easeInOutQuint;
+ (TrCurve *)easeInSine;
+ (TrCurve *)easeOutSine;
+ (TrCurve *)easeInOutSine;
+ (TrCurve *)easeInExpo;
+ (TrCurve *)easeOutExpo;
+ (TrCurve *)easeInOutExpo;
+ (TrCurve *)easeInCirc;
+ (TrCurve *)easeOutCirc;
+ (TrCurve *)easeInOutCirc;
+ (TrCurve *)easeInElastic;
+ (TrCurve *)easeOutElastic;
+ (TrCurve *)easeInOutElastic;
+ (TrCurve *)easeInBack;
+ (TrCurve *)easeOutBack;
+ (TrCurve *)easeInOutBack;
+ (TrCurve *)easeInBounce;
+ (TrCurve *)easeOutBounce;
+ (TrCurve *)easeInOutBounce;

+ (instancetype)curveWithBlock:(double (^)(double t))block;

@end
