//
//  TKCompanies+Customization.m
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKCompanies+Customization.h"
#import "TKCars.h"

@implementation TKCompanies (Customization)
- (NSArray *)sortedCars{
    return [self.cars.allObjects sortedArrayUsingComparator:
            ^NSComparisonResult(id obj1, id obj2) {
                return [[(TKCars *) obj1 model] compare:[(TKCars *) obj2 model]];
            }];
}
@end
