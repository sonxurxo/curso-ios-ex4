//
//  FailedBankDatabase.m
//  Ex4
//
//  Created by Xurxo Méndez Pérez on 25/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "FailedBankDatabase.h"

#import "FailedBankInfo.h"
#import "FailedBankDetails.h"

@implementation FailedBankDatabase

static FailedBankDatabase *_database;

+ (FailedBankDatabase*)database {
    if (_database == nil) {
        _database = [[FailedBankDatabase alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"banklist"
                                                             ofType:@"sqlite3"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (NSArray *)failedBankInfos {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT id, name, city, state FROM failed_banks ORDER BY close_date DESC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *cityChars = (char *) sqlite3_column_text(statement, 2);
            char *stateChars = (char *) sqlite3_column_text(statement, 3);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *city = [[NSString alloc] initWithUTF8String:cityChars];
            NSString *state = [[NSString alloc] initWithUTF8String:stateChars];
            FailedBankInfo *info = [[FailedBankInfo alloc]
                                    initWithUniqueId:uniqueId name:name city:city state:state];
            [retval addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (FailedBankDetails *)failedBankDetails:(int)uniqueId {
    FailedBankDetails *retval = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT id, name, city, state, zip, close_date, updated_date FROM failed_banks WHERE id=%d", uniqueId];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
       == SQLITE_OK) {
       while (sqlite3_step(statement) == SQLITE_ROW) {
           int uniqueId = sqlite3_column_int(statement, 0);
           char *nameChars = (char *) sqlite3_column_text(statement, 1);
           char *cityChars = (char *) sqlite3_column_text(statement, 2);
           char *stateChars = (char *) sqlite3_column_text(statement, 3);
           int zip = sqlite3_column_int(statement, 4);
           char *closeDateChars = (char *) sqlite3_column_text(statement, 5);
           char *updatedDateChars = (char *) sqlite3_column_text(statement, 6);
           NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
           NSString *city = [[NSString alloc] initWithUTF8String:cityChars];
           NSString *state = [[NSString alloc] initWithUTF8String:stateChars];
           NSString *closeDateString =
           [[NSString alloc] initWithUTF8String:closeDateChars];
           NSString *updatedDateString =
           [[NSString alloc] initWithUTF8String:updatedDateChars];
           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
           [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
           NSDate *closeDate = [formatter dateFromString:closeDateString];
           NSDate *updateDate = [formatter dateFromString:updatedDateString];
           
           retval = [[FailedBankDetails alloc] initWithUniqueId:uniqueId name:name
                                                            city:city state:state zip:zip closeDate:closeDate 
                                                     updatedDate:updateDate];
           
           break;
       }
       sqlite3_finalize(statement);
    }
    return retval;
    
}

@end
