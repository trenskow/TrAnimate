//
//  TrMoveAnimation.m
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

#import "TrLayerAdditions.h"
#import "TrMoveAnimation.h"

@implementation TrMoveAnimation

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer withKeyPath:@"position"];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve options:(TrMoveAnimationsOptions)options completion:(void (^)(BOOL))completion {
    
    CGPoint finalStartPosition = startPosition;
    CGPoint finalEndPosition = endPosition;
    
    CALayer *layer = TrGetLayer(viewOrLayer);
    
    if (options == kTrMoveAnimationsOptionOriginTopLeft) {
        finalStartPosition.x += layer.bounds.size.width * layer.anchorPoint.x;
        finalStartPosition.y += layer.bounds.size.height * layer.anchorPoint.y;
        finalEndPosition.x += layer.bounds.size.width * layer.anchorPoint.x;
        finalEndPosition.y += layer.bounds.size.height * layer.anchorPoint.y;
    }
    
    return [super animate:viewOrLayer
             layerKeyPath:@"position"
               startValue:[NSValue valueWithCGPoint:finalStartPosition]
                 endValue:[NSValue valueWithCGPoint:finalEndPosition]
                 duration:duration
                    delay:delay
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve options:(TrMoveAnimationsOptions)options completion:(void (^)(BOOL))completion {
    
    CALayer *layer = TrGetLayer(viewOrLayer);
    CGPoint startPosition = TrGetPresentedLayer(viewOrLayer).position;
    
    if (options == kTrMoveAnimationsOptionOriginTopLeft) {
        startPosition.x -= layer.bounds.size.width * layer.anchorPoint.x;
        startPosition.y -= layer.bounds.size.height * layer.anchorPoint.y;
    }
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
           startPosition:startPosition
             endPosition:endPosition
                   curve:curve
                 options:options
              completion:completion];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
             endPosition:endPosition
                   curve:curve
                 options:kTrMoveAnimationsOptionOriginCenter
              completion:completion];
    
}

@end
