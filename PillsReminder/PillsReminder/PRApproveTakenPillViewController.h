//
//  ApproveTakenPillViewController.h
//  PillsReminder
//
//  Created by Dmytro Durda on 29/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPillToday.h"

@class PRApproveTakenPillViewController;

@protocol PRApproveTakenPillViewControllerDelegate <NSObject>
- (void)viewController:(PRApproveTakenPillViewController *)viewController didUpdatePillStatus:(PRPillTodayStatus)pillStatus forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)viewController:(PRApproveTakenPillViewController *)viewController didUpdateTakeTime:(NSString *)takeTime forRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface PRApproveTakenPillViewController : UIViewController

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *pillTakenTime;
@property (nonatomic) NSNumber *pillDose;
@property (nonatomic) NSData *imageData;
@property (nonatomic) NSIndexPath *currentIndexPath;

@property (nonatomic, weak) id <PRApproveTakenPillViewControllerDelegate> delegate;
//...........

@end
