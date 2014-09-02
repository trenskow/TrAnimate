//
//  TrMoveInAnimation.m
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

#import "CALayer+TrMoveInAnimationAdditions.h"

#import "TrAnimatable.h"
#import "TrLayerAnimation+Private.h"

#import "TrMoveInAnimation.h"

@implementation TrMoveInAnimation

#pragma mark - Internals

- (void)setupAnimations {
    
    [super setupAnimations];
    
    self.layer.hidden = NO;
    
}

#pragma mark - Creating Animation

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL))completion {
    
    /* Get the layers relevant to do all calculations. */
    CALayer *layer = viewOrLayer.animationLayer;
    CALayer *superLayer = layer.superlayer;
    CALayer *windowLayer = layer.windowLayer;
    
    CGRect b;
    
    /* Get the bounds `b` based on `bounds` in the coordinate space of the superLayer. */
    switch (bounds) {
        case TrMoveInAnimationBoundsContent:
            b = [superLayer convertRect:layer.bounds
                              fromLayer:layer];
            break;
        case TrMoveInAnimationBoundsSuper:
            b = superLayer.bounds;
            break;
        default:
            b = [superLayer convertRect:windowLayer.bounds
                              fromLayer:windowLayer];
            break;
    }
    
    /* Calculate `fromPosition` based on `direction` */
    CGPoint fromPosition = layer.position;
    
    switch (direction) {
        case TrMoveInAnimationDirectionTop:
            fromPosition.y = b.origin.y - layer.bounds.size.height * (1.0 - layer.anchorPoint.y);
            break;
        case TrMoveInAnimationDirectionRight:
            fromPosition.x = b.origin.x + b.size.width + layer.bounds.size.width * layer.anchorPoint.x;
            break;
        case TrMoveInAnimationDirectionBottom:
            fromPosition.y = b.origin.y + b.size.height + layer.bounds.size.height * layer.anchorPoint.y;
            break;
        case TrMoveInAnimationDirectionLeft:
            fromPosition.x = b.origin.x - layer.bounds.size.width * (1.0 - layer.anchorPoint.x);
            break;
    }
    
    /* Return position animation */
    return [super animate:viewOrLayer
                 duration:duration
                    delay:delay
             fromPosition:fromPosition
               toPosition:layer.position
                   anchor:TrPositionAnimationAnchorCenter
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                  bounds:bounds
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                  bounds:bounds
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                  bounds:TrMoveInAnimationBoundsContent
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                  bounds:TrMoveInAnimationBoundsContent
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                  bounds:TrMoveInAnimationBoundsContent
                   curve:nil
              completion:nil];
    
}

@end
