//
//  TKModelsWheelViewController.h
//  Engine Sound
//
//  Created by ASPCartman on 8/27/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@class TKCompanies;

@interface TKModelsWheelViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property  (nonatomic, strong) TKCompanies *companies;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
