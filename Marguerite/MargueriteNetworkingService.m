//
//  MargueriteNetworkingService.m
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MargueriteNetworkingService.h"
#import <AFNetworking/AFNetworking.h>

@implementation MargueriteNetworkingService

static NSString *kStopsURL = @"http://tsukihi.org/marguerite/stops.json";
static NSString *kStopTimesURL = @"http://tsukihi.org/marguerite/stop_times.json";
static NSString *kTripsURL = @"http://tsukihi.org/marguerite/trips.json";
static NSString *kRoutesURL = @"http://tsukihi.org/marguerite/routes.json";

+ (instancetype)sharedNetworkingService {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)getRoutesWithSuccess:(MargueriteSuccessBlock)success failure:(MargueriteFailureBlock)failure;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kRoutesURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if([responseObject isKindOfClass:[NSDictionary class]]) {
                 success(responseObject);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
}

@end
