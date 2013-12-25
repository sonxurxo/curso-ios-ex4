//
//  FailedBankDatabase.h
//  Ex4
//
//  Created by Xurxo Méndez Pérez on 25/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class FailedBankDetails;

@interface FailedBankDatabase : NSObject {
    sqlite3 *_database;
}

+ (FailedBankDatabase*)database;

- (NSArray *)failedBankInfos;

- (FailedBankDetails *)failedBankDetails:(int)uniqueId;

@end