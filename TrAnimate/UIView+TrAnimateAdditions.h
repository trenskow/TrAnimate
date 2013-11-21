//
//  UIView+TrAnimateAdditions.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 21/11/13.
//  Copyright (c) 2013 Kristian Trenskow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TrAnimateAdditions)

- (void)setValueAnimated:(id)value forKey:(NSString *)key withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay curve:(TrCustomCurveBlock)curve completed:(void (^)(BOOL finished))completed;

@end
