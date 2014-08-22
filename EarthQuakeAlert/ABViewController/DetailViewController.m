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

NSInteger selectedIndex;
static CGFloat expandedHeight = 100.0;
static CGFloat contractedHeight = 44.0;

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *tableCell;
@property (strong, nonatomic) NSArray *sections;

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
    selectedIndex = 0;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.backgroundView = [ABCommonUtils backgroundView:@"cellBg"];
    NSDictionary *cellData = [[self.sections objectAtIndex:indexPath.row] objectForKey:@"properties"];
    cell.textLabel.text = [cellData objectForKey:@"place"];
    cell.detailTextLabel.text = FORMAT(@"Magnitude:  %@", [cellData objectForKey:@"mag"]);
    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	if ([tableView indexPathsForSelectedRows].count) {
//		if ([[tableView indexPathsForSelectedRows] indexOfObject:indexPath] != NSNotFound) {
//			return expandedHeight; // Expanded height
//		}
//        return contractedHeight; // Normal height
//	}
//    return contractedHeight; // Normal height
//}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSDictionary *cellData = [[self.sections objectAtIndex:section] objectForKey:@"properties"];
//    NSString *title = [cellData objectForKey:@"place"];
//    return title;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        self.detailViewController.detailItem = [self.sections objectForKey:@"SettingData"];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"indexpath is %ld", indexPath.row);
//    selectedIndex = indexPath.row;
//    isSearching = YES;
    
    [self.tableview beginUpdates];
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.textLabel.text=@"mnxbcnbxznmbc";//[array objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text=@"cbxzmbcmbxz";//[detailarray objectAtIndex:indexPath.row];
//    
//    cell.detailTextLabel.hidden = NO;
    
    [self.tableview endUpdates];
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview beginUpdates];
    [self.tableview endUpdates];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    if ([[segue identifier] isEqualToString:@"showDetail"]) {
    //        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //        NSDate *object = _objects[indexPath.row];
//    [[segue destinationViewController] setDetailItem:[self.sections objectForKey:@"SettingData"]];
    //    }
}

//
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.sections.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    GCRetractableSectionController* sectionController = [self.sections objectAtIndex:section];
//    return sectionController.numberOfRow;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GCRetractableSectionController* sectionController = [self.sections objectAtIndex:indexPath.section];
//    return [sectionController cellForRow:indexPath.row];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    GCRetractableSectionController* sectionController = [self.sections objectAtIndex:indexPath.section];
//    return [sectionController didSelectCellAtRow:indexPath.row];
//}



@end
