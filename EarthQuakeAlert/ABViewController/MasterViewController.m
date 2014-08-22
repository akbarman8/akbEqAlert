//
//  MasterViewController.m
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/1/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "MasterViewController.h"
#import "ABCommonUtils.h"
#import "DetailViewController.h"
#import "ABRestInterface.h"
#import "ABParser.h"

NSString const* urlStr=@"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary";

@interface MasterViewController ()

@property(nonatomic, retain) NSArray *eqType;
@property(nonatomic, retain) NSArray *eqDuration;
@property(nonatomic, retain) IBOutlet UIPickerView *pickerview;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    NSDictionary *sections = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"EQSettingData"];
    self.eqType = [sections objectForKey:@"EQType"];
    self.eqDuration = [sections objectForKey:@"EQDuration"];    
    self.tableView.backgroundView = [ABCommonUtils backgroundView:@"background"];
    self.navigationItem.backBarButtonItem = [ABCommonUtils backButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eqType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundView = [ABCommonUtils backgroundView:@"cellBg"];;
    cell.textLabel.text = [self.eqType objectAtIndex:indexPath.row];
    return cell;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [[self.sections objectAtIndex:section] objectForKey:@"section"];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self getDataFromServer:nil];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        [self getDataFromServer:segue];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.eqDuration.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.eqDuration objectAtIndex:row];
}


#pragma mark - Display data
- (void)getDataFromServer:(id)segue {
    NSInteger type = [[self.tableView indexPathForSelectedRow] row];
    NSInteger dur = [self.pickerview selectedRowInComponent:0];
    
    NSArray *eqTypes = @[@"Significant", @"4.5", @"2.5", @"1.0", @"all"];
    NSArray *eqDurations = @[@"hour", @"day", @"week", @"month"];
    
    NSString *urlString = FORMAT(@"%@/%@_%@.geojson", urlStr, [[eqTypes objectAtIndex:type] lowercaseString],
                                 [eqDurations objectAtIndex:dur]);
    NSURL *url = [urlString url];
    
    [ABRestInterface sendSyncRequest:url body:nil method:HttpGet completionBlock:^(NSData *response, NSError *error) {
        if (!error) {
            NSDictionary *userDetail = [ABParser parseDictionaryFromJson:response];
            NSString *title = [self.eqType objectAtIndex:type];
            
            if (segue) {
                [[segue destinationViewController] setTitle:title];
                [[segue destinationViewController] setDetailItem:[userDetail valueForKeyPath:@"features"]];
            }
            else {
                self.detailViewController.detailItem = [userDetail valueForKeyPath:@"features"];
                self.detailViewController.title = title;
            }
        }
        else {
            [ABCommonUtils showAlertwith:self.title message:error.description delete:nil];
        }
    }];
}
@end
