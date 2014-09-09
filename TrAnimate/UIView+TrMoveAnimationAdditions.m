//
//  UIView+TrMoveAnimationAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

#import "UIView+TrAnimateAdditions.h"

#import "UIView+TrMoveAnimationAdditions.h"

@implementation UIView (TrMoveAnimationAdditions)

- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:completion];
    
}

- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve  {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:nil];
    
}

- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge
                      delay:(NSTimeInterval)delay {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:nil
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrMoveAnimation *)moveIn:(NSTimeInterval)duration
                       edge:(TrMoveAnimationEdge)edge {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:nil
                              delay:.0
                              curve:nil
                         completion:nil];
    
}

- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:completion];
    
}

- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve  {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:nil];
    
}

- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:nil
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrMoveAnimation *)moveOut:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge {
    
    return [TrMoveAnimation animate:self
                           duration:duration
                          direction:TrMoveAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:nil
                              delay:.0
                              curve:nil
                         completion:nil];
    
}

@end
