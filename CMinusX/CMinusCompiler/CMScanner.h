//
//  CMScanner.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMToken.h"

@interface CMScanner : NSObject

+ (NSArray *)scan:(NSString *)input;

@end
