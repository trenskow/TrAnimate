//
//  NSObject+TrAnimationsAddition.m
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

#import "NSObject+TrAnimateAdditions.h"

#import "NSObject+TrAnimationsAddition.h"

NSString *const NSObjectAnimationAssociationsKey = @"NSObjectAnimationAssociationsKey";

@implementation NSObject (TrAnimationsAddition)

#pragma mark - Associated Animations

- (NSArray *)associatedAnimations {
    
    return [[self associatedValueForKey:NSObjectAnimationAssociationsKey] copy];
    
}

- (void)associateAnimation:(id<TrAnimation>)animation {
    
    NSMutableArray *animations = [self associatedValueForKey:NSObjectAnimationAssociationsKey];
    
    if (!animations) {
        animations = [[NSMutableArray alloc] init];
        [self setAssociatedValue:animations forKey:NSObjectAnimationAssociationsKey];
    }
    
    [animations addObject:animation];
    
}

- (void)removeAnimationAssociation:(id<TrAnimation>)animation {
    
    NSMutableArray *animations = [self associatedValueForKey:NSObjectAnimationAssociationsKey];
    
    [animations removeObject:animation];
    
    if ([animations count] == 0)
        [self setAssociatedValue:nil forKey:NSObjectAnimationAssociationsKey];
    
}

@end
