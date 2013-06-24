//
//  SymbolTable.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/14/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SymbolTable : NSObject

- (void)insertSymbolName:(NSString *)name withInfo:(NSDictionary *)info;
- (id)lookupSymbolName:(NSString *)name;
- (void)deleteSymbolName:(NSString *)name;
- (void)pushLevel;
- (void)popLevel;

@end
