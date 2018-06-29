//
//  PRPill.h
//  PillsReminder
//
//  Created by Dmytro Durda on 28/06/2018.
//  Copyright © 2018 Cogniance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRPill : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSData *imageData;

@end
