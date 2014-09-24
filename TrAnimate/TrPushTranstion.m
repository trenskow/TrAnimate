//
//  TrPushTransition.m
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

#import "TrAnimationGroup+Private.h"

#import "TrPushTransition.h"

@interface TrPushTransition ()

@property (nonatomic,weak) UIView *sourceView;
@property (nonatomic,weak) UIView *destinationView;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) TrMoveAnimationEdge edge;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *curve;

@end

@implementation TrPushTransition

#pragma mark - Internals

- (void)animationsCompleted:(BOOL)finished {
    
    [self.sourceView removeFromSuperview];
    
}

- (void)setupAnimations {
    
    self.destinationView.frame = self.sourceView.frame;
    self.destinationView.hidden = YES;
    
    [self.sourceView.superview addSubview:self.destinationView];
    
    TrMoveAnimation *moveOutAnimation = [TrMoveAnimation animate:self.sourceView
                                                        duration:self.applyDuration
                                                       direction:TrMoveAnimationDirectionOut
                                                            edge:self.edge
                                                  toOrFromBounds:self.sourceView
                                                           delay:self.applyDelay
                                                           curve:self.curve
                                                      completion:nil];
    
    TrMoveAnimation *moveInAnimation = [TrMoveAnimation animate:self.destinationView
                                                       duration:self.applyDuration
                                                      direction:TrMoveAnimationDirectionIn
                                                           edge:(self.edge + 2) % 4 // Opposide side
                                                 toOrFromBounds:self.destinationView
                                                          delay:self.applyDelay
                                                          curve:self.curve
                                                     completion:nil];
    
    [self addAnimations:@[moveOutAnimation, moveInAnimation]];
    
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
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    if (!sourceView.superview)
        [NSException raise:@"NotInViewHierarchy" format:@"View sourceView must be added to a view heirarchy."];
    
    TrPushTransition *pushTransition = [TrPushTransition animationGroupWithCompletion:completion];
    
    pushTransition.sourceView = sourceView;
    pushTransition.destinationView = destinationView;
    pushTransition.applyDuration = duration;
    pushTransition.edge = edge;
    pushTransition.applyDelay = delay;
    pushTransition.curve = curve;
    
    return pushTransition;
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                           edge:edge
                          delay:delay
                          curve:curve
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                           edge:edge
                          delay:delay
                          curve:nil
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge {
    
    return [self transitionFrom:sourceView
                             to:destinationView
                       duration:duration
                           edge:edge
                          delay:.0
                          curve:nil
                     completion:nil];
    
}

@end
