//
//  ABCollapseTableView.h
//  ABCollapseTableView
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/2/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//
// ***********************************************************************************/

#import <UIKit/UIKit.h>

/**
 *	ABCollapseTableView is a UITableView subclass that automatically collapse and/or expand your sections.
 *
 *  Just fill your datasource like for any table view and the magic will happen.
 *  By default all the sections are closed.
 */
@interface ABCollapseTableView : UITableView

/**
 *	This property allow to enable/disable the exclusivity.
 *  If YES, only one section is allowed to be open.
 *  Default value is YES.
 */
@property (nonatomic, assign) BOOL exclusiveSections;

/**
 *	This property allows ABCollapseTableView to automatically handle tap on headers in order to collapse or expand sections.
 *  If NO, you'll have to manually call the open or close methods if you want any content to be displayed.
 *  Default value is YES.
 */
@property (nonatomic, assign) BOOL shouldHandleHeadersTap;

/**
 *	This method will display the section whose index is in parameters
 *  If exclusiveSections boolean is YES, this method will close any open section.
 *
 *	@param	sectionIndex	The section you want to show.
 *	@param	animated	YES if you want the opening to be animated.
 */
- (void)openSection:(NSUInteger)sectionIndex animated:(BOOL)animated;

/**
 *	This method will close the section whose index is in parameters.
 *
 *	@param	sectionIndex	The section you want to close.
 *	@param	animated	YES if you want the closing to be animated.
 */
- (void)closeSection:(NSUInteger)sectionIndex animated:(BOOL)animated;

/**
 *	The will open or close the section whose index is in parameters regarding of its current state.
 *
 *	@param	sectionIndex	The section you want to toggle the visibility.
 *	@param	animated	YES if you want the toggle to be animated.
 */
- (void)toggleSection:(NSUInteger)sectionIndex animated:(BOOL)animated;

/**
 *	This methods will return YES if the section whose index is in parameters is open.
 *
 *	@param	sectionIndex	The section you want to knwo its visibility.
 *
 *	@return	YES if the section is open.
 */
- (BOOL)isOpenSection:(NSUInteger)sectionIndex;

@end
