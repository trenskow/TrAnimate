//
//  TrAnimation_Subclass.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 7/7/13.
//  Copyright (c) 2013 Kristian Trenskow. All rights reserved.
//

#import "TrAnimation.h"

@interface TrAnimation ()

- (id)initWithView:(UIView *)view
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
           options:(TrAnimationOptions)options
        completion:(void (^)(BOOL))completion;

@property (weak,nonatomic) UIView *view;
@property (nonatomic) TrAnimationOptions options;
@property (nonatomic) NSTimeInterval duration;

- (void)prepareAnimation:(CAAnimation *)animation
                usingKey:(NSString *)key;

- (void)animationStarted;
- (void)animationCompleted:(BOOL)finished;
- (void)setupAnimations;

@end
