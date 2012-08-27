//
//  TKCompanyWheelViewController.h
//  Engine Sound
//
//  Created by ASPCartman on 8/24/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface TKCompanyWheelViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
