//
//  UIView+TrMoveAnimationAdditions.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
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
