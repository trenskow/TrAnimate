//
//  TrInterpolation.m
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

#import "TrCurve.h"
#import "TrInterpolatable.h"

#import "TrInterpolation.h"

@interface TrInterpolation ()

@property (nonatomic,copy) id (^block)(id, id, double);

@end

@implementation TrInterpolation

#pragma mark - Setup / Tear down

- (instancetype)initWithBlock:(id (^)(id, id, double))block {
    
    if ((self = [super init]))
        self.block = block;
    
    return self;
    
}

#pragma mark - Creating Interpolations

+ (instancetype)interpolationWithBlock:(id (^)(id, id, double))block {
    
    return [[self alloc] initWithBlock:block];
    
}

#pragma mark - Interpolation

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue atPosition:(double)position {
    
    if (self.block)
        return self.block(fromValue, toValue, position);
    
    if (![fromValue conformsToProtocol:@protocol(TrInterpolatable)])
        [NSException raise:@"UnsupportedType" format:@"Class of kind %@ is not interpolatable by TrAnimate.", NSStringFromClass(fromValue)];
    if (![toValue conformsToProtocol:@protocol(TrInterpolatable)])
        [NSException raise:@"UnsupportedType" format:@"Class of kind %@ is not interpolatable by TrAnimate.", NSStringFromClass(toValue)];
    
    return [(id<TrInterpolatable>)fromValue interpolateWithValue:toValue atPosition:position];
    
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    return [[[self class] alloc] initWithBlock:self.block];
    
}

@end
