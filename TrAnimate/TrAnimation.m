//
//  TrAnimation.m
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

#import <objc/runtime.h>

#import "TrAnimation.h"

//#define Tr_ANIMATION_VIEW_DEBUG

const void *TrAnimationLayerKey;

NSString *const TrAnimationKey = @"TrAnimationKey";

@interface TrAnimation () {
    
    BOOL _animationStarted;
    BOOL _animationFinished;
    NSMutableArray *_observedAnimations;
    
}

@property (nonatomic,getter = isAnimating) BOOL animating;
@property (nonatomic,getter = isComplete) BOOL complete;
@property (nonatomic,getter = isFinished) BOOL finished;
@property (weak,nonatomic) CALayer *layer;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) TrAnimationOptions options;
@property (copy,nonatomic) void(^completionBlock)(BOOL finished);

@end

@implementation TrAnimation

#pragma mark - Setup / Teardown

- (instancetype)initWithLayer:(CALayer *)layer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    if ((self = [super init])) {
        
        self.layer = layer;
        self.duration = duration;
        self.delay = delay;
        self.options = options;
        self.completionBlock = completion;
        
        _animationFinished = YES;
        _observedAnimations = [[NSMutableArray alloc] init];
        
        /* Associate animation object with view, so it won't be released doing animation */
        objc_setAssociatedObject(self.layer, &TrAnimationLayerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return self;
    
}

#pragma mark - Internal

- (void)animationDidStart:(CAAnimation *)anim {
    
    if (!_animationStarted)
        [self animationStarted];
    
    _animationStarted = YES;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [_observedAnimations removeObject:[anim valueForKey:TrAnimationKey]];
    
    _animationFinished |= flag;
    
    if ([_observedAnimations count] == 0) {
        
        [self animationCompleted:_animationFinished];
        
        if (self.completionBlock)
            self.completionBlock(_animationFinished);
        
        self.complete = YES;
        self.finished = _animationFinished;
        
        /* Remove animation from view so it can be released */
        objc_setAssociatedObject(self.layer, &TrAnimationLayerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
}

- (void)prepareAnimation:(CAAnimation *)animation usingKey:(NSString *)key {
    
#if defined(TR_ANIMATION_VIEW_DEBUG)
    animation.duration = self.duration * 10.0f;
    animation.beginTime = CACurrentMediaTime() + self.delay * 10.0f;
#else
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
#endif
    
    [animation setValue:key forKey:TrAnimationKey];
    
    animation.delegate = self;
    [_observedAnimations addObject:key];
    
}

- (void)beginAnimation {
    
    if (!self.isAnimating) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
        self.animating = YES;
        [self setupAnimations];
    }
    
}

- (void)postponeAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
}

- (void)animationStarted { }
- (void)animationCompleted:(BOOL)finished { }
- (void)setupAnimations { }

#pragma mark - Properties

@synthesize delay=_delay;

#pragma mark - Creating Animation

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    if (!viewOrLayer)
        return nil;
    
    CALayer *layer = viewOrLayer;
    if ([layer isKindOfClass:[UIView class]])
        layer = ((UIView *)viewOrLayer).layer;
    
    /* Setup animation object */
    id animation = [[[self class] alloc] initWithLayer:layer
                                              duration:duration
                                                 delay:delay
                                               options:options
                                            completion:completion];
    
    [animation performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0];
    
    return animation;
    
}

@end
