//
//  TKCars.h
//  Engine Sound
//
//  Created by Timofey Korchagin on 29/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TKCompanies;

@interface TKCars : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSNumber * gearsNumber;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * pic1;
@property (nonatomic, retain) NSString * pic2;
@property (nonatomic, retain) NSString * pic3;
@property (nonatomic, retain) NSString * pic4;
@property (nonatomic, retain) NSString * pic5;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * sound_idle;
@property (nonatomic, retain) NSString * sound_offhight;
@property (nonatomic, retain) NSString * sound_offlow;
@property (nonatomic, retain) NSString * sound_offmid;
@property (nonatomic, retain) NSString * sound_onhight;
@property (nonatomic, retain) NSString * sound_onlow;
@property (nonatomic, retain) NSString * sound_onmid;
@property (nonatomic, retain) NSString * sound_start;
@property (nonatomic, retain) NSNumber * timeToHundred;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * soundTrack;
@property (nonatomic, retain) NSString * topSpeed;
@property (nonatomic, retain) TKCompanies *companies;

@end
