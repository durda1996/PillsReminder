//
//  ViewController.m
//  PillsReminder
//
//  Created by Dmytro Durda on 25/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "ViewController.h"
#import "PRNotificationIconView.h"
#import "PRPatientIconView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *notificationBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *patientBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PRNotificationIconView *notificationIconView = [[PRNotificationIconView alloc] init];

    self.notificationBarButtonItem.title = nil;
    self.notificationBarButtonItem.customView = notificationIconView;

    PRPatientIconView *patientIconView = [[PRPatientIconView alloc] init];

    self.patientBarButtonItem.title = nil;
    self.patientBarButtonItem.customView = patientIconView;
}

- (IBAction)notificationReceived:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kAppDelegateReceivedNotification" object:self];
}

@end
