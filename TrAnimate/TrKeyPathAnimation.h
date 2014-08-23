//
//  TrKeyPathAnimation.h
//  TrAnimate
//
//  Copyright (c) 2014, Kristian Trenskow All rights reserved.
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

#import "TrAnimation.h"

@protocol TrAnimatable;
@protocol TrInterpolatable;

/*!
 The `TrKeyPathAnimation` provides animation on any animatable property of CALayer. Use this animation if you need to do custom animations on a layer that is not directly implemented in TrAnimate as an explicit animation.
 */
@interface TrKeyPathAnimation : TrAnimation

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

/*!
*  Checks if an animation is in progress on a `UIView` or `CALayer` instance at a perticular property.
*
*  @param viewOrLayer The `UIView` or `CALayer` you want to examine.
*  @param keyPath     The key path of the property that you want to examine.
*
*  @return Returns `YES` if the `UIView` or `CALayer` is animating on the property of `keyPath`.
*/
+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer withKeyPath:(NSString *)keyPath;

/// -------------------------
/// @name Creating Animations
/// -------------------------

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue;

@end
