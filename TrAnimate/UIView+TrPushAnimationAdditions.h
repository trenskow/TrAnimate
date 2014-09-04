//
//  UIView+TrPushAnimationAdditions.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

@import UIKit;

#import "TrPushAnimation.h"

@protocol TrAnimatable;
@class TrCurve;

/*!
 A category to `UIView` with convenience methods to create push animations.
 */
@interface UIView (TrPushAnimationAdditions)

/// ------------------------
/// @name Pushing in and out
/// ------------------------

/*!
 Creates and returns a push-in animation.
 
 @param duration          The duration of the push-in.
 @param edge              The edge from which the push-in should occor.
 @param delay             The delay before the push-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the push-in.
 @param completion        A block that gets invoked when push-in completes.
 
 @return A push-in animation ready to animate.
 */
- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a push-in animation.
 
 @param duration          The duration of the push-in.
 @param edge              The edge from which the push-in should occor.
 @param delay             The delay before the push-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the push-in.
 
 @return A push-in animation ready to animate.
 */
- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve;

/*!
 Creates and returns a push-in animation.
 
 @param duration          The duration of the push-in.
 @param edge              The edge from which the push-in should occor.
 @param delay             The delay before the push-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A push-in animation ready to animate.
 */
- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer;

/*!
 Creates and returns a push-in animation.
 
 @param duration          The duration of the push-in.
 @param edge              The edge from which the push-in should occor.
 @param delay             The delay before the push-in begins.
 
 @return A push-in animation ready to animate.
 */
- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay;

/*!
 Creates and returns a push-in animation.
 
 @param duration          The duration of the push-in.
 @param edge              The edge from which the push-in should occor.
 
 @return A push-in animation ready to animate.
 */
- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge;

/*!
 Creates and returns a push-out animation.
 
 @param duration          The duration of the push-out.
 @param edge              The edge from which the push-out should occor.
 @param delay             The delay before the push-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the push-out.
 @param completion        A block that gets invoked when push-out completes.
 
 @return A push-out animation ready to animate.
 */
- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a push-out animation.
 
 @param duration          The duration of the push-out.
 @param edge              The edge from which the push-out should occor.
 @param delay             The delay before the push-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the push-out.
 
 @return A push-out animation ready to animate.
 */
- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve;

/*!
 Creates and returns a push-out animation.
 
 @param duration          The duration of the push-out.
 @param edge              The edge from which the push-out should occor.
 @param delay             The delay before the push-out begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the push-out should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A push-out animation ready to animate.
 */
- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer;

/*!
 Creates and returns a push-out animation.
 
 @param duration          The duration of the push-out.
 @param edge              The edge from which the push-out should occor.
 @param delay             The delay before the push-out begins.
 
 @return A push-out animation ready to animate.
 */
- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay;

/*!
 Creates and returns a push-out animation.
 
 @param duration          The duration of the push-out.
 @param edge              The edge from which the push-out should occor.
 
 @return A push-out animation ready to animate.
 */
- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge;

@end
