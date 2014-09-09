//
//  UIView+TrMoveAnimationAdditions.h
//  TrAnimate
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

@import UIKit;

#import "TrMoveAnimation.h"

@protocol TrAnimatable;
@class TrCurve;

/*!
 A category to `UIView` with convenience methods to create move animations.
 */
@interface UIView (TrMoveAnimationAdditions)

/// ------------------------
/// @name moveing in and out
/// ------------------------

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param edge              The edge from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-in.
 @param completion        A block that gets invoked when move-in completes.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param edge              The edge from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-in.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param edge              The edge from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param edge              The edge from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param edge              The edge from which the move-in should occor.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge;

/*!
 Creates and returns a move-out animation.
 
 @param duration          The duration of the move-out.
 @param edge              The edge from which the move-out should occor.
 @param delay             The delay before the move-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-out.
 @param completion        A block that gets invoked when move-out completes.
 
 @return A move-out animation ready to animate.
 */
- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a move-out animation.
 
 @param duration          The duration of the move-out.
 @param edge              The edge from which the move-out should occor.
 @param delay             The delay before the move-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-out.
 
 @return A move-out animation ready to animate.
 */
- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve;

/*!
 Creates and returns a move-out animation.
 
 @param duration          The duration of the move-out.
 @param edge              The edge from which the move-out should occor.
 @param delay             The delay before the move-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A move-out animation ready to animate.
 */
- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer;

/*!
 Creates and returns a move-out animation.
 
 @param duration          The duration of the move-out.
 @param edge              The edge from which the move-out should occor.
 @param delay             The delay before the move-out begins.
 
 @return A move-out animation ready to animate.
 */
- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay;

/*!
 Creates and returns a move-out animation.
 
 @param duration          The duration of the move-out.
 @param edge              The edge from which the move-out should occor.
 
 @return A move-out animation ready to animate.
 */
- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge;

@end
