//
//  ABRestInterface.m
//  PeriodicTable
//
//  Created by Amit Barman on 10/15/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------
#include <CommonCrypto/CommonCryptor.h>
#import "ABRestInterface.h"
//----------------------------------------------------------------------------------------------------------------------
#define HTTP_METHOD_GET             @"GET"
#define HTTP_METHOD_POST            @"POST"
#define HTTP_METHOD_PUT             @"PUT"
#define HTTP_METHOD_DELETE          @"DELETE"
#define HTTP_CONTENT_TYPE           @"Content-type"
#define HTTP_MEDIA_APPLICATION_XML  @"application/xml"
#define HTTP_MEDIA_APPLICATION_JSON @"application/json"
#define HTTP_MEDIA_TEXT_PLAIN       @"text/plain"

//----------------------------------------------------------------------------------------------------------------------
@interface ABRestInterface ()

+ (NSString *)httpMethod:(WFMMethodType)methodType;

+ (NSMutableURLRequest *)creatRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method;

@end

@implementation ABRestInterface

static NSTimeInterval requestTimeout = 20;
NSMutableDictionary *header = nil;
NSMutableDictionary *authentication = nil;
NSOperationQueue *operationQueue = nil;
//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization -
//----------------------------------------------------------------------------------------------------------------------

+ (NSMutableURLRequest *)creatRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method {
    if ([[url absoluteString] containString:@"null"]) {
        WFMLog(LOG_ERROR, @"Request server url is not proper, Please verify server configuration");
        return nil;
    }

    NSString *httpMethod = [ABRestInterface httpMethod:method];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:requestTimeout];
    @synchronized (self) {
        if (header) {
            [header addEntriesFromDictionary:authentication];
        }
        else {
            header = [NSMutableDictionary dictionaryWithDictionary:authentication];
        }
        if (body) {
            [request setHTTPBody:body];
        }
        if (![header valueForKey:HTTP_CONTENT_TYPE] && method != HttpGet) {
            [header setValue:HTTP_MEDIA_APPLICATION_JSON forKey:HTTP_CONTENT_TYPE];
        }
        [request setAllHTTPHeaderFields:header];
        [request setHTTPMethod:httpMethod];

        //Print Request
        NSString *logMsg = FORMAT(@"Request:\n\tType: %@\n\tURL: %@", httpMethod, [url absoluteString]);
        NSMutableDictionary *logHeader = header;
        [logHeader removeObjectForKey:@"Authorization"];
        [logHeader removeObjectForKey:@"APP_KEY"];
//        logMsg = FORMAT(@"%@\n\tHeader: %@", logMsg, [ABParser parseJsonStringFromDictionary:logHeader isIncludeEmpty:YES]);
        if (body && ![[body stringFromData] containString:@"bpmn"]) {
            logMsg = FORMAT(@"%@\n\tBody: %@", logMsg, [body stringFromData]);
        }
        WFMLog(LOG_INFO, @"%@\n", logMsg);
        header = nil;
    }
    return request;
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Public API: Http property -
//----------------------------------------------------------------------------------------------------------------------
+ (void)setEnviornment:(NSString *)enviornment {
    NSMutableDictionary *envDict = [NSMutableDictionary dictionaryWithObject:enviornment forKey:@"env"];
    if (!authentication) {
        authentication = [NSMutableDictionary dictionaryWithDictionary:envDict];
    }
    else {
        [authentication addEntriesFromDictionary:envDict];
    }
}


+ (void)addHttpHeaderField:(NSDictionary *)newHeader {
    if (!header) {
        header = [NSMutableDictionary dictionaryWithDictionary:newHeader];
    }
    else {
        [header addEntriesFromDictionary:newHeader];
    }
}


+ (void)setAuthentication:(NSString *)userName password:(NSString *)password {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss-mm-HH yyyy:MMM:dd ss:mm:HH MM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSString *privateKey = [dateFormatter stringFromDate:[NSDate date]];
    NSString *appKeyValue = FORMAT(@"%0.f", [[dateFormatter dateFromString:privateKey] timeIntervalSince1970] * 1000);
    authentication = [NSMutableDictionary dictionaryWithObject:appKeyValue forKey:@"APP_KEY"];

    NSData *authdata = [self loginAuthorization:[FORMAT(@"%@:%@", userName, password) dataFromString] key:privateKey];
    [authentication setValue:[authdata base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Authorization"];
}


+ (void)setHttpMediaType:(WFMMediaType)mediaType {
    if (!header) {
        header = [NSMutableDictionary dictionaryWithDictionary:authentication];
    }
    NSString *httpMedia = HTTP_MEDIA_APPLICATION_JSON;;
    if (mediaType == HttpXml) {
        httpMedia = HTTP_MEDIA_APPLICATION_XML;
    }
    if (mediaType == HttpText) {
        httpMedia = HTTP_MEDIA_TEXT_PLAIN;
    }
    [header setValue:httpMedia forKey:HTTP_CONTENT_TYPE];
}


+ (void)setRequestTimeOut:(NSTimeInterval)httpTimeout {
    requestTimeout = httpTimeout;
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Sync Resuest - With Block -
//----------------------------------------------------------------------------------------------------------------------
+ (void)sendSyncRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method
        completionBlock:(void (^) (NSData *response, NSError *error))handler {
    NSDate *startTime = [NSDate date];

    NSMutableURLRequest *request = [self creatRequest:url body:body method:method];
    if (!request) {
        return;
    }
    NSHTTPURLResponse *response = NULL;
    NSError *httpError = nil;
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&httpError];

    WFMLog(LOG_INFO, @"Duration: %0.f msec", [[NSDate date] timeIntervalSinceDate:startTime] * 1000);
    if (response.statusCode != RESPONSE_OK) {
        httpError = [self defaultError:response];
        WFMLog(LOG_INFO, @"Response Result: %@", (resultData.length > 0) ? [resultData stringFromData] :
                FORMAT(@"Response Code: %ld %@", (long)httpError.code, httpError.domain));
    }
    else {
        WFMLog(LOG_INFO, @"Response Result: %ld", (long)response.statusCode);
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        handler(resultData, httpError);
    });
}

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Async Resuest - With Block -
//----------------------------------------------------------------------------------------------------------------------

+ (void)sendAsyncRequest:(NSURL *)url completionBlock:(FetchBlock)handler {
    [ABRestInterface sendAsyncRequest:url body:nil method:HttpGet completionBlock:handler];
}


+ (void)sendAsyncRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method completionBlock:(FetchBlock)handler {
    if (!operationQueue) {
        operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.maxConcurrentOperationCount = 3;
    }

    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSDate *startTime = [NSDate date];
        NSMutableURLRequest *request = [self creatRequest:url body:body method:method];
        if (!request) {
            return;
        }

        [NSURLConnection sendAsynchronousRequest:request queue:operationQueue
                               completionHandler:^(NSURLResponse *asynResponse, NSData *data, NSError *httpError) {
                                   WFMLog(LOG_INFO, @"Duration: %0.f msec", [[NSDate date] timeIntervalSinceDate:startTime] * 1000);

                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *) asynResponse;
                                   if (response.statusCode != RESPONSE_OK) {
                                       httpError = [self defaultError:response];
                                       WFMLog(LOG_INFO, @"Response Result: %@", (data.length > 0) ? [data stringFromData] :
                                               FORMAT(@"Response Code: %ld %@", (long)httpError.code, httpError.domain));
                                   }
                                   else {
                                       WFMLog(LOG_INFO, @"Response Result: %ld", (long)response.statusCode);
                                   }

                                   [operationQueue addOperationWithBlock:^{
                                       handler(data, httpError);
                                   }];
                               }];
    }];
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [operationQueue addOperation:operation];
}


#pragma - Sync Rest call To get data -
//----------------------------------------------------------------------------------------------------------------------
+ (NSData *)getSyncResponse:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method error:(NSError **)error {
    NSDate *startTime = [NSDate date];

    NSMutableURLRequest *request = [self creatRequest:url body:body method:method];
    if (!request) {
        return nil;
    }

    NSHTTPURLResponse *response = NULL;
    NSError *httpError = nil;
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&httpError];
    WFMLog(LOG_INFO, @"Duration: %0.f msec", [[NSDate date] timeIntervalSinceDate:startTime] * 1000);
    if (response.statusCode != RESPONSE_OK) {
        *error = [ABRestInterface defaultError:(NSHTTPURLResponse *) response];
        WFMLog(LOG_INFO, @"%@", [resultData stringFromData]);
    }
    else {
        *error = httpError;
    }
    return resultData;
}



#pragma - Sync/Async Rest call with selector and direct return
//----------------------------------------------------------------------------------------------------------------------
+ (void)sendSyncRequest:(id)target selector:(SEL)selector url:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method {
    NSDate *startTime = [NSDate date];

    NSMutableURLRequest *request = [self creatRequest:url body:body method:method];
    if (!request) {
        return;
    }

    NSHTTPURLResponse *response = NULL;
    NSError *error = nil;
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (response.statusCode != RESPONSE_OK) {
        error = [ABRestInterface defaultError:(NSHTTPURLResponse *) response];
        WFMLog(LOG_INFO, @"%@", [resultData stringFromData]);
    }

    WFMLog(LOG_INFO, @"Duration: %0.f msec", [[NSDate date] timeIntervalSinceDate:startTime] * 1000);

    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
    [inv setSelector:selector];
    [inv setTarget:target];
    [inv setArgument:&resultData atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
    [inv setArgument:&error atIndex:3];
    [inv invoke];
}


+ (void)sendAsyncRequest:(id)target selector:(SEL)selector url:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method {
    NSDate *startTime = [NSDate date];
    NSMutableURLRequest *request = [self creatRequest:url body:body method:method];
    if (!request) {
        return;
    }

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *asynResponse, NSData *data, NSError *error) {
                               NSHTTPURLResponse *response = (NSHTTPURLResponse *) asynResponse;
                               if (response.statusCode != RESPONSE_OK) {
                                   error = [ABRestInterface defaultError:response];
                                   WFMLog(LOG_INFO, @"%@", [data stringFromData]);
                               }

                               WFMLog(LOG_INFO, @"Duration: %0.f msec", [[NSDate date] timeIntervalSinceDate:startTime] * 1000);

                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
                                   [inv setSelector:selector];
                                   [inv setTarget:target];
                                   [inv setArgument:(void *) &data atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
                                   [inv setArgument:(void *) &error atIndex:3];
                                   [inv invoke];
                               });
                           }];
}


//----------------------------------------------------------------------------------------------------------------------
#pragma mark - private method -
//----------------------------------------------------------------------------------------------------------------------
+ (NSError *)defaultError:(NSHTTPURLResponse *)response {
    return [NSError errorWithDomain:[NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]
                               code:response.statusCode
                           userInfo:[response allHeaderFields]];
}


+ (NSString *)httpMethod:(WFMMethodType)methodType {
    NSString *httpMethod = HTTP_METHOD_GET;
    if (methodType == HttpGet) {
        httpMethod = HTTP_METHOD_GET;
    }
    if (methodType == HttpPost) {
        httpMethod = HTTP_METHOD_POST;
    }
    if (methodType == HttpPut) {
        httpMethod = HTTP_METHOD_PUT;
    }
    if (methodType == HttpDelete) {
        httpMethod = HTTP_METHOD_DELETE;
    }
    return httpMethod;
}


+ (NSData *)loginAuthorization:(NSData *)data key:(NSString *)key {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    const void *iv = [[@"0123456789abcdef" dataUsingEncoding:NSUTF8StringEncoding] bytes];
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus status = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256,
            iv, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
//----------------------------------------------------------------------------------------------------------------------
