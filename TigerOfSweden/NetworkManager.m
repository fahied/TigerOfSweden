//
//  NetworkManager.m
//  Tastingnotes
//
//  Created by Muhammad Fahied on 12/02/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import "NetworkManager.h"
#import "AppConstants.h"


@implementation NetworkManager


#pragma mark Singleton Methods

+ (id)sharedManager {
    static NetworkManager *sharedManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 300;
        
        sharedManger = [[self alloc] initWithBaseURL:SERVER_URL sessionConfiguration:config];
        //set max concurrent operation
        sharedManger.operationQueue.maxConcurrentOperationCount = 3;
        //allow invalid ssl certificate : not recommended for production
        sharedManger.securityPolicy.allowInvalidCertificates = YES;
        
        // Make sure we a JSON serialization policy, not sure what the default is
        sharedManger.requestSerializer = [AFJSONRequestSerializer serializer];
        sharedManger.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    
    return sharedManger;
}




@end
