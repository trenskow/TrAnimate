//
//  UIView+TrFadeTransitionAdditions.m
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

#import "TrFadeTransition.h"

#import "UIView+TrFadeTransitionAdditions.h"

@implementation UIView (TrFadeTransitionAdditions)

#pragma mark - Creating Fade To Transitions

- (TrFadeTransition *)fadeTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion {
    
    return [TrFadeTransition transitionFrom:self
                                         to:destinationView
                                   duration:duration
                                      delay:delay
                                      curve:curve
                                 completion:completion];
    
}

- (TrFadeTransition *)fadeTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve {
    
    return [TrFadeTransition transitionFrom:self
                                         to:destinationView
                                   duration:duration
                                      delay:delay
                                      curve:curve];
    
}

- (TrFadeTransition *)fadeTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay {
    
    return [TrFadeTransition transitionFrom:self
                                         to:destinationView
                                   duration:duration
                                      delay:delay];
    
}

- (TrFadeTransition *)fadeTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration {
    
    return [TrFadeTransition transitionFrom:self
                                         to:destinationView
                                   duration:duration];
    
}

@end
