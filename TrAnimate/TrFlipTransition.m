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

#import "TrAnimationGroup+Private.h"

#import "TrFlipTransition.h"

@interface TrFlipTransition ()

@property (nonatomic) UIView *encapsulationView;
@property (nonatomic,weak) UIView *sourceView;
@property (nonatomic,weak) UIView *destinationView;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) TrFlipTransitionDirection direction;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *curve;

@end

@implementation TrFlipTransition

#pragma mark - Internals

- (TrRotateAnimationAxis)axisForDirection:(TrFlipTransitionDirection)direction {
    
    if (self.direction == TrFlipTransitionDirectionDown || self.direction == TrFlipTransitionDirectionUp)
        return TrRotateAnimationAxisX;
    
    return TrRotateAnimationAxisY;
    
}

- (NSString *)keyPathForAxis:(TrRotateAnimationAxis)axis {
    
    if (axis == TrRotateAnimationAxisX)
        return @"transform.rotation.x";
    
    return @"transform.rotation.y";
    
}

- (void)animationsCompleted:(BOOL)finished {
    
    self.sourceView.frame = self.destinationView.frame = self.encapsulationView.frame;
    [self.encapsulationView.superview addSubview:self.destinationView];
    
    [self.sourceView removeFromSuperview];
    [self.encapsulationView removeFromSuperview];
    
    self.sourceView.hidden = YES;
    self.sourceView.alpha = 1.0;
    [self.sourceView.layer setValue:@(.0) forKeyPath:[self keyPathForAxis:[self axisForDirection:self.direction]]];
    
}

- (void)setupAnimations {
    
    self.encapsulationView = [UIView new];
    self.encapsulationView.backgroundColor = [UIColor clearColor];
    self.encapsulationView.opaque = NO;
    self.encapsulationView.frame = self.sourceView.frame;
    
    [self.sourceView.superview addSubview:self.encapsulationView];
    
    self.sourceView.frame = self.destinationView.frame = self.encapsulationView.bounds;
    
    self.destinationView.alpha = .0;
    self.destinationView.hidden = NO;
    
    [self.encapsulationView addSubview:self.sourceView];
    [self.encapsulationView addSubview:self.destinationView];
    
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -500.0;
    self.encapsulationView.layer.sublayerTransform = sublayerTransform;
    
    CGFloat delta = 1.0;
    if (self.direction == TrFlipTransitionDirectionDown || self.direction == TrFlipTransitionDirectionRight)
        delta = -1.0;
    
    TrRotateAnimationAxis axis = [self axisForDirection:self.direction];
    
    [self.destinationView.layer setValue:@(M_PI * delta) forKey:[self keyPathForAxis:axis]];
    
    TrRotateAnimation *fromViewRotationAnimation = [TrRotateAnimation animate:self.sourceView
                                                                     duration:self.applyDuration
                                                                        delay:self.applyDelay
                                                                    fromAngle:.0
                                                                      toAngle:M_PI * delta
                                                                         axis:axis
                                                                        curve:self.curve
                                                                   completion:nil];
    
    /* To and from values are ignored in our custom interpolation below. */
    TrRotateAnimation *toViewRotationAnimation = [TrRotateAnimation animate:self.destinationView
                                                                   duration:self.applyDuration
                                                                      delay:self.applyDelay
                                                                  fromAngle:.0
                                                                    toAngle:.0
                                                                       axis:axis];
    
    // We use a custom interpolation to ensure rotation is in correct direction. */
    toViewRotationAnimation.interpolation = [TrInterpolation interpolationWithBlock:^id<TrInterpolatable>(id<TrInterpolatable> fromValue, id<TrInterpolatable> toValue, double position) {
        return @(M_PI + M_PI * [(self.curve ?: [TrCurve linear]) transform:position] * delta);
    }];
    
    TrCurve *halfwayCurve = [TrCurve curveWithBlock:^double(double t) {
        if (self.curve)
            return ([self.curve transform:t] >= .5 ? 1.0 : .0);
        return (t >= .5 ? 1.0 : .0);
    }];
    
    TrOpacityAnimation *fromViewOpacityAnimation = [TrOpacityAnimation animate:self.sourceView
                                                                      duration:self.applyDuration
                                                                         delay:self.applyDelay
                                                                   fromOpacity:1.0
                                                                     toOpacity:.0
                                                                         curve:halfwayCurve];
    
    TrOpacityAnimation *toViewOpacityAnimation = [TrOpacityAnimation animate:self.destinationView
                                                                    duration:self.applyDuration
                                                                       delay:self.applyDelay
                                                                 fromOpacity:.0
                                                                   toOpacity:1.0
                                                                       curve:halfwayCurve];
    
    [self addAnimations:@[fromViewRotationAnimation,
                          toViewRotationAnimation,
                          fromViewOpacityAnimation,
                          toViewOpacityAnimation]];
    
}

#pragma mark - Properties

- (void)setDelay:(NSTimeInterval)delay {
    
    [super setDelay:delay];
    self.applyDelay = delay;
    
}

#pragma mark - Creating Transition

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    if (!sourceView.superview)
        [NSException raise:@"NotInViewHierarchy" format:@"View sourceView must be added to a view heirarchy."];
    
    TrFlipTransition *flipTransition = [self animationGroupWithCompletion:completion];
    
    flipTransition.sourceView = sourceView;
    flipTransition.destinationView = destinationView;
    flipTransition.applyDuration = duration;
    flipTransition.direction = direction;
    flipTransition.applyDelay = delay;
    flipTransition.curve = curve;
    
    return flipTransition;
    
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
