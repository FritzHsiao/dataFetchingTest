//
//  NetworkUtility.h
//  HuayuReader
//
//  Created by a2 on 2016/10/10.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworkUtility : NSObject
+ (NetworkUtility * _Nonnull) sharedUtil;

- (void) AsyncHttpRequestWithMethod:(NSString * _Nonnull)method
                          URLString:(NSString * _Nonnull)URLString
                         parameters:(NSDictionary * _Nullable)parameters
                            headers:(NSDictionary * _Nullable)headers
                     uploadProgress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgressBlock
                   downloadProgress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgressBlock
                  completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;

- (NSInteger)NetworkStatus;

- (AFNetworkReachabilityStatus)RefreshNetwork;

@end
