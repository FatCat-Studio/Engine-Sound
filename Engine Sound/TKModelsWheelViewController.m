//
//  TKModelsWheelViewController.m
//  Engine Sound
//
//  Created by ASPCartman on 8/27/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKModelsWheelViewController.h"
#import "TKCompanies+Customization.h"
#import "TKDetailsViewController.h"
#import "TKDriveViewController.h"
#import "TKCars.h"
#import "TKCompanies.h"

@interface TKModelsWheelViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *companiesList;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UINavigationItem *companyName;
@property (nonatomic, strong) IBOutlet UIImageView *companyimage;
@property (nonatomic, strong) IBOutlet UILabel *carModelLabel;
@end

@implementation TKModelsWheelViewController
@synthesize company = _company;
@synthesize carousel;
@synthesize items;
@synthesize companiesList = _companiesList;
@synthesize companyName = _companyName;
@synthesize carModelLabel = _carModelLabel;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TKCompanies"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor
                                                             sortDescriptorWithKey:@"name"
                                                             ascending:YES]];
    self.companiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (void)viewDidLoad
{
	self.companyName.title = self.company.name;
//  self.companyimage.image = [UIImage imageNamed:self.company.icon];
//	self.companyimage.contentMode = UIViewContentModeScaleToFill;
//  self.companyimage.transform = CGAffineTransformMakeRotation(3.142);
    [super viewDidLoad];
	
    //configure carousel
	carousel.type = iCarouselTypeCoverFlow2;
	carousel.contentOffset = CGSizeMake(0,0);
//	carousel.decelerationRate = 0.3;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (self.company.sortedCars.count != 0){
        if ([segue.identifier isEqualToString:@"ModelsWheelToDriveSegue"]) {
            TKDriveViewController *drive = segue.destinationViewController;
            drive.car = [self.company.sortedCars objectAtIndex:
                             self.carousel.currentItemIndex];
        }
    }
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return self.company.cars.count;;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UIButton *button = (UIButton *)view;
    
    if (self.company.cars.count == 0) {
        UIImage *image = [UIImage imageNamed:@"page.png"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 300.0, 200.0);
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:40];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        //set button label
        [button setTitle:[NSString stringWithFormat:@"%i", index] forState:UIControlStateNormal];
        
        return button;
    }
    
	if (button == nil)
	{
//        TKCars *currentCar = [self.companies.cars.allObjects objectAtIndex:index];
		//no button available to recycle, so create new one
		UIImage *image = [UIImage imageNamed:@"bg.jpeg"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 290.0f, 200.0f);
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleToFill;
		button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return button;
}

- (void)buttonTapped:(UIButton *)sender
{
	//get item index for button
	NSInteger index = [carousel indexOfItemViewOrSubview:sender];
	
    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] show];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    if (self.company.cars.count != 0) {
        TKCars *currentCar = [self.company.sortedCars objectAtIndex:self.carousel.currentItemIndex];
        self.carModelLabel.text = currentCar.model;
        //	NSLog([NSString stringWithFormat:@"%d",self.carousel.currentItemIndex]);
    }
}

@end
