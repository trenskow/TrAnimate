//
//  TrScaleAnimation.m
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
#import "TrScaleAnimation.h"

@implementation TrScaleAnimation

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer withKeyPath:@"transform.scale"];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startZoomLevel:(CGFloat)startZoomLevel endZoomLevel:(CGFloat)endZoomLevel curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [super animate:viewOrLayer
             layerKeyPath:@"transform.scale"
               startValue:@(startZoomLevel)
                 endValue:@(endZoomLevel)
                 duration:duration
                    delay:delay
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endZoomLevel:(CGFloat)endZoomLevel curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
          startZoomLevel:[[TrGetLayer(viewOrLayer) valueForKeyPath:@"transform.scale.x"] floatValue]
            endZoomLevel:endZoomLevel
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startZoomLevel:(CGFloat)startZoomLevel endZoomLevel:(CGFloat)endZoomLevel {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
          startZoomLevel:startZoomLevel
            endZoomLevel:endZoomLevel
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
          startZoomLevel:.0f
            endZoomLevel:1.0f
                   curve:nil
              completion:completion];
    
}

@end
