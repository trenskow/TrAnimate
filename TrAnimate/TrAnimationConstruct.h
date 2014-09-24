//
//  TrAnimationConstruct.h
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

@import UIKit;

#import "TrRotateAnimation.h"
#import "TrMoveAnimation.h"
#import "TrFlipTransition.h"

#import "TrAnimationGroup.h"

@class TrCurve;
@protocol TrInterpolatable;
@protocol TrAnimation;

@interface TrAnimationConstruct : TrAnimationGroup

+ (instancetype)constructWithView:(UIView *)view duration:(NSTimeInterval)duration andCurve:(TrCurve *)curve;

- (TrAnimationConstruct *)opacity:(CGFloat)opacity;
- (TrAnimationConstruct *)fadeIn;
- (TrAnimationConstruct *)fadeOut;
- (TrAnimationConstruct *)position:(CGPoint)position;
- (TrAnimationConstruct *)scale:(CGFloat)scale;
- (TrAnimationConstruct *)rotate:(CGFloat)angle;
- (TrAnimationConstruct *)rotate:(CGFloat)angle axis:(TrRotateAnimationAxis)axis;

- (TrAnimationConstruct *)moveIn:(TrMoveAnimationEdge)direction;
- (TrAnimationConstruct *)moveIn:(TrMoveAnimationEdge)direction fromOutsideBounds:(UIView *)bounds;
- (TrAnimationConstruct *)moveOut:(TrMoveAnimationEdge)direction;
- (TrAnimationConstruct *)moveOut:(TrMoveAnimationEdge)direction fromOutsideBounds:(UIView *)bounds;
- (TrAnimationConstruct *)popIn;
- (TrAnimationConstruct *)popInElastic;

- (TrAnimationConstruct *)fadeTo:(UIView *)destinationView;
- (TrAnimationConstruct *)pushTo:(UIView *)destinationView direction:(TrMoveAnimationEdge)direction;
- (TrAnimationConstruct *)flipTo:(UIView *)destinationView direction:(TrFlipTransitionDirection)direction;

- (TrAnimationConstruct *)and:(id<TrAnimation>)animation;
- (TrAnimationConstruct *)then:(id<TrAnimation>)animation;

- (TrAnimationConstruct *)withDelay:(NSTimeInterval)delay;
- (TrAnimationConstruct *)onCompleted:(void (^)(BOOL finished))completion;

@end
