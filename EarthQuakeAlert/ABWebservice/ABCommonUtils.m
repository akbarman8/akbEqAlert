//
//  ABCommonUtils.m
//  WorkFlowManager
//
//  Created by Amit Barman on 11/16/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//
//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
@implementation ABCommonUtils

static NSString *logFilePath = nil;
//--------------------------------------------------------------------------------------------------
+ (void)initialize {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    logFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    logFilePath = FORMAT(@"%@/%@.log", logFilePath, appName);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [@"************ LOG ************" writeToFile:logFilePath
                                           atomically:YES
                                             encoding:NSUTF8StringEncoding
                                                error:nil];
    }
}


+ (UIImage *)imageNamed:(NSString *)imageName {
    static NSString *resourcePath = nil;
    if (!resourcePath) {
        resourcePath = [[NSBundle mainBundle] resourcePath];
    }
    NSString *filepath = [resourcePath stringByAppendingPathComponent:imageName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:filepath];
        return image;
    }
    return [UIImage imageNamed:imageName];
}


+ (void)showAlertwith:(NSString *)title message:(NSString *)message delete:(id)delegate {
    if (![NSThread isMainThread]) {
        EXECUTE_BLOCK_ON_MAIN_THREAD(^{
            [self showAlertwith:title message:message delete:delegate];
        });
    }
    else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:title
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [alertview show];
    }
}


+ (UIView *)backgroundView:(NSString *)imagename {
    if (!imagename) {
        imagename = @"background";
    }
    UIImageView *imageviw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagename]];
    return imageviw;
}


+ (UIBarButtonItem *)backButton {
    return [[UIBarButtonItem alloc]initWithTitle:@""
                                           style:UIBarButtonItemStyleBordered
                                          target:nil
                                          action:nil];
}


+ (void)logWithType:(int)type msg:(NSString *)format, ... {
    va_list marker;
    va_start(marker, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:marker];
    va_end(marker);

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a(z)"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];

    //Log type
    NSString *logTypeStr = @"";
    if (type == LOG_WARNING) {
        logTypeStr = @"WARNING";
    }
    else if (type == LOG_ERROR) {
        logTypeStr = @"ERROR";
    }
    else if (type == LOG_INFO) {
        logTypeStr = @"INFO";
    }
    else if (type == LOG_NONE) {
        logTypeStr = @"";
    }

    string = FORMAT(@"\n[Axio Manager] %@: %@: %@", currentTime, logTypeStr, string);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [string writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else {
        uint64_t fileSize = [[fileManager attributesOfItemAtPath:logFilePath error:nil] fileSize] / (1000 * 1000); //MB
        if (fileSize > 10) { // Max file size 10 MB
            [fileManager removeItemAtPath:logFilePath error:nil];
        }
        NSLog(@"%@", string);
#if DEBUG
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
#else
        freopen([logPath fileSystemRepresentation], "a+", stderr);
#endif
    }
    dateFormatter = nil;
}


@end
