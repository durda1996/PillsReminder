//
//  PRNotificationCounter.h
//  PillsReminder
//
//  Created by Dmytro Durda on 27/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * kPRNotificationCounterUpdatedNotificationCount = @"kPRNotificationCounterUpdatedNotificationCount";

@interface PRNotificationCounter : NSObject

+ (instancetype)sharedCounter;

- (void)increase;
- (void)decrease;
- (void)clear;
- (int)notificationCount;

@end
