//
//  TrOpacityAnimation.m
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

#import "NSNumber+TrAnimateAdditions.h"
#import "CALayer+TrAnimateAdditions.h"

#import "TrCurve.h"
#import "TrAnimatable.h"

#import "TrLayerAnimation+Private.h"

#import "TrOpacityAnimation.h"

@implementation TrOpacityAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    self.layer.hidden = NO;
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer.presentedLayer withKeyPath:@"opacity"];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [super animate:viewOrLayer.animationLayer
                 duration:duration
                    delay:delay
                  keyPath:@"opacity"
                fromValue:@(fromOpacity)
                  toValue:@(toOpacity)
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer.animationLayer
                duration:duration
                   delay:delay
             fromOpacity:fromOpacity
               toOpacity:toOpacity
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
             fromOpacity:fromOpacity
               toOpacity:toOpacity
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
             fromOpacity:viewOrLayer.presentedLayer.opacity
               toOpacity:toOpacity
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               toOpacity:toOpacity
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               toOpacity:toOpacity
                   curve:nil
              completion:nil];
    
}

@end
