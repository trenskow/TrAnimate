//
//  UIView+TrAnimateAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 21/11/13.
//  Copyright (c) 2013 Kristian Trenskow. All rights reserved.
//

#import <objc/runtime.h>

#import "TrValueTransition.h"
#import "TrCustomCurvedAnimation.h"

#import "UIView+TrAnimateAdditions.h"

@interface UIViewSetValueAnimatedInfo : NSObject

@property (strong,nonatomic) CADisplayLink *displayLink;
@property (strong,nonatomic) NSDate *startTime;
@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) id<TrValueTransition> startValue;
@property (strong,nonatomic) id<TrValueTransition> endValue;
@property (assign,nonatomic) NSTimeInterval duration;
@property (strong,nonatomic) TrCustomCurveBlock curve;
@property (strong,nonatomic) void(^completed)(BOOL);

@end

@implementation UIViewSetValueAnimatedInfo

@end

static void* UIVIewTrAnimateAnimations;

@implementation UIView (TrAnimateAdditions)

- (NSMutableArray *)_animations {
    
    NSMutableArray *animations = objc_getAssociatedObject(self, &UIVIewTrAnimateAnimations);
    if (!animations) {
        animations = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &UIVIewTrAnimateAnimations, animations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return animations;
    
}

- (void)_displayDidUpdate:(CADisplayLink *)displayLink {
    
    for (UIViewSetValueAnimatedInfo *info in [self _animations])
        if (info.displayLink == displayLink) {
            CGFloat progress = MAX(.0, MIN(1.0, fabs([info.startTime timeIntervalSinceNow]) / info.duration));
            
            [self setValue:[(id<TrValueTransition>)info.startValue
                            transitionToValue:info.endValue
                            withProgress:info.curve(progress)]
                    forKey:info.key];
            
            if (progress == 1.0) {
                
                [info.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
                
                if (info.completed)
                    info.completed(YES);
                
                [[self _animations] removeObject:info];
                
            }
            
            break;
        }
    
}

- (void)setValueAnimated:(id)value forKey:(NSString *)key withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve completed:(void (^)(BOOL))completed {
    
    if (![value conformsToProtocol:@protocol(TrValueTransition)])
        [NSException raise:@"Bad argument exception" format:@"Value must conform to protocol TrValueTransition."];
    
    UIViewSetValueAnimatedInfo *info = [UIViewSetValueAnimatedInfo new];
    
    info.displayLink = [self.window.screen displayLinkWithTarget:self selector:@selector(_displayDidUpdate:)];
    info.key = key;
    info.startValue = [self valueForKey:key];
    info.endValue = value;
    info.duration = duration;
    info.curve = curve;
    info.completed = [completed copy];
    
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        info.startTime = [NSDate date];
        
        [[self _animations] addObject:info];
        
        [info.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    });
    
}

@end
