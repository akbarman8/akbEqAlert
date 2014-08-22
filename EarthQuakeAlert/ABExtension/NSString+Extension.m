//
//  NSString+Extension.m
//  WorkFlowManager
//
//  Created by Amit Barman on 11/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//
//--------------------------------------------------------------------------------------------------

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"


//--------------------------------------------------------------------------------------------------
#pragma mark - NSString Category
//--------------------------------------------------------------------------------------------------

@implementation NSString (Extension)


- (NSData *)dataFromString {
    NSString *string = [self copy];
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}


- (BOOL)containString:(NSString *)inputString {
    NSString *string = [self copy];
    NSRange range = [[string lowercaseString] rangeOfString:[inputString lowercaseString]];
    if (range.length != 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isNumber {
    NSString *string = [self copy];
    NSRange range;
    NSCharacterSet *allowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    range = [string rangeOfCharacterFromSet:allowedChars];
    if (range.location != NSNotFound) {
        return NO;
    }
    return YES;
}

- (BOOL)isSpecialCharacter {
    NSString *string = [self copy];
    NSString *specialCharacterString = @"!~`@#$%^&*+();:={}[],.<>?\\/\"\'";
    NSCharacterSet *specialCharacterSet = [NSCharacterSet
            characterSetWithCharactersInString:specialCharacterString];

    if ([string.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length) {
        return YES;
    }
    return NO;
}

- (BOOL)isSpecialCharacterforRightExpression {
    NSString *string = [self copy];
    NSString *specialCharacterString = @"!~`@#$%^&*+();:={}[],.<>?\\/\'";
    NSCharacterSet *specialCharacterSet = [NSCharacterSet
            characterSetWithCharactersInString:specialCharacterString];

    if ([string.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length) {
        return YES;
    }
    return NO;
}


- (BOOL)isEmptyString {
    NSString *string = [self copy];
    if ([string isKindOfClass:[NSString class]]) {
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        return [string isEqualToString:@""];
    }
    return NO;
}


- (NSString *)nullToEmpty {
    NSString *string = [self copy];
    if ([string containString:@"null"] || !string || string.length < 1) {
        string = EMPTY_STRING;
    }
    return string;
}


- (BOOL)isWhitespaceExist {
    NSString *string = [self copy];
    NSRange whiteSpaceRange = [string rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}


- (NSString *)trimWhitespace {
    NSMutableString *mStr = [self mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef) mStr);

    NSString *result = [mStr copy];
    mStr = nil;
    return result;
}


- (NSString *)removeNewlineAndWhitespace {
    NSString *string = [self copy];
    if (string && [string isKindOfClass:[NSString class]]) {
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return string;
}


+ (NSString *)stringFromData:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


+ (NSString *)stringWithUTF8Data:(NSData *)data {
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}


- (NSString *)encodeUrl {
    NSString *string = [self copy];
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)replaceAll:(NSString *)target withString:(NSString *)replacement {
    NSString *string = [self copy];
    return [string stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSURL *)url {
    NSString *string = [self copy];
    return [NSURL URLWithString:string];
}


- (NSString *)xmlUnescape {
    NSMutableString *string = [NSMutableString stringWithString:[self copy]];
    [string replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&#x27;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&#x39;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&#x92;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&#x96;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [string length])];

    return string;
}

- (NSString *)xmlEscape {
    NSMutableString *string = [NSMutableString stringWithString:[self copy]];
    [string replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"'" withString:@"&#x27;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];

    return string;
}


//- (NSString *)stringBreakToFitWidth:(CGFloat)width maxLine:(NSInteger)maxLine attribute:(NSMutableDictionary *)attributes {
//    if (!attributes) {
//        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        [paragraphStyle setAlignment:UILeftTextAlignment];
//        attributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                paragraphStyle, NSParagraphStyleAttributeName,
//                [NSFont fontWithName:FONT_HELVETICA size:11], NSFontAttributeName,
//                [NSColor blackColor], NSForegroundColorAttributeName,
//                nil];
//    }
//    NSString *string = [self copy];
//    NSSize stringSize = [string sizeWithAttributes:attributes];
//
//    CGFloat ratio = width / stringSize.width;
//    NSInteger difference = (NSInteger) stringSize.width % (NSInteger) width;
//    NSInteger numberOfLines = (stringSize.width - difference) / width;
//    NSInteger numberOfChars = abs(ratio * string.length);
//
//    NSRange range = NSMakeRange(0, numberOfChars);
//    NSInteger charsReturned = 0;
//    NSMutableArray *retArray = [NSMutableArray array];
//    for (int i = 0; i < numberOfLines; i++) {
//        [retArray addObject:[string substringWithRange:range]];
//        charsReturned += numberOfChars;
//        range.location += numberOfChars;
//    }
//    if (charsReturned < string.length) {
//        [retArray addObject:[string substringFromIndex:range.location]];
//    }
//
//    NSMutableString *newstr = [[NSMutableString alloc] init];
//    for (NSInteger index = 0; index < retArray.count; index++) {
//        NSString *temp = [retArray objectAtIndex:index];
//
//        if (index == maxLine) {
//            temp = FORMAT(@"%@..", [newstr substringToIndex:(newstr.length - 2)]);
//            return temp;
//        }
//        else {
//            [newstr appendFormat:@"%@\n", temp];
//        }
//    }
//    return newstr;
//}

@end


//--------------------------------------------------------------------------------------------------
#pragma mark - NSdata Category
//--------------------------------------------------------------------------------------------------
@implementation NSData (Extension)

- (NSString *)stringWithUTF8Data {
    NSData *data = [self copy];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}

- (NSString *)stringFromData {
    NSData *data = [self copy];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end


//--------------------------------------------------------------------------------------------------
#pragma mark - NSNull Category
//--------------------------------------------------------------------------------------------------
@implementation NSNull (Extension)

- (NSString *)nullToEmpty {
    NSNull *null = [self copy];
    if (!null) {
        return @"";
    }
    return @"";
}

@end


//--------------------------------------------------------------------------------------------------


