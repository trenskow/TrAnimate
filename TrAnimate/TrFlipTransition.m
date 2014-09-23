//
//  TrFlipTransition.h
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

#import "UIView+TrAnimateAdditions.h"
#import "NSNumber+TrAnimateAdditions.h"

#import "TrInterpolation.h"
#import "TrCurve.h"
#import "TrRotateAnimation.h"
#import "TrOpacityAnimation.h"

#import "TrFlipTransition.h"

@implementation TrFlipTransition

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    UIView *encapsulationView = [UIView new];
    encapsulationView.backgroundColor = [UIColor clearColor];
    encapsulationView.opaque = NO;
    encapsulationView.frame = sourceView.frame;
    
    [sourceView.superview addSubview:encapsulationView];
    
    sourceView.frame = destinationView.frame = encapsulationView.bounds;
    
    destinationView.alpha = .0;
    destinationView.hidden = NO;
    
    [encapsulationView addSubview:sourceView];
    [encapsulationView addSubview:destinationView];
    
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -500.0;
    encapsulationView.layer.sublayerTransform = sublayerTransform;
    
    TrRotateAnimationAxis axis = TrRotateAnimationAxisY;
    NSString *keyPath = @"transform.rotation.y";
    if (direction == TrFlipTransitionDirectionDown || direction == TrFlipTransitionDirectionUp) {
        axis = TrRotateAnimationAxisX;
        keyPath = @"transform.rotation.x";
    }
    
    CGFloat delta = 1.0;
    if (direction == TrFlipTransitionDirectionDown || direction == TrFlipTransitionDirectionRight)
        delta = -1.0;
    
    [destinationView.layer setValue:@(M_PI * delta) forKey:keyPath];
    
    TrRotateAnimation *fromViewRotationAnimation = [TrRotateAnimation animate:sourceView
                                                                     duration:duration
                                                                        delay:delay
                                                                    fromAngle:.0
                                                                      toAngle:M_PI * delta
                                                                         axis:axis
                                                                        curve:curve
                                                                   completion:nil];
    
    /* To and from values are ignored in our custom interpolation below. */
    TrRotateAnimation *toViewRotationAnimation = [TrRotateAnimation animate:destinationView
                                                                   duration:duration
                                                                      delay:delay
                                                                  fromAngle:.0
                                                                    toAngle:.0
                                                                       axis:axis];
    
    // We use a custom interpolation to ensure rotation is in correct direction. */
    toViewRotationAnimation.interpolation = [TrInterpolation interpolationWithBlock:^id<TrInterpolatable>(id<TrInterpolatable> fromValue, id<TrInterpolatable> toValue, double position) {
        return @(M_PI + M_PI * [(curve ?: [TrCurve linear]) transform:position] * delta);
    }];
    
    TrCurve *halfwayCurve = [TrCurve curveWithBlock:^double(double t) {
        if (curve)
            return ([curve transform:t] >= .5 ? 1.0 : .0);
        return (t >= .5 ? 1.0 : .0);
    }];
    
    TrOpacityAnimation *fromViewOpacityAnimation = [TrOpacityAnimation animate:sourceView
                                                                      duration:duration
                                                                         delay:delay
                                                                   fromOpacity:1.0
                                                                     toOpacity:.0
                                                                         curve:halfwayCurve];
    
    TrOpacityAnimation *toViewOpacityAnimation = [TrOpacityAnimation animate:destinationView
                                                                    duration:duration
                                                                       delay:delay
                                                                 fromOpacity:.0
                                                                   toOpacity:1.0
                                                                       curve:halfwayCurve];
    
    return [self animationGroupWithAnimations:@[fromViewRotationAnimation,
                                                toViewRotationAnimation,
                                                fromViewOpacityAnimation,
                                                toViewOpacityAnimation]
                                   completion:^(BOOL finished) {
                                       
                                       sourceView.frame = destinationView.frame = encapsulationView.frame;
                                       [encapsulationView.superview addSubview:destinationView];
                                       
                                       [sourceView removeFromSuperview];
                                       [encapsulationView removeFromSuperview];
                                       
                                       sourceView.hidden = YES;
                                       sourceView.alpha = 1.0;
                                       [sourceView.layer setValue:@(.0) forKeyPath:keyPath];
                                       
                                       if (completion)
                                           completion(finished);
                                       
                                   }];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                      direction:direction
                          delay:delay
                          curve:curve
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                      direction:direction
                          delay:delay
                          curve:nil
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                      direction:direction
                          delay:.0
                          curve:nil
                     completion:nil];
    
}

@end
