//
//  MargueriteNetworkingService.h
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MargueriteSuccessBlock)(id responseObject);
typedef void (^MargueriteFailureBlock)(NSError *error);

@interface MargueriteNetworkingService : NSObject

+ (instancetype)sharedNetworkingService;

- (void)getRoutessWithSuccess:(MargueriteSuccessBlock)success failure:(MargueriteFailureBlock)failure;

@end
