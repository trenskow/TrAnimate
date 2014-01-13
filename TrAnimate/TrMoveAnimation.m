//
//  TrMoveAnimation.m
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
#import "TrMoveAnimation.h"

@interface TrMoveAnimation () {
    
    TrCustomCurveBlock _curve;
    CGPoint _startPosition;
    CGPoint _endPosition;
    
}

@end

@implementation TrMoveAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    CGPoint endPosition = [[[NSValue valueWithCGPoint:_startPosition] transitionToValue:[NSValue valueWithCGPoint:_endPosition]
                                                                           withProgress:_curve(1.0f)] CGPointValue];
    
    self.layer.position = endPosition;
    
}

- (void)setupAnimations {
    
    /* Create and group animations */
    TrCustomCurvedAnimation *moveAnimation = [TrCustomCurvedAnimation animationWithKeyPath:@"position"];
    moveAnimation.curve = _curve;
    moveAnimation.fromValue = [NSValue valueWithCGPoint:_startPosition];
    moveAnimation.toValue = [NSValue valueWithCGPoint:_endPosition];
    
    [self prepareAnimation:moveAnimation usingKey:@"moveAnimation"];
    
    [self.layer addAnimation:moveAnimation forKey:nil];
    
}

#pragma mark - Creating Animation

+ (instancetype)animate:(id)viewOrLayer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay endPosition:(CGPoint)endPosition curve:(TrCustomCurveBlock)curve completion:(void (^)(BOOL))completion {
    
    TrMoveAnimation *animation = [super animate:viewOrLayer
                                       duration:duration
                                          delay:delay
                                        options:0
                                     completion:completion];
    
    if (animation) {
        animation->_curve = (curve ? curve : kTrAnimationCurveLinear);;
        animation->_startPosition = animation.layer.position;
        animation->_endPosition = endPosition;
    }
    
    return animation;
    
}

@end
