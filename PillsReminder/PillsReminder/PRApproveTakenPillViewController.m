//
//  ApproveTakenPillViewController.m
//  PillsReminder
//
//  Created by Dmytro Durda on 29/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRApproveTakenPillViewController.h"

@interface PRApproveTakenPillViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *doseLabel;
@property (weak, nonatomic) IBOutlet UILabel *takenTimeLabel;

@end

@implementation PRApproveTakenPillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameLabel.text = self.name;
    self.takenTimeLabel.text = self.pillTakenTime;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 5.0f;
    self.imageView.image = [UIImage imageWithData:self.imageData];

    if ([self.pillDose floatValue] <= 1)
    {
        self.doseLabel.text = [NSString stringWithFormat:@"%@ pill", self.pillDose];
    }
    else
    {
        self.doseLabel.text = [NSString stringWithFormat:@"%@ pills", self.pillDose];
    }
}

#pragma mark - Button Actions

- (IBAction)back:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)approveTakenPills:(UIButton *)sender
{
    [self.delegate viewController:self didUpdatePillStatus:PRPillTodayTaken forRowAtIndexPath:self.currentIndexPath];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moveTakePillLater:(UIButton *)sender
{
    [self openDatePicker];
}

#pragma mark - DatePicker Methods

- (void)openDatePicker
{
    // will be used 1, 2, 3 and 4 view tags
    if ([self.view viewWithTag:1])
    {
        return;
    }

    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGRect datePickerFrame = CGRectMake(0, screenFrame.size.height - screenFrame.size.height / 3, screenFrame.size.width, screenFrame.size.height / 3);
    CGRect toolBarFrame = CGRectMake(0, screenFrame.size.height - screenFrame.size.height / 3 - 40, screenFrame.size.width, 40);

    UIView *darkBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkBackgroundView.tag = 1;
    darkBackgroundView.alpha = 0;
    darkBackgroundView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker)];
    [darkBackgroundView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkBackgroundView];

    UIView *whiteBackgroundDatePickerView = [[UIView alloc] initWithFrame:datePickerFrame];
    whiteBackgroundDatePickerView.tag = 2;
    whiteBackgroundDatePickerView.alpha = 0;
    whiteBackgroundDatePickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBackgroundDatePickerView];

    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenFrame.size.height + 44, screenFrame.size.width, screenFrame.size.height / 3)];
    datePicker.tag = 3;
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_150"]; //set to english europe locale
    datePicker.date = self.currentTime;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];

    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenFrame.size.height, screenFrame.size.width, 40)];
    toolBar.tag = 4;
    toolBar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(acceptChanges)];
    toolBar.items = [NSArray arrayWithObjects:spacer, doneButton, nil];
    [self.view addSubview:toolBar];

    //Move in date picker animation
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolBarFrame;
    datePicker.frame = datePickerFrame;
    darkBackgroundView.alpha = 0.5;
    whiteBackgroundDatePickerView.alpha = 1;
    [UIView commitAnimations];
}

- (void)dismissDatePicker
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGRect datePickerFrame = CGRectMake(0, screenFrame.size.height + 44, screenFrame.size.width, screenFrame.size.height / 3);
    CGRect toolBarFrame = CGRectMake(0, screenFrame.size.height, screenFrame.size.width, 40);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:1].alpha = 0;
    [self.view viewWithTag:2].alpha = 0;
    [self.view viewWithTag:3].frame = datePickerFrame;
    [self.view viewWithTag:4].frame = toolBarFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews)];
    [UIView commitAnimations];
}

- (void)removeViews
{
    [[self.view viewWithTag:1] removeFromSuperview];
    [[self.view viewWithTag:2] removeFromSuperview];
    [[self.view viewWithTag:3] removeFromSuperview];
    [[self.view viewWithTag:4] removeFromSuperview];
}

- (void)acceptChanges
{
    [self dismissDatePicker];

    [self.delegate viewController:self didUpdateTakeTime:self.pillTakenTime forRowAtIndexPath:self.currentIndexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeDate:(UIDatePicker *)sender
{
    NSDate *changedTime = sender.date;

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"HH:mm";
    self.pillTakenTime = [timeFormatter stringFromDate:changedTime];
}

- (NSDate *)currentTime
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"HH:mm";
    NSDate *date = [timeFormatter dateFromString:self.pillTakenTime];
    return date;
}

@end
