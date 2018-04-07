//
//  CommonUtility.h
//  CustService
//
//  Created by a2 on 13/9/2.
//  Copyright (c) 2013年 foreknowledge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MY_APP_NAME @"FarEast3000"

typedef enum {
    PushTypeGroupContract,
    PushTypeGroupMessage,
    PushTypeGroupActive
} PushTypeGroup;

@interface CommonUtility : NSObject

+ (CommonUtility *)sharedUtil;

/* 系統參數 */
@property (readonly, strong, nonatomic) NSString * AppName;
@property (readonly,strong,nonatomic) NSString * keyChainService;
@property (strong,nonatomic) NSString *strLoginServer;
@property (strong,nonatomic) NSString *strServerUrl;
@property (nonatomic) BOOL isTesting;

/* APP預設字 超大 & 大 & 中 & 小 */
@property (nonatomic) float floatFontSizeSystem;
@property (nonatomic) float floatFontSizeXXXLarge;
@property (nonatomic) float floatFontSizeXXLarge;
@property (nonatomic) float floatFontSizeXLarge;
@property (nonatomic) float floatFontSizeLarge;
@property (nonatomic) float floatFontSizeMedium;
@property (nonatomic) float floatFontSizeSmall;

/* 系統配色 */
@property (strong,nonatomic) UIColor *systemNavigationBarBackgroundColor;
@property (strong,nonatomic) UIColor *systemBackgroundColor;
@property (strong,nonatomic) UIColor *dashboardBackgroundColor;

/* 系統UI Table 配置 */
@property (nonatomic) float floatTableSectionHeight;
@property (nonatomic) float floatTableSectionFontSize;

/* 系統UI PieChart配色 */
@property (strong,nonatomic) UIColor *pieChartBackGround;
@property (strong,nonatomic) NSArray *sliceColorSafe;
@property (strong,nonatomic) NSArray *sliceColorSeventy;
@property (strong,nonatomic) NSArray *sliceColorHundred;

/* 預設高度 */
@property (nonatomic) float intMainViewY;
@property (nonatomic) float intMainViewHeight;

/** 
 訊息顯示時間 
 */
@property (nonatomic) float floatMsgShowTime;

/* 推播類型 */
@property (readonly, nonatomic, strong) NSDictionary *dicPushType;

/**
 是否不再顯示 Demo 畫面
 */
@property (nonatomic) BOOL IsConfirmDemo;

- (void)DashLineView:(UIView *)view color:(UIColor *)color linewidth:(float)linewidth daswidth:(float)daswidth;

/**
 * @brief 取得裝置版本號
 * @return NSString 裝置版本號
 **/
- (NSString*) deviceName;

/* textView高度計算 */
- (CGSize) getFixedHeight:(NSString *)labelText labelFontSize:(NSInteger)labelFontSize;
- (CGSize) getFixedHeight:(NSString *)labelText labelFontSize:(NSInteger)labelFontSize labelWidth:(NSInteger)labelWidth;

/**
 * @brief 依系統字體調整 UILabel 字體大小
 * @param label description
 */
- (void) resizeTableCellTextLabelFontSize:(UILabel *)label;
/**
 * @brief 依系統字體調整 UILabel 字體大小
 * @param label description
 */
- (void) resizeTableCellDetailTextLabelFontSize:(UILabel *)label;

/**
 * @brief 依欄寬、字數取得最大Font Size
 * @param word description
 * @param rect description
 * @return float 最大Font Size
 */
- (float) getFitSizeFontWithWords:(NSString *)word rect:(CGRect)rect;

/**
 * @brief 個資隱碼規則
 * @param strDeviceNo description
 * @return NSString 隱碼門號
 */
- (NSString *)getRegexDeviceNumber:(NSString *)strDeviceNo;

/**
 * @brief 檢查email合法性
 * @param strEmail description
 * @return BOOL 是否合法
 */
- (BOOL) validateEmail:(NSString *)strEmail;

/**
 * @brief 檢查手機門號合法性
 * @param strMobileNumber description
 * @return BOOL 是否合法
 */
- (BOOL) validateMobileNumber:(NSString *)strMobileNumber;

/**
 * @brief 設定檔案屬性 iCloud 不備份
 */
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;


/**
 * @brief 取得 金額文字 (100,000)
 * @param num description
 * @return NSString 金額文字
 */
-(NSString *)getMoneyFormatString:(NSNumber *)num;

/* 取得 基本 分隔線 */
- (UIView *) getBasicSeparateLine:(CGRect)frame;

/* 取得 灰色漸層 分隔線 */
- (UIView *) getGrayGradientSeparateLine:(CGRect)frame;

/* 取得 藍色 分隔線 */
- (UIView *) getBlueSeparateLine:(CGRect)frame;

/**
 * @brief 取得中文 日期(星期) ex. 2015/01/01(一)
 * @param strDate description
 */
- (NSString *)getChineseDateAndWeek:(NSString*)strDate;

/**
 * @brief Debug Log
 * @param str description
 */
- (void)printDebugLog:(NSString *)str, ...;

/**
 檢查local圖片檔案是否存在 ?
 */
- (BOOL)isLocalImageWithName:(NSString *)name;

/**
 儲存圖片檔案
 */
- (void)saveImage:(UIImage *)image withName:(NSString *)name;

/**
 取得local圖片檔案
 */
- (UIImage *)loadImage:(NSString *)name;

/**
 * @brief 取得 float 轉字串並去尾巴的 0
 * @param strInput description
 * @return NSString float 轉字串並去尾巴的 0
 */
- (NSString *) floatStringWithNoZero:(NSString *)strInput;


@end
