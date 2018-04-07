//
//  AuthUtility.h
//  HuayuReader
//
//  Created by a2 on 2016/10/19.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthUtility : NSObject

+ (AuthUtility * _Nonnull) sharedUtil;

/**
 用戶帳號
 */
@property(strong,nonatomic) NSString * _Nullable UserId;
/**
 用戶名稱
 */
@property(strong,nonatomic) NSString * _Nullable UserName;
/**
 用戶FamilyName
 */
@property(strong,nonatomic) NSString * _Nullable UserFamilyName;
/**
 用戶GivenName
 */
@property(strong,nonatomic) NSString * _Nullable UserGivenName;
/**
 用戶email
 */
@property(strong,nonatomic) NSString * _Nullable UserEmail;
/**
 用戶照片url
 */
@property(strong,nonatomic) NSString * _Nullable UserImageUrl;
/**
 登入方式
 */
@property(strong,nonatomic) NSString * _Nullable LoginType;
/**
 登入金鑰 for (Google/Facebook)
 */
@property(strong,nonatomic) NSString * _Nullable Token;
/**
 登入金鑰效期
 */
@property(strong,nonatomic) NSDate * _Nullable TokenExpirationDate;
/**
 推播金鑰
 */
@property(strong,nonatomic) NSString * _Nullable PushKey;
/**
 登入金鑰 for (Applicaiton)
 */
@property(strong,nonatomic) NSString * _Nullable AuthToken;
/**
 登入金鑰效期 for (Applicaiton)
 */
@property(strong,nonatomic) NSDate * _Nullable TokenExp;


/**
 登入檢查
 @return 已登入?
 */
- (BOOL)IsLogin;

/**
 執行登出
 */
- (void)DoLogout;

@end
