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

@import Foundation;

#import "NSObject+TrAnimateAdditions.h"

#import "TrAnimation.h"

#import "TrAnimationGroup.h"

// Information class.
@interface TrAnimationInfo : NSObject
@property (nonatomic) id<TrAnimation> animation;
@property (nonatomic,weak) id<TrAnimation> animateAfter;
+ (instancetype)infoWithAnimation:(id<TrAnimation>)animation animateAfter:(id<TrAnimation>)animateAfter;
@end

@implementation TrAnimationInfo
+ (instancetype)infoWithAnimation:(id<TrAnimation>)animation animateAfter:(id<TrAnimation>)animateAfter {
    TrAnimationInfo *info = [[self alloc] init];
    info.animation = animation;
    info.animateAfter = animateAfter;
    return info;
}
@end
// End information class

NSString *const TrAnimationGroupKey = @"TrAnimationGroupKey";
char TrAnimationGroupObserverContext;

@interface TrAnimationGroup ()

@property (nonatomic,getter = isAnimating) BOOL animating;
@property (nonatomic,getter = isComplete) BOOL complete;
@property (nonatomic,getter = hasFinished) BOOL finished;

@property (nonatomic) NSMutableArray *animations;
@property (nonatomic) BOOL animationFinished;
@property (nonatomic) BOOL beginsImmediately;

@property (nonatomic,getter=isSetupComplete) BOOL setupComplete;

@end

@implementation TrAnimationGroup

#pragma mark - Setup / Teardown

- (instancetype)initWithAnimations:(NSArray *)animations completion:(void(^)(BOOL finished))completion {
    
    if ((self = [super init])) {
        
        self.animations = [[NSMutableArray alloc] init];
        self.completionBlock = completion;
        
        /* We mark it as finished - not complete. */
        self.animationFinished = YES;
        
        for (id<TrAnimation> animation in animations)
            [self addAnimation:animation animateAfter:nil];
        
        [self performSelector:@selector(beginAnimation) withObject:nil afterDelay:.0 inModes:@[NSRunLoopCommonModes]];
        
    }
    
    return self;
    
}

#pragma mark - Creating Animation Group

+ (instancetype)animationGroupWithAnimations:(NSArray *)animations completion:(void(^)(BOOL finished))completion {
    
    return [[self alloc] initWithAnimations:animations
                                 completion:completion];
    
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

#pragma mark - Managing Animations

- (void)addAnimation:(id<TrAnimation>)animation animateAfter:(id<TrAnimation>)animateAfter {
    
    /* Check if an actual animation is being added */
    if (animation) {
        
        /* Animations can only be added to one group, so we check if the animation already has an associated group. */
        if ([(id)animation associatedValueForKey:TrAnimationGroupKey])
            [NSException raise:@"ExistingGroupException" format:@"Animation has already been added to a group."];
        
        /* Tell animation to postpone it's animation so we can manage this in the group */
        [animation postponeAnimation];
        
        [self.animations addObject:[TrAnimationInfo infoWithAnimation:animation animateAfter:animateAfter]];
        
        /* Add observer for when animation completes */
        [(id)animation addObserver:self forKeyPath:@"complete" options:0 context:&TrAnimationGroupObserverContext];
        
        /* Associate group with animation so it will retain it as long as animation lives */
        [(id)animation setAssociatedValue:self forKey:TrAnimationGroupKey];
        
    }
    
}

- (void)addAnimation:(id<TrAnimation>)animation {
    
    [self addAnimation:animation animateAfter:nil];
    
}

- (void)addAnimations:(NSArray *)animations {
    
    for (id<TrAnimation> animation in animations)
        [self addAnimation:animation];
    
}

- (void)beginAnimation {
    
    /* Start by cancelling any scheduled calls */
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
    if ([self.animations count] > 0) {
        
        /* Create a copy in order to prevent mutation exceptions while enumerating */
        NSArray *animations = [self.animations copy];
        
        for (TrAnimationInfo *a in animations)
            if (!a.animateAfter && !a.animation.isAnimating)
                [a.animation beginAnimation];
        
    } else {
        
        self.finished = self.animationFinished;
        self.complete = YES;
        
        [self animationsCompleted:self.finished];
        
        if (self.completionBlock)
            self.completionBlock(self.animationFinished);
        
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

- (void)cancelAnimation {
    
    while ([self.animations count] > 0)
        [[self.animations[0] animation] cancelAnimation];
    
}

#pragma mark - Subclassing

- (void)animationsCompleted:(BOOL)finished { }

#pragma mark - Properties

- (NSTimeInterval)duration {
    
    NSTimeInterval duration = .0;
    
    /* Iterate animations and find the longest running */
    for (TrAnimationInfo *a in self.animations) {
        NSTimeInterval animDuration = a.animation.delay + a.animation.duration;
        if (a.animateAfter)
            animDuration += a.animateAfter.delay + a.animateAfter.duration;
        duration = MAX(duration, animDuration);
        
    }
    
    return duration - self.delay;
    
}

/* Finds the lowest delay of all animations */
- (NSTimeInterval)delay {
    
    NSTimeInterval delay = DBL_MAX;
    
    for (TrAnimationInfo *a in self.animations)
        if (!a.animateAfter)
            delay = MIN(delay, a.animation.delay);
    
    return (delay < DBL_MAX ? delay : .0);
    
}

- (void)setDelay:(NSTimeInterval)delay {
    
    NSTimeInterval delayDiff = MAX(delay, .0) - self.delay;
    
    for (TrAnimationInfo *a in self.animations)
        if (!a.animateAfter)
            a.animation.delay += delayDiff;
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == &TrAnimationGroupObserverContext) {
        
        /* We really only observe one kind of value - complete */
        [object removeObserver:self forKeyPath:@"complete" context:&TrAnimationGroupObserverContext];
        
        // Iterate animations and remove the completed animation from self.animations.
        for (NSInteger idx = 0 ; idx < [self.animations count] ; idx++)
            if (((TrAnimationInfo *)self.animations[idx]).animation == object) {
                [self.animations removeObjectAtIndex:idx];
                break;
            }
        
        /*
         Find all animations waiting on this animation and remove their depencency.
         This begins the animation when `beginAnimation` is called.
         */
        for (TrAnimationInfo *a in self.animations)
            if (a.animateAfter == object)
                a.animateAfter = nil;
        
        BOOL finished = [object isFinished];
        self.animationFinished &= finished;
        
        /* Call beginAnimation again to start any waiting animations */
        [self beginAnimation];
        
        /* Remove association with animation in order to get released when all animations are complete */
        [object setAssociatedValue:nil forKey:TrAnimationGroupKey];
        
    } else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
}

@end
