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

@interface TrDirectAnimation ()

@property (nonatomic,readwrite,getter = isAnimating) BOOL animating;
@property (nonatomic,readwrite,getter = isComplete) BOOL complete;
@property (nonatomic,readwrite,getter = isFinished) BOOL finished;

@property (nonatomic) id object;
@property (nonatomic,copy) NSString *keyPath;
@property (nonatomic,readwrite) NSTimeInterval duration;
@property (nonatomic,copy) id<TrInterpolatable> fromValue;
@property (nonatomic,copy) id<TrInterpolatable> toValue;
@property (nonatomic,copy) TrCurve *curve;
@property (nonatomic,copy) void (^completionBlock)(BOOL finished);

@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) NSDate *beginTime;

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
        
        [[self class] cancelAnimationOn:object withKeyPath:keyPath];
        
        self.object = object;
        self.keyPath = keyPath;
        self.duration = duration;
        self.delay = delay;
        self.fromValue = fromValue;
        self.toValue = toValue;
        self.curve = (curve ?: [TrCurve linear]);
        self.completionBlock = [completion copy];
        
        objc_setAssociatedObject(self.object, &TrDirectAnimationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
        
    }
    
    return self;
    
}

#pragma mark - Internals

- (void)endAnimation:(BOOL)finished {
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    self.finished = finished;
    self.complete = YES;
    
    if (self.completionBlock)
        self.completionBlock(finished);
    
    objc_setAssociatedObject(self.object, &TrDirectAnimationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)displayDidUpdate:(CADisplayLink *)displayLink {
    
    double progress = MIN([[NSDate date] timeIntervalSinceDate:_beginTime] / self.duration, 1.0);
    
    if (progress >= 0 && progress <= 1.0)
        [self.object setValue:[self.fromValue interpolateWithValue:self.toValue
                                                        atPosition:[self.curve transform:progress]]
               forKeyPath:self.keyPath];
    
    if (progress == 1.0)
        [self endAnimation:YES];
    
}

#pragma mark - Properties

@synthesize animating;
@synthesize complete;
@synthesize finished=_finished;
@synthesize duration=_duration;
@synthesize delay=_delay;

#pragma mark - Public Methods

- (void)beginAnimation {
    
    if (!self.isAnimating) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
        
        self.beginTime = [NSDate dateWithTimeIntervalSinceNow:self.delay];
        
        self.displayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(displayDidUpdate:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        self.animating = YES;
        
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

- (void)cancel {
    
    if (self.displayLink)
        [self endAnimation:NO];
    
}

#pragma mark - Creating Animation

+ (void)cancelAnimationOn:(id)object withKeyPath:(NSString *)keyPath {
    
    TrDirectAnimation *animation = objc_getAssociatedObject(object, &TrDirectAnimationKey);
    [animation cancel];
    
}

+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [[self alloc] initWithObject:object
                               duration:duration
                                  delay:delay
                                keyPath:keyPath
                              fromValue:fromValue
                                toValue:toValue
                                  curve:curve
                             completion:completion];
    
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
