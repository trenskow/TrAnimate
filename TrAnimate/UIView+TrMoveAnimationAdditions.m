//
//  UIView+TrMoveAnimationAdditions.m
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
