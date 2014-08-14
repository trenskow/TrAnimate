//
//  TrDirectAnimation.h
//  TrAnimate
//
//  Copyright (c) 2014, Kristian Trenskow All rights reserved.
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

#import <objc/runtime.h>

#import "TrDirectAnimation.h"

const void *TrDirectAnimationKey;

@interface TrDirectAnimation () {
    
    id _what;
    NSString *_keyPath;
    NSTimeInterval _duration;
    NSTimeInterval _delay;
    id<TrValueTransition> _startValue;
    id<TrValueTransition> _endValue;
    TrCurve _curve;
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

- (instancetype)initWithWhat:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startValue:(id<TrValueTransition>)startValue endValue:(id<TrValueTransition>)endValue curve:(TrCurve)curve completion:(void(^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        _what = what;
        _keyPath = keyPath;
        self.duration = duration;
        self.delay = delay;
        _startValue = startValue;
        _endValue = endValue;
        _curve = (curve ?: TrCurveLinear);
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
        [_what setValue:[_startValue transitionToValue:_endValue
                                          withProgress:_curve(progress)]
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

+ (instancetype)animate:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startValue:(id<TrValueTransition>)startValue endValue:(id<TrValueTransition>)endValue curve:(TrCurve)curve completion:(void (^)(BOOL))completion {
    
    TrDirectAnimation *animation = [[self alloc] initWithWhat:what
                                                      keyPath:keyPath
                                                     duration:duration
                                                        delay:delay
                                                   startValue:startValue
                                                     endValue:endValue
                                                        curve:curve
                                                   completion:completion];
    
    [animation performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
    
    return animation;
    
}

+ (instancetype)animate:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endValue:(id<TrValueTransition>)endValue curve:(TrCurve)curve completion:(void (^)(BOOL))completion {
    
    return [self animate:what
                 keyPath:keyPath
                duration:duration
                   delay:delay
              startValue:[what valueForKeyPath:keyPath]
                endValue:endValue
                   curve:curve
              completion:completion];
    
}


@end
