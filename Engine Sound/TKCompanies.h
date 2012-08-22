//
//  TKCompanies.h
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TKCars;

@interface TKCompanies : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSSet *cars;
@end

@interface TKCompanies (CoreDataGeneratedAccessors)

- (void)addCarsObject:(TKCars *)value;
- (void)removeCarsObject:(TKCars *)value;
- (void)addCars:(NSSet *)values;
- (void)removeCars:(NSSet *)values;

@end
