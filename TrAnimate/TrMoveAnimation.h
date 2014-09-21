//
//  TrMoveAnimation.h
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

#import "TrPositionAnimation.h"

/*!
 Specifies the direction of the move.
 */
typedef NS_ENUM(NSInteger, TrMoveAnimationDirection) {
    /*! Moves content in. With this option the content is unhidden before it is moved in. */
    TrMoveAnimationDirectionIn = 0,
    /*! Moves content out. With this option the content is hidden after the move-out is complete. */
    TrMoveAnimationDirectionOut
};

/*!
 Specifies the edge of the move.
 */
typedef NS_ENUM(NSInteger, TrMoveAnimationEdge) {
    /*! Move in from or out to the top. */
    TrMoveAnimationEdgeTop = 0,
    /*! Move in from or out to the right. */
    TrMoveAnimationEdgeRight,
    /*! Move in from or out to the bottom. */
    TrMoveAnimationEdgeBottom,
    /*! Move in from or out to the left. */
    TrMoveAnimationEdgeLeft
};

/*!
 The `TrMoveAnimation` moves in or out a `UIView` or `CALayer` object from a specific edge (top, right, bottom or left) - and from outside some specific bounds.
 
 ## Convenience methods
 
 There are some convenience methods for creating move animation on `UIView` objects which are described in the reference for UIView(TrMoveAnimationAdditions).
 
 */
@interface TrMoveAnimation : TrPositionAnimation

/// ------------------------
/// @name Creating Animation
/// ------------------------

/*!
 Creates and returns a move in or out animation that is moved to or from a specific edge of a specific bounds.

 @param viewOrLayer The `UIView` or `CALayer` object you want to move.
 @param duration    The duration of the move.
 @param direction   The direction of the move.
 @param edge        The edge of which the move will go to or come from.
 @param bounds      The `UIView` or `CALayer` object which bounds will be animated to or from outside. If *nil* is provided the bounds of the `viewOrLayer` is used.
 @param delay       The delay before the animation begins.
 @param curve       The curvature of the animation.
 @param completion  A block that get invoked when the move completes.

 @return A move animation ready to animate.
*/
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a move in or out animation that is moved to or from a specific edge of a specific bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to move.
 @param duration    The duration of the move.
 @param direction   The direction of the move.
 @param edge        The edge of which the move will go to or come from.
 @param bounds      The `UIView` or `CALayer` object which bounds will be animated to or from outside. If *nil* is provided the bounds of the `viewOrLayer` is used.
 @param delay       The delay before the animation begins.
 @param curve       The curvature of the animation.
 
 @return A move animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay
                  curve:(TrCurve *)curve;

/*!
 Creates and returns a move in or out animation that is moved to or from a specific edge of a specific bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to move.
 @param duration    The duration of the move.
 @param direction   The direction of the move.
 @param edge        The edge of which the move will go to or come from.
 @param bounds      The `UIView` or `CALayer` object which bounds will be animated to or from outside. If *nil* is provided the bounds of the `viewOrLayer` is used.
 @param delay       The delay before the animation begins.
 
 @return A move animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay;

/*!
 Creates and returns a move in or out animation that is moved to or from a specific edge of a specific bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to move.
 @param duration    The duration of the move.
 @param direction   The direction of the move.
 @param edge        The edge of which the move will go to or come from.
 @param bounds      The `UIView` or `CALayer` object which bounds will be animated to or from outside. If *nil* is provided the bounds of the `viewOrLayer` is used.
 
 @return A move animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds;

/*!
 Creates and returns a move in or out animation that is moved to or from a specific edge of a specific bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to move.
 @param duration    The duration of the move.
 @param direction   The direction of the move.
 @param edge        The edge of which the move will go to or come from.
 
 @discussion When using this method the move will occur from or to outside the bounds of the animated content.
 
 @return A move animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge;

@end
