//
//  PRPillToday.h
//  PillsReminder
//
//  Created by Dmytro Durda on 28/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRPill.h"

typedef NS_ENUM(NSInteger, PRPillTodayStatus)
{
    PRPillTodayActive,
    PRPillTodayRemember,
    PRPillTodayTaken
};

@interface PRPillToday : PRPill

@property (nonatomic) NSString *takeTime;
@property (nonatomic) NSNumber *pillDose;
@property (nonatomic, assign) PRPillTodayStatus takenPillStatus;
@property (nonatomic, readonly) NSData *statusImageData;

@end
