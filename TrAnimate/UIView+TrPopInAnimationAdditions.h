//
//  UIView+TrPopInAnimationAdditions.h
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

@class TrPopInAnimation;
@class TrCurve;

/*!
 A category to `UIView` with convenience methods to create pop-in animations.
 
 @discussion See `TrPopInAnimation` for information about this type of transition.
 */
@interface UIView (TrPopInAnimationAdditions)

/// --------------------------------
/// @name Creating Pop In Animations
/// --------------------------------

/*!
 Creates and returns a pop-in animation.
 
 @param duration          The duration of the move-in.
 @param delay             The delay before the move-in begins.
 @param elastic           Specifies if the pop-in should end in an elastic fasion.
 @param completion        A block that gets invoked when move-in completes.
 
 @return A pop-in animation ready to animate.
 */
- (TrPopInAnimation *)popIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                    elastic:(BOOL)elastic
                 completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a pop-in animation.
 
 @param duration          The duration of the move-in.
 @param delay             The delay before the move-in begins.
 @param elastic           Specifies if the pop-in should end in an elastic fasion.
 
 @return A pop-in animation ready to animate.
 */
- (TrPopInAnimation *)popIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                    elastic:(BOOL)elastic;

/*!
 Creates and returns a pop-in animation.
 
 @param duration          The duration of the move-in.
 @param delay             The delay before the move-in begins.
 
 @return A pop-in animation ready to animate.
 */
- (TrPopInAnimation *)popIn:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay;

/*!
 Creates and returns a pop-in animation.
 
 @param duration          The duration of the move-in.
 
 @return A pop-in animation ready to animate.
 */
- (TrPopInAnimation *)popIn:(NSTimeInterval)duration;

@end
