//
//  TrDirectAnimation.h
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
@import UIKit;

#import "TrCurve.h"
#import "TrInterpolatable.h"

#import "TrDirectAnimation.h"

const void *TrDirectAnimationKey;

@interface TrDirectAnimation () {
    
    id _object;
    NSString *_keyPath;
    NSTimeInterval _duration;
    NSTimeInterval _delay;
    id<TrInterpolatable> _fromValue;
    id<TrInterpolatable> _toValue;
    TrCurve *_curve;
    void (^_completionBlock)(BOOL);
    
    CADisplayLink *_displayLink;
    NSDate *_beginTime;
    
}

@property (nonatomic,readwrite,getter = isAnimating) BOOL animating;
@property (nonatomic,readwrite,getter = isComplete) BOOL complete;
@property (nonatomic,readwrite,getter = isFinished) BOOL finished;
@property (nonatomic,readwrite) NSTimeInterval duration;

@end

@implementation TrDirectAnimation

#pragma mark - Setup / Teardown

- (instancetype)initWithObject:(id)object
                      duration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                       keyPath:(NSString *)keyPath
                     fromValue:(id<TrInterpolatable>)fromValue
                       toValue:(id<TrInterpolatable>)toValue
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        _object = object;
        _keyPath = keyPath;
        self.duration = duration;
        self.delay = delay;
        _fromValue = fromValue;
        _toValue = toValue;
        _curve = (curve ?: [TrCurve linear]);
        _completionBlock = [completion copy];
        
        objc_setAssociatedObject(self, &TrDirectAnimationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return self;
    
}

#pragma mark - Internals

- (void)endAnimation {
    
    [_displayLink invalidate];
    _displayLink = nil;
    
    self.complete = YES;
    self.finished = YES;
    
    if (_completionBlock)
        _completionBlock(YES);
    
    objc_setAssociatedObject(self, &TrDirectAnimationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)displayDidUpdate:(CADisplayLink *)displayLink {
    
    double progress = MIN([[NSDate date] timeIntervalSinceDate:_beginTime] / self.duration, 1.0);
    
    if (progress >= 0 && progress <= 1.0)
        [_object setValue:[_fromValue interpolateWithValue:_toValue
                                                atPosition:[_curve transform:progress]]
               forKeyPath:_keyPath];
    
    if (progress == 1.0)
        [self endAnimation];
    
}

#pragma mark - Properties

@synthesize animating;
@synthesize complete;
@synthesize finished;
@synthesize duration=_duration;
@synthesize delay=_delay;

#pragma mark - Public Methods

- (void)beginAnimation {
    
    if (!self.isAnimating) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
        
        _beginTime = [NSDate dateWithTimeIntervalSinceNow:self.delay];
        
        _displayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(displayDidUpdate:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        self.animating = YES;
        
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

#pragma mark - Creating Animation

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    TrDirectAnimation *animation = [[self alloc] initWithObject:object
                                                       duration:duration
                                                          delay:delay
                                                        keyPath:keyPath
                                                      fromValue:fromValue
                                                        toValue:toValue
                                                          curve:curve
                                                     completion:completion];
    
    [animation performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
    
    return animation;
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:object
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:object
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [self animate:object
                duration:duration
                   delay:delay
                 keyPath:keyPath
               fromValue:[object valueForKeyPath:keyPath]
                 toValue:toValue
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:object
                duration:duration
                   delay:delay
                 keyPath:keyPath
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:object
                duration:duration
                   delay:delay
                 keyPath:keyPath
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

@end
