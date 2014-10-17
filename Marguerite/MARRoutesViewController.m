//
//  MARRoutesViewController.m
//  Marguerite
//
//  Created by Michelle Guo on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARRoutesViewController.h"
#import "MARMargueriteRoute.h"
#import "MARNetworkingService.h"
#import "MARStopsViewController.h"

@interface MARRoutesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *routes;

@end

@implementation MARRoutesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MARNetworkingService *sharedService = [MARNetworkingService sharedNetworkingService];
    [sharedService getDataWithURL:@"routes" success:^(id responseObject) {
        NSDictionary *results = responseObject;
        NSArray *routes = [results objectForKey:@"results"];
        self.routes = [[NSMutableArray alloc] init];
        for (NSDictionary *routeDictionary in routes) {
            MARMargueriteRoute *route = [[MARMargueriteRoute alloc] initWithId:[routeDictionary[@"route_id"] integerValue] longName:routeDictionary[@"route_long_name"]]; // store values in MARMarguerite object
            [self.routes addObject:route]; // add to the array
        }
        //self.members = [results objectForKey:@"students"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
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
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"routeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MARMargueriteRoute *route = [self.routes objectAtIndex:indexPath.row]; // routes is an array of MARMargueriteRoute
                                                                           // objects
    [cell.textLabel setText:route.routeLongName];
    
    return cell;
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MARStopsViewController *viewController = segue.destinationViewController;
    MARMargueriteRoute *route = [self.routes objectAtIndex:[self.tableView
                                                     indexPathForSelectedRow].row];
    [viewController setRouteID:route.routeId];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
