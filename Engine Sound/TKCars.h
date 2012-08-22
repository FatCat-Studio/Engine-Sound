//
//  TKCars.h
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TKCompanies;

@interface TKCars : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * timeToHundred;
@property (nonatomic, retain) NSNumber * gearsNumber;
@property (nonatomic, retain) NSString * pic_inFirst;
@property (nonatomic, retain) NSString * pic_inSecond;
@property (nonatomic, retain) NSString * pic_inThird;
@property (nonatomic, retain) NSString * pic_outFirst;
@property (nonatomic, retain) NSString * pic_outSecond;
@property (nonatomic, retain) NSString * pic_outThird;
@property (nonatomic, retain) NSString * sound_idle;
@property (nonatomic, retain) NSString * sound_start;
@property (nonatomic, retain) NSString * sound_onmid;
@property (nonatomic, retain) NSString * sound_offmid;
@property (nonatomic, retain) NSString * sound_onlow;
@property (nonatomic, retain) NSString * sound_onhight;
@property (nonatomic, retain) NSString * sound_offlow;
@property (nonatomic, retain) NSString * sound_offhight;
@property (nonatomic, retain) TKCompanies *companies;

@end
