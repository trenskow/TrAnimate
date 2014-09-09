//
//  TrConstruct.m
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

#import "TrFadeAnimation.h"
#import "TrMoveAnimation.h"
#import "TrPopInAnimation.h"

#import "TrConstruct.h"

@interface TrConstruct ()

@property (nonatomic,weak) id<TrAnimatable> viewOrLayer;
@property (nonatomic) NSTimeInterval applyDuration;
@property (nonatomic) NSTimeInterval applyDelay;
@property (nonatomic,copy) TrCurve *curve;
@property (nonatomic) TrAnimationGroup *group;
@property (nonatomic) TrAnimationGroup *animateAfterGroup
;

@end

@implementation TrConstruct

#pragma mark - Setup / Tear Down

- (instancetype)initWithViewOrLayer:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration curve:(TrCurve *)curve {
    
    if ((self = [super initWithAnimations:nil completion:nil])) {
        self.viewOrLayer = viewOrLayer;
        self.applyDuration = duration;
        self.curve = curve;
        self.group = [TrAnimationGroup animationGroup];
        [self addAnimation:self.group];
    }
    
    return self;
    
}

#pragma mark - Creating Constructs

+ (instancetype)constructWithViewOrLayer:(id<TrAnimatable>)viewOrLayer duration:(NSTimeInterval)duration curve:(TrCurve *)curve {
    
    return [[self alloc] initWithViewOrLayer:viewOrLayer duration:duration curve:curve];
    
}

#pragma mark - Adding Animations

- (TrConstruct *)fadeIn {
    
    [self.group addAnimation:[TrFadeAnimation animate:self.viewOrLayer
                                                      duration:self.applyDuration
                                                         delay:self.applyDelay
                                                     direction:TrFadeAnimationDirectionIn
                                                         curve:self.curve]];
    
    return self;
    
}

- (TrConstruct *)pushIn:(TrMoveAnimationEdge)edge fromBounds:(id<TrAnimatable>)bounds {
    
    [self.group addAnimation:[TrMoveAnimation animate:self.viewOrLayer
                                                      duration:self.applyDuration
                                                     direction:TrMoveAnimationDirectionIn
                                                          edge:edge
                                                toOrFromBounds:bounds
                                                         delay:self.applyDelay
                                                         curve:self.curve]];
    
    return self;
    
}

- (TrConstruct *)pushIn:(TrMoveAnimationEdge)edge {
    
    return [self pushIn:edge fromBounds:self.viewOrLayer];
    
}

- (TrConstruct *)popIn:(BOOL)elastic {
    
    [self.group addAnimation:[TrPopInAnimation animate:self.viewOrLayer
                                                       duration:self.applyDuration
                                                          delay:self.delay
                                                        elastic:elastic]];
    
    return self;
    
}

- (TrConstruct *)and:(id<TrAnimation>)animation {
    
    [self.group addAnimation:animation];
    
    return self;
    
}

- (TrConstruct *)then:(id<TrAnimation>)animation {
    
    if (!self.animateAfterGroup) {
        self.animateAfterGroup = [TrAnimationGroup animationGroup];
        [self addAnimation:self.animateAfterGroup animateAfter:self.group];
    }
    
    [self.animateAfterGroup addAnimation:animation];
    
    return self;
    
}

#pragma mark - Setting Animations Properties

- (TrConstruct *)afterDelay:(NSTimeInterval)delay {
    
    self.applyDelay = delay;
    
    self.group.delay = delay;
    
    return self;
    
}

- (TrConstruct *)onCompletion:(void (^)(BOOL))completion {
    
    self.completionBlock = completion;
    
    return self;
    
}

@end
