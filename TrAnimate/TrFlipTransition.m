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

// Some convinience methods for getting the axis and CALayer keyPaths of the flip.
static TrRotateAnimationAxis rotationAxisForDirection(TrFlipTransitionDirection direction) {
    if (direction == TrFlipTransitionDirectionDown || direction == TrFlipTransitionDirectionUp)
        return TrRotateAnimationAxisX;
    return TrRotateAnimationAxisY;
}

static NSString *layerKeyPathForAxis(TrRotateAnimationAxis axis) {
    if (axis == TrRotateAnimationAxisX)
        return @"transform.rotation.x";
    return @"transform.rotation.y";
}

@interface TrFlipTransition ()

@property (nonatomic) UIView *encapsulationView;
@property (nonatomic) TrFlipTransitionDirection direction;

@end

@implementation TrFlipTransition

#pragma mark - Setup / Tear Down

- (instancetype)initWithSourceView:(UIView *)sourceView
                   destinationView:(UIView *)destinationView
                          duration:(NSTimeInterval)duration
                             delay:(NSTimeInterval)delay
                             curve:(TrCurve *)curve
                         direction:(TrFlipTransitionDirection)direction
                        completion:(void (^)(BOOL))completion {
    
    self = [super initWithSourceView:sourceView
                     destinationView:destinationView
                            duration:duration
                               delay:delay
                               curve:curve
                          completion:completion];
    
    if (self)
        self.direction = direction;
    
    return self;
    
}

#pragma mark - Internals

- (void)animationsCompleted:(BOOL)finished {
    
    // Apply frame and add destination view to source view's original place in hierarchy.
    self.sourceView.frame = self.destinationView.frame = self.encapsulationView.frame;
    [self.encapsulationView.superview addSubview:self.destinationView];
    
    // Remove source view and encapsulation view.
    [self.sourceView removeFromSuperview];
    [self.encapsulationView removeFromSuperview];
    
    self.sourceView.hidden = YES;
    self.sourceView.alpha = 1.0;
    
    // Reset source view rotation.
    [self.sourceView.layer setValue:@(.0) forKeyPath:layerKeyPathForAxis(rotationAxisForDirection(self.direction))];
    
}

- (void)setupAnimations {
    
    // Create an encapsulation view that will contain the views doing animation.
    self.encapsulationView = [UIView new];
    self.encapsulationView.backgroundColor = [UIColor clearColor];
    self.encapsulationView.opaque = NO;
    self.encapsulationView.frame = self.sourceView.frame;
    
    // Add encapsulation view to view hierarchy.
    [self.sourceView.superview addSubview:self.encapsulationView];
    
    self.sourceView.frame = self.destinationView.frame = self.encapsulationView.bounds;
    
    // Hide destinationView.
    self.destinationView.alpha = .0;
    self.destinationView.hidden = NO;
    
    // Add views to encapsulation view.
    [self.encapsulationView addSubview:self.sourceView];
    [self.encapsulationView addSubview:self.destinationView];
    
    // Apply perspective.
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -500.0;
    self.encapsulationView.layer.sublayerTransform = sublayerTransform;
    
    // Adjust angle calculation according to direction.
    CGFloat delta = 1.0;
    if (self.direction == TrFlipTransitionDirectionDown || self.direction == TrFlipTransitionDirectionRight)
        delta = -1.0;
    
    // Get the axis for the direction.
    TrRotateAnimationAxis axis = rotationAxisForDirection(self.direction);
    
    // Rotate the destination view to it's initial position.
    [self.destinationView.layer setValue:@(M_PI * delta) forKey:layerKeyPathForAxis(axis)];
    
    // Source view rotation animation.
    TrRotateAnimation *fromViewRotationAnimation = [TrRotateAnimation animate:self.sourceView
                                                                     duration:self.applyDuration
                                                                        delay:self.applyDelay
                                                                    fromAngle:.0
                                                                      toAngle:M_PI * delta
                                                                         axis:axis
                                                                        curve:self.applyCurve
                                                                   completion:nil];
    
    // Destination view rotation animation.
    // To and from values are ignored in our custom interpolation below.
    TrRotateAnimation *toViewRotationAnimation = [TrRotateAnimation animate:self.destinationView
                                                                   duration:self.applyDuration
                                                                      delay:self.applyDelay
                                                                  fromAngle:.0
                                                                    toAngle:.0
                                                                       axis:axis
                                                                      curve:self.applyCurve];
    
    // We use a custom interpolation to ensure rotation is in correct direction. */
    toViewRotationAnimation.interpolation = [TrInterpolation interpolationWithBlock:^id<TrInterpolatable>(id<TrInterpolatable> fromValue, id<TrInterpolatable> toValue, double position) {
        return @(M_PI + M_PI * position * delta);
    }];
    
    __weak TrCurve *curve = self.applyCurve;
    
    // We create a custom curvature returns 0.0 when t is below 0.5 - otherwise 1.0.
    // Applied to an opacity animation in order to hide the source view and show the destination view
    // when the rotation animation is halfway.
    TrCurve *halfwayCurve = [TrCurve curveWithBlock:^double(double t) {
        if (curve)
            return ([curve transform:t] >= .5 ? 1.0 : .0);
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
    
    // Add animations to group.
    [self addAnimations:@[fromViewRotationAnimation,
                          toViewRotationAnimation,
                          fromViewOpacityAnimation,
                          toViewOpacityAnimation]];
    
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
        [NSException raise:@"NotInViewHierarchyException" format:@"View sourceView must be added to a view heirarchy."];
    
    return [[self alloc] initWithSourceView:sourceView
                            destinationView:destinationView
                                   duration:duration
                                      delay:delay
                                      curve:curve
                                  direction:direction
                                 completion:completion];
    
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
