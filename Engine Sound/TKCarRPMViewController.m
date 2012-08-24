//
//  TKCarRPMViewController.m
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKCarRPMViewController.h"
#import "TKCars.h"
@interface TKCarRPMViewController ()
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;

@end

@implementation TKCarRPMViewController
@synthesize navItem = _navItem;
@synthesize label = _label;
@synthesize car = _car;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navItem.title = [NSString stringWithFormat:@"%@ - RPM", self.car.model];
    self.label.text = self.car.sound_idle;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
