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

#import "TrPushTransition.h"

@implementation TrPushTransition

+ (instancetype)transitionFrom:(UIView *)fromView
                            to:(UIView *)toView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion {
    
    toView.frame = fromView.frame;
    toView.hidden = YES;
    
    [fromView.superview addSubview:toView];
    
    TrMoveAnimation *moveOutAnimation = [TrMoveAnimation animate:fromView
                                                        duration:duration
                                                       direction:TrMoveAnimationDirectionOut
                                                            edge:edge
                                                  toOrFromBounds:fromView
                                                           delay:delay
                                                           curve:curve
                                                      completion:^(BOOL finished) {
                                                          [fromView removeFromSuperview];
                                                      }];
    
    TrMoveAnimation *moveInAnimation = [TrMoveAnimation animate:toView
                                                       duration:duration
                                                      direction:TrMoveAnimationDirectionIn
                                                           edge:(edge + 2) % 4 // Opposide side
                                                 toOrFromBounds:toView
                                                          delay:delay
                                                          curve:curve
                                                     completion:nil];
    
    return [self animationGroupWithAnimations:@[moveOutAnimation, moveInAnimation]
                                   completion:completion];
    
}

+ (instancetype)transitionFrom:(UIView *)fromView
                            to:(UIView *)toView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve {
    
    return [self transitionFrom:fromView
                             to:toView
                       duration:duration
                           edge:edge
                          delay:delay
                          curve:curve
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)fromView
                            to:(UIView *)toView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge
                         delay:(NSTimeInterval)delay {
    
    return [self transitionFrom:fromView
                             to:toView
                       duration:duration
                           edge:edge
                          delay:delay
                          curve:nil
                     completion:nil];
    
}

+ (instancetype)transitionFrom:(UIView *)fromView
                            to:(UIView *)toView
                      duration:(NSTimeInterval)duration
                          edge:(TrMoveAnimationEdge)edge {
    
    return [self transitionFrom:fromView
                             to:toView
                       duration:duration
                           edge:edge
                          delay:.0
                          curve:nil
                     completion:nil];
    
}

@end
