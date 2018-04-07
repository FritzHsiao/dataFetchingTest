//
//  DBUtility.m
//  CustService
//
//  Created by a2 on 13/8/11.
//  Copyright (c) 2013年 cht. All rights reserved.
//

#import "DBUtility.h"
#import <sqlite3.h>

@implementation DBUtility
#pragma mark -
#pragma mark Default DBUtil
+ (DBUtility *)sharedUtil {
    static DBUtility *_sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtil = [[self alloc] init];
    });
    return _sharedUtil;
}
#pragma mark -
#pragma mark Memory Management
- (void)dealloc {
    
    // Stop Notifier
    if (_fmdatabase) [_fmdatabase close];
    if (_databaseQueue) [_databaseQueue close];
        
}
#pragma mark -
#pragma mark Class Methods


#pragma mark -
#pragma mark Private Initialization
- (id)init {
    self = [super init];
    if (self) {
        // Initialize Reachability
        NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docsdir stringByAppendingPathComponent:@"FarEast3000.db"];
        
        self.fmdatabase = [FMDatabase databaseWithPath:dbPath];
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        // Start Monitoring
        [self.fmdatabase open];
        
    }
    return self;
}
- (int) databaseSchemaVersion {
    FMResultSet *resultSet = [self.fmdatabase executeQuery:@"PRAGMA user_version"];
    int version = 0;
    if ([resultSet next]) {
        version = [resultSet intForColumnIndex:0];
    }
    return version;
}
- (void) setDatabaseSchemaVersion:(int)version {
    // FMDB cannot execute this query because FMDB tries to use prepared statements
    sqlite3_exec(self.fmdatabase.sqliteHandle, [[NSString stringWithFormat:@"PRAGMA user_version = %d", version] UTF8String], NULL, NULL, NULL);
}
@end
