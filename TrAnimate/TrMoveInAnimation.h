//
//  TrMoveInAnimation.h
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

#import "TrCustomCurvedAnimation.h"

#import "TrAnimation.h"

typedef enum {
    
    /* Represented in bit 1 and 2 */
    kTrMoveInAnimationOptionReversed = kTrAnimationOptionReversed,
    kTrMoveInAnimationOptionDirectionTop = 0x00,
    kTrMoveInAnimationOptionDirectionRight = 0x02,
    kTrMoveInAnimationOptionDirectionBottom = 0x04,
    kTrMoveInAnimationOptionDirectionLeft = 0x06,
    kTrMoveInAnimationOptionFromScreenBounds = 1 << 3
    
} TrMoveInAnimationOptions;

@interface TrMoveInAnimation : TrAnimation

+ (id)animate:(id)viewOrLayer
     duration:(NSTimeInterval)duration
        delay:(NSTimeInterval)delay
      options:(TrMoveInAnimationOptions)options
        curve:(TrCustomCurveBlock)curve
   completion:(void (^)(BOOL finished))completion;

+ (id)animate:(id)viewOrLayer
     duration:(NSTimeInterval)duration
        delay:(NSTimeInterval)delay
      options:(TrMoveInAnimationOptions)options;

+ (id)animate:(id)viewOrLayer
     duration:(NSTimeInterval)duration
        delay:(NSTimeInterval)delay;

@end
