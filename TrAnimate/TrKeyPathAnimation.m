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

#import "TrCurve.h"
#import "TrCustomCurvedAnimation.h"
#import "TrAnimatable.h"
#import "TrInterpolatable.h"

#import "TrAnimation+Private.h"

#import "TrKeyPathAnimation.h"

@interface TrKeyPathAnimation () {
    
    NSString *_keyPath;
    id<TrInterpolatable> _fromValue;
    id<TrInterpolatable> _toValue;
    
}

@end

@implementation TrKeyPathAnimation

#pragma mark - Internal

- (void)animationStarted {
    
    [super animationStarted];
    
    [self.layer setValue:[_fromValue interpolateWithValue:_toValue
                                               atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
}

- (void)setupAnimations {
    
    TrCustomCurvedAnimation *customAnimation = [TrCustomCurvedAnimation animationWithKeyPath:_keyPath];
    customAnimation.fromValue = _fromValue;
    customAnimation.toValue = _toValue;
    
    [self.layer setValue:[_fromValue interpolateWithValue:_toValue
                                                atPosition:[self.curve transform:1.0]]
              forKeyPath:_keyPath];
    
    [self prepareAnimation:customAnimation usingKey:[NSString stringWithFormat:@"keyPathAnimation.%@", _keyPath]];
    
}

#pragma mark - Creating Animation

+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer withKeyPath:(NSString *)keyPath {
    
    NSString *key = [NSString stringWithFormat:@"keyPathAnimation.%@", keyPath];
    
    TrCustomCurvedAnimation *animation = (TrCustomCurvedAnimation *)[viewOrLayer.animationLayer animationForKey:key];
    return (animation && [animation.keyPath isEqualToString:keyPath]);
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    [viewOrLayer.animationLayer setValue:fromValue forKeyPath:keyPath];
    
    TrKeyPathAnimation *animation = [super animate:viewOrLayer
                                          duration:duration
                                             delay:delay
                                             curve:curve
                                        completion:completion];
    
    if (animation) {
        animation->_keyPath = keyPath;
        animation->_fromValue = fromValue;
        animation->_toValue = toValue;
    }
    
    return animation;
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            layerKeyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            layerKeyPath:keyPath
               fromValue:fromValue
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            layerKeyPath:keyPath
               fromValue:[viewOrLayer.presentedLayer valueForKeyPath:keyPath]
                 toValue:toValue
                   curve:curve
              completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            layerKeyPath:keyPath
                 toValue:toValue
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           layerKeyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
            layerKeyPath:keyPath
                 toValue:toValue
                   curve:nil
              completion:nil];
    
}

@end
