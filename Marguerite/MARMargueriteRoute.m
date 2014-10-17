//
//  MARMargueriteRoute.m
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARMargueriteRoute.h"

@implementation MARMargueriteRoute

- (instancetype) initWithId:(NSInteger)routeID longNAme:(NSString *)longName;
{
    self = [super init];
    if(self) {
        self.routeId = routeID;
        self.routeLongName = longName;
    }
    return self;
}

@end
