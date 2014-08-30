//
//  TrPopInAnimation.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 30/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import "TrAnimatable.h"

#import "TrCurve.h"
#import "TrScaleAnimation.h"
#import "TrFadeAnimation.h"

#import "TrPopInAnimation.h"

@implementation TrPopInAnimation

#pragma mark - Creating Animations

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic
             completion:(void (^)(BOOL))completion {
    
    TrCurve *curve = (elastic ? [TrCurve easeOutElastic] : [TrCurve easeOutBack]);
    
    TrScaleAnimation *scaleAnimation = [TrScaleAnimation animate:viewOrLayer
                                                        duration:duration
                                                           delay:delay
                                                 fromScaleFactor:0.01
                                                   toScaleFactor:1.0
                                                           curve:curve];
    
    TrOpacityAnimation *opacityAnimation = [TrFadeAnimation animate:viewOrLayer
                                                           duration:duration * (elastic ? .1 : .3)
                                                              delay:delay
                                                        fromOpacity:.0
                                                          toOpacity:1.0];
    
    return [self animationGroupWithAnimations:@[scaleAnimation, opacityAnimation]
                                   completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 elastic:elastic
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
                 elastic:NO
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:.0
                 elastic:NO
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer {
    
    return [self animate:viewOrLayer
                duration:.2
                   delay:.0
                 elastic:NO
              completion:nil];
    
}

@end
