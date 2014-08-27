//
//  NSValue+TrCustomCurvedAnimationAdditions.m
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

@import UIKit;

#import "NSValue+TrAnimateAdditions.h"

typedef struct {
    CGFloat x;
    CGFloat y;
    CGFloat z;
    CGFloat w;
} NSValueQuaternion;

@implementation NSValue (TrAnimateAdditions)

#pragma mark - CATransform3D Helper Methods

- (CGFloat)interpolateFromSource:(CGFloat)source dest:(CGFloat)dest progress:(CGFloat)progress {
    
    return (dest - source) * progress + source;
    
}

- (NSValueQuaternion)matrixQuaternion:(CATransform3D)m {
    
    NSValueQuaternion q;
    
    if (m.m11 + m.m22 + m.m33 > 0) {
        
        CGFloat t = m.m11 + m.m22 + m.m33 + 1.0;
        CGFloat s = .5 / sqrt(t);
        
        q.w = s * t;
        q.z = (m.m12 - m.m21) * s;
        q.y = (m.m31 - m.m13) * s;
        q.x = (m.m23 - m.m32) * s;
        
    } else if (m.m11 > m.m22 && m.m11 > m.m33) {
        
        CGFloat t = m.m11 - m.m22 - m.m33 + 1.0;
        CGFloat s = .5 / sqrt(t);
        
        q.x = s * t;
        q.y = (m.m12 + m.m21) * s;
        q.z = (m.m31 + m.m13) * s;
        q.w = (m.m23 - m.m32) * s;
        
    } else if (m.m22 > m.m33) {
        
        CGFloat t = -m.m11 + m.m22 - m.m33 + 1.0;
        CGFloat s = .5 / sqrt(t);
        
        q.y = s * t;
        q.x = (m.m12 + m.m21) * s;
        q.w = (m.m31 - m.m13) * s;
        q.z = (m.m23 + m.m32) * s;
        
    } else {
        
        CGFloat t = -m.m11 - m.m22 + m.m33 + 1.0;
        CGFloat s = .5 / sqrt(t);
        
        q.z = s * t;
        q.w = (m.m12 - m.m21) * s;
        q.x = (m.m31 + m.m13) * s;
        q.y = (m.m23 + m.m32) * s;
        
    }
    
    return q;
    
}

- (CATransform3D)transpose:(CATransform3D)m {
    
    CATransform3D r;
    
    CGFloat *mT = (CGFloat *)&m;
    CGFloat *rT = (CGFloat *)&r;
    
    for(NSInteger i = 0; i < 16; i++) {
        
        NSInteger col = i % 4;
        NSInteger row = i / 4;
        NSInteger j = col * 4 + row;
        
        rT[j] = mT[i];
        
    }
    
    return r;
    
}

- (CATransform3D)quaternionMatrix:(NSValueQuaternion)q {
    
    CATransform3D m;
    
    m.m11 = 1.0 - 2.0 * pow(q.y, 2.0) - 2.0 * pow(q.z, 2.0);
    m.m12 = 2.0 * q.x * q.y + 2.0 * q.w * q.z;
    m.m13 = 2.0 * q.x * q.z - 2.0 * q.w * q.y;
    m.m14 = .0;
    
    m.m21 = 2.0 * q.x * q.y - 2.0 * q.w * q.z;
    m.m22 = 1.0 - 2.0 * pow(q.x, 2.0) - 2.0 * pow(q.z, 2.0);
    m.m23 = 2.0 * q.y * q.z + 2.0 * q.w * q.x;
    m.m24 = .0;
    
    m.m31 = 2.0 * q.x * q.z + 2.0 * q.w * q.y;
    m.m32 = 2.0 * q.y * q.z - 2.0 * q.w * q.x;
    m.m33 = 1.0 - 2.0 * pow(q.x, 2.0) - 2.0 * pow(q.y, 2.0);
    m.m34 = .0;
    
    m.m41 = .0;
    m.m42 = .0;
    m.m43 = .0;
    m.m44 = 1.0;
    
    return m;
    
}

- (NSValueQuaternion)interpolateQuaternion:(NSValueQuaternion)a b:(NSValueQuaternion)b progress:(CGFloat)progress {
    
    NSValueQuaternion q;
    
    if (!memcmp(&a, &b, sizeof(a)))
        return a;
    
    if (progress == .0)
        return a;
    
    if (progress == 1.0)
        return b;
    
    CGFloat dp = a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
    CGFloat theta, st, sut, sout, coeff1, coeff2;
    
    theta = acos(dp);
    if (theta == .0)
        return a;
    
    if (theta < .0)
        theta *= -1.0;
    
    st = sin(theta);
    sut = sin(progress * theta);
    sout = sin((1.0 - progress) * theta);
    coeff1 = sout / st;
    coeff2 = sut / st;
    
    q.x = coeff1 * a.x + coeff2 * b.x;
    q.y = coeff1 * a.y + coeff2 * b.y;
    q.z = coeff1 * a.z + coeff2 * b.z;
    q.w = coeff1 * a.w + coeff2 * b.w;
    
    CGFloat qLen = sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w);
    q.x /= qLen;
    q.y /= qLen;
    q.z /= qLen;
    q.w /= qLen;
    
    return q;
    
}

#pragma mark - Transitioning

- (id<TrInterpolatable>)interpolateWithValue:(id<TrInterpolatable>)value atPosition:(double)position {
    
    id val = value;
    
    NSAssert([val isKindOfClass:[NSValue class]], @"NSValue cannot interpolate to value of class %@", NSStringFromClass([val class]));
    const char* valType = [val objCType];
    NSAssert(0 == strcmp(valType, [self objCType]), @"NSValue of Obj-C type %s cannot interpolate to NSValue of Ojb-C type %s", [self objCType], valType);
    
    if (0 == strcmp(valType, @encode(CGPoint))) {
        
        CGPoint val1 = [self CGPointValue];
        CGPoint val2 = [val CGPointValue];
        
        return [NSValue valueWithCGPoint:CGPointMake(((val2.x - val1.x) * position) + val1.x,
                                                     ((val2.y - val1.y) * position) + val1.y)];
        
    } else if (0 == strcmp(valType, @encode(CGSize))) {
        
        CGSize val1 = [self CGSizeValue];
        CGSize val2 = [val CGSizeValue];
        
        return [NSValue valueWithCGSize:CGSizeMake(((val2.width - val1.width) * position) + val1.width,
                                                   ((val2.height - val1.height) * position) + val1.height)];
        
    } else if (0 == strcmp(valType, @encode(CGRect))) {
        
        CGRect val1 = [self CGRectValue];
        CGRect val2 = [val CGRectValue];
        
        return [NSValue valueWithCGRect:CGRectMake(((val2.origin.x - val1.origin.x) * position) + val1.origin.x,
                                                   ((val2.origin.y - val1.origin.y) * position) + val1.origin.y,
                                                   ((val2.size.width - val1.size.width) * position) + val1.size.width,
                                                   ((val2.size.height - val1.size.height) * position) + val1.size.height)];
        
    } else if (0 == strcmp(valType, @encode(CATransform3D))) {
        
        CATransform3D fromTf = [self CATransform3DValue];
        CATransform3D toTf = [val CATransform3DValue];
        CATransform3D valueTf;
        
        memcpy(&valueTf, &CATransform3DIdentity, sizeof(valueTf));
        
        fromTf = [self transpose:fromTf];
        toTf = [self transpose:toTf];
        
        NSValueQuaternion from;
        NSValueQuaternion to;
        from.x = fromTf.m14;
        from.y = fromTf.m24;
        from.z = fromTf.m34;
        
        to.x = toTf.m14;
        to.y = toTf.m24;
        to.z = toTf.m34;
        
        CGFloat vTX = [self interpolateFromSource:from.x dest:to.x progress:position];
        CGFloat vTY = [self interpolateFromSource:from.y dest:to.y progress:position];
        CGFloat vTZ = [self interpolateFromSource:from.z dest:to.z progress:position];
        
        NSValueQuaternion fromS;
        NSValueQuaternion toS;
        
        fromS.x = sqrt(pow(fromTf.m11, 2.0) + pow(fromTf.m12, 2.0) + pow(fromTf.m13, 2.0));
        fromS.y = sqrt(pow(fromTf.m21, 2.0) + pow(fromTf.m22, 2.0) + pow(fromTf.m23, 2.0));
        fromS.z = sqrt(pow(fromTf.m31, 2.0) + pow(fromTf.m32, 2.0) + pow(fromTf.m33, 2.0));
        
        toS.x = sqrt(pow(toTf.m11, 2.0) + pow(toTf.m12, 2.0) + pow(toTf.m13, 2.0));
        toS.y = sqrt(pow(toTf.m21, 2.0) + pow(toTf.m22, 2.0) + pow(toTf.m23, 2.0));
        toS.z = sqrt(pow(toTf.m31, 2.0) + pow(toTf.m32, 2.0) + pow(toTf.m33, 2.0));
        
        NSValueQuaternion vS;
        
        vS.x = [self interpolateFromSource:fromS.x dest:toS.x progress:position];
        vS.y = [self interpolateFromSource:fromS.y dest:toS.y progress:position];
        vS.z = [self interpolateFromSource:fromS.z dest:toS.z progress:position];
        
        CATransform3D fromRotation;
        
        fromRotation.m11 = fromTf.m11 / fromS.x;
        fromRotation.m12 = fromTf.m12 / fromS.x;
        fromRotation.m13 = fromTf.m13 / fromS.x;
        fromRotation.m14 = .0;
        
        fromRotation.m21 = fromTf.m21 / fromS.y;
        fromRotation.m22 = fromTf.m22 / fromS.y;
        fromRotation.m23 = fromTf.m23 / fromS.y;
        fromRotation.m24 = .0;
        
        fromRotation.m31 = fromTf.m31 / fromS.z;
        fromRotation.m32 = fromTf.m32 / fromS.z;
        fromRotation.m33 = fromTf.m33 / fromS.z;
        fromRotation.m34 = .0;
        
        fromRotation.m41 = .0;
        fromRotation.m42 = .0;
        fromRotation.m43 = .0;
        fromRotation.m44 = 1.0;
        
        CATransform3D toRotation;
        toRotation.m11 = toTf.m11 / toS.x;
        toRotation.m12 = toTf.m12 / toS.x;
        toRotation.m13 = toTf.m13 / toS.x;
        toRotation.m14 = 0.0;
        
        toRotation.m21 = toTf.m21 / toS.y;
        toRotation.m22 = toTf.m22 / toS.y;
        toRotation.m23 = toTf.m23 / toS.y;
        toRotation.m24 = 0;
        
        toRotation.m31 = toTf.m31 / toS.z;
        toRotation.m32 = toTf.m32 / toS.z;
        toRotation.m33 = toTf.m33 / toS.z;
        toRotation.m34 = 0;
        
        toRotation.m41 = 0;
        toRotation.m42 = 0;
        toRotation.m43 = 0;
        toRotation.m44 = 1;
        
        NSValueQuaternion fromQuat = [self matrixQuaternion:fromRotation];
        NSValueQuaternion toQuat = [self matrixQuaternion:toRotation];
        
        CGFloat fromQuatLen = sqrt(fromQuat.x*fromQuat.x + fromQuat.y*fromQuat.y + fromQuat.z*fromQuat.z + fromQuat.w*fromQuat.w);
        fromQuat.x /= fromQuatLen;
        fromQuat.y /= fromQuatLen;
        fromQuat.z /= fromQuatLen;
        fromQuat.w /= fromQuatLen;
        CGFloat toQuatLen = sqrt(toQuat.x*toQuat.x + toQuat.y*toQuat.y + toQuat.z*toQuat.z + toQuat.w*toQuat.w);
        toQuat.x /= toQuatLen;
        toQuat.y /= toQuatLen;
        toQuat.z /= toQuatLen;
        toQuat.w /= toQuatLen;
        
        NSValueQuaternion valueQuat;
        valueQuat = [self interpolateQuaternion:fromQuat
                                              b:toQuat
                                       progress:position];
        
        valueTf = [self quaternionMatrix:valueQuat];
        
        valueTf.m11 *= vS.x;
        valueTf.m12 *= vS.x;
        valueTf.m13 *= vS.x;
        
        valueTf.m21 *= vS.y;
        valueTf.m22 *= vS.y;
        valueTf.m23 *= vS.y;
        
        valueTf.m31 *= vS.z;
        valueTf.m32 *= vS.z;
        valueTf.m33 *= vS.z;
        
        valueTf.m14 = vTX;
        valueTf.m24 = vTY;
        valueTf.m34 = vTZ;
        
        valueTf = [self transpose:valueTf];
        
        return [NSValue valueWithCATransform3D:valueTf];
        
    }
    
    NSAssert(NO, @"NSValue cannot interpolate values of type %s", valType);
    return nil;
    
}

@end
