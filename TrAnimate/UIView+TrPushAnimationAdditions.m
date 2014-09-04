//
//  UIView+TrPushAnimationAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

#import "UIView+TrAnimateAdditions.h"

#import "UIView+TrPushAnimationAdditions.h"

@implementation UIView (TrPushAnimationAdditions)

- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:completion];
    
}

- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                      curve:(TrCurve *)curve  {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:nil];
    
}

- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay
           fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge
                      delay:(NSTimeInterval)delay {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:nil
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrPushAnimation *)pushIn:(NSTimeInterval)duration
                       edge:(TrPushAnimationEdge)edge {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionIn
                               edge:edge
                     toOrFromBounds:nil
                              delay:.0
                              curve:nil
                         completion:nil];
    
}

- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:completion];
    
}

- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                       curve:(TrCurve *)curve  {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:curve
                         completion:nil];
    
}

- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay
            fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:boundsViewOrLayer
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge
                       delay:(NSTimeInterval)delay {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:nil
                              delay:delay
                              curve:nil
                         completion:nil];
    
}

- (TrPushAnimation *)pushOut:(NSTimeInterval)duration
                        edge:(TrPushAnimationEdge)edge {
    
    return [TrPushAnimation animate:self
                           duration:duration
                          direction:TrPushAnimationDirectionOut
                               edge:edge
                     toOrFromBounds:nil
                              delay:.0
                              curve:nil
                         completion:nil];
    
}

@end
