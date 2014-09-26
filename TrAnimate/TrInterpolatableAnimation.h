//
//  TrInterpolatableAnimation.h
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

#import "TrAnimation.h"

@class TrInterpolation;
@class TrCurve;

/*!
 The `TrInterpolatableAnimation` protocol defines properties that are common to all types of animations that support custom interpolation between two values.
 
 You can use custom interpolation if the build-in interpolation is not satisfactory, or if you need to interpolate values that are not currently implemented by TrAnimate - see `TrInterpolatable`.
 
 The `TrDirectAnimation` and `TrLayerAnimation` - and it's subclasses - currently conforms to this protocol.
 
 ## Example
 
 An example of custom interpolation is when you need to rotate in the opposite direction of what the build-in interpolation does. In this case you can provide the interpolation in order to achieve the desired result.
 
 */
@protocol TrInterpolatableAnimation <TrAnimation>

///------------------------------------
/// @name Getting Animation Information
///------------------------------------

/*!
 Returns the curvature to be used in the interpolation. A linear curvature will be applied if this is nil (default).
 */
@property (nonatomic,copy) TrCurve *curve;

/*!
 Returns the interpolation used or nil if no custom interpolation has been provided.
 
 @discussion Assign it with a `TrInterpolation` object to provide custom interpolation.
 */
@property (nonatomic,copy) TrInterpolation *interpolation;

@end
