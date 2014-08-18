//
//  TrKeyPathAnimation.m
//  TrAnimate
//
//  Copyright (c) 2014, Kristian Trenskow All rights reserved.
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

#import "TrCurve+Private.h"
#import "TrCustomCurvedAnimation.h"
#import "TrAnimatable.h"
#import "TrInterpolatable.h"

#import "TrAnimationSubclass.h"

#import "TrKeyPathAnimation.h"

@interface TrKeyPathAnimation () {
    
    NSString *_keyPath;
    id<TrInterpolatable> _startValue;
    id<TrInterpolatable> _endValue;
    
}

@end

@implementation TrKeyPathAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    [self.layer setValue:[_startValue interpolateWithValue:_endValue
                                                atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
}

- (void)setupAnimations {
    
    TrCustomCurvedAnimation *customAnimation = [TrCustomCurvedAnimation animationWithKeyPath:_keyPath];
    customAnimation.fromValue = _startValue;
    customAnimation.toValue = _endValue;
    
    [self.layer setValue:[_startValue interpolateWithValue:_endValue
                                                atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
    [self prepareAnimation:customAnimation usingKey:[NSString stringWithFormat:@"customAnimation.%@", _keyPath]];
        
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer withKeyPath:(NSString *)keyPath {
    
    NSString *key = [NSString stringWithFormat:@"customAnimation.%@", keyPath];
    
    TrCustomCurvedAnimation *animation = (TrCustomCurvedAnimation *)[viewOrLayer.animationLayer animationForKey:key];
    return (animation && [animation.keyPath isEqualToString:keyPath]);
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer layerKeyPath:(NSString *)keyPath startValue:(id<TrInterpolatable>)startValue endValue:(id<TrInterpolatable>)endValue duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCurve *)curve completion:(void (^)(BOOL))completion {
    
    [viewOrLayer.animationLayer setValue:startValue forKeyPath:keyPath];
    
    TrKeyPathAnimation *animation = [super animate:viewOrLayer
                                         duration:duration
                                            delay:delay
                                            curve:curve
                                       completion:completion];
    
    if (animation) {
        animation->_keyPath = keyPath;
        animation->_startValue = startValue;
        animation->_endValue = endValue;
    }
    
    return animation;
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer layerKeyPath:(NSString *)keyPath endValue:(id<TrInterpolatable>)endValue duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCurve *)curve completion:(void (^)(BOOL))completion {
    
    TrKeyPathAnimation *animation = [self animate:viewOrLayer
                                    layerKeyPath:keyPath
                                       startValue:[viewOrLayer.presentedLayer valueForKeyPath:keyPath]
                                        endValue:endValue
                                        duration:duration
                                           delay:delay
                                           curve:curve
                                      completion:completion];
    
    if (animation)
        animation->_startValue = [animation.layer valueForKeyPath:keyPath];
    
    return animation;
    
}

@end
