//
//  MARMargueriteRoute.h
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARMargueriteRoute : NSObject

@property (assign, nonatomic) NSInteger routeId;
@property (strong, nonatomic) NSString *routeLongName;

- (instancetype) initWithId:(NSInteger)routeID longName:(NSString *)longName;

@end
