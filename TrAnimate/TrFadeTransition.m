//
//  TrFadeTransition.h
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

#import "UIView+TrAnimateAdditions.h"

#import "TrFadeAnimation.h"
#import "TrAnimationGroup+Private.h"

#import "TrFadeTransition.h"

@interface TrFadeTransition ()

@property (nonatomic,weak) UIView *sourceView;
@property (nonatomic,weak) UIView *destinationView;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *curve;

@end

@implementation TrFadeTransition

#pragma mark - Internals

- (void)animationsCompleted:(BOOL)finished {
    
    [self.sourceView removeFromSuperview];
    
}

- (void)setupAnimations {
    
    self.destinationView.frame = self.sourceView.frame;
    self.destinationView.alpha = .0;
    self.destinationView.hidden = NO;
    
    [self.sourceView.superview addSubview:self.destinationView];
    
    if (!self.sourceView.opaque)
        [self addAnimation:[TrFadeAnimation animate:self.sourceView
                                           duration:self.applyDuration
                                              delay:self.applyDelay
                                          direction:TrFadeAnimationDirectionOut
                                              curve:self.curve
                                         completion:nil]];
    
    [self addAnimation:[TrFadeAnimation animate:self.destinationView
                                                 duration:self.applyDuration
                                                    delay:self.applyDelay
                                                direction:TrFadeAnimationDirectionIn
                                                    curve:self.curve
                                               completion:nil]];
    
}

#pragma mark - Properties

- (void)setDelay:(NSTimeInterval)delay {
    
    [super setDelay:delay];
    self.applyDelay = delay;
    
}

#pragma mark - Creating Transition

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    if (!sourceView.superview)
        [NSException raise:@"NotInViewHierarchy" format:@"View sourceView must be added to a view heirarchy."];
    
    TrFadeTransition *fadeTransition = [self animationGroupWithCompletion:completion];
    
    fadeTransition.sourceView = sourceView;
    fadeTransition.destinationView = destinationView;
    fadeTransition.applyDuration = duration;
    fadeTransition.applyDelay = delay;
    fadeTransition.curve = curve;
    
    return fadeTransition;
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                          delay:delay
                          curve:curve
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                          delay:delay
                          curve:nil
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                          delay:.0
                          curve:nil
                     completion:nil];
    
}

@end
