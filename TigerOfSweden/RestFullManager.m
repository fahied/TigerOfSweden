//
//  RestFullManager.m
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 11/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import "RestFullManager.h"
#import "NetworkManager.h"


@implementation RestFullManager

+(void)getJsonWhereRoute:(NSString*)route prams:(NSDictionary*)prams completion:(void (^)(NSError *error, id json))completion
{
    NetworkManager *networkManger = [NetworkManager sharedManager];
    
    [networkManger GET:route parameters:prams success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(nil, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(error, nil);
    }];
}


@end
