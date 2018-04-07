//
//  ViewController.m
//  dataFetchingTest
//
//  Created by hsiao Wei lung on 2018/4/7.
//  Copyright © 2018年 hsiao Wei lung. All rights reserved.
//

#import "ViewController.h"
#import "NetworkUtility.h"
#import "DBUtility.h"
#import <MBProgressHUD.h>


@interface ViewController ()
{
    MBProgressHUD *hud;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWordsData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWordsData {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"Loading";
    [hud removeFromSuperview];
    
    if ([NetworkUtility sharedUtil].NetworkStatus == AFNetworkReachabilityStatusUnknown) {
        
        [[NetworkUtility sharedUtil] RefreshNetwork];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(initWordsData) userInfo:nil repeats:NO];
        
        [hud hideAnimated:YES];

        
        return;
    }
    
    NSDictionary *headers = @{
                              @"MemberID": @"test@test.com",
                              @"AuthToken": @"AuthToken",
//                              @"Dictionary_Version": @"201802260000",
                              @"Dictionary_Version": @"1",
                              };
    
    [[NetworkUtility sharedUtil] AsyncHttpRequestWithMethod:@"POST" URLString:@"https://reader.foreknowledge.com.tw/fareastdictionary/APPInfo/FareastDictionary/" parameters:nil headers:headers uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error) {
        if ([responseObject[@"result"] isEqualToString:@"-1"]) {
            
            printf("Log in error");
            
            return;
        }
        
        if ([responseObject[@"result"] isEqualToString:@"1"]) {
            
            NSMutableArray *Dictionary_WordLists = responseObject[@"Dictionary_WordLists"];
            NSUInteger intWord = Dictionary_WordLists.count;
            printf("%d", intWord);
            
            for (NSUInteger i = 0; i < intWord; i ++) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[DBUtility sharedUtil].databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
//                        if (responseObject[@"SoundFilename"] == NULL) {
//
//                        };
                        NSDictionary *word = responseObject[@"Dictionary_WordLists"][i];
                        [db executeUpdate:@"create table if not exists Word(word_eng text, word_cht text, WordIndex integer, word_info_simple text, SoundFilename text, word_level integer)"];
                        [db executeUpdateWithFormat:@"INSERT INTO Word (word_eng,word_cht,WordIndex,word_info_simple,SoundFilename,word_level) VALUES (%@,%@,%@,%@,%@,%@) ",
                         word[@"word_eng"],
                         word[@"word_cht"],
                         word[@"WordIndex"],
                         word[@"word_info_simple"],
                         word[@"SoundFilename"],
                         word[@"word_level"]
                         ];
                    }];
                    
                });
                
            };
            
        }
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"Dictionary_WordLists"] forKey:@"Dictionary_WordLists"];
    }];
}


@end
