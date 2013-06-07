//
//  TMStepResult.m
//  CMinX
//
//  Created by AquarHEAD L. on 6/8/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "TMStepResult.h"

@implementation TMStepResult

+ (TMStepResult *)resultOKAY {
    TMStepResult *result = [TMStepResult new];
    result.type = srOKAY;
    return result;
}

+ (TMStepResult *)resultHALT {
    TMStepResult *result = [TMStepResult new];
    result.type = srHALT;
    return result;
}

@end
