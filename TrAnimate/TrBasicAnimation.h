//
//  TrBasicAnimation.h
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

@import QuartzCore;

#import "TrInterpolatable.h"

@class TrCurve;

/*!
 The `TrBasicAnimation` class is a `CAAnimation` subclass that provides basic animation of a `CALayer` property. This class is much like Core Animation's `CABasicAnimation` except it allows for custom interpolation using `TrCurve`.
 */
@interface TrBasicAnimation : CAKeyframeAnimation

/// --------------------------
/// @name Interpolation values
/// --------------------------

/*!
 Returns the curve used by the animation. Default is a linear curve.
 */
@property (copy,nonatomic) TrCurve *curve;

/*!
 The value at which the animation should begin.
 */
@property (nonatomic,strong) id<TrInterpolatable> fromValue;

/*!
 The value at which the animation ends.
 */
@property (nonatomic,strong) id<TrInterpolatable> toValue;

@end
