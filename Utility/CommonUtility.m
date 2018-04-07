//
//  CommonUtility.m
//  CustService
//
//  Created by a2 on 13/9/2.
//  Copyright (c) 2013年 foreknowledge. All rights reserved.
//

#import "CommonUtility.h"
#import <sys/utsname.h>
#import "DBUtility.h"

@implementation CommonUtility

/* 系統參數 */
@synthesize keyChainService = _keyChainService;
@synthesize strLoginServer;
@synthesize strServerUrl;

@synthesize IsConfirmDemo = _IsConfirmDemo;

/* Frame預設高度 */
@synthesize intMainViewHeight;

/**
 訊息顯示時間
 */
@synthesize floatMsgShowTime;

+ (CommonUtility *)sharedUtil {
    static CommonUtility *_sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtil = [[self alloc] init];
    });
    return _sharedUtil;
}

-(NSString *)keyChainService {
    return @"tw.com.foreknowledge.fareastengA";
}

- (id)init {
    if (self = [super init]) {
        
        /* 是否倒入測試資料 */
        _isTesting = NO;
        
        _dicPushType = @{};
        
        /* 系統參數 */
        _AppName = @"Hanzi3000";
 //       strLoginServer = @"https://reader.foreknowledge.com.tw/Hanzi3000";
 //       strServerUrl = @"https://reader.foreknowledge.com.tw/Hanzi3000";
        strLoginServer = @"https://dic.fareast.com.tw/hanzi3000/";
        strServerUrl = @"https://dic.fareast.com.tw/hanzi3000/";
        
        /* 系統配色 */
        _systemNavigationBarBackgroundColor = [UIColor colorWithRed:250.0/255.0 green:192.0/255.0 blue:0.0/255.0 alpha:1.0];
        _systemBackgroundColor = [UIColor colorWithRed:79./255. green:0. blue:90./255 alpha:1];
        _dashboardBackgroundColor = [UIColor colorWithRed:0.0/255. green:153/255.0 blue:218/255.0 alpha:1.];
        
        /* APP預設字 超大 & 大 & 中 & 小 */
        CGFloat size = 16.;
        _floatFontSizeXXXLarge = size*1.4;
        _floatFontSizeXXLarge = size*1.3;
        _floatFontSizeXLarge = size*1.2;
        _floatFontSizeLarge = size;
        _floatFontSizeMedium = size*.9;
        _floatFontSizeSmall = size*.7;
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        [self resizeTableCellTextLabelFontSize:cell.textLabel];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
            _floatFontSizeSystem = 14;
        else
            _floatFontSizeSystem = cell.textLabel.font.pointSize;
        
        /* 系統UI Table */
        _floatTableSectionHeight = 25.0;
        _floatTableSectionFontSize = 16.0;
        
        /* 系統UI PieChart配色 */
        _pieChartBackGround = [UIColor colorWithWhite:0.95 alpha:1];
        _sliceColorSafe = @[[UIColor colorWithRed:9.0/255.0 green:129.0/255.0 blue:198.0/255.0 alpha:0.5],[UIColor clearColor]];
        _sliceColorSeventy = @[[UIColor colorWithRed:222.0/255.0 green:138.0/255.0 blue:46.0/255.0 alpha:0.5],[UIColor clearColor]];
        _sliceColorHundred = @[[[UIColor redColor] colorWithAlphaComponent:0.5],[UIColor clearColor]];
        
        /* 功能用語 */
        floatMsgShowTime = 1.0f;

    }
    return self;
}

/**
 是否不再顯示 Demo 畫面
 */
- (BOOL) IsConfirmDemo {
    FMResultSet *rs = [[[DBUtility sharedUtil] fmdatabase] executeQuery:@"Select cvalue FROM Config WHERE ckey='ConfirmDemo'"];
    while ([rs next]) {
        
        if ([[rs stringForColumn:@"cvalue"] isEqualToString:@"1"]) {
            return YES;
        }
        return NO;
    }
    return NO;
}

- (void) setIsConfirmDemo:(BOOL)IsConfirmDemo {
    NSString *demo = [NSString stringWithFormat:@"REPLACE INTO Config (ckey,cvalue,isenable) VALUES ('ConfirmDemo','%@',1)", IsConfirmDemo ? @"1":@"0"];
    [[[DBUtility sharedUtil] fmdatabase] executeUpdate:demo];
    
    _IsConfirmDemo = IsConfirmDemo;
}

- (void)DashLineView:(UIView *)view color:(UIColor *)color linewidth:(float)linewidth daswidth:(float)daswidth {
    
    // Important, otherwise we will be adding multiple sub layers
    if ([[[view layer] sublayers] objectAtIndex:0])
    {
        view.layer.sublayers = nil;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setLineWidth:linewidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:
      [NSNumber numberWithInt:daswidth],
      [NSNumber numberWithInt:daswidth],
      nil
      ]
     ];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, -view.frame.origin.y+linewidth/2);
    CGPathAddLineToPoint(path, NULL, view.frame.size.width, -view.frame.origin.y+linewidth/2);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[view layer] addSublayer:shapeLayer];
}

/**
 * @brief 取得裝置版本號
 * @return NSString 裝置版本號
 **/
- (NSString*) deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    NSString* deviceName = [self platformString:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName=code;
        }
    }
    
    return deviceName;
}

- (NSString *) platformString:(NSString *)platform {
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}

/**
 * @brief 依系統字體調整 UILabel 字體大小
 * @param label desctiption
 */
- (void) resizeTableCellTextLabelFontSize:(UILabel *)label
{
    NSString *strFontName = label.font.fontName;
    
    if (label.font.pointSize >= _floatFontSizeXXLarge) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeXXLarge];
    } else if (label.font.pointSize >= _floatFontSizeXLarge) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeXLarge];
    } else if (label.font.pointSize >= _floatFontSizeLarge) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeLarge];
    } else if (label.font.pointSize >= _floatFontSizeMedium) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeMedium];
    } else if (label.font.pointSize >= _floatFontSizeSmall) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeSmall];
    }
}
/**
 * @brief 依系統字體調整 UILabel 字體大小
 * @param label desctiption
 */
- (void) resizeTableCellDetailTextLabelFontSize:(UILabel *)label
{
    NSString *strFontName = label.font.fontName;
    
    if (label.font.pointSize >= _floatFontSizeMedium) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeMedium];
    } else if (label.font.pointSize >= _floatFontSizeSmall) {
        label.font = [UIFont fontWithName:strFontName size:_floatFontSizeSmall];
    }
}

/**
 * @brief 取得內容高度
 * @param labelText description
 * @param labelFontSize description
 * @return CGSize 適合文字的Label寬、高
 */
- (CGSize) getFixedHeight:(NSString *)labelText labelFontSize:(NSInteger)labelFontSize
{
    CGSize size = CGSizeMake(240,2000);
    
    CGRect textRect = [labelText boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labelFontSize]}
                                              context:nil];
    
    return textRect.size;
}

/**
 * @brief 依欄寬取得內容高度
 * @param labelText description
 * @param labelFontSize description
 * @param labelWidth description
 * @return CGSize 適合文字的Label寬、高
 */
- (CGSize) getFixedHeight:(NSString *)labelText labelFontSize:(NSInteger)labelFontSize labelWidth:(NSInteger)labelWidth
{
    CGSize size = CGSizeMake(labelWidth,2000);
    
    CGRect textRect = [labelText boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labelFontSize]}
                                              context:nil];
    
    return textRect.size;
}

/**
 * @brief 依欄寬、字數取得最大Font Size
 * @param word description
 * @param rect description
 * @return float 最大Font Size
 */
- (float) getFitSizeFontWithWords:(NSString *)word rect:(CGRect)rect
{
    UIFont *fBase = [UIFont systemFontOfSize:8.];
//    CGSize size = [word sizeWithFont:fBase];
    CGSize size = [word sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8.]}];
    
    float pointsPerPixel =  fBase.pointSize / size.width;
    return rect.size.width * pointsPerPixel;
}

/**
 * @brief 行動電話個資隱碼規則
 * @param strDeviceNo description
 * @return NSString 隱碼的行動電話
 */
- (NSString *)getRegexDeviceNumber:(NSString *)strDeviceNo
{
    NSInteger intShowCount = strDeviceNo.length - 6;
    NSString *strPattern = [NSString stringWithFormat:@"(?i)(\\b\\w{%zd})\\w(?i)(\\w)\\w(?i)(\\w)\\w(?i)(\\w)", intShowCount];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:strPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *strReg = [regex stringByReplacingMatchesInString:strDeviceNo options:0 range:NSMakeRange(0, strDeviceNo.length) withTemplate:@"$1*$2*$3*$4"];
    return strReg;
}

/**
 * @brief 檢查email合法性
 * @param strEmail description
 * @return BOOL 是否合法
 */
- (BOOL) validateEmail:(NSString *)strEmail
{
    NSString *strRegex = @"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    return [emailTest evaluateWithObject:strEmail];
}

/**
 * @brief 檢查手機門號合法性
 * @param strMobileNumber description
 * @return BOOL 是否合法
 */
- (BOOL) validateMobileNumber:(NSString *)strMobileNumber
{
    NSString *strRegex = @"09[0-9]{8}";
    NSPredicate *mobileNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    return [mobileNumberTest evaluateWithObject:strMobileNumber];
}

/**
 * @brief 設定檔案屬性 iCloud 不備份
 */
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        
        [self printDebugLog:@"Error excluding %@ from backup %@", [URL lastPathComponent], error];
        
    }
    return success;
}

/**
 * @brief 取得當前時間文字
 * @return NSString 當前時間文字
 */
- (NSString *) getNowTimeString
{
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:dateNow];
}

/**
 * @brief 取得 金額文字 (100,000)
 * @param num description
 * @return NSString 金額文字
 */
-(NSString *)getMoneyFormatString:(NSNumber *)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.maximumIntegerDigits = 3;
//    formatter.minimumFractionDigits = 3;
//    formatter.maximumFractionDigits = 8;
    formatter.usesSignificantDigits = NO;
    formatter.usesGroupingSeparator = YES;
    formatter.groupingSeparator = @",";
    formatter.decimalSeparator = @".";
    return [formatter stringFromNumber:num];
}

/**
 * @brief 取得 基本 分隔線
 * @param frame description
 * @return UIView 分隔線
 */
- (UIView *) getBasicSeparateLine:(CGRect)frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

/**
 * @brief 取得 灰色漸層 分隔線
 * @param frame description
 * @return UIView 灰色漸層 分隔線
 */
- (UIView *) getGrayGradientSeparateLine:(CGRect)frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    /* 漸層光線 */
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor grayColor] CGColor],
                       (id)[[[UIColor grayColor] colorWithAlphaComponent:0.] CGColor],
                       nil
                       ]; // 由上到下的漸層顏色
    [view.layer insertSublayer:gradient atIndex:0];
    return view;
}

/**
 * @brief 取得 藍色 分隔線
 * @param frame description
 * @return UIView 藍色 分隔線
 */
- (UIView *) getBlueSeparateLine:(CGRect)frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

/**
 * @brief 取得中文 日期(星期) ex. 2015/01/01(一)
 * @param strDate description
 */
- (NSString *)getChineseDateAndWeek:(NSString*)strDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormat dateFromString:strDate];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calender components:NSCalendarUnitWeekday fromDate:date];
    NSUInteger intWeekDay = [comps weekday];
    
    switch (intWeekDay) {
        case 1:
            return [NSString stringWithFormat:@"%@ (日)",strDate];
        case 2:
            return [NSString stringWithFormat:@"%@ (一)",strDate];
        case 3:
            return [NSString stringWithFormat:@"%@ (二)",strDate];
        case 4:
            return [NSString stringWithFormat:@"%@ (三)",strDate];
        case 5:
            return [NSString stringWithFormat:@"%@ (四)",strDate];
        case 6:
            return [NSString stringWithFormat:@"%@ (五)",strDate];
        case 7:
            return [NSString stringWithFormat:@"%@ (六)",strDate];
        default:
            return strDate;
    }
}

/**
 * @brief Debug Log
 * @param str description
 */
- (void)printDebugLog:(NSString *)str, ...
{
    if ([[self deviceName] rangeOfString:@"Simulator"].location != NSNotFound ||
        [[self deviceName] rangeOfString:@"x86"].location != NSNotFound) {
        va_list args;
        va_start(args, str);
        NSLogv(str, args);
        va_end(args);
    }
}

- (BOOL)isLocalImageWithName:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    /* 存放檔案目錄：assets */
    NSString *strFilePath = [documentsDirectory stringByAppendingPathComponent:@"/assets"];
    
    /* 若不存在目錄，則新增該目錄 */
    if (![[NSFileManager defaultManager] fileExistsAtPath:strFilePath])
    {
        /* 新增目錄 */
        [[NSFileManager defaultManager] createDirectoryAtPath:strFilePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *fullPath = [strFilePath stringByAppendingPathComponent:name];
    return [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *strFilePath = [documentsDirectory stringByAppendingPathComponent:@"/assets"];
    NSString *fullPath = [strFilePath stringByAppendingPathComponent:name];
    
    NSData *data = UIImagePNGRepresentation(image);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
    
}

- (UIImage *)loadImage:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *strFilePath = [documentsDirectory stringByAppendingPathComponent:@"/assets"];
    NSString *fullPath = [strFilePath stringByAppendingPathComponent:name];
    UIImage *img = [UIImage imageWithContentsOfFile:fullPath];
    
    return img;
}

/**
 * @brief 取得 float 轉字串並去尾巴的 0
 * @param strInput description
 * @return NSString float 轉字串並去尾巴的 0
 */
- (NSString *) floatStringWithNoZero:(NSString *)strInput
{
    const char *floatChars = [strInput UTF8String];
    NSInteger length = strInput.length;
    NSInteger i = length -1;
    for (; i >= 0; i --) {
        if (floatChars[i] != '0') {
            break;
        } else {
            if (floatChars[i] == '.') {
                i --;
                break;
            }
        }
    }
    if (i == -1) return @"0";
    if (floatChars[i] == '.') return [strInput substringToIndex:i];
    return [strInput substringToIndex:i+1];
}

@end
