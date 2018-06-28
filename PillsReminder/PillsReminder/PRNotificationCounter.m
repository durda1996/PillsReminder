//
//  PRNotificationCounter.m
//  PillsReminder
//
//  Created by Dmytro Durda on 27/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRNotificationCounter.h"

@interface PRNotificationCounter ()

@property (nonatomic) int counter;
@property (nonatomic) NSUserDefaults *standartUserDefaults;

@end

static NSString * kPRNotificationCounter = @"kPRNotificationCounter";

@implementation PRNotificationCounter

+ (instancetype)sharedCounter
{
    static PRNotificationCounter *sharedCounter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedCounter = [[self alloc] init];
    });
    return sharedCounter;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.standartUserDefaults = [NSUserDefaults standardUserDefaults];
        if ([self.standartUserDefaults objectForKey:kPRNotificationCounter] != nil)
        {
            self.counter = (int)[self.standartUserDefaults integerForKey:kPRNotificationCounter];
        }
        else
        {
            self.counter = 0;
        }
        [self.standartUserDefaults setInteger:self.counter forKey:kPRNotificationCounter];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification) name:@"kAppDelegateReceivedNotification" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)increase
{
    [self.standartUserDefaults setInteger:++self.counter forKey:kPRNotificationCounter];
}

- (void)decrease
{
    if ([self.standartUserDefaults objectForKey:kPRNotificationCounter] > 0)
    {
        [self.standartUserDefaults setInteger:--self.counter forKey:kPRNotificationCounter];
    }
}

- (void)clear
{
    [self.standartUserDefaults removeObjectForKey:kPRNotificationCounter];
}

- (int)notificationCount
{
    return (int)[self.standartUserDefaults integerForKey:kPRNotificationCounter];
}

- (void)receivedNotification
{
    [self increase];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPRNotificationCounterUpdatedNotificationCount object:self];
}

@end
