//
//  NSObject+TrDirectAnimationAdditions.h
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

@class TrDirectAnimation;
@class TrCurve;

/*!
 Category of `NSObject` that adds convinience methods for direct animations.
 */
@interface NSObject (TrDirectAnimationAdditions)

/*!
 Sets the value for the property identified by a given key path to a given value interpolating and setting the value regularly using a direct drivin' animation.
 
 @param value      The value for the property identified by `keyPath`.
 @param keyPath    A key path of the form `relationship.property` (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 @param duration   The duration of the value change.
 @param delay      The delay before the value change begins.
 @param curve      The curvature of the value change.
 @param completion A block that gets invoked when the value change is complete.
 
 @return A `TrDirectAnimation` instance ready to animate.
 */
- (TrDirectAnimation *)setValue:(id)value
                     forKeyPath:(NSString *)keyPath
                       duration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
                          curve:(TrCurve *)curve
                     completion:(void (^)(BOOL finished))completion;

/*!
 Sets the value for the property identified by a given key path to a given value interpolating and setting the value regularly using `TrDirectAnimation`
 
 @param value      The value for the property identified by `keyPath`.
 @param keyPath    A key path of the form `relationship.property` (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 @param duration   The duration of the value change.
 @param delay      The delay before the value change begins.
 @param curve      The curvature of the value change.
 
 @return A `TrDirectAnimation` instance ready to animate.
 */
- (TrDirectAnimation *)setValue:(id)value
                     forKeyPath:(NSString *)keyPath
                       duration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
                          curve:(TrCurve *)curve;

/*!
 Sets the value for the property identified by a given key path to a given value interpolating and setting the value regularly using `TrDirectAnimation`
 
 @param value      The value for the property identified by `keyPath`.
 @param keyPath    A key path of the form `relationship.property` (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 @param duration   The duration of the value change.
 @param delay      The delay before the value change begins.
 
 @return A `TrDirectAnimation` instance ready to animate.
 */
- (TrDirectAnimation *)setValue:(id)value
                     forKeyPath:(NSString *)keyPath
                       duration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay;

/*!
 Sets the value for the property identified by a given key path to a given value interpolating and setting the value regularly using `TrDirectAnimation`
 
 @param value      The value for the property identified by `keyPath`.
 @param keyPath    A key path of the form `relationship.property` (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 @param duration   The duration of the value change.
 
 @return A `TrDirectAnimation` instance ready to animate.
 */
- (TrDirectAnimation *)setValue:(id)value
                     forKeyPath:(NSString *)keyPath
                       duration:(NSTimeInterval)duration;

@end
