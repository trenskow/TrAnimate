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

#import "TrRotateAnimation.h"

@interface TrAnimation (Private)
@property (weak,nonatomic) UIView *view;
@property (nonatomic) TrAnimationOptions options;
- (void)prepareAnimation:(CAAnimation *)animation usingKey:(NSString *)key;
- (void)animationStarted;
- (void)setupAnimations;
@end

@interface TrRotateAnimation () {
    
    TrCustomCurveBlock _curve;
    CGFloat _startValue;
    CGFloat _endValue;
    
}

@property (nonatomic,readonly) NSString *keyPath;

@end

@implementation TrRotateAnimation

#pragma mark - Internals

- (NSString *)keyPath {
    
    NSString *keyPath = @"transform.rotation.z";
    if (self.options & kTrRotateAnimationOptionsAxisX)
        keyPath = @"transform.rotation.x";
    else if (self.options & kTrRotateAnimationOptionsAxisY)
        keyPath = @"transform.rotation.y";
    
    return keyPath;
        
}

- (void)animationStarted {
    
    [super animationStarted];
    
    /*
     Animation has started. Presentation layer is now present. Set layer to end value so that
     when presentation layer is removed our animation is final.
     */
    
    CGFloat endValue = (_endValue - _startValue) * _curve(1.0f) + _startValue;
    
    [self.view.layer setValue:@(endValue) forKey:self.keyPath];
    
}

- (void)setupAnimations {
    
    /* Create rotation animation */
    TrCustomCurvedAnimation *rotateAnimation = [TrCustomCurvedAnimation animationWithKeyPath:self.keyPath];
    rotateAnimation.curve = _curve;
    rotateAnimation.fromValue = @(_startValue);
    rotateAnimation.toValue = @(_endValue);
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    
    /* Add to observed animations */
    [self prepareAnimation:rotateAnimation usingKey:@"rotateAnimation"];
    
    /* As delay may have been applied, we start by applying the start value to our layer */
    [self.view.layer setValue:@(_startValue) forKey:self.keyPath];
    
    [self.view.layer addAnimation:rotateAnimation forKey:nil];
    
}

#pragma mark - Creating Animation

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle options:(TrRotateAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrRotateAnimation *animation = [super animateView:view
                                               duration:duration
                                                  delay:delay
                                                options:(TrAnimationOptions)options
                                             completion:completion];
    
    animation->_curve = (curve ? curve : kTrAnimationCurveLinear);
    animation->_startValue = startAngle;
    animation->_endValue = endAngle;
    
    return animation;
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                  startAngle:startAngle
                    endAngle:endAngle
                     options:kTrRotateAnimationOptionsAxisZ
                       curve:curve
                  completion:completion];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                  startAngle:startAngle
                    endAngle:endAngle
                     options:kTrRotateAnimationOptionsAxisZ
                       curve:nil
                  completion:nil];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle options:(TrRotateAnimationOptions)options {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                  startAngle:startAngle
                    endAngle:endAngle
                     options:options
                       curve:nil
                  completion:nil];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                  startAngle:.0f
                    endAngle:M_PI
                     options:kTrRotateAnimationOptionsAxisZ
                       curve:nil
                  completion:completion];
        
}

@end
