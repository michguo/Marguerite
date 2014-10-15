//
//  MARMargueriteRoute.m
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MargueriteRoute.h"

@implementation MARMargueriteRoute

- (instancetype) initWithName:(NSString *)ID shortName:(NSString *)shortName longNAme:(NSString *)longName;
{
    self = [super init];
    if(self) {
        self.routeId = ID;
        self.routeShortName = shortName;
        self.routeLongName = longName;
        
    }
    return self;
}

@end
