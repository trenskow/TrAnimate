//
//  TrLayerAnimation.m
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

#import "NSObject+TrAnimationsAddition.h"
#import "CALayer+TrAnimateAdditions.h"

#import "TrAnimation.h"
#import "TrDirectCurvedInterpolation.h"
#import "TrCurve.h"
#import "TrBasicAnimation.h"
#import "TrAnimatable.h"

#import "TrLayerAnimation+Private.h"

#define ANIMATION_KEY_FOR_KEYPATH(x) [NSString stringWithFormat:@"layerAnimation.%@", x]

const void *TrAnimationLayerKey;

NSString *const TrLayerAnimationKey = @"TrAnimationKey";

@interface TrLayerAnimation ()

@property (nonatomic,copy) NSString *keyPath;
@property (nonatomic,copy) id<TrInterpolatable> fromValue;
@property (nonatomic,copy) id<TrInterpolatable> toValue;

@property (nonatomic,getter = isAnimating) BOOL animating;
@property (nonatomic,getter = isComplete) BOOL complete;
@property (nonatomic,getter = isFinished) BOOL finished;
@property (copy,nonatomic) TrCurve *curve;
@property (copy,nonatomic) void(^completionBlock)(BOOL finished);
@property (weak,readwrite,nonatomic) CALayer *layer;

@end

@implementation TrLayerAnimation

#pragma mark - Setup / Teardown

- (instancetype)initWithLayer:(CALayer *)layer
                     duration:(NSTimeInterval)duration
                        delay:(NSTimeInterval)delay
                      keyPath:(NSString *)keyPath
                    fromValue:(id<TrInterpolatable>)fromValue
                      toValue:(id<TrInterpolatable>)toValue
                        curve:(TrCurve *)curve
                   completion:(void (^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        [[self class] cancelAnimationOn:layer withKeyPath:keyPath];
        
        self.layer = layer;
        self.duration = duration;
        self.delay = delay;
        self.keyPath = keyPath;
        self.fromValue = fromValue;
        self.toValue = toValue;
        self.curve = curve;
        self.completionBlock = completion;
        
        /* Associate animation object with layer, so it won't be released doing animation */
        [layer associateAnimation:self];
        
    }
    
    return self;
    
}

#pragma mark - Properties

@synthesize delay=_delay;

#pragma mark - Internal

- (void)animationDidStart:(TrBasicAnimation *)anim {
    
    [self animationStarted];
    
}

- (void)animationDidStop:(TrBasicAnimation *)anim finished:(BOOL)flag {
    
    [self animationCompleted:flag];
    
    if (self.completionBlock)
        self.completionBlock(flag);
    
    self.finished = flag;
    self.complete = YES;
    
    /* Remove animation from view so it can be released */
    [self.layer removeAnimationAssociation:self];
    
}

- (void)prepareAnimation:(TrBasicAnimation *)animation usingKey:(NSString *)key {
    
    animation.duration = self.duration;
    animation.interpolation = self.interpolation;
    
    [animation setValue:key forKey:TrLayerAnimationKey];
    
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:key];
    
}

- (void)beginAnimation {
    
    if (!self.isAnimating) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
        self.animating = YES;
        [self performSelector:@selector(setupAnimations)
                   withObject:nil
                   afterDelay:self.delay
                      inModes:@[NSRunLoopCommonModes]];
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

- (void)animationStarted {
    
    [self.layer setValue:[self.interpolation interpolateFromValue:self.fromValue
                                                          toValue:self.toValue
                                                         position:1.0]
              forKeyPath:self.keyPath];
    
}

- (void)animationCompleted:(BOOL)finished { }

- (void)setupAnimations {
    
    self.fromValue = (self.fromValue ?: [self.layer valueForKeyPath:self.keyPath]);
    
    TrBasicAnimation *customAnimation = [TrBasicAnimation animationWithKeyPath:self.keyPath];
    customAnimation.fromValue = self.fromValue;
    customAnimation.toValue = self.toValue;
    
    [self.layer setValue:[self.interpolation interpolateFromValue:self.fromValue
                                                          toValue:self.toValue
                                                         position:1.0]
              forKeyPath:self.keyPath];
    
    [self prepareAnimation:customAnimation usingKey:ANIMATION_KEY_FOR_KEYPATH(self.keyPath)];
    
}

- (void)cancel {
    
    // Animation has not yet begun
    if (!self.isAnimating && !self.isComplete) {
        
        [self postponeAnimation];
        
    } else if (self.isAnimating && !self.isComplete) {
        
        // We need to determine if we are on a delay or on actually animating.
        // We do that by checking if the animation has been added to the layer.
        
        // Animation is in it's delay.
        if (![self.layer animationForKey:ANIMATION_KEY_FOR_KEYPATH(self.keyPath)]) {
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setupAnimations) object:nil];
            [self animationDidStop:nil finished:NO];
            
        } else { // Animation is in progress.
            
            [self.layer setValue:[self.layer.presentationLayer valueForKeyPath:self.keyPath]
                      forKeyPath:self.keyPath];
            [self.layer removeAnimationForKey:ANIMATION_KEY_FOR_KEYPATH(self.keyPath)];
            
        }
        
    }
    
}

+ (TrLayerAnimation *)animationOn:(CALayer *)layer withKeyPath:(NSString *)keyPath {
    
    for (id animation in layer.associatedAnimations)
        if ([animation isKindOfClass:[TrLayerAnimation class]])
            if ([((TrLayerAnimation *)animation).keyPath isEqualToString:keyPath])
                return animation;
    
    return nil;
    
}

#pragma mark - Properties

- (TrCurve *)curve {
    
    if ([self.interpolation isKindOfClass:[TrDirectCurvedInterpolation class]])
        return ((TrDirectCurvedInterpolation *)self.interpolation).curve;
    
    return nil;
    
}

- (void)setCurve:(TrCurve *)curve {
    
    self.interpolation = [TrDirectCurvedInterpolation interpolationWithCurve:(curve ?: [TrCurve linear])];
    
}

#pragma mark - Actions and Information

+ (void)cancelAnimationOn:(CALayer *)layer withKeyPath:(NSString *)keyPath {
    
    [[self animationOn:layer withKeyPath:keyPath] cancel];
    
}

+ (BOOL)inProgressOn:(CALayer *)layer withKeyPath:(NSString *)keyPath {
    
    return ([self animationOn:layer withKeyPath:keyPath] != nil);
        
}

#pragma mark - Creating Animation

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    if (!layer)
        return nil;
    
    TrLayerAnimation *animation = [[self alloc] initWithLayer:layer
                                                     duration:duration
                                                        delay:delay
                                                      keyPath:keyPath
                                                    fromValue:fromValue
                                                      toValue:toValue
                                                        curve:curve
                                                   completion:completion];
    
    if (fromValue)
        [layer setValue:fromValue forKeyPath:keyPath];
    
    [animation performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
    
    return animation;
    
}

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:layer
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:layer
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [self animate:layer
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:nil
                 toValue:toValue
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:layer
                duration:duration
                   delay:delay
                 keyPath:keyPath
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:layer
                duration:duration
                   delay:delay
                 keyPath:keyPath
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

@end
