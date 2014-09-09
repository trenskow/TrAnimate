//
//  TrConstruct.h
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

#import "TrMoveAnimation.h"
#import "TrAnimationGroup.h"

@protocol TrAnimatable;
@class TrCurve;

#warning Documentation is missing
@interface TrConstruct : TrAnimationGroup

+ (instancetype)constructWithViewOrLayer:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration curve:(TrCurve *)curve;

- (TrConstruct *)fadeIn;
- (TrConstruct *)moveIn:(TrMoveAnimationEdge)edge fromBounds:(id<TrAnimatable>)bounds;
- (TrConstruct *)moveIn:(TrMoveAnimationEdge)edge;
- (TrConstruct *)popIn:(BOOL)elastic;
- (TrConstruct *)and:(id<TrAnimation>)animation;
- (TrConstruct *)then:(id<TrAnimation>)animation;

- (TrConstruct *)afterDelay:(NSTimeInterval)delay;
- (TrConstruct *)onCompletion:(void (^)(BOOL finished))completion;

@end
