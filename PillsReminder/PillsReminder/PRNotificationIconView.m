//
//  NotificationIconView.m
//  PillsReminder
//
//  Created by Dmytro Durda on 26/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRNotificationIconView.h"
#import "PRNotificationCounter.h"

@interface PRNotificationIconView ()

@property (nonatomic) UIImageView *redCircleImageView;
@property (nonatomic) UIImage *image;
@property (nonatomic) UILabel *label;

@end

@implementation PRNotificationIconView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:kPRNotificationCounterUpdatedNotificationCount object:nil];

        self.bounds = CGRectMake(0, 0, 30, 30);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:@"notification"];
        [self addSubview:imageView];

        self.redCircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2, 18, 18)];
        self.redCircleImageView.image = [UIImage imageNamed:@"redCircle"];
        [imageView addSubview:self.redCircleImageView];

        self.label = [[UILabel alloc] initWithFrame:self.redCircleImageView.bounds];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:10];
        [self.redCircleImageView addSubview:self.label];

        [self update];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)update
{
    int notificationCount = [[PRNotificationCounter sharedCounter] notificationCount];

    if (notificationCount == 0)
    {
        self.redCircleImageView.hidden = YES;
    }
    else if (notificationCount >= 1 && notificationCount <= 99)
    {
        self.redCircleImageView.hidden = NO;
        self.label.text = [NSString stringWithFormat:@"%d", notificationCount];
    }
    if (notificationCount > 99)
    {
        self.redCircleImageView.hidden = NO;
        self.label.text = [NSString stringWithFormat:@"%d", 99];
    }

    [self setNeedsDisplay];
}

@end
