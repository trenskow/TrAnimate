//
//  UIView+TrMoveInAnimationAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

#import "UIView+TrAnimateAdditions.h"

#import "UIView+TrMoveInAnimationAdditions.h"

@implementation UIView (TrMoveInAnimationAdditions)

- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                        curve:(TrCurve *)curve
                   completion:(void (^)(BOOL finished))completion {
    
    return [TrMoveInAnimation animate:self
                             duration:duration
                                delay:delay
                            direction:direction
                    fromOutsideBounds:boundsViewOrLayer
                                curve:curve
                           completion:completion];
    
}

- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                        curve:(TrCurve *)curve {
    
    return [TrMoveInAnimation animate:self
                             duration:duration
                                delay:delay
                            direction:direction
                    fromOutsideBounds:boundsViewOrLayer
                                curve:curve];
    
}

- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer {
    
    
    return [TrMoveInAnimation animate:self
                             duration:duration
                                delay:delay
                            direction:direction
                    fromOutsideBounds:boundsViewOrLayer];
}

- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay {
    
    return [TrMoveInAnimation animate:self
                             duration:duration
                                delay:delay
                            direction:direction];
    
}

- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction {
    
    return [TrMoveInAnimation animate:self
                             duration:duration
                                delay:.0
                            direction:direction];
    
}

@end
