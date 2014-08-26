//
//  TrPositionAnimation.m
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

@import UIKit;

#import "NSValue+TrAnimateAdditions.h"

#import "TrAnimatable.h"

#import "TrPositionAnimation.h"

@implementation TrPositionAnimation

#pragma mark - Internal

+ (CGPoint)position:(CGPoint)position ofLayer:(CALayer *)layer fromAnchor:(TrPositionAnimationAnchor)anchor {
    
    if (anchor == TrPositionAnimationAnchorTopLeft)
        return CGPointMake(position.x + layer.bounds.size.width * layer.anchorPoint.x,
                           position.y + layer.bounds.size.height * layer.anchorPoint.y);
    
    return position;
    
}

+ (TrPositionAnimationAnchor)anchorForViewOrLayer:(id<TrAnimatable>)viewOrLayer withAnchor:(TrPositionAnimationAnchor)anchor {
    
    if (anchor == TrPositionAnimationAnchorAutomatic)
        return ([viewOrLayer isKindOfClass:[UIView class]] ? TrPositionAnimationAnchorTopLeft : TrPositionAnimationAnchorCenter);
    
    return anchor;
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer.presentedLayer withKeyPath:@"position"];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    TrPositionAnimationAnchor useAnchor = [self anchorForViewOrLayer:viewOrLayer
                                                          withAnchor:anchor];
    
    return [super animate:viewOrLayer.animationLayer
                 duration:duration
                    delay:delay
                  keyPath:@"position"
                fromValue:[NSValue valueWithCGPoint:[self position:fromPosition
                                                           ofLayer:viewOrLayer.animationLayer
                                                        fromAnchor:useAnchor]]
                  toValue:[NSValue valueWithCGPoint:[self position:toPosition
                                                           ofLayer:viewOrLayer.animationLayer
                                                        fromAnchor:useAnchor]]
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:fromPosition
              toPosition:toPosition
                  anchor:anchor
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:fromPosition
              toPosition:toPosition
                  anchor:anchor
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:fromPosition
              toPosition:toPosition
                  anchor:TrPositionAnimationAnchorAutomatic
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    // We already convert toPosition to center origin here.
    
    TrPositionAnimationAnchor useAnchor = [self anchorForViewOrLayer:viewOrLayer
                                                          withAnchor:anchor];
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:viewOrLayer.presentedLayer.position
              toPosition:[self position:toPosition
                                ofLayer:viewOrLayer.animationLayer
                             fromAnchor:useAnchor]
                  anchor:TrPositionAnimationAnchorCenter
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              toPosition:toPosition
                  anchor:anchor
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              toPosition:toPosition
                  anchor:anchor
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              toPosition:toPosition
                  anchor:TrPositionAnimationAnchorAutomatic
                   curve:nil
              completion:nil];
    
}

@end
