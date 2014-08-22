//
//  NSString+Extension.h
//  WorkFlowManager
//
//  Created by Amit Barman on 11/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//
//--------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>

//--------------------------------------------------------------------------------------------------
#pragma mark - NSString Category
//--------------------------------------------------------------------------------------------------
@interface NSString (Extension)

- (BOOL)containString:(NSString *)inputString;

- (BOOL)isNumber;

- (BOOL)isEmptyString;

- (NSString *)nullToEmpty;

- (BOOL)isWhitespaceExist;

- (NSData *)dataFromString;

- (NSString *)trimWhitespace;

- (NSString *)removeNewlineAndWhitespace;

- (BOOL)isSpecialCharacter;

- (BOOL)isSpecialCharacterforRightExpression;

- (NSString *)encodeUrl;

- (NSString *)replaceAll:(NSString *)target withString:(NSString *)replacement;

- (NSURL *)url;

- (NSString *)xmlUnescape;

- (NSString *)xmlEscape;

//- (NSString *)stringBreakToFitWidth:(CGFloat)width maxLine:(NSInteger)maxLine attribute:(NSMutableDictionary *)attributes;

@end

//--------------------------------------------------------------------------------------------------
#pragma mark - NSData Category
//--------------------------------------------------------------------------------------------------
@interface NSData (Extension)

- (NSString *)stringFromData;

- (NSString *)stringWithUTF8Data;

@end

//--------------------------------------------------------------------------------------------------
#pragma mark - NSNull Category
//--------------------------------------------------------------------------------------------------
@interface NSNull (Extension)

- (NSString *)nullToEmpty;

@end

//--------------------------------------------------------------------------------------------------
