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

#import "TrPositionAnimation.h"

@implementation TrPositionAnimation

#pragma mark - Internal

+ (CGPoint)position:(CGPoint)position ofLayer:(CALayer *)layer fromOptions:(TrPositionAnimationsOptions)options {
    
    if (options == kTrPositionAnimationsOptionOriginTopLeft)
        return CGPointMake(position.x + layer.bounds.size.width * layer.anchorPoint.x,
                           position.y + layer.bounds.size.height * layer.anchorPoint.y);
    
    return position;
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer withKeyPath:@"position"];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve options:(TrPositionAnimationsOptions)options completion:(void (^)(BOOL))completion {
    
    return [super animate:viewOrLayer
             layerKeyPath:@"position"
               startValue:[NSValue valueWithCGPoint:[self position:startPosition
                                                           ofLayer:viewOrLayer.animationsLayer
                                                       fromOptions:options]]
                 endValue:[NSValue valueWithCGPoint:[self position:endPosition
                                                           ofLayer:viewOrLayer.animationsLayer
                                                       fromOptions:options]]
                 duration:duration
                    delay:delay
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
           startPosition:startPosition
             endPosition:endPosition
                   curve:curve
                 options:([viewOrLayer isKindOfClass:[UIView class]] ?
                          kTrPositionAnimationsOptionOriginTopLeft :
                          kTrPositionAnimationsOptionOriginCenter)
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve options:(TrPositionAnimationsOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
           startPosition:viewOrLayer.animationsLayer.position
             endPosition:[self position:endPosition
                                ofLayer:viewOrLayer.animationsLayer
                            fromOptions:options]
                   curve:curve
                 options:kTrPositionAnimationsOptionOriginCenter
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
             endPosition:endPosition
                   curve:curve
                 options:([viewOrLayer isKindOfClass:[UIView class]] ?
                          kTrPositionAnimationsOptionOriginTopLeft :
                          kTrPositionAnimationsOptionOriginCenter)
              completion:completion];
    
}

@end