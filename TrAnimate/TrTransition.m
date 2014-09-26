//
//  TrTransition.m
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

#import "TrTransition.h"

@interface TrTransition ()

@property (nonatomic,getter=isSetupComplete) BOOL setupComplete;

@property (nonatomic,weak) UIView *sourceView;
@property (nonatomic,weak) UIView *destinationView;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *applyCurve;

@end

@implementation TrTransition

#pragma mark - Setup / Tear Down

- (instancetype)initWithSourceView:(id)sourceView
                   destinationView:(id)destinationView
                          duration:(NSTimeInterval)duration
                             delay:(NSTimeInterval)delay
                             curve:(id)curve
                        completion:(void (^)(BOOL))completion {
    
    if ((self = [super initWithAnimations:nil completion:completion])) {
        self.sourceView = sourceView;
        self.destinationView = destinationView;
        self.applyDuration = duration;
        self.applyDelay = delay;
        self.applyCurve = curve;
    }
    
    return self;
    
}

#pragma mark - Subclassing

- (void)setupAnimations { }

#pragma mark - Internals

- (void)beginAnimation {
    
    if (!self.isSetupComplete) {
        [self setupAnimations];
        self.setupComplete = YES;
    }
    
    [super beginAnimation];
    
}

#pragma mark - Properties

// We override this in order to apply the correct delay when animations are setup in transition.
- (void)setDelay:(NSTimeInterval)delay {
    
    self.applyDelay = delay;
    [super setDelay:delay];
    
}

@end
