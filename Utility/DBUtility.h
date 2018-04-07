//
//  DBUtility.h
//  CustService
//
//  Created by a2 on 13/8/11.
//  Copyright (c) 2013年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import <FMResultSet.h>
#import <FMDatabaseAdditions.h>

@class FMDatabase;
@interface DBUtility : NSObject
@property (strong, nonatomic) FMDatabase *fmdatabase;
@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;

#pragma mark -
#pragma mark Shared Manager
+ (DBUtility *)sharedUtil;
#pragma mark -
#pragma mark Class Methods
- (int) databaseSchemaVersion;
- (void) setDatabaseSchemaVersion:(int)version;
@end
