//
//  TrFadeOutAnimation.m
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

#import "TrAnimationSubclass.h"

#import "TrFadeAnimation.h"

@implementation TrFadeAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    self.layer.hidden = NO;
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer {
    
    return [self inProgressOn:viewOrLayer withKeyPath:@"opacity"];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startValue:(CGFloat)startValue endValue:(CGFloat)endValue curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
            layerKeyPath:@"opacity"
              startValue:@(startValue)
                endValue:@(endValue)
                duration:duration
                   delay:delay
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endValue:(CGFloat)endValue curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrFadeAnimation *animation = [self animate:viewOrLayer
                                      duration:duration
                                         delay:delay
                                    startValue:viewOrLayer.presentedLayer.opacity
                                      endValue:endValue
                                         curve:curve
                                    completion:completion];
    
    return animation;
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve fadesIn:(BOOL)fadesIn completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                endValue:(fadesIn ? 1.0 : .0)
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay fadesIn:(BOOL)fadesIn completion:(void (^)(BOOL))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                   curve:kTrAnimationCurveLinear
                 fadesIn:fadesIn
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay fadesIn:(BOOL)fadesIn {
    
    return [self animate:viewOrLayer duration:duration delay:delay fadesIn:fadesIn completion:nil];
    
}

@end
