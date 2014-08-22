//
//  ABParser.h
//  AxioManager
//
//  Created by Amit on 7/10/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------
@interface ABParser : NSObject <NSXMLParserDelegate> {
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}

+ (id)parseFromXml:(NSData *)data keyListWithDot:(NSString *)key;

+ (NSArray *)parseFromJson:(NSData *)data;

+ (NSMutableDictionary *)parseDictionaryFromJson:(NSData *)data;

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error;

+ (NSDictionary *)parseFromXml:(NSData *)data;

+ (NSMutableArray *)parseMutableFromJson:(NSData *)data;

+ (NSData *)parseJsonFromDictionary:(NSDictionary *)dictionary;

+ (NSString *)parseJsonStringFromDictionary:(NSDictionary *)dictionary isIncludeEmpty:(BOOL)isIncludeEmpty;

@end
