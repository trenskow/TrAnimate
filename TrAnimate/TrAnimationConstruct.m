//
//  TrAnimationConstruct.m
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

#import "TrCurve.h"

#import "TrOpacityAnimation.h"
#import "TrFadeAnimation.h"
#import "TrPositionAnimation.h"
#import "TrScaleAnimation.h"
#import "TrRotateAnimation.h"
#import "TrMoveAnimation.h"
#import "TrPopInAnimation.h"
#import "TrFadeTransition.h"
#import "TrPushTransition.h"
#import "TrFlipTransition.h"

#import "TrAnimationConstruct.h"

@interface TrAnimationConstruct ()

@property (nonatomic,weak) UIView *view;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *curve;

@property (nonatomic) TrAnimationGroup *group;
@property (nonatomic) TrAnimationGroup *then;

@end

@implementation TrAnimationConstruct

#pragma mark - Creating Constructs

+ (instancetype)constructWithView:(UIView *)view duration:(NSTimeInterval)duration andCurve:(TrCurve *)curve {
    
    TrAnimationConstruct *construct = [TrAnimationConstruct animationGroup];
    
    construct.view = view;
    construct.applyDuration = duration;
    construct.curve = (curve ?: [TrCurve linear]);
    
    construct.group = [TrAnimationGroup animationGroup];
    [construct addAnimation:construct.group];
    
    return construct;
    
}

#pragma mark - Internals

- (TrAnimationConstruct *)append:(id<TrAnimation>)animation {
    
    [self.group addAnimation:animation];
    return self;
    
}

#pragma mark - Creating Animations

- (TrAnimationConstruct *)opacity:(CGFloat)opacity {
    
    return [self append:[TrOpacityAnimation animate:self.view
                                           duration:self.applyDuration
                                              delay:self.applyDelay
                                          toOpacity:opacity
                                              curve:self.curve]];
    
}

- (TrAnimationConstruct *)fadeIn {
    
    return [self append:[TrFadeAnimation animate:self.view
                                        duration:self.applyDuration
                                           delay:self.applyDelay
                                       direction:TrFadeAnimationDirectionIn
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)fadeOut {
    
    return [self append:[TrFadeAnimation animate:self.view
                                        duration:self.applyDuration
                                           delay:self.applyDelay
                                       direction:TrFadeAnimationDirectionOut
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)position:(CGPoint)position {
    
    return [self append:[TrPositionAnimation animate:self.view
                                            duration:self.applyDuration
                                               delay:self.applyDelay
                                          toPosition:position
                                              anchor:TrPositionAnimationAnchorAutomatic
                                               curve:self.curve]];
    
}

- (TrAnimationConstruct *)scale:(CGFloat)scale {
    
    return [self append:[TrScaleAnimation animate:self.view
                                         duration:self.applyDuration
                                            delay:self.applyDelay
                                    toScaleFactor:scale
                                            curve:self.curve]];
    
}

- (TrAnimationConstruct *)rotate:(CGFloat)angle {
    
    return [self append:[TrRotateAnimation animate:self.view
                                          duration:self.applyDuration
                                             delay:self.applyDelay
                                           toAngle:angle
                                              axis:TrRotateAnimationAxisZ
                                             curve:self.curve]];
    
}

- (TrAnimationConstruct *)rotate:(CGFloat)angle axis:(TrRotateAnimationAxis)axis {
    
    return [self append:[TrRotateAnimation animate:self.view
                                          duration:self.applyDuration
                                             delay:self.applyDelay
                                           toAngle:angle
                                              axis:axis
                                             curve:self.curve]];
    
}

- (TrAnimationConstruct *)moveIn:(TrMoveAnimationEdge)direction {
    
    return [self append:[TrMoveAnimation animate:self.view
                                        duration:self.applyDuration
                                       direction:TrMoveAnimationDirectionIn
                                            edge:direction
                                  toOrFromBounds:self.view
                                           delay:self.applyDelay
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)moveIn:(TrMoveAnimationEdge)direction fromOutsideBounds:(UIView *)bounds {
    
    return [self append:[TrMoveAnimation animate:self.view
                                        duration:self.applyDuration
                                       direction:TrMoveAnimationDirectionIn
                                            edge:direction
                                  toOrFromBounds:bounds
                                           delay:self.applyDelay
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)moveOut:(TrMoveAnimationEdge)direction {
    
    return [self append:[TrMoveAnimation animate:self.view
                                        duration:self.applyDuration
                                       direction:TrMoveAnimationDirectionOut
                                            edge:direction
                                  toOrFromBounds:self.view
                                           delay:self.applyDelay
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)moveOut:(TrMoveAnimationEdge)direction fromOutsideBounds:(UIView *)bounds {
    
    return [self append:[TrMoveAnimation animate:self.view
                                        duration:self.applyDuration
                                       direction:TrMoveAnimationDirectionOut
                                            edge:direction
                                  toOrFromBounds:bounds
                                           delay:self.applyDelay
                                           curve:self.curve]];
    
}

- (TrAnimationConstruct *)popIn {
    
    return [self append:[TrPopInAnimation animate:self.view
                                         duration:self.applyDuration
                                            delay:self.applyDelay
                                          elastic:NO]];
    
}

- (TrAnimationConstruct *)popInElastic {
    
    return [self append:[TrPopInAnimation animate:self.view
                                         duration:self.applyDuration
                                            delay:self.applyDelay
                                          elastic:YES]];
    
}

- (TrAnimationConstruct *)fadeTo:(UIView *)destinationView {
    
    return [self append:[TrFadeTransition transitionFrom:self.view
                                                      to:destinationView
                                                duration:self.applyDuration
                                                   delay:self.applyDelay
                                                   curve:self.curve]];
    
}

- (TrAnimationConstruct *)pushTo:(UIView *)destinationView direction:(TrMoveAnimationEdge)direction {
    
    return [self append:[TrPushTransition transitionFrom:self.view
                                                      to:destinationView
                                                duration:self.applyDuration
                                                    edge:direction
                                                   delay:self.applyDelay
                                                   curve:self.curve]];
    
}

- (TrAnimationConstruct *)flipTo:(UIView *)destinationView direction:(TrFlipTransitionDirection)direction {
    
    return [self append:[TrFlipTransition transitionFrom:self.view
                                                      to:destinationView
                                                duration:self.applyDuration
                                               direction:direction
                                                   delay:self.applyDelay
                                                   curve:self.curve]];
    
}


- (TrAnimationConstruct *)and:(id<TrAnimation>)animation {
    
    return [self append:animation];
    
}

- (TrAnimationConstruct *)then:(id<TrAnimation>)animation {
    
    if (!self.then) {
        self.then = [TrAnimationGroup animationGroup];
        [self addAnimation:self.then animateAfter:self.group];
    }
    
    [self.then addAnimation:animation];
    
    return self;
    
}

- (TrAnimationConstruct *)withDelay:(NSTimeInterval)delay {
    
    self.delay = self.applyDelay = delay;
    return self;
    
}

- (TrAnimationConstruct *)onCompleted:(void (^)(BOOL finished))completion {
    
    self.group.completionBlock = completion;
    return self;
    
}

@end
