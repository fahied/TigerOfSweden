//
//  NetworkManager.h
//  Tastingnotes
//
//  Created by Muhammad Fahied on 12/02/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
