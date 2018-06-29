//
//  ViewController.m
//  PillsReminder
//
//  Created by Dmytro Durda on 25/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRTodayViewController.h"
#import "PRNotificationIconView.h"
#import "PRPatientIconView.h"
#import "PRTakePillTodayCell.h"
#import "PRPillToday.h"

@interface PRTodayViewController () <UITableViewDelegate, UITableViewDataSource, UIApplicationDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *notificationBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *patientBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (nonatomic) NSArray<PRPillToday *> *pillDataArray;

@end

@implementation PRTodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set navigation bar title color
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    PRNotificationIconView *notificationIconView = [[PRNotificationIconView alloc] init];

    self.notificationBarButtonItem.title = nil;
    self.notificationBarButtonItem.customView = notificationIconView;

    PRPatientIconView *patientIconView = [[PRPatientIconView alloc] init];

    self.patientBarButtonItem.title = nil;
    self.patientBarButtonItem.customView = patientIconView;

    // ***** simulating of server responce
    //     ||
    //     ||
    //     ||
    //    \  /
    //     \/
    PRPillToday *pill = [[PRPillToday alloc] init];
    pill.name = @"Ibuprom";
//    pill.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"pill"]);
    pill.pillDose = [NSNumber numberWithFloat:0.5];
    pill.takenPillStatus = PRPillTodayTaken;
    pill.takeTime = @"12:00";

    PRPillToday *pill2 = [[PRPillToday alloc] init];
    pill2.name = @"Misam";
    pill2.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"pill"]);
    pill2.pillDose = [NSNumber numberWithInt:1];
    pill2.takenPillStatus = PRPillTodayActive;
    pill2.takeTime = @"14:30";

    self.pillDataArray = @[pill, pill2];
    // ***** finish simulating of server responce

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PRTakePillTodayCell" bundle:nil] forCellReuseIdentifier:@"takePillTadayCell"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pillDataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PRTakePillTodayCell *cell = (PRTakePillTodayCell *)[tableView dequeueReusableCellWithIdentifier:@"takePillTadayCell"];
    PRPillToday *pill = self.pillDataArray[indexPath.row];

    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PRTakePillTodayCell" owner:self options:nil][0];
    }

    cell.pillIconImageView.layer.cornerRadius = cell.pillIconImageView.frame.size.height / 2;
    cell.pillIconImageView.layer.masksToBounds = YES;
    cell.pillIconImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.pillIconImageView.layer.borderWidth = 3.0f;
    cell.pillIconImageView.image = [UIImage imageWithData:pill.imageData] ?: [UIImage imageNamed:@"question"];
    cell.statusIconImageView.layer.cornerRadius = cell.statusIconImageView.frame.size.height / 2;
    cell.statusIconImageView.layer.masksToBounds = YES;
    cell.statusIconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.statusIconImageView.layer.borderWidth = 3.0f;
    cell.statusIconImageView.image = [UIImage imageWithData:pill.statusImageData] ?: [UIImage imageNamed:@"greenCircle"];
    cell.pillNameLabel.text = pill.name ?: @"name";
    cell.takeTimeLabel.text = pill.takeTime ?: @"00:00";
    NSNumber *pillDose = pill.pillDose ?: @0;

    if ([pillDose floatValue] <= 1)
    {
        cell.pillDoseLabel.text = [NSString stringWithFormat:@"%@ pill", pillDose];
    }
    else
    {
        cell.pillDoseLabel.text = [NSString stringWithFormat:@"%@ pills", pillDose];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PRTakePillTodayCell *cell = (PRTakePillTodayCell *)[tableView dequeueReusableCellWithIdentifier:@"takePillTadayCell"];
    return cell.frame.size.height;
}

#pragma mark - UIApplicationDelegate

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
    // reload data after midnight;
}

@end
