//
//  DetailViewController.h
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/1/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
