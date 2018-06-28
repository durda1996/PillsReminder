//
//  PRPatientIconView.m
//  PillsReminder
//
//  Created by Dmytro Durda on 27/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import "PRPatientIconView.h"
#import "PRPatient.h"

@interface PRPatientIconView ()

@property (nonatomic) PRPatient *patient;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *label;

@end

@implementation PRPatientIconView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, 100, 30);

        UIImage *patientImage = [UIImage imageNamed:@"patientImage"];
        self.patient = [[PRPatient alloc] initWithName:@"Dima" surname:@"Durda" imageData:UIImagePNGRepresentation(patientImage)];

        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];

        self.label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 65, 30)];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.numberOfLines = 0;
        [self addSubview:self.label];

        [self update];
    }
    return self;
}

- (void)update
{
    self.imageView.image = [UIImage imageWithData:self.patient.imageData];
    self.label.text = [NSString stringWithFormat:@"%@", self.patient.name];

    [self setNeedsDisplay];
}

@end
