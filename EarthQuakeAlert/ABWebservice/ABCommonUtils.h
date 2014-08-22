//
//  ABCommonUtils.h
//  WorkFlowManager
//
//  Created by Amit Barman on 11/16/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//
//--------------------------------------------------------------------------------------------------
typedef enum {
    LOG_ERROR,
    LOG_INFO,
    LOG_WARNING,
    LOG_NONE,
} LogType;


#define WFMLog(type, ...)   [ABCommonUtils logWithType:type msg:@"%@", [NSString stringWithFormat:__VA_ARGS__]];


//--------------------------------------------------------------------------------------------------
@interface ABCommonUtils : NSObject

//--------------------------------------------------------------------------------------------------

+ (UIImage *)imageNamed:(NSString *)imageName;

+ (void)showAlertwith:(NSString *)title message:(NSString *)message delete:(id)delegate;

+ (void)logWithType:(int)type msg:(NSString *)format, ...;

+ (UIView *)backgroundView:(NSString *)imageName;

+ (UIBarButtonItem *)backButton;

@end
