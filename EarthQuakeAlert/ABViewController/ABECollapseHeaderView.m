//
//  ABECollapseHeaderView.m
//  CignaCore
//
//  Created by Amit Barman on 03/14/14.
//  Copyright 2014 Cigna. All rights reserved.
//
//--------------------------------------------------------------------------------------------------

#import "ABECollapseHeaderView.h"

#define ICON_SECTION_HEADER @"sectionheader"
//--------------------------------------------------------------------------------------------------
@interface ABECollapseHeaderView()

@property (nonatomic, strong) IBOutlet UIImageView*	arrowImage;

@end

//--------------------------------------------------------------------------------------------------
@implementation ABECollapseHeaderView

+ (ABECollapseHeaderView*)expandableHeaderViewWithSection:(NSInteger)section {
    NSArray* nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ABECollapseHeaderView"
                                                        owner:nil
                                                      options:nil];
	ABECollapseHeaderView* headerView = [nibObjects objectAtIndex:0];
	return headerView;
}


+ (CGFloat)height {
	static CGFloat height = 0.0f;
	if (height == 0.0f) {
		ABECollapseHeaderView* view = [self expandableHeaderViewWithSection:0];
		height = view.frame.size.height;
	}
	return height;
}

@end
