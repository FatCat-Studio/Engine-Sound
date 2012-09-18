//
//  TKDetailsViewController.m
//  Engine Sound
//
//  Created by ASPCartman on 8/22/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKDetailsViewController.h"
#import "TKCars.h"

@interface TKDetailsViewController ()
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@end

@implementation TKDetailsViewController
@synthesize navItem = _navItem;

- (void)viewDidLoad
{
	self.navItem.title = self.car.model;
//	UIImage *backgrounImage = [UIImage imageNamed:@"bg.jpeg"];
//	self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgrounImage];
	
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"DetailsToRPMSegue"]) {
        TKDetailsViewController *carRPM = segue.destinationViewController;
        carRPM.car = self.car;
    }
}
@end
