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

@import ObjectiveC.runtime;

#import "CALayer+TrAnimateAdditions.h"

#import "TrAnimation.h"
#import "TrCurve.h"
#import "TrCustomCurvedAnimation.h"
#import "TrAnimatable.h"
#import "TrInterpolatable.h"

#import "TrLayerAnimation+Private.h"

const void *TrAnimationLayerKey;

NSString *const TrAnimationKey = @"TrAnimationKey";

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
        
        self.layer = layer;
        self.duration = duration;
        self.delay = delay;
        self.keyPath = keyPath;
        self.fromValue = fromValue;
        self.toValue = toValue;
        self.curve = (curve ?: [TrCurve linear]);
        self.completionBlock = completion;
        
        /* Associate animation object with view, so it won't be released doing animation */
        objc_setAssociatedObject(self.layer, &TrAnimationLayerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return self;
    
}

#pragma mark - Properties

@synthesize delay=_delay;

#pragma mark - Internal

- (void)animationDidStart:(TrCustomCurvedAnimation *)anim {
    
    [self animationStarted];
    
}

- (void)animationDidStop:(TrCustomCurvedAnimation *)anim finished:(BOOL)flag {
    
    [self animationCompleted:flag];
    
    if (self.completionBlock)
        self.completionBlock(flag);
    
    self.complete = YES;
    self.finished = flag;
    
    /* Remove animation from view so it can be released */
    objc_setAssociatedObject(self.layer, &TrAnimationLayerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)prepareAnimation:(TrCustomCurvedAnimation *)animation usingKey:(NSString *)key {
    
#if defined(TR_ANIMATION_VIEW_DEBUG)
    animation.duration = self.duration * 10.0;
#else
    animation.duration = self.duration;
#endif
    
    animation.curve = self.curve;
    
    [animation setValue:key forKey:TrAnimationKey];
    
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:key];
    
}

- (void)beginAnimation {
    
    if (!self.isAnimating) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
        self.animating = YES;
        [self performSelector:@selector(setupAnimations)
                   withObject:nil
#if defined(TR_ANIMATION_VIEW_DEBUG)
                   afterDelay:self.delay * 10.0
#else
                   afterDelay:self.delay
#endif
                      inModes:@[NSRunLoopCommonModes]];
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

- (void)animationStarted {
    
    [self.layer setValue:[_fromValue interpolateWithValue:_toValue
                                               atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
}

- (void)animationCompleted:(BOOL)finished { }

- (void)setupAnimations {
    
    TrCustomCurvedAnimation *customAnimation = [TrCustomCurvedAnimation animationWithKeyPath:_keyPath];
    customAnimation.fromValue = _fromValue;
    customAnimation.toValue = _toValue;
    
    [self.layer setValue:[_fromValue interpolateWithValue:_toValue
                                               atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
    [self prepareAnimation:customAnimation usingKey:[NSString stringWithFormat:@"keyPathAnimation.%@", _keyPath]];
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(CALayer *)layer withKeyPath:(NSString *)keyPath {
    
    NSString *key = [NSString stringWithFormat:@"keyPathAnimation.%@", keyPath];
    
    TrCustomCurvedAnimation *animation = (TrCustomCurvedAnimation *)[layer animationForKey:key];
    return (animation && [animation.keyPath isEqualToString:keyPath]);
    
}

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
               fromValue:[layer valueForKeyPath:keyPath]
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
