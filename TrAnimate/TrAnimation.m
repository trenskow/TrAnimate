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

#import "TrCustomCurvedAnimation.h"
#import "TrAnimation.h"

//#define TR_ANIMATION_VIEW_DEBUG

const void *TrAnimationLayerKey;

NSString *const TrAnimationKey = @"TrAnimationKey";

@interface TrAnimation ()

@property (nonatomic,getter = isAnimating) BOOL animating;
@property (nonatomic,getter = isComplete) BOOL complete;
@property (nonatomic,getter = isFinished) BOOL finished;
@property (copy,nonatomic) TrCustomCurveBlock curve;
@property (copy,nonatomic) void(^completionBlock)(BOOL finished);

@end

@implementation TrAnimation

#pragma mark - Setup / Teardown

- (instancetype)initWithLayer:(CALayer *)layer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    if ((self = [super init])) {
        
        self.layer = layer;
        self.duration = duration;
        self.delay = delay;
        self.curve = (curve ? curve : kTrAnimationCurveLinear);
        self.completionBlock = completion;
        
        /* Associate animation object with view, so it won't be released doing animation */
        objc_setAssociatedObject(self.layer, &TrAnimationLayerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return self;
    
}

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
    animation.duration = self.duration * 10.0f;
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
                   afterDelay:self.delay * 10.0f
#else
                   afterDelay:self.delay
#endif
                      inModes:@[NSRunLoopCommonModes]];
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

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    if (!viewOrLayer)
        return nil;
    
    /* Setup animation object */
    id animation = [[[self class] alloc] initWithLayer:viewOrLayer.animationsLayer
                                              duration:duration
                                                 delay:delay
                                                 curve:curve
                                            completion:completion];
    
    [animation performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
    
    return animation;
    
}

@end
