//
//  PRPatient.m
//  PillsReminder
//
//  Created by Dmytro Durda on 27/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRPatient.h"

@implementation PRPatient

- (instancetype)initWithName:(NSString *)name surname:(NSString *)surname imageData:(NSData *)imageData
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.surname = surname;
        self.imageData = imageData;
    }
    return self;
}

@end
