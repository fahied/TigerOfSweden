//
//  RestFullManager.h
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 11/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestFullManager : NSObject


+(void)getJsonWhereRoute:(NSString*)route prams:(NSDictionary*)prams completion:(void (^)(BOOL success, id json))completion;


@end
