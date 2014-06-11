//
//  DataProvider.h
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 11/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataProvider : NSObject


+(NSArray*)fetchProductsFromIndex:(int)index count:(int)count;

@end
