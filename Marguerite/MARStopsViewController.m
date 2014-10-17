//
//  MARStopsViewController.m
//  Marguerite
//
//  Created by Michelle Guo on 10/15/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARStopsViewController.h"
#import "MARNetworkingService.h"
#import "MARMargueriteRoute.h"

@interface MARStopsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UITableViewCell *tableView;
@property (strong, nonatomic) NSMutableArray *stops;
@property (strong, nonatomic) NSMutableDictionary *allStops;
@property (strong, nonatomic) NSMutableArray *trips;
@property (assign, nonatomic) NSInteger tripID;

@end

@implementation MARStopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MARNetworkingService *sharedService = [MARNetworkingService sharedNetworkingService];
    [sharedService getDataWithURL:@"stops" success:^(id responseObject) {
        self.allStops = [[NSMutableDictionary alloc] init]; // empty dictionary for all stops
        NSDictionary *stops = responseObject;
        NSArray *allStops = [stops objectForKey:@"results"]; // grab the value of the responseObject dictionary
        for (NSDictionary *stopDictionary in allStops) {
            [self.allStops setObject:stopDictionary[@"stop_name"] forKey:stopDictionary[@"stop_id"]];
        }
        
        // get one trip of route, using the first trip for now
        [sharedService getDataWithURL:@"trips" success:^(id responseObject) {
            NSDictionary *trips = responseObject;
            NSArray *allTrips = [trips objectForKey:@"results"]; // grab the value of the responseObject dictionary
            
            for (NSDictionary *tripDictionary in allTrips) {
                if ([tripDictionary[@"route_id"] integerValue] == self.routeID) {
                    self.tripID = [tripDictionary[@"trip_id"] integerValue];
                    break;
                }
            }
            
            self.stops = [[NSMutableArray alloc] init]; // list of stop names
            
            [sharedService getDataWithURL:@"stopTimes" success:^(id responseObject) {
                
                NSDictionary *stopTimes = responseObject;
                NSArray *allStopTimes = [stopTimes objectForKey:@"results"];
                for (NSDictionary *stopTimeDictionary in allStopTimes) {
                    NSString *stopName = self.allStops[stopTimeDictionary[@"stop_id"]];
                    [self.stops addObject:stopName];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }failure:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:[NSString stringWithFormat:@"Problem found: %@", error.localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }];
        }failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:[NSString stringWithFormat:@"Problem found: %@", error.localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }];
    }failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:[NSString stringWithFormat:@"Problem found: %@", error.localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"stopCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[self.stops objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
