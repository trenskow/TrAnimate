//
//  TrDirectAnimation.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 01/05/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
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
    TrCustomCurveBlock _curve;
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

- (instancetype)initWithWhat:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startValue:(id<TrValueTransition>)startValue endValue:(id<TrValueTransition>)endValue curve:(TrCustomCurveBlock)curve completion:(void(^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        _what = what;
        _keyPath = keyPath;
        self.duration = duration;
        self.delay = delay;
        _startValue = startValue;
        _endValue = endValue;
        _curve = (curve ?: kTrAnimationCurveLinear);
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
    
    CGFloat progress = MIN([[NSDate date] timeIntervalSinceDate:_beginTime] / self.duration, 1.0);
    
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

+ (instancetype)animate:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay startValue:(id<TrValueTransition>)startValue endValue:(id<TrValueTransition>)endValue curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
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

+ (instancetype)animate:(id)what keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endValue:(id<TrValueTransition>)endValue curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
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
