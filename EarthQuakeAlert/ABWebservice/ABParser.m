//
//  ABParser.m
//  AxioManager
//
//  Created by Amit on 7/10/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------
#import "ABParser.h"
//----------------------------------------------------------------------------------------------------------------------
@interface ABParser (Internal)

- (id)initWithError:(NSError **)error;

- (NSDictionary *)objectWithData:(NSData *)data;

@end


//----------------------------------------------------------------------------------------------------------------------
@implementation ABParser

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Public methods - Parse JSON
//----------------------------------------------------------------------------------------------------------------------
+ (NSArray *)parseFromJson:(NSData *)data {
    if (!data) {
        return nil;
    }
    id cData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([cData isKindOfClass:[NSDictionary class]]) {
        cData = [NSArray arrayWithObject:cData];
    }
//    WFMLog(LOG_SUCCESS, @"Respose:%@", cData);
    return cData;
}


+ (NSMutableDictionary *)parseDictionaryFromJson:(NSData *)data {
    if (!data) {
        return nil;
    }
    id cData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([cData count] < 1) {
        return nil;
    }
//    WFMLog(LOG_SUCCESS, @"Respose:%@", cData);
    return [NSMutableDictionary dictionaryWithDictionary:cData];
}


+ (NSMutableArray *)parseMutableFromJson:(NSData *)data {
    if (!data) {
        return [NSMutableArray array];
    }
    id cData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([cData isKindOfClass:[NSDictionary class]]) {
        cData = [NSArray arrayWithObject:cData];
    }
//    WFMLog(LOG_SUCCESS, @"Respose:%@", cData);
    NSMutableArray *mutableCData = [NSMutableArray array];
    for (NSDictionary *eachCData in cData) {
        NSMutableDictionary *newcData = [NSMutableDictionary dictionaryWithDictionary:eachCData];
        [mutableCData addObject:newcData];
    }
    return mutableCData;
}


+ (NSData *)parseJsonFromDictionary:(NSDictionary *)dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return jsonData;
}


+ (NSString *)parseJsonStringFromDictionary:(NSDictionary *)dictionary isIncludeEmpty:(BOOL)isIncludeEmpty {
    NSError *error = nil;
    NSString *jsonString = nil;
    if (isIncludeEmpty) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        jsonString = [jsonData stringFromData];
    }
    else {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];

        for (NSString *eachkey in [dictionary allKeys]) {
            id eachValue = [dictionary valueForKey:eachkey];
            if ([eachValue isKindOfClass:[NSNumber class]]) {
                eachValue = [NSString stringWithFormat:@"%@", eachValue];
            }
            if (![eachValue isEmptyString]) {
                [newDict setValue:eachValue forKey:eachkey];
            }
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newDict options:0 error:&error];
        jsonString = [jsonData stringFromData];
    }
    return jsonString;
}

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Public methods - Parse XML
//----------------------------------------------------------------------------------------------------------------------
+ (NSDictionary *)parseFromXml:(NSData *)data {
    NSString *xmlStr = [data stringFromData];
    xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"bpmn2:" withString:@""];
    xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"drools:" withString:@""];
    xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"tns:" withString:@""];

    NSError *error = nil;
    ABParser *reader = [[ABParser alloc] initWithError:&error];
    NSDictionary *rootDictionary = [reader objectWithData:[xmlStr dataFromString]];
    reader = nil;
    return rootDictionary;
}


+ (id)parseFromXml:(NSData *)data keyListWithDot:(NSString *)key {
    NSDictionary *dictinary = [ABParser parseFromXml:data];
    if (!key) {
        return dictinary;
    }
    return [dictinary valueForKeyPath:key];
}


+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error {
    return [ABParser parseFromXml:data];
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark -  mark Parsing
//----------------------------------------------------------------------------------------------------------------------

- (id)initWithError:(NSError **)error {
    if (self = [super init]) {
//        errorPointer = *error;
    }
    return self;
}

- (void)dealloc {
    SAFE_RELEASE(dictionaryStack);
    SAFE_RELEASE(textInProgress);
}


- (NSDictionary *)objectWithData:(NSData *)data {
    // Clear out any old data
    /**  [dictionaryStack release];
      [textInProgress release];**/

    dictionaryStack = [[NSMutableArray alloc] init];
    textInProgress = [[NSMutableString alloc] init];

    // Initialize the stack with a fresh dictionary
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];

    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];

    // Return the stack's root dictionary on success
    if (success) {
        NSDictionary *resultDict = [dictionaryStack objectAtIndex:0];
        return resultDict;
    }
    return nil;
}

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - NSXMLParserDelegate methods -
//----------------------------------------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // Get the dictionary for the current level in the stack
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];

    // Create the child dictionary for the new element, and initilaize it with the attributes
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];

    // If there's already an item for this key, it means we need to create an array
    id existingValue = [parentDict objectForKey:elementName];
    if (existingValue) {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]]) {
            // The array exists, so use it
            array = (NSMutableArray *) existingValue;
        }
        else {
            // Create an array if it doesn't exist
            array = [NSMutableArray array];
            [array addObject:existingValue];

            // Replace the child dictionary with an array of children dictionaries
            [parentDict setObject:array forKey:elementName];
        }
        // Add the new child dictionary to the array
        [array addObject:childDict];
    }
    else {
        // No existing value, so update the dictionary
        [parentDict setObject:childDict forKey:elementName];
    }
    // Update the stack
    [dictionaryStack addObject:childDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // Update the parent dict with text info
    NSMutableDictionary *dictInProgress = [dictionaryStack lastObject];

    // Set the text property
    if ([textInProgress length] > 0) {
        [dictInProgress setObject:textInProgress forKey:elementName];
        // Reset the text
        //[textInProgress release];
        textInProgress = [[NSMutableString alloc] init];
    }
    // Pop the current dict
    [dictionaryStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Build the text value
    [textInProgress appendString:[string trimWhitespace]];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Set the error pointer to the parser's error object
    errorPointer = parseError;
}

@end
