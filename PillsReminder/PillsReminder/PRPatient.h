//
//  PRPatient.h
//  PillsReminder
//
//  Created by Dmytro Durda on 27/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRPatient : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic) NSData *imageData;

- (instancetype)initWithName:(NSString *)name surname:(NSString *)surname imageData:(NSData *)imageData;

@end
