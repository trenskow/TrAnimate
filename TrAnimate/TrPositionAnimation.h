//
//  TrPositionAnimation.h
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

#import "TrKeyPathAnimation.h"

/**
 *  Specifies the origin of the position.
 */
typedef NS_OPTIONS(NSUInteger, TrPositionAnimationOrigin) {
    /**
     *  Origin in the center of the view or layer. Default when animating `CALayer`s.
     */
    TrPositionAnimationsOriginCenter = 0,
    /**
     *  Origin at the top left of the view or layer. Default when animating `UIView`s.
     */
    TrPositionAnimationsOriginTopLeft
};

/**
 *  The `TrPositionAnimation` moves a `UIView` or `CALayer`
 */
@interface TrPositionAnimation : TrKeyPathAnimation

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer;

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                  curve:(TrCurve *)curve
                 origin:(TrPositionAnimationOrigin)origin
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            endPosition:(CGPoint)endPosition
                  curve:(TrCurve *)curve
                 origin:(TrPositionAnimationOrigin)origin
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            endPosition:(CGPoint)endPosition
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

@end
