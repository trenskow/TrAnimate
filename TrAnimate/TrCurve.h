//
//  TrCurve.h
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

@import Foundation;

/*!
 The `TrCurve` class provides curvature for animations. Use one of the many build-in curves or create your own customized curves either using a block or by subclassing this class.
 */
@interface TrCurve : NSObject <NSCopying>

/// ---------------------
/// @name Build-in Curves
/// ---------------------

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/linear.png" alt="The signature of the linear curve." />
 */
+ (TrCurve *)linear;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInQuad.png" alt="The signature of the easeInQuad curve." />
 */
+ (TrCurve *)easeInQuad;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutQuad.png" alt="The signature of the easeOutQuad curve." />
 */
+ (TrCurve *)easeOutQuad;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutQuad.png" alt="The signature of the easeInOutQuad curve." />
 */
+ (TrCurve *)easeInOutQuad;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInCubic.png" alt="The signature of the easeInCubic curve." />
 */
+ (TrCurve *)easeInCubic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutCubic.png" alt="The signature of the easeOutCubic curve." />
 */
+ (TrCurve *)easeOutCubic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutCubic.png" alt="The signature of the easeInOutCubic curve." />
 */
+ (TrCurve *)easeInOutCubic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInQuart.png" alt="The signature of the easeInQuart curve." />
 */
+ (TrCurve *)easeInQuart;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutQuart.png" alt="The signature of the easeOutQuart curve." />
 */
+ (TrCurve *)easeOutQuart;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutQuart.png" alt="The signature of the easeInOutQuart curve." />
 */
+ (TrCurve *)easeInOutQuart;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInQuint.png" alt="The signature of the easeInQuint curve." />
 */
+ (TrCurve *)easeInQuint;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutQuint.png" alt="The signature of the easeOutQuint curve." />
 */
+ (TrCurve *)easeOutQuint;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutQuint.png" alt="The signature of the easeInOutQuint curve." />
 */
+ (TrCurve *)easeInOutQuint;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInSine.png" alt="The signature of the easeInSine curve." />
 */
+ (TrCurve *)easeInSine;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutSine.png" alt="The signature of the easeOutSine curve." />
 */
+ (TrCurve *)easeOutSine;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutSine.png" alt="The signature of the easeInOutSine curve." />
 */
+ (TrCurve *)easeInOutSine;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInExpo.png" alt="The signature of the easeInExpo curve." />
 */
+ (TrCurve *)easeInExpo;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutExpo.png" alt="The signature of the easeOutExpo curve." />
 */
+ (TrCurve *)easeOutExpo;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutExpo.png" alt="The signature of the easeInOutExpo curve." />
 */
+ (TrCurve *)easeInOutExpo;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInCirc.png" alt="The signature of the easeInCirc curve." />
 */
+ (TrCurve *)easeInCirc;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutCirc.png" alt="The signature of the easeOutCirc curve." />
 */
+ (TrCurve *)easeOutCirc;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutCirc.png" alt="The signature of the easeInOutCirc curve." />
 */
+ (TrCurve *)easeInOutCirc;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInElastic.png" alt="The signature of the easeInElastic curve." />
 */
+ (TrCurve *)easeInElastic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutElastic.png" alt="The signature of the easeOutElastic curve." />
 */
+ (TrCurve *)easeOutElastic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutElastic.png" alt="The signature of the easeInOutElastic curve." />
 */
+ (TrCurve *)easeInOutElastic;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInBack.png" alt="The signature of the easeInBack curve." />
 */
+ (TrCurve *)easeInBack;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutBack.png" alt="The signature of the easeOutBack curve." />
 */
+ (TrCurve *)easeOutBack;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutBack.png" alt="The signature of the easeInOutBack curve." />
 */
+ (TrCurve *)easeInOutBack;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInBounce.png" alt="The signature of the easeInBounce curve." />
 */
+ (TrCurve *)easeInBounce;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeOutBounce.png" alt="The signature of the easeOutBounce curve." />
 */
+ (TrCurve *)easeOutBounce;

/*!
 Returns a curve with a signature as below.<br /><img src="../docs/curves/easeInOutBounce.png" alt="The signature of the easeInOutBounce curve." />
 */
+ (TrCurve *)easeInOutBounce;

/// --------------------
/// @name Creating Curve
/// --------------------

/*!
 Creates and returns a new curve using a block.
 
 @param block A block that takes a value in time *t* between one and zero and returns the relative position on the curve.
 
 @return A curve.
 */
+ (instancetype)curveWithBlock:(double (^)(double t))block;

/// ------------------------
/// @name Transforming Curve
/// ------------------------

/*!
 Transforms a value in time into a curved position.
 
 @param positionInTime Position in time between one and zero.
 
 @discussion Override this in a subclass if you want to create a custom curve without using blocks.
 
 @return The position on the curve relative to `positionInTime`.
 */
- (double)transform:(double)positionInTime;

@end
