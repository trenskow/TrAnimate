//
//  TrAnimationGroup.m
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

#import "NSMutableArray+TrAnimationGroupAdditions.h"
#import "NSMutableDictionary+TrAnimationGroupAdditions.h"

#import "TrAnimation.h"

#import "TrAnimationGroup.h"

const char TrAnimationGroupKey;
char TrAnimationGroupObserverContext;

@interface TrAnimationGroup () {
    
    NSMutableArray *_animations;
    void (^_completion)(BOOL finished);
    BOOL _animationFinished;
    BOOL _beginsImmediately;
    
}
@property (nonatomic,getter = isAnimating) BOOL animating;
@property (nonatomic,getter = isComplete) BOOL complete;
@property (nonatomic,getter = hasFinished) BOOL finished;

@end

@implementation TrAnimationGroup

#pragma mark - Setup / Teardown

- (instancetype)initWithAnimations:(NSArray *)animations completion:(void(^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        _animations = [[NSMutableArray alloc] init];
        _completion = [completion copy];
        
        _animationFinished = YES;
        
        for (id<TrAnimation> animation in animations)
            [self addAnimation:animation animateAfter:nil];
        
    }
    
    return self;
    
}

#pragma mark - Creating Animation Group

+ (instancetype)animationGroupWithAnimations:(NSArray *)animations completion:(void(^)(BOOL finished))completion {
    
    TrAnimationGroup *animationGroup = [[self alloc] initWithAnimations:animations
                                                               completion:completion];
    
    [animationGroup performSelector:@selector(beginAnimation) withObject:nil afterDelay:.0 inModes:@[NSRunLoopCommonModes]];
    
    return animationGroup;
    
}

+ (instancetype)animationGroupWithAnimations:(NSArray *)animations {
    
    return [self animationGroupWithAnimations:animations completion:nil];
    
}

+ (instancetype)animationGroupWithCompletion:(void (^)(BOOL finished))completion {
    
    return [self animationGroupWithAnimations:nil completion:completion];
    
}

+ (instancetype)animationGroup {
    
    return [self animationGroupWithAnimations:nil completion:nil];
    
}

#pragma mark - Internals

- (NSMutableArray *)animationGroupsForAnimation:(id<TrAnimation>)animation {
    
    NSMutableArray *animationGroups = objc_getAssociatedObject(animation, &TrAnimationGroupKey);
    if (!animationGroups) {
        animationGroups = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(animation, &TrAnimationGroupKey, animationGroups, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return animationGroups;
    
}

#pragma mark - Managing Animations

- (void)addAnimation:(id<TrAnimation>)animation animateAfter:(id<TrAnimation>)animateAfter {
    
    /* Check if an actual animation is being added */
    if (animation) {
        
        /* Tell animation to postpone it's animation so we can manage this in the group */
        [animation postponeAnimation];
        
        [_animations addObject:[NSMutableDictionary dictionaryWithAnimation:animation animatedAfter:animateAfter]];
        
        /* Add observer for when animation completes */
        [(id)animation addObserver:self forKeyPath:@"complete" options:0 context:&TrAnimationGroupObserverContext];
        
        /* Associate group with animation so it will retain it as long as animation lives */
        [[self animationGroupsForAnimation:animation] addObject:self];
        
    }
    
}

- (void)addAnimation:(id<TrAnimation>)animation {
    
    [self addAnimation:animation animateAfter:nil];
    
}

- (void)beginAnimation {
    
    /* Start by cancelling any scheduled calls */
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
    if ([_animations count] > 0) {
        
        /* Create a copy in order to prevent mutation exceptions while enumerating */
        NSArray *animations = [_animations copy];
        
        for (NSMutableDictionary *a in animations)
            if (!a.animatedAfter && !a.animation.isAnimating)
                [a.animation beginAnimation];
        
    } else {
        
        if (_completion)
            _completion(_animationFinished);
        
        self.complete = YES;
        self.finished = _animationFinished;
        
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

#pragma mark - Properties

- (NSTimeInterval)duration {
    
    NSTimeInterval duration = .0;
    
    /* Iterate animations and find the longest running */
    for (NSMutableDictionary *a in _animations) {
        NSTimeInterval animDuration = a.animation.delay + a.animation.duration;
        if (a.animatedAfter)
            animDuration += a.animatedAfter.delay + a.animatedAfter.duration;
        duration = MAX(duration, animDuration);
        
    }
    
    return duration - self.delay;
    
}

/* Finds the lowest delay of all animations */
- (NSTimeInterval)delay {
    
    NSTimeInterval delay = DBL_MAX;
    
    for (NSMutableDictionary *a in _animations)
        if (!a.animatedAfter)
            delay = MIN(delay, a.animation.delay);
    
    return (delay < DBL_MAX ? delay : .0);
    
}

- (void)setDelay:(NSTimeInterval)delay {
    
    NSTimeInterval delayDiff = MAX(delay, .0) - self.delay;
    
    for (NSMutableDictionary *a in _animations)
        if (!a.animatedAfter)
            a.animation.delay += delayDiff;
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == &TrAnimationGroupObserverContext) {
        
        /* We really only observe once kind of value */
        [object removeObserver:self forKeyPath:@"complete" context:&TrAnimationGroupObserverContext];
        [_animations removeAnimation:object];
        
        /* Find all animations waiting on this animation and remove them */
        for (NSMutableDictionary *a in _animations)
            if (a.animatedAfter == object)
                a.animatedAfter = nil;
        
        BOOL finished = [object isFinished];
        _animationFinished |= finished;
        
        /* Call beginAnimation again to start any waiting animations */
        [self beginAnimation];
        
        /* Remove association with animation in order to get released when all animations are done */
        [[self animationGroupsForAnimation:object] removeObject:self];
        
    } else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
}

@end
