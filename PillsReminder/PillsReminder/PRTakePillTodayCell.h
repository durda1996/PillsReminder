//
//  TakePillTodayCell.h
//  PillsReminder
//
//  Created by Dmytro Durda on 28/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRTakePillTodayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pillIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *pillNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pillDoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *takeTimeLabel;

@end
