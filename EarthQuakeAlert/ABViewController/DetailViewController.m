//
//  DetailViewController.m
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/1/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------
#import "DetailViewController.h"
#import "ABRestInterface.h"
#import "ABParser.h"
#import "ABECollapseHeaderView.h"
#import "STCollapseTableView.h"
//----------------------------------------------------------------------------------------------------------------------
typedef enum {
    Magnutude = 100,
    Time = 101,
    Updated = 102,
    rms = 103,
    title = 104,
}cellData;

//----------------------------------------------------------------------------------------------------------------------
@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) NSMutableArray *sections;
@property (weak, nonatomic) IBOutlet STCollapseTableView *tableView;

- (void)configureView;

@end


//----------------------------------------------------------------------------------------------------------------------
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
    self.sections = [NSMutableArray arrayWithArray:self.detailItem];
    self.navigationItem.backBarButtonItem = [ABCommonUtils backButton];
    self.tableView.backgroundView = [ABCommonUtils backgroundView:nil];
    [self.tableView reloadData];
    [self.tableView openSection:0 animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Split view
//----------------------------------------------------------------------------------------------------------------------
- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController {
    
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Table View - 
//----------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.sections count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellIdentifier = @"Cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}

    cell.backgroundView = [ABCommonUtils backgroundView:nil];
    NSDictionary *cellData = [[self.sections objectAtIndex:indexPath.row] objectForKey:@"properties"];
    
    [(UILabel *)[cell viewWithTag:Magnutude] setText:FORMAT(@"%@ %@", [cellData objectForKey:@"mag"], [cellData objectForKey:@"magType"])];
    NSString *stringFromDate = FORMAT(@"%@", [cellData objectForKey:@"time"]);
    [(UILabel *)[cell viewWithTag:Time] setText:stringFromDate];
    [(UILabel *)[cell viewWithTag:Updated] setText:[cellData objectForKey:@"Updated"]];
    [(UILabel *)[cell viewWithTag:rms] setText:FORMAT(@"%@", [cellData objectForKey:@"rms"])];
    [(UILabel *)[cell viewWithTag:title] setText:[cellData objectForKey:@"title"]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return [ABECollapseHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ABECollapseHeaderView* view = [ABECollapseHeaderView expandableHeaderViewWithSection:section];
    NSDictionary *cellData = [[self.sections objectAtIndex:section] objectForKey:@"properties"];
	view.titleLabel.text = [cellData objectForKey:@"place"];
    return view;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = [[self.sections objectAtIndex:indexPath.row] objectForKey:@"properties"];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end
