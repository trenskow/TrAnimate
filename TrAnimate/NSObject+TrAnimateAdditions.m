//
//  NSObject+TrAnimateAdditions.m
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

@import ObjectiveC.runtime;

#import "NSObject+TrAnimateAdditions.h"

const char NSObjectAssociatedObjectsKey;

@implementation NSObject (TrAnimateAdditions)

#pragma mark - Associated Values

- (id)associatedValueForKey:(NSString *)key {
    
    /* Return the value from the associated dictionary. */
    return [objc_getAssociatedObject(self, &NSObjectAssociatedObjectsKey) valueForKey:key];
    
}

- (void)setAssociatedValue:(id)value forKey:(NSString *)key {
    
    NSMutableDictionary *associatedValues = objc_getAssociatedObject(self, &NSObjectAssociatedObjectsKey);
    
    /* We create and associate a dictionary if not already present. */
    if (!associatedValues) {
        associatedValues = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &NSObjectAssociatedObjectsKey, associatedValues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /* We use setValue:forKey: because it removes the object if value is nil. */
    [associatedValues setValue:value forKey:key];
    
    // If dictionary is empty we remove it as an associated object. */
    if ([associatedValues count] == 0)
        objc_setAssociatedObject(self, &NSObjectAssociatedObjectsKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
