//
//  TrPositionAnimation.m
//  TrAnimate
//
//  Copyright (c) 2013, Kristian Trenskow All rights reserved.
//
//  Redistribution and use in source and binary forms, with or
//  without modification, are permitted provided that the following
//  conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following
//  disclaimer in the documentation and/or other materials provided
//  with the distribution. THIS SOFTWARE IS PROVIDED BY THE
//  COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
//  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

@import UIKit;

#import "NSValue+TrAnimateAdditions.h"

#import "TrAnimatable.h"

#import "TrPositionAnimation.h"

@implementation TrPositionAnimation

#pragma mark - Internal

+ (CGPoint)position:(CGPoint)position ofLayer:(CALayer *)layer fromOrigin:(TrPositionAnimationOrigin)origin {
    
    if (origin == TrPositionAnimationOriginTopLeft)
        return CGPointMake(position.x + layer.bounds.size.width * layer.anchorPoint.x,
                           position.y + layer.bounds.size.height * layer.anchorPoint.y);
    
    return position;
    
}

+ (TrPositionAnimationOrigin)originForViewOrLayer:(id<TrAnimatable>)viewOrLayer withOrigin:(TrPositionAnimationOrigin)origin {
    
    if (origin == TrPositionAnimationOriginAutomatic)
        return ([viewOrLayer isKindOfClass:[UIView class]] ? TrPositionAnimationOriginTopLeft : TrPositionAnimationOriginCenter);
    
    return origin;
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer withKeyPath:@"position"];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    TrPositionAnimationOrigin useOrigin = [self originForViewOrLayer:viewOrLayer
                                                          withOrigin:origin];
    
    return [super animate:viewOrLayer
                 duration:duration
                    delay:delay
             layerKeyPath:@"position"
                fromValue:[NSValue valueWithCGPoint:[self position:fromPosition
                                                           ofLayer:viewOrLayer.animationLayer
                                                        fromOrigin:useOrigin]]
                  toValue:[NSValue valueWithCGPoint:[self position:toPosition
                                                           ofLayer:viewOrLayer.animationLayer
                                                        fromOrigin:useOrigin]]
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:fromPosition
              toPosition:toPosition
                  origin:origin
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:fromPosition
              toPosition:toPosition
                  origin:origin
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
                  origin:TrPositionAnimationOriginAutomatic
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    // We already convert toPosition to center origin here.
    
    TrPositionAnimationOrigin useOrigin = [self originForViewOrLayer:viewOrLayer
                                                          withOrigin:origin];
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            fromPosition:viewOrLayer.presentedLayer.position
              toPosition:[self position:toPosition
                                ofLayer:viewOrLayer.animationLayer
                             fromOrigin:useOrigin]
                  origin:TrPositionAnimationOriginCenter
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              toPosition:toPosition
                  origin:origin
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 origin:(TrPositionAnimationOrigin)origin {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              toPosition:toPosition
                  origin:origin
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
                  origin:TrPositionAnimationOriginAutomatic
                   curve:nil
              completion:nil];
    
}

@end
