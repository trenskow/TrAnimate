//
//  TrAnimationGroup.h
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

#import "TrAnimation.h"

/*!
 `TrAnimationGroup` is a class that provides the ability to group animations into a single entity. Animations can be added to the animation group - even other animation groups can be added, to build a complex chain of animations. A completion handler can be provided on creation that gets invoked when all animations in the group has completed.
 */
@interface TrAnimationGroup : NSObject <TrAnimation>

#pragma mark - Creating animation groups

/*!
 Creates a new instance of `TrAnimationGroup`.
 
 @param animations An NSArray containing animations which should be added to the group. The animations provided will all animate at the same time.
 @param completion A block that gets invoked when all the animations in the group has completed.
 
 @return Returns a `TrAnimationGroup` object.
 */
+ (instancetype)animationGroupWithAnimations:(NSArray *)animations
                                  completion:(void(^)(BOOL finished))completion;

/*!
 Create a new instance of `TrAnimationGroup`.
 
 @param animations An NSArray containing animation which should be added to the group. The animations provided will all animate at the same time.
 
 @return Returns a `TrAnimationGroup` object.
 */
+ (instancetype)animationGroupWithAnimations:(NSArray *)animations;

/*!
 Creates a new instance of `TrAnimationGroup`.
 
 @param completion A block that gets invoked when all animations in the group has completed.
 
 @return Returns a `TrAnimationGroup` object.
 */
+ (instancetype)animationGroupWithCompletion:(void(^)(BOOL finished))completion;

/*!
 Creates a new instance of `TrAnimationGroup`.
 
 @return Returns a `TrAnimationGroup` object.
 */
+ (instancetype)animationGroup;

#pragma mark - Adding animations

/*!
 Adds an animation to the group.
 
 @param animation    The animation to add to the group.
 @param animateAfter An animation which must complete before the added animation in `animation` begins. This animation must already have been added to the group.
 */
- (void)addAnimation:(id<TrAnimation>)animation
        animateAfter:(id<TrAnimation>)animateAfter;

/*!
 Adds an animation to the group.
 
 @param animation The animation to add to the group.
 */
- (void)addAnimation:(id<TrAnimation>)animation;

@end
