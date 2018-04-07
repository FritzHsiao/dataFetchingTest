//
//  AuthUtility.m
//  HuayuReader
//
//  Created by a2 on 2016/10/19.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "AuthUtility.h"
#import "UICKeyChainStore.h"
#import "CommonUtility.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation AuthUtility

@synthesize UserId = _UserId;
@synthesize UserName = _UserName;
@synthesize UserFamilyName = _UserFamilyName;
@synthesize UserGivenName = _UserGivenName;
@synthesize UserEmail = _UserEmail;
@synthesize UserImageUrl = _UserImageUrl;
@synthesize LoginType = _LoginType;
@synthesize Token = _Token;
@synthesize TokenExpirationDate = _TokenExpirationDate;
@synthesize PushKey = _PushKey;
@synthesize AuthToken = _AuthToken;
@synthesize TokenExp = _TokenExp;

+ (AuthUtility *)sharedUtil {
    static AuthUtility *_sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtil = [[self alloc] init];
    });
    return _sharedUtil;
}

/**
 用戶帳號
 */
- (NSString *)UserId {
    
    if (_UserId && ![_UserId isEqualToString:@""]) return _UserId;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    
    NSLog(@"store: %@", store);
    
    if (store[@"UserId"]) {
        _UserId = store[@"UserId"];
        return _UserId;
    }
    return nil;
}
- (void)setUserId:(NSString *)UserId {
    
    if (!UserId) {
        [UICKeyChainStore removeItemForKey:@"UserId" service:[CommonUtility sharedUtil].keyChainService];
        _UserId = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserId forKey:@"UserId" service:[CommonUtility sharedUtil].keyChainService];
    _UserId = UserId;
}

/**
 用戶名稱
 */
- (NSString *)UserName {
    if (_UserName && ![_UserName isEqualToString:@""]) return _UserName;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"UserName"]) {
        _UserName = store[@"UserName"];
        return _UserName;
    }
    return nil;
}
- (void)setUserName:(NSString *)UserName {
    
    if (!UserName) {
        [UICKeyChainStore removeItemForKey:@"UserName" service:[CommonUtility sharedUtil].keyChainService];
        _UserName = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserName forKey:@"UserName" service:[CommonUtility sharedUtil].keyChainService];
    _UserName = UserName;
}

/**
 用戶FamilyName
 */
- (NSString *)UserFamilyName {
    if (_UserFamilyName && ![_UserFamilyName isEqualToString:@""]) return _UserFamilyName;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"UserFamilyName"]) {
        _UserFamilyName = store[@"UserFamilyName"];
        return _UserFamilyName;
    }
    return nil;
}
- (void)setUserFamilyName:(NSString *)UserFamilyName {
    
    if (!UserFamilyName) {
        [UICKeyChainStore removeItemForKey:@"UserFamilyName" service:[CommonUtility sharedUtil].keyChainService];
        _UserFamilyName = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserFamilyName forKey:@"UserFamilyName" service:[CommonUtility sharedUtil].keyChainService];
    _UserFamilyName = UserFamilyName;
}

/**
 用戶GivenName
 */
- (NSString *)UserGivenName {
    if (_UserGivenName && ![_UserGivenName isEqualToString:@""]) return _UserGivenName;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"UserGivenName"]) {
        _UserGivenName = store[@"UserGivenName"];
        return _UserGivenName;
    }
    return nil;
}
- (void)setUserGivenName:(NSString *)UserGivenName {
    
    if (!UserGivenName) {
        [UICKeyChainStore removeItemForKey:@"UserGivenName" service:[CommonUtility sharedUtil].keyChainService];
        _UserGivenName = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserGivenName forKey:@"UserGivenName" service:[CommonUtility sharedUtil].keyChainService];
    _UserGivenName = UserGivenName;
}

/**
 用戶email
 */
- (NSString *)UserEmail {
    if (_UserEmail && ![_UserEmail isEqualToString:@""]) return _UserEmail;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"UserEmail"]) {
        _UserEmail = store[@"UserEmail"];
        return _UserEmail;
    }
    return nil;
}
- (void)setUserEmail:(NSString *)UserEmail {
    
    if (!UserEmail) {
        [UICKeyChainStore removeItemForKey:@"UserEmail" service:[CommonUtility sharedUtil].keyChainService];
        _UserEmail = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserEmail forKey:@"UserEmail" service:[CommonUtility sharedUtil].keyChainService];
    _UserEmail = UserEmail;
}

/**
 用戶照片url
 */
- (NSString *)UserImageUrl {
    if (_UserImageUrl && ![_UserImageUrl isEqualToString:@""]) return _UserImageUrl;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"UserImageUrl"]) {
        _UserImageUrl = store[@"UserImageUrl"];
        return _UserImageUrl;
    }
    return nil;
}
- (void)setUserImageUrl:(NSString *)UserImageUrl {
    
    if (!UserImageUrl) {
        [UICKeyChainStore removeItemForKey:@"UserImageUrl" service:[CommonUtility sharedUtil].keyChainService];
        _UserImageUrl = nil;
        return;
    }
    
    [UICKeyChainStore setString:UserImageUrl forKey:@"UserImageUrl" service:[CommonUtility sharedUtil].keyChainService];
    _UserImageUrl = UserImageUrl;
}

/**
 登入方式
 */
- (NSString *)LoginType {
    if (_LoginType && ![_LoginType isEqualToString:@""]) return _LoginType;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"LoginType"]) {
        _LoginType = store[@"LoginType"];
        return _LoginType;
    }
    return nil;
}
- (void)setLoginType:(NSString *)LoginType {
    
    if (!LoginType) {
        [UICKeyChainStore removeItemForKey:@"LoginType" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    [UICKeyChainStore setString:LoginType forKey:@"LoginType" service:[CommonUtility sharedUtil].keyChainService];
    _LoginType = LoginType;
}

/**
 登入金鑰
 */
- (NSString *)Token {
    if (_Token && ![_Token isEqualToString:@""]) return _Token;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"Token"]) {
        _Token = store[@"Token"];
        return _Token;
    }
    return nil;
}
- (void)setToken:(NSString *)Token {
    
    if (!Token) {
        [UICKeyChainStore removeItemForKey:@"Token" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    [UICKeyChainStore setString:Token forKey:@"Token" service:[CommonUtility sharedUtil].keyChainService];
    _Token = Token;
}

/**
 登入金鑰效期
 */
- (NSDate *)TokenExpirationDate {
    if (_TokenExpirationDate && _TokenExpirationDate != nil) return _TokenExpirationDate;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    
    if (store[@"TokenExpirationDate"]) {
        _TokenExpirationDate = [dateFormat dateFromString:store[@"TokenExpirationDate"]];
        return _TokenExpirationDate;
    }
    
    return nil;
}
- (void)setTokenExpirationDate:(NSDate *)TokenExpirationDate {
    
    if (!TokenExpirationDate) {
        [UICKeyChainStore removeItemForKey:@"TokenExpirationDate" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [UICKeyChainStore setString:[dateFormat stringFromDate:TokenExpirationDate] forKey:@"TokenExpirationDate" service:[CommonUtility sharedUtil].keyChainService];
    _TokenExpirationDate = TokenExpirationDate;
}

/**
 推播金鑰
 */
- (NSString *)PushKey {
    if (_PushKey && ![_PushKey isEqualToString:@""]) return _PushKey;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"PushKey"]) {
        _PushKey = store[@"PushKey"];
        return _PushKey;
    }
    return nil;
}
- (void)setPushKey:(NSString *)PushKey {
    
    if (!PushKey) {
        [UICKeyChainStore removeItemForKey:@"PushKey" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    [UICKeyChainStore setString:PushKey forKey:@"PushKey" service:[CommonUtility sharedUtil].keyChainService];
    _PushKey = PushKey;
}

/**
 登入金鑰 for (Applicaiton)
 */
- (NSString *)AuthToken {
    if (_AuthToken && ![_AuthToken isEqualToString:@""]) return _AuthToken;
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    if (store[@"AuthToken"]) {
        _AuthToken = store[@"AuthToken"];
        return _AuthToken;
    }
    return nil;
}
- (void)setAuthToken:(NSString *)AuthToken {
    if (!AuthToken) {
        [UICKeyChainStore removeItemForKey:@"AuthToken" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    [UICKeyChainStore setString:AuthToken forKey:@"AuthToken" service:[CommonUtility sharedUtil].keyChainService];
    _AuthToken = AuthToken;
}

/**
 登入金鑰效期 for (Applicaiton)
 */
- (NSDate *)TokenExp {
    if (_TokenExp && _TokenExp != nil) return _TokenExp;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:[CommonUtility sharedUtil].keyChainService];
    
    if (store[@"TokenExp"]) {
        _TokenExp = [dateFormat dateFromString:store[@"TokenExp"]];
        return _TokenExp;
    }
    
    return nil;
}
- (void)setTokenExp:(NSDate *)TokenExp {
    if (!TokenExp) {
        [UICKeyChainStore removeItemForKey:@"TokenExp" service:[CommonUtility sharedUtil].keyChainService];
        return;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [UICKeyChainStore setString:[dateFormat stringFromDate:TokenExp] forKey:@"TokenExp" service:[CommonUtility sharedUtil].keyChainService];
    _TokenExp = TokenExp;
}

/**
 登入檢查
 @return 已登入?
 */
- (BOOL)IsLogin {
    
//    NSLog(@"UserId: %@", self.UserId);
//    NSLog(@"UserEmail: %@", self.UserEmail);
//    NSLog(@"UserEmail: %@", self.UserEmail);
    
    if (!self.UserId || !self.UserEmail || !self.AuthToken) {
        return NO;
    }
    
    // 檢查金鑰效期 (效期是給 Server 用的，非自己用)
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *nowDate = [NSDate date];
    NSDate *d = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",self.TokenExp]];
    
    NSComparisonResult dateCompareResult = [d compare:nowDate];
    
    if (dateCompareResult == NSOrderedAscending) return NO;
    
    return YES;
}


/**
 執行登出
 */
- (void)DoLogout {
    
    self.UserId = nil;
    self.UserName = nil;
    self.UserFamilyName = nil;
    self.UserGivenName = nil;
    self.UserEmail = nil;
    self.UserImageUrl = nil;
    self.LoginType = nil;
    self.Token = nil;
    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
    
}


@end
