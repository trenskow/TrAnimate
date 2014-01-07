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
    CALayer *_destinationLayer;
    CALayer *_encapsulationLayer;
    
}

@end

@implementation TrFlipAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    if (_destinationLayer) {
        
        _destinationLayer.opacity = 1.0f;
        self.layer.opacity = .0f;
        
    }
    
}

- (void)animationCompleted:(BOOL)finished {
    
    [super animationCompleted:finished];
    
    if (_destinationLayer) {
        
        /* Animation is complete so we need to unpack view from encapsulation */
        _destinationLayer.bounds = _encapsulationLayer.bounds;
        _destinationLayer.position = _encapsulationLayer.position;
        [_encapsulationLayer.superlayer insertSublayer:_destinationLayer above:_encapsulationLayer];
        
    } else {
        
        self.layer.bounds = _encapsulationLayer.bounds;
        self.layer.position = _encapsulationLayer.position;
        [_encapsulationLayer.superlayer insertSublayer:self.layer above:_encapsulationLayer];
        
    }
    
    [_encapsulationLayer removeFromSuperlayer];
    
}

- (void)setupAnimations {
    
    /* We start by encapsulating layer into a container layer */
    _encapsulationLayer = [[CALayer alloc] init];
    _encapsulationLayer.bounds = self.layer.bounds;
    _encapsulationLayer.position = self.layer.position;
    _encapsulationLayer.backgroundColor = [UIColor clearColor].CGColor;
    _encapsulationLayer.opaque = NO;
    
    /* Place layer in layer hierarki */
    [self.layer.superlayer insertSublayer:_encapsulationLayer below:self.layer];
    [_encapsulationLayer addSublayer:self.layer];
    self.layer.bounds = _encapsulationLayer.bounds;
    self.layer.position = CGPointZero;
    
    /* Hide destination layer as this is the state at animation departure */
    _destinationLayer.opacity = .0f;
    
    /* Add destination view */
    _destinationLayer.bounds = _encapsulationLayer.bounds;
    _destinationLayer.position = CGPointZero;
    
    if (_destinationLayer)
        [_encapsulationLayer insertSublayer:_destinationLayer atIndex:0];
    
    CATransform3D theTransform = _encapsulationLayer.sublayerTransform;
    theTransform.m34 = 1.0f / -250.0f;
    _encapsulationLayer.sublayerTransform = theTransform;
    
    /* If view should fit context we add a zoom animation */
    if (self.options & kTrFlipAnimationOptionFit) {
        
        TrCustomInterpolationAnimation *encapsulationZoomAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"transform"];
        encapsulationZoomAnimation.interpolation = ^(CGFloat t) {
            CGFloat level = fabs(sin(_curve(t) * M_PI)) * .1f;
            return [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f - level, 1.0f - level, 1.0)];
        };
        
        [self prepareAnimation:encapsulationZoomAnimation usingKey:@"encapsulationZoomAnimation"];
        
        [_encapsulationLayer addAnimation:encapsulationZoomAnimation forKey:nil];
        
    }
    
    CAAnimationGroup *sourceAnimationGroup = [CAAnimationGroup animation];
    
    /* Setup rotation animation for source view */
    TrCustomInterpolationAnimation *sourceRotationAnimation = [TrCustomInterpolationAnimation animationWithKeyPath:@"transform"];
    sourceRotationAnimation.interpolation = ^(CGFloat t) {
        return [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * _curve(t), .0f, 1.0f, .0f)];
    };
    
    if (_destinationLayer) {
        
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
    
    [self.layer addAnimation:sourceAnimationGroup forKey:nil];
    
    if (_destinationLayer) {
        
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
        
        [_destinationLayer addAnimation:destinationAnimationGroup forKey:nil];
        
    }
    
}

#pragma mark - Creating Animation

+ (id)animateFrom:(id)sourceViewOrLayer to:(id)destinationViewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrFlipAnimation *animation = [self animate:sourceViewOrLayer
                                      duration:duration
                                         delay:delay
                                       options:options
                                    completion:completion];
    
    /* Set flip animation instance variables */
    if (animation) {
        
        CALayer *destinationLayer = destinationViewOrLayer;
        if ([destinationViewOrLayer isKindOfClass:[UIView class]])
            destinationLayer = ((UIView *)destinationViewOrLayer).layer;
        
        animation->_destinationLayer = destinationLayer;
        animation->_curve = curve;
        
    }
    
    return animation;
    
}

+ (id)animateFrom:(id)sourceViewOrLayer to:(id)destinationViewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options {
    
    return [self animateFrom:sourceViewOrLayer
                          to:destinationViewOrLayer
                    duration:duration
                       delay:delay
                     options:options
                       curve:kTrAnimationCurveLinear
                  completion:nil];
    
}

+ (id)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    return [self animateFrom:viewOrLayer
                          to:nil
                    duration:duration
                       delay:delay
                     options:options
                       curve:curve
                  completion:completion];
    
}

@end
