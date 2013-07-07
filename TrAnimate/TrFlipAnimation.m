//
//  TrFlipAnimation.m
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

#import "TrCustomCurvedAnimation.h"

#import "TrAnimationSubclass.h"
#import "TrFlipAnimation.h"

@interface TrFlipAnimation () {
    
    TrCustomCurveBlock _curve;
    UIView *_destinationView;
    UIView *_encapsulation;
    
}

@end

@implementation TrFlipAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    if (_destinationView) {
        
        _destinationView.layer.opacity = 1.0f;
        self.view.layer.opacity = .0f;
        
    }
    
}

- (void)animationCompleted:(BOOL)finished {
    
    [super animationCompleted:finished];
    
    if (_destinationView) {
        
        /* Animation is complete so we need to unpack view from encapsulation */
        _destinationView.frame = _encapsulation.frame;
        [_encapsulation.superview insertSubview:_destinationView aboveSubview:_encapsulation];
        
    } else {
        
        self.view.frame = _encapsulation.frame;
        [_encapsulation.superview insertSubview:self.view aboveSubview:_encapsulation];
        
    }
    
    [_encapsulation removeFromSuperview];
    
}

- (void)setupAnimations {
    
    /* We start by encapsulating view into a container view */
    _encapsulation = [[UIView alloc] initWithFrame:self.view.frame];
    _encapsulation.backgroundColor = [UIColor clearColor];
    _encapsulation.opaque = NO;
    
    /* Place views in view hierarki */
    [self.view.superview insertSubview:_encapsulation belowSubview:self.view];
    [_encapsulation addSubview:self.view];
    self.view.frame = _encapsulation.bounds;
    
    /* Hide destination layer as this is the state at animation departure */
    _destinationView.layer.opacity = .0f;
    
    /* Add destination view */
    _destinationView.frame = _encapsulation.bounds;
    
    if (_destinationView)
        [_encapsulation insertSubview:_destinationView atIndex:0];
    
    CATransform3D theTransform = _encapsulation.layer.sublayerTransform;
    theTransform.m34 = 1.0f / -250.0f;
    _encapsulation.layer.sublayerTransform = theTransform;
    
    /* If view should fit context we add a zoom animation */
    if (self.options & kTrFlipAnimationOptionFit) {
        
        TrCustomInterpolationAnimation *encapsulationZoomAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"transform"];
        encapsulationZoomAnimation.interpolation = ^(CGFloat t) {
            CGFloat level = fabs(sin(_curve(t) * M_PI)) * .1f;
            return [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f - level, 1.0f - level, 1.0)];
        };
        
        [self prepareAnimation:encapsulationZoomAnimation usingKey:@"encapsulationZoomAnimation"];
        
        [_encapsulation.layer addAnimation:encapsulationZoomAnimation forKey:nil];
        
    }
    
    CAAnimationGroup *sourceAnimationGroup = [CAAnimationGroup animation];
    
    /* Setup rotation animation for source view */
    TrCustomInterpolationAnimation *sourceRotationAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"transform"];
    sourceRotationAnimation.interpolation = ^(CGFloat t) {
        return [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * _curve(t), .0f, 1.0f, .0f)];
    };
    
    if (_destinationView) {
        
        /* Setup opacity animation for source view - hide halfway */
        TrCustomInterpolationAnimation *sourceOpacityAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"opacity"];
        sourceOpacityAnimation.interpolation = ^(CGFloat t) {
            return (_curve(t) < .5f ? @(1.0f) : @(.0f));
        };
        
        /* Group animations for source view */
        sourceAnimationGroup.animations = @[sourceRotationAnimation, sourceOpacityAnimation];
        
    } else
        sourceAnimationGroup.animations = @[sourceRotationAnimation];
    
    [self prepareAnimation:sourceAnimationGroup usingKey:@"flipSourceAnimation"];
    
    [self.view.layer addAnimation:sourceAnimationGroup forKey:nil];
    
    if (_destinationView) {
        
        CAAnimationGroup *destinationAnimationGroup = [CAAnimationGroup animation];
        
        /* Setup rotation animation for destination view */
        TrCustomInterpolationAnimation *destinationRotationAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"transform"];
        destinationRotationAnimation.interpolation = ^(CGFloat t) {
            return [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI + M_PI * _curve(t), .0f, 1.0f, .0f)];
        };
        
        /* Setup opacity animation for destination view - show halfway */
        TrCustomInterpolationAnimation *destinationOpacityAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"opacity"];
        destinationOpacityAnimation.interpolation = ^(CGFloat t) {
            return (_curve(t) > .5f ? @(1.0f) : @(.0f));
        };
        
        /* Group animations for destination view */
        destinationAnimationGroup.animations = @[destinationRotationAnimation, destinationOpacityAnimation];
        
        [self prepareAnimation:destinationAnimationGroup usingKey:@"flipDestinationAnimation"];
        
        [_destinationView.layer addAnimation:destinationAnimationGroup forKey:nil];
        
    }
    
}

#pragma mark - Creating Animation

+ (id)animateFromView:(UIView *)sourceView toView:(UIView *)destinationView duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrFlipAnimation *animation = [self animateView:sourceView
                                            duration:duration
                                               delay:delay
                                             options:options
                                          completion:completion];
    
    /* Set flip animation instance variables */
    animation->_destinationView = destinationView;
    animation->_curve = curve;
    
    return animation;
    
}

+ (id)animateFromView:(UIView *)sourceView toView:(UIView *)destinationView duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options {
    
    return [self animateFromView:sourceView
                          toView:destinationView
                        duration:duration
                           delay:delay
                         options:options
                           curve:kTrAnimationCurveLinear
                      completion:nil];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animateFromView:view
                          toView:nil
                        duration:duration
                           delay:delay
                         options:options
                           curve:curve
                      completion:completion];
    
}

@end
