//
//  DescriptionViewController.m
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/2/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "DescriptionViewController.h"
#import <MapKit/MapKit.h>

@interface DescriptionViewController () <UISplitViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) IBOutlet MKMapView *mapview;

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
    [self.view addSubview:[ABCommonUtils backgroundView:nil]];
    NSLog(@"%@", self.detailItem);
    NSArray *coordinate = [self.detailItem valueForKeyPath:@"geometry.coordinates"];
    CGFloat xpos = [[coordinate objectAtIndex:0] floatValue];
    CGFloat ypos = [[coordinate objectAtIndex:1] floatValue];
    [self.mapview setCenter:CGPointMake(xpos, ypos)];
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



@end
