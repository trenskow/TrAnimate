//
//  TrRotateAnimation.m
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

#import "NSNumber+TrCustomCurvedAnimationAdditions.h"

#import "TrRotateAnimation.h"

@implementation TrRotateAnimation

#pragma mark - Creating Animation

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle options:(TrRotateAnimationOptions)options curve:(TrCurve)curve completion:(void (^)(BOOL))completion {
    
    NSString *keyPath = @"transform.rotation.z";
    if (options & kTrRotateAnimationOptionsAxisX)
        keyPath = @"transform.rotation.x";
    else if (options & kTrRotateAnimationOptionsAxisY)
        keyPath = @"transform.rotation.y";
    
    return [super animate:viewOrLayer
             layerKeyPath:keyPath
               startValue:@(startAngle)
                 endValue:@(endAngle)
                 duration:duration
                    delay:delay
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle curve:(TrCurve)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              startAngle:startAngle
                endAngle:endAngle
                 options:kTrRotateAnimationOptionsAxisZ
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              startAngle:startAngle
                endAngle:endAngle
                 options:kTrRotateAnimationOptionsAxisZ
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle options:(TrRotateAnimationOptions)options {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              startAngle:startAngle
                endAngle:endAngle
                 options:options
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrRotateAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
              startAngle:.0
                endAngle:M_PI
                 options:kTrRotateAnimationOptionsAxisZ
                   curve:nil
              completion:completion];
    
}

@end
