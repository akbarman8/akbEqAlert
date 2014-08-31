//
//  DetailViewController.m
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/1/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "DetailViewController.h"
#import "ABRestInterface.h"
#import "ABParser.h"

typedef enum {
    Magnutude = 100,
    Time = 101,
    Updated = 102,
    rms = 103,
    title = 104,
}cellData;

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *sections;

@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *updatedTime;
@property (strong, nonatomic) IBOutlet UILabel *gap;

- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView {
    if (!self.detailItem) {
        return;
    }
    self.sections = [NSArray arrayWithArray:self.detailItem];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview reloadData];
    
    self.navigationItem.backBarButtonItem = [ABCommonUtils backButton];
    self.tableview.backgroundView = [ABCommonUtils backgroundView:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

+ (NSTimeInterval)getUTCFormateDate:(NSDate *)currdate {
    
    NSDateComponents *comps = [[NSCalendar currentCalendar]
                               components:NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit
                               fromDate:currdate];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    
    return [[[NSCalendar currentCalendar] dateFromComponents:comps] timeIntervalSince1970];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.backgroundView = [ABCommonUtils backgroundView:@"cellBg"];
    NSDictionary *cellData = [[self.sections objectAtIndex:indexPath.row] objectForKey:@"properties"];

    [(UILabel *)[cell viewWithTag:Magnutude] setText:FORMAT(@"%@ %@", [cellData objectForKey:@"mag"], [cellData objectForKey:@"magType"])];
    
    
    NSString *stringFromDate = FORMAT(@"%@", [cellData objectForKey:@"time"]);
    [(UILabel *)[cell viewWithTag:Time] setText:stringFromDate];
    
    
//    [(UILabel *)[cell viewWithTag:Updated] setText:[cellData objectForKey:@"Updated"]];
    [(UILabel *)[cell viewWithTag:rms] setText:FORMAT(@"%@", [cellData objectForKey:@"rms"])];
    [(UILabel *)[cell viewWithTag:title] setText:[cellData objectForKey:@"title"]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *cellData = [[self.sections objectAtIndex:section] objectForKey:@"properties"];
    return [cellData objectForKey:@"place"];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview beginUpdates];
    [self.tableview endUpdates];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        NSDictionary *object = [[self.sections objectAtIndex:indexPath.row] objectForKey:@"properties"];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end
