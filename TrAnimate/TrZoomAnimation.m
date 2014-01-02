//
//  TrZoomAnimation.m
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
#import "TrZoomAnimation.h"

@interface TrZoomAnimation () {
    
    TrCustomCurveBlock _curve;
    CGFloat _startValue;
    CGFloat _endValue;
    
}

@end

@implementation TrZoomAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    CGFloat endValue = (_endValue - _startValue) * _curve(1.0f) + _startValue;
    
    self.view.layer.transform = CATransform3DMakeScale(endValue, endValue, 1.0);
    
}

- (void)setupAnimations {
        
    /* Setup zoom animation */
    TrCustomCurvedAnimation *zoomAnimation = [TrCustomCurvedAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.curve = _curve;
    zoomAnimation.fromValue = @(_startValue);
    zoomAnimation.toValue = @(_endValue);
    
    [self prepareAnimation:zoomAnimation usingKey:@"zoomAnimation"];
    
    [self.view.layer addAnimation:zoomAnimation forKey:nil];
    
}

#pragma mark - Creating Animation

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startZoomLevel:(CGFloat)startZoomLevel endZoomLevel:(CGFloat)endZoomLevel curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrZoomAnimation *animation = [super animateView:view
                                             duration:duration
                                                delay:delay
                                              options:0
                                           completion:completion];
    
    if (animation) {
        animation->_curve = (curve ? curve : kTrAnimationCurveLinear);
        animation->_startValue = startZoomLevel;
        animation->_endValue = endZoomLevel;
    }
    
    return animation;
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startZoomLevel:(CGFloat)startZoomLevel endZoomLevel:(CGFloat)endZoomLevel {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
              startZoomLevel:startZoomLevel
                endZoomLevel:endZoomLevel
                       curve:nil
                  completion:nil];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
              startZoomLevel:.0f
                endZoomLevel:1.0f
                       curve:nil
                  completion:completion];
    
}

@end
