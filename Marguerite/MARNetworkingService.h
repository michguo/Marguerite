//
//  MARNetworkingService.h
//  Marguerite
//
//  Created by Michelle Guo on 10/15/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MargueriteSuccessBlock)(id responseObject);
typedef void (^MargueriteFailureBlock)(NSError *error);

@interface MARNetworkingService : NSObject

+ (instancetype)sharedNetworkingService;

- (void)getDataWithURL:(NSString *)type success:(MargueriteSuccessBlock)success failure:(MargueriteFailureBlock)failure;

@end