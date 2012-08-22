//
//  TKCarDetailsViewController.m
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKCarDetailsViewController.h"
#import "TKCars.h"

@interface TKCarDetailsViewController ()

@property (nonatomic, strong) IBOutlet UILabel *carDetailslabel;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;

@end

@implementation TKCarDetailsViewController
@synthesize carDetailslabel = _carDetailslabel;
@synthesize car = _car;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navItem.title = [NSString stringWithFormat:@"%@ %@", self.car.company, self.car.model];
    self.carDetailslabel.text = self.car.pic_inFirst;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CarDetailsToCarRPMSegue"]) {
        TKCarDetailsViewController *carRPM = segue.destinationViewController;
        carRPM.car = self.car;
    }
}

@end
