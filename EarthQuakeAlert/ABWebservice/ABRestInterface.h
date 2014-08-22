//
//  WFMHttpServices.h
//  PeriodicTable
//
//  Created by Amit Barman on 11/14/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//
//--------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#define RESPONSE_OK         200
#define RESPONSE_NOT_FOUND  404
#define RESPONSE_TIMEOUT    408

//----------------------------------------------------------------------------------------------------------------------
typedef enum {
    HttpGet,
    HttpPost,
    HttpDelete,
    HttpPut,
} WFMMethodType;


typedef enum {
    HttpXml,
    HttpJson,
    HttpText,
} WFMMediaType;

typedef void (^FetchBlock)(NSData *response, NSError *error);

//----------------------------------------------------------------------------------------------------------------------
@interface ABRestInterface : NSObject

#pragma - Publich and Mandatory API
//----------------------------------------------------------------------------------------------------------------------
+ (void)setEnviornment:(NSString *)enviornment;

+ (void)addHttpHeaderField:(NSDictionary *)newHeader;

+ (void)setAuthentication:(NSString *)userName password:(NSString *)password;

+ (void)setHttpMediaType:(WFMMediaType)mediaType;

+ (void)setRequestTimeOut:(NSTimeInterval)httpTimeout;


#pragma - Block sync call
//----------------------------------------------------------------------------------------------------------------------
+ (void)sendSyncRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method
        completionBlock:(void (^) (NSData *response, NSError *error))handler;

#pragma - Block Async call
//----------------------------------------------------------------------------------------------------------------------
+ (void)sendAsyncRequest:(NSURL *)url completionBlock:(FetchBlock)handler;

+ (void)sendAsyncRequest:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method completionBlock:(FetchBlock)handler;

#pragma - Sync Rest call To get data
//----------------------------------------------------------------------------------------------------------------------
+ (NSData *)getSyncResponse:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method error:(NSError **)error;


#pragma - Sync/Async Rest call with selector
//----------------------------------------------------------------------------------------------------------------------
+ (void)sendSyncRequest:(id)target selector:(SEL)selector url:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method;

+ (void)sendAsyncRequest:(id)target selector:(SEL)selector url:(NSURL *)url body:(NSData *)body method:(WFMMethodType)method;

@end
