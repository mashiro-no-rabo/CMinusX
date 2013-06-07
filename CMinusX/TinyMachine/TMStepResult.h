//
//  TMStepResult.h
//  CMinX
//
//  Created by AquarHEAD L. on 6/8/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    srOKAY = 0,
    srHALT,
    srIMEM_ERR,
    srDMEM_ERR,
    srZERODIVIDE
} T_STEPRESULT;

@interface TMStepResult : NSObject

@property T_STEPRESULT type;
@property (strong, nonatomic) NSString *message;

+ (TMStepResult *)resultOKAY;
+ (TMStepResult *)resultHALT;

@end
