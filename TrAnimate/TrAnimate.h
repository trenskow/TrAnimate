//
//  TrAnimate.h
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

@import Foundation;

FOUNDATION_EXPORT double TrAnimateVersionNumber;
FOUNDATION_EXPORT const unsigned char TrAnimateVersionString[];

#import "TrInterpolatable.h"

#import "NSNumber+TrAnimateAdditions.h"
#import "NSValue+TrAnimateAdditions.h"
#import "UIColor+TrAnimateAdditions.h"

#import "TrAnimatable.h"

#import "UIView+TrAnimateAdditions.h"
#import "CALayer+TrAnimateAdditions.h"

#import "TrInterpolation.h"
#import "TrCurve.h"

#import "TrAnimation.h"

#import "TrLayerAnimation.h"

#import "TrOpacityAnimation.h"
#import "TrFadeAnimation.h"
#import "UIView+TrFadeAnimationAdditions.h"
#import "TrPositionAnimation.h"
#import "TrMoveAnimation.h"
#import "UIView+TrMoveAnimationAdditions.h"
#import "TrScaleAnimation.h"
#import "TrPopInAnimation.h"
#import "UIView+TrPopInAnimationAdditions.h"
#import "TrRotateAnimation.h"

#import "TrDirectAnimation.h"
#import "NSObject+TrDirectAnimationAdditions.h"

#import "TrAnimationGroup.h"

#import "TrFadeTransition.h"
#import "TrPushTransition.h"
#import "TrFlipTransition.h"
