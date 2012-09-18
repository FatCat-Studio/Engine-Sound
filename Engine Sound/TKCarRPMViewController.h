//
//  TKCarRPMViewController.h
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectAL.h"

@class  TKCars;

@interface TKCarRPMViewController : UIViewController
{
    ALSource* startSource;
    ALSource* idleSource;
    ALSource* onlowSource;
    ALSource* offlowSource;
    ALSource* onmidSource;
    ALSource* offmidSource;
    ALSource* onhightSource;
    ALSource* offhightSource;

	ALBuffer* startBuffer;
    ALBuffer* idleBuffer;
    ALBuffer* onlowBuffer;
    ALBuffer* offlowBuffer;
    ALBuffer* onmidBuffer;
    ALBuffer* offmidBuffer;
    ALBuffer* onhightBuffer;
    ALBuffer* offhightBuffer;
}

@property (nonatomic, strong) TKCars *car;

@end
