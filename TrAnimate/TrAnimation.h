//
//  TrAnimation.h
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

/**
 *  The `TrAnimation` protocol defines a set of methods and properties that are common to all types of animations. As an example the `TrAnimationGroup` only adds animations of objects that conform to this protocol.
 */
@protocol TrAnimation

@required

///------------------------------------
/// @name Getting Animation Information
///------------------------------------

/**
 *  Returns `YES` if the animation is currently in progress.
 */
@property (nonatomic,readonly,getter = isAnimating) BOOL animating;

/**
 *  Returns `YES` if the animation has completed.
 */
@property (nonatomic,readonly,getter = isComplete) BOOL complete;

/**
 *  Returns `YES` if the animation has completed and the animation actually finished.
 */
@property (nonatomic,readonly,getter = isFinished) BOOL finished;

/**
 *  Returns the duration of the animation.
 */
@property (nonatomic,readonly) NSTimeInterval duration;

/**
 *  Returns the delay before the animation will begin.
 */
@property (nonatomic) NSTimeInterval delay;

- (void)postponeAnimation;
- (void)beginAnimation;

@end

@class TrCurve;
@protocol TrAnimatable;

/**
 *  The `TrAnimation` is an abstract class used by many animations that uses Core Animation as the animation technology.
 *
 *  @discussion Do not instantiate this class - as it does no animation on its own. Instead instantiate one of the many subclasses. If this an instance of this class is added to a TrAnimationGroup instance, the animation will never complete.
 */
@interface TrAnimation : NSObject <TrAnimation>

///------------------------------------
/// @name Getting Animation Information
///------------------------------------

/**
 *  Returns the animated layer.
 */
@property (weak,readonly,nonatomic) CALayer *layer;

@property (nonatomic) NSTimeInterval duration;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                  curve:(TrCurve *)curve
             completion:(void(^)(BOOL finished))completion;

@end
