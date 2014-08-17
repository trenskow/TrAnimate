//
//  TrCustomCurvedAnimation.h
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

#import "TrTransitionable.h"

/**
 *  A block representing an animation curve.<br />
 *  <br />
 *  Build-in curves available:<br />
 *  TrCurveLinear<br />
 *  TrCurveEaseInQuad<br />
 *  TrCurveEaseOutQuad<br />
 *  TrCurveEaseInOutQuad<br />
 *  TrCurveEaseInCubic<br />
 *  TrCurveEaseOutCubic<br />
 *  TrCurveEaseInOutCubic<br />
 *  TrCurveEaseInQuart<br />
 *  TrCurveEaseOutQuart<br />
 *  TrCurveEaseInOutQuart<br />
 *  TrCurveEaseInQuint<br />
 *  TrCurveEaseOutQuint<br />
 *  TrCurveEaseInOutQuint<br />
 *  TrCurveEaseInSine<br />
 *  TrCurveEaseOutSine<br />
 *  TrCurveEaseInOutSine<br />
 *  TrCurveEaseInExpo<br />
 *  TrCurveEaseOutExpo<br />
 *  TrCurveEaseInOutExpo<br />
 *  TrCurveEaseInCirc<br />
 *  TrCurveEaseOutCirc<br />
 *  TrCurveEaseInOutCirc<br />
 *  TrCurveEaseInElastic<br />
 *  TrCurveEaseOutElastic<br />
 *  TrCurveEaseInOutElastic<br />
 *  TrCurveEaseInBack<br />
 *  TrCurveEaseOutBack<br />
 *  TrCurveEaseInOutBack<br />
 *  TrCurveEaseInBounce<br />
 *  TrCurveEaseOutBounce<br />
 *  TrCurveEaseInOutBounce<br />
 *
 *  @param t Linear position in time between zero and and.
 *
 *  @return The curve position.
 */
typedef double(^TrCurve)(double t);

extern TrCurve const TrCurveLinear;
extern TrCurve const TrCurveEaseInQuad;
extern TrCurve const TrCurveEaseOutQuad;
extern TrCurve const TrCurveEaseInOutQuad;
extern TrCurve const TrCurveEaseInCubic;
extern TrCurve const TrCurveEaseOutCubic;
extern TrCurve const TrCurveEaseInOutCubic;
extern TrCurve const TrCurveEaseInQuart;
extern TrCurve const TrCurveEaseOutQuart;
extern TrCurve const TrCurveEaseInOutQuart;
extern TrCurve const TrCurveEaseInQuint;
extern TrCurve const TrCurveEaseOutQuint;
extern TrCurve const TrCurveEaseInOutQuint;
extern TrCurve const TrCurveEaseInSine;
extern TrCurve const TrCurveEaseOutSine;
extern TrCurve const TrCurveEaseInOutSine;
extern TrCurve const TrCurveEaseInExpo;
extern TrCurve const TrCurveEaseOutExpo;
extern TrCurve const TrCurveEaseInOutExpo;
extern TrCurve const TrCurveEaseInCirc;
extern TrCurve const TrCurveEaseOutCirc;
extern TrCurve const TrCurveEaseInOutCirc;
extern TrCurve const TrCurveEaseInElastic;
extern TrCurve const TrCurveEaseOutElastic;
extern TrCurve const TrCurveEaseInOutElastic;
extern TrCurve const TrCurveEaseInBack;
extern TrCurve const TrCurveEaseOutBack;
extern TrCurve const TrCurveEaseInOutBack;
extern TrCurve const TrCurveEaseInBounce;
extern TrCurve const TrCurveEaseOutBounce;
extern TrCurve const TrCurveEaseInOutBounce;

/**
 *  A `CAKeyframeAnimation` subclass which support custom curves.
 */
@interface TrCustomCurvedAnimation : CAKeyframeAnimation

/**
 *  Gets or sets the curve for the animation.
 */
@property (copy,nonatomic) TrCurve curve;

/**
 *  Gets or sets the value from which the animation will begin.
 */
@property (nonatomic,strong) id<TrTransitionable> fromValue;

/**
 *  Gets or sets the value to which the animation should end.
 */
@property (nonatomic,strong) id<TrTransitionable> toValue;

@end
