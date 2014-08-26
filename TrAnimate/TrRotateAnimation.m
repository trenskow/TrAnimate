//
//  TrRotateAnimation.m
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

#import "TrAnimatable.h"

#import "TrRotateAnimation.h"

@implementation TrRotateAnimation

#pragma mark - Internal

+ (NSString *)keyPathForAxis:(TrRotateAnimationAxis)axis {
    
    if (axis == TrRotateAnimationAxisX)
        return @"transform.rotation.x";
    if (axis == TrRotateAnimationAxisY)
        return @"transform.rotation.y";
    
    return @"transform.rotation.z";
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer withAxis:(TrRotateAnimationAxis)axis {
    
    return [super inProgressOn:viewOrLayer.presentedLayer withKeyPath:[self keyPathForAxis:axis]];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [super animate:viewOrLayer.animationLayer
                 duration:duration
                    delay:delay
                  keyPath:[self keyPathForAxis:axis]
                fromValue:@(fromAngle)
                  toValue:@(toAngle)
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               fromAngle:fromAngle
                 toAngle:toAngle
                    axis:axis
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               fromAngle:fromAngle
                 toAngle:toAngle
                    axis:axis
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               fromAngle:fromAngle
                 toAngle:toAngle
                    axis:TrRotateAnimationAxisZ
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               fromAngle:[[viewOrLayer.presentedLayer valueForKeyPath:[self keyPathForAxis:axis]] doubleValue]
                 toAngle:toAngle
                    axis:axis
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 toAngle:toAngle
                    axis:axis
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 toAngle:toAngle
                    axis:axis
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 toAngle:toAngle
                    axis:TrRotateAnimationAxisZ
                   curve:nil
              completion:nil];
    
}

@end
