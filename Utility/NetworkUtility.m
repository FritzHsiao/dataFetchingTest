//
//  NetworkUtility.m
//  HuayuReader
//
//  Created by a2 on 2016/10/10.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "NetworkUtility.h"

@implementation NetworkUtility {
    int intTimeInterval;
}

+ (NetworkUtility *)sharedUtil {
    static NetworkUtility *_sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtil = [[self alloc] init];
        [_sharedUtil SetRequestTimeInterval:60];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return _sharedUtil;
}

-(void) SetRequestTimeInterval:(int)interval
{
    intTimeInterval = interval;
}

- (void) AsyncHttpRequestWithMethod:(NSString * _Nonnull)method
                          URLString:(NSString * _Nonnull)URLString
                         parameters:(NSDictionary * _Nullable)parameters
                            headers:(NSDictionary * _Nullable)headers
                     uploadProgress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgressBlock
                   downloadProgress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgressBlock
                  completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    
    if (self.NetworkStatus <1) {
        [self RefreshNetwork];
        completionHandler(nil, @{@"result": @"-1", @"msg": @"Please check your network status."}, nil);
    }
    
    // AFURLSessionManager iOS 7 以上支援
    // AFHTTPSessionManager iOS 6 以下支援
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // 允許不合法憑證的連線
//    manager.securityPolicy.allowInvalidCertificates = YES;
    
    // 建立 NSMutableURLRequest
    NSMutableURLRequest *req = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:URLString parameters:parameters error:nil];
    
    // Request Timeout 設定
    req.timeoutInterval = intTimeInterval;
    
    if (headers && headers.count > 0) {
        NSArray *keys = headers.allKeys;
        for (int i = 0; i < headers.count; i ++) {
            [req addValue:headers[keys[i]] forHTTPHeaderField:keys[i]];
        }
    }
    
    [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) uploadProgressBlock(uploadProgress);
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) downloadProgressBlock(downloadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSLog(@"completionHandler......");
        
        completionHandler(response, responseObject, error);
    }] resume];
    
}

- (NSInteger)NetworkStatus {
    
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
}

- (AFNetworkReachabilityStatus)RefreshNetwork {
    
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus __block s;
    
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        s = status;
    }];
    
    return s;
}

@end
