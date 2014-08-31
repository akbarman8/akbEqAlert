//
//  DescriptionViewController.m
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/2/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation DescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem = [ABCommonUtils backButton];
    NSLog(@"%@", self.detailItem);
    NSMutableArray *tempList = [NSMutableArray array];
    for (NSUInteger index =0; index < [self.detailItem allKeys].count; index++) {
        NSString *key = [[self.detailItem allKeys] objectAtIndex:index];
        id value = [[self.detailItem allValues] objectAtIndex:index];
        if (![value isKindOfClass:[NSNull class]]) {
            [tempList addObject:@{key: value}];
        }
    }
    self.dataList = [NSArray arrayWithArray:tempList];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.backgroundView = [ABCommonUtils backgroundView:@"cellBg"];
    
    
    cell.textLabel.text = [[[self.dataList objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    
    id value = [[[self.dataList objectAtIndex:indexPath.row] allValues] objectAtIndex:0];
    if ([value isKindOfClass:[NSString class]]) {
        cell.detailTextLabel.text = value;
    }
    
    return cell;
}



@end
