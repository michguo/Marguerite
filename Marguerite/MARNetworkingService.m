//
//  MARNetworkingService.m
//  Marguerite
//
//  Created by Michelle Guo on 10/15/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARNetworkingService.h"
#import <AFNetworking/AFNetworking.h>

@implementation MARNetworkingService

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

- (void)getDataWithURL:(NSString *)type success:(MargueriteSuccessBlock)success failure:(MargueriteFailureBlock)failure;
{
    NSString *URL;
    if([type isEqualToString:@"routes"]) {
        URL = kRoutesURL;
    } else if([type isEqualToString:@"stops"]) {
        URL = kStopsURL;
    } else if([type isEqualToString:@"stopTimes"]) {
        URL = kStopTimesURL;
    } else {
        URL = kTripsURL;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL
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
