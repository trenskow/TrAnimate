//
//  TrMoveInAnimation.m
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

#import "TrAnimationSubclass.h"
#import "TrMoveInAnimation.h"

@interface TrMoveInAnimation () {
    
    TrCustomCurveBlock _curve;
    CGPoint _startPosition;
    CGPoint _endPosition;
    
}

@end

@implementation TrMoveInAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    /* Unhide layer */
    if (!(self.options & kTrMoveInAnimationOptionReversed))
        self.view.hidden = NO;
    
    /*
     Animation has started. Presentation layer is not visible instead of actual layer.
     Set view's layers position to match the end of the animation, so that when the presentation layer is removed,
     the view's layer is in end position.
     */
    self.view.layer.position = _endPosition;
    
}

- (void)animationCompleted:(BOOL)finished {
    
    [super animationCompleted:finished];
    
    if (self.options & kTrMoveInAnimationOptionReversed) {
        self.view.hidden = YES;
        self.view.layer.position = _startPosition;
    }
    
}

- (void)setupAnimations {
    
    TrAnimationOptions options = self.options;
    
    CGRect animationBounds = self.view.superview.bounds;
    if (options & kTrMoveInAnimationOptionFromScreenBounds)
        animationBounds = [self.view.window convertRect:self.view.window.bounds toView:self.view.superview];
    
    CGPoint endPosition = self.view.layer.position;
    CGPoint startPosition = endPosition;
    
    CGRect viewFrame = self.view.frame;
    
    /* Parse settings */
    switch (options & 0x6) {
        case kTrMoveInAnimationOptionDirectionTop:
            startPosition.y = animationBounds.origin.y - (viewFrame.size.height * self.view.layer.anchorPoint.y);
            break;
        case kTrMoveInAnimationOptionDirectionRight:
            startPosition.x = animationBounds.origin.x + animationBounds.size.width + (viewFrame.size.width * self.view.layer.anchorPoint.x);
            break;
        case kTrMoveInAnimationOptionDirectionBottom:
            startPosition.y = animationBounds.origin.y + animationBounds.size.height + (viewFrame.size.height * self.view.layer.anchorPoint.y);
            break;
        case kTrMoveInAnimationOptionDirectionLeft:
            startPosition.x = animationBounds.origin.x - (viewFrame.size.width * self.view.layer.anchorPoint.x);
            break;
    }
    
    /* Reverse start and end if reversed option is set */
    if (options & kTrAnimationOptionReversed) {
        CGPoint t = startPosition;
        startPosition = endPosition;
        endPosition = t;
    }
    
    CGFloat startValue = startPosition.x;
    CGFloat endValue = endPosition.x;
    NSString *keyPath = @"position.x";
    
    if ((options & 0x6) == kTrMoveInAnimationOptionDirectionTop || (options & 0x6) == kTrMoveInAnimationOptionDirectionBottom) {
        startValue = startPosition.y;
        endValue = endPosition.y;
        keyPath = @"position.y";
    }
    
    /* Create and group animations */
    TrCustomCurvedAnimation *moveAnimation = [TrCustomCurvedAnimation animationWithKeyPath:keyPath];
    moveAnimation.curve = _curve;
    moveAnimation.fromValue = @(startValue);
    moveAnimation.toValue = @(endValue);
    
    [self prepareAnimation:moveAnimation usingKey:@"moveAnimation"];
    
    /*
     Animation has not yet started. If a delay is set, the presentation layer will not be presented until animation begins.
     Therefore we set the layers position to match the beginning of the animation.
     */
    self.view.layer.position = CGPointMake(startPosition.x,
                                           startPosition.y);
    
    /* Set animation instance variables */
    _startPosition = startPosition;
    _endPosition = endPosition;
    
    /* Add animation */
    [self.view.layer addAnimation:moveAnimation forKey:nil];
    
}

#pragma mark - Creating Animation

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrMoveInAnimationOptions)options curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrMoveInAnimation *animation = [super animateView:view
                                               duration:duration
                                                  delay:delay
                                                options:(TrAnimationOptions)options
                                             completion:completion];
    
    if (animation)
        animation->_curve = (curve ? curve : kTrAnimationCurveLinear);
    
    return animation;
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrAnimationOptions)options completion:(void (^)(BOOL))completion {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                     options:(TrMoveInAnimationOptions)options
                       curve:nil
                  completion:completion];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(TrMoveInAnimationOptions)options {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                     options:(TrAnimationOptions)options
                  completion:nil];
    
}

+ (id)animateView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    
    return [self animateView:view
                    duration:duration
                       delay:delay
                     options:0
                  completion:nil];
    
}

@end
