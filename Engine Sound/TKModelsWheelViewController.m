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
#import "TKCars.h"
#import "TKCompanies.h"

@interface TKModelsWheelViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *companiesList;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UINavigationItem *companyName;
@property (nonatomic, strong) IBOutlet UIImageView *companyimage;

@end

@implementation TKModelsWheelViewController
@synthesize companies = _companies;
@synthesize carousel;
@synthesize items;
@synthesize companiesList = _companiesList;
@synthesize companyName = _companyName;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TKCompanies"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor
                                                             sortDescriptorWithKey:@"name" ascending:YES]];
    self.companiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (void)viewDidLoad
{
	self.companyName.title = self.companies.name;
	self.companyimage.image = [UIImage imageNamed:self.companies.icon];
	self.companyimage.contentMode = UIViewContentModeScaleToFill;
    [super viewDidLoad];
	
    //configure carousel
	carousel.type = iCarouselTypeCoverFlow;
	carousel.contentOffset = CGSizeMake(0,0);
	carousel.decelerationRate = 0.3;
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
    if ([segue.identifier isEqualToString:@"ModelsToDetailsSegue"]) {
        TKDetailsViewController *carDetail = segue.destinationViewController;
        carDetail.car = [self.companies.sortedCars objectAtIndex:self.carousel.currentItemIndex];
        
    }
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return self.companies.cars.count;;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
		TKCars *currentCar = [self.companies.cars.allObjects objectAtIndex:index];
		
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 210.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page"];
		
        view.contentMode = UIViewContentModeScaleToFill;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:20];
		label.textColor = [UIColor whiteColor];
        label.tag = 1;
        [view addSubview:label];
		label.text = currentCar.model;
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    return view;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
	TKCars *currentCar = [self.companies.cars.allObjects objectAtIndex:self.carousel.currentItemIndex];
//	self.companyName.title = currentCar.company;
	NSLog([NSString stringWithFormat:@"%d",self.carousel.currentItemIndex]);
}


@end
