//
//  CALayer+TrFadeAnimationAdditions.h
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

@import UIKit;
@import QuartzCore;

@class TrFadeAnimation;
@class TrCurve;

/*!
 A category to `UIView` with convenience methods to create fade-in and fade-out animations.
 
 @discussion See `TrFadeAnimation` for information about this type of transition.
 */
@interface UIView (TrFadeAnimationAdditions)

/// -----------------------------------------
/// @name Creating Fade In and Out Animations
/// -----------------------------------------

/*!
 Creates and returns a fade-in animation. 

 @param duration   The duration of the fade-in.
 @param delay      The delay before the fade-in begins.
 @param curve      The curvature of the fade-in.
 @param completion A block that gets invokes when the fade-in completes.

 @return A fade-in animation ready to animate.
*/
- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                      curve:(TrCurve *)curve
                 completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a fade-in animation.
 
 @param duration   The duration of the fade-in.
 @param delay      The delay before the fade-in begins.
 @param curve      The curvature of the fade-in.
 
 @return A fade-in animation ready to animate.
 */
- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                      curve:(TrCurve *)curve;

/*!
 Creates and returns a fade-in animation.
 
 @param duration   The duration of the fade-in.
 @param delay      The delay before the fade-in begins.
 
 @return A fade-in animation ready to animate.
 */
- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay;

/*!
 Creates and returns a fade-in animation.
 
 @param duration   The duration of the fade-in.
 
 @return A fade-in animation ready to animate.
 */
- (TrFadeAnimation *)fadeIn:(NSTimeInterval)duration;

/*!
 Creates and returns a fade-out animation.
 
 @param duration   The duration of the fade-out.
 @param delay      The delay before the fade-out begins.
 @param curve      The curvature of the fade-out.
 @param completion A block that gets invokes when the fade-out completes.
 
 @return A fade-out animation ready to animate.
 */
- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a fade-out animation.
 
 @param duration   The duration of the fade-out.
 @param delay      The delay before the fade-out begins.
 @param curve      The curvature of the fade-out.
 
 @return A fade-out animation ready to animate.
 */
- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve;

/*!
 Creates and returns a fade-out animation.
 
 @param duration   The duration of the fade-out.
 @param delay      The delay before the fade-out begins.
 
 @return A fade-out animation ready to animate.
 */
- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration
                       delay:(NSTimeInterval)delay;


/*!
 Creates and returns a fade-out animation.
 
 @param duration   The duration of the fade-out.
 
 @return A fade-out animation ready to animate.
 */
- (TrFadeAnimation *)fadeOut:(NSTimeInterval)duration;

@end
