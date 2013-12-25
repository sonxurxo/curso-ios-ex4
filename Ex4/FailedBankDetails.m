//
//  FailedBankDetails.m
//  Ex4
//
//  Created by Xurxo Méndez Pérez on 25/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "FailedBankDetails.h"

@implementation FailedBankDetails

- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name
                  city:(NSString *)city state:(NSString *)state zip:(int)zip closeDate:(NSDate *)closeDate
           updatedDate:(NSDate *)updatedDate {
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
        self.name = name;
        self.city = city;
        self.state = state;
        self.zip = zip;
        self.closeDate = closeDate;
        self.updatedDate = updatedDate;
    }
    return self;
}

@end
