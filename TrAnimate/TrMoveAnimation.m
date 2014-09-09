//
//  TrMoveAnimation.m
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

#import "TrAnimatable.h"
#import "TrLayerAnimation+Private.h"

#import "TrMoveAnimation.h"

@interface TrMoveAnimation ()

@property (nonatomic) TrMoveAnimationDirection direction;

@end

@implementation TrMoveAnimation

#pragma mark - Internals

- (void)animationCompleted:(BOOL)finished {
    
    if (self.direction == TrMoveAnimationDirectionOut) {
        self.layer.hidden = YES;
        [self.layer setValue:self.fromValue forKeyPath:@"position"];
    }
    
    [super animationCompleted:finished];
    
}

- (void)setupAnimations {
    
    if (self.direction == TrMoveAnimationDirectionIn)
        self.layer.hidden = NO;
    
    [super setupAnimations];
    
}

#pragma mark - Creating Animation

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    /* We create a push in by default and reverse it below if it's a push out. */
    
    /* Get the layers relevant to do all calculations. */
    CALayer *layer = viewOrLayer.animationLayer;
    CALayer *boundsLayer = (bounds ?: viewOrLayer).animationLayer;
    
    CGRect b = [layer.superlayer convertRect:boundsLayer.bounds
                                   fromLayer:boundsLayer];
    
    /* Calculate `fromPosition` based on `direction` */
    CGPoint toPosition = layer.position;
    CGPoint fromPosition = layer.position;
    
    switch (edge) {
        case TrMoveAnimationEdgeTop:
            fromPosition.y = b.origin.y - layer.bounds.size.height * (1.0 - layer.anchorPoint.y);
            break;
        case TrMoveAnimationEdgeRight:
            fromPosition.x = b.origin.x + b.size.width + layer.bounds.size.width * layer.anchorPoint.x;
            break;
        case TrMoveAnimationEdgeBottom:
            fromPosition.y = b.origin.y + b.size.height + layer.bounds.size.height * layer.anchorPoint.y;
            break;
        case TrMoveAnimationEdgeLeft:
            fromPosition.x = b.origin.x - layer.bounds.size.width * (1.0 - layer.anchorPoint.x);
            break;
    }
    
    /* In case it's a push out we swap the positions */
    if (direction == TrMoveAnimationDirectionOut) {
        CGPoint p = fromPosition;
        fromPosition = toPosition;
        toPosition = p;
    }
    
    /* Return position animation */
    TrMoveAnimation *pushAnimation = [super animate:viewOrLayer
                                           duration:duration
                                              delay:delay
                                       fromPosition:fromPosition
                                         toPosition:toPosition
                                             anchor:TrPositionAnimationAnchorCenter
                                              curve:curve
                                         completion:completion];
    
    /* Needed in order to do correct hiding of viewOrLayer before or after animation. */
    pushAnimation.direction = direction;
    
    return pushAnimation;
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
               direction:direction
                    edge:edge
          toOrFromBounds:bounds
                   delay:delay
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds
                  delay:(NSTimeInterval)delay {
    
    return [self animate:viewOrLayer
                duration:duration
               direction:direction
                    edge:edge
          toOrFromBounds:bounds
                   delay:delay
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge
         toOrFromBounds:(id<TrAnimatable>)bounds {
    
    return [self animate:viewOrLayer
                duration:duration
               direction:direction
                    edge:edge
          toOrFromBounds:bounds
                   delay:.0
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
              direction:(TrMoveAnimationDirection)direction
                   edge:(TrMoveAnimationEdge)edge {
    
    return [self animate:viewOrLayer
                duration:duration
               direction:direction
                    edge:edge
          toOrFromBounds:nil
                   delay:.0
                   curve:nil
              completion:nil];
    
}


@end
