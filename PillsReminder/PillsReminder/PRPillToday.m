//
//  PRPillToday.m
//  PillsReminder
//
//  Created by Dmytro Durda on 28/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRPillToday.h"

@import UIKit;

@interface PRPillToday ()

@property (nonatomic) NSData *statusImageData;

@end

@implementation PRPillToday

- (void)setTakenPillStatus:(PRPillTodayStatus)takenPillStatus
{
    switch (takenPillStatus)
    {
        case PRPillTodayActive:
            self.statusImageData = UIImagePNGRepresentation([UIImage imageNamed:@"greenCircle"]);
            break;
        case PRPillTodayRemember:
            self.statusImageData = UIImagePNGRepresentation([UIImage imageNamed:@"redCircle"]);
            break;
        case PRPillTodayTaken:
            self.statusImageData = UIImagePNGRepresentation([UIImage imageNamed:@"redCircle"]);
            break;
        default:
            self.statusImageData = UIImagePNGRepresentation([UIImage imageNamed:@"greenCircle"]);
            break;
    }
}

@end
