//
//  CALayer+TrFadeAnimationAdditions.m
//  TrAnimate
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

#import "TrFadeAnimation.h"

#import "UIView+TrFadeAnimationAdditions.h"

@implementation UIView (TrFadeAnimationAdditions)

#pragma mark - Creating Fade In Animations

- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionIn
                              curve:curve
                         completion:completion];
    
}

- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                      curve:(TrCurve *)curve {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionIn
                              curve:curve];
    
}

- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionIn];
    
}

- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:.0
                          direction:TrFadeAnimationDirectionIn];
    
}

#pragma mark - Creating Fade Out Animations

- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionOut
                              curve:curve
                         completion:completion];
    
}

- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionOut
                              curve:curve];
    
}

- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:delay
                          direction:TrFadeAnimationDirectionOut];
    
}

- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration {
    
    return [TrFadeAnimation animate:self
                           duration:duration
                              delay:.0
                          direction:TrFadeAnimationDirectionOut];
    
}

@end
