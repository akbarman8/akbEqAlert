//
//  ABECollapseHeaderView.h
//  CignaCore
//
//  Created by Amit Barman on 03/14/14.
//  Copyright 2014 Cigna. All rights reserved.
//
//--------------------------------------------------------------------------------------------------
typedef enum
{
	ABECollapseHeaderViewColorGray,
	ABECollapseHeaderViewColorWhite
} ABECollapseHeaderViewColor;


@interface ABECollapseHeaderView : UIView

@property (nonatomic, strong) IBOutlet UILabel*		titleLabel;
+ (ABECollapseHeaderView*)expandableHeaderViewWithSection:(NSInteger)section;
+ (CGFloat)height;

@end
