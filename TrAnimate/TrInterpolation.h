//
//  TrInterpolation.h
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

@class TrCurve;
@protocol TrInterpolatable;

/*!
 The `TrInterpolation` class provides interpolation between two values. Currently `TrLayerAnimation` - and it's subclasses - and `TrDirectAnimation` supports this - see `TrInterpolatableAnimation`.
 
 ## Custom Interpolation
 
 Create an interpolation with a block or subclass it and override the `interpolateFromValue:toValue:atPosition:` method to provide custom interpolation.
 
 */
@interface TrInterpolation : NSObject <NSCopying>

/*!
 Creates and returns a `TrInterpolation` object with a block that is capable of interpolating two values.
 
 @param block The block that is capable of interpolating two values.
 
 @return An `TrInterpolation` object.
 */
+ (instancetype)interpolationWithBlock:(id (^)(id fromValue, id toValue, double position))block;

/*!
 Interpolate two values at a given position.
 
 @param fromValue The value to interpolate from.
 @param toValue   The value to interpolate to.
 @param position  The position of the interpolation.
 
 @return An interpolated value.
 */
- (id)interpolateFromValue:(id)fromValue
                   toValue:(id)toValue
                atPosition:(double)position;

@end
