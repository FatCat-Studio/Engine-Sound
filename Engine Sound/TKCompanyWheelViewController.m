//
//  TKCompanyWheelViewController.m
//  Engine Sound
//
//  Created by ASPCartman on 8/24/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKCompanyWheelViewController.h"
#import "TKAppDelegate.h"
#import "TKCompanies.h"
#import "TKModelsViewController.h"

@interface TKCompanyWheelViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *companiesList;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UILabel *companyNameLabel;

@end

@implementation TKCompanyWheelViewController
@synthesize carousel;
@synthesize items;
@synthesize companiesList = _companiesList;
@synthesize companyNameLabel = _companyNameLabel;

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
	
	self.items = [NSMutableArray array];
	for (int i = 0; i < self.companiesList.count; i++)
    {
        [items addObject:[self.companiesList objectAtIndex:i]];
		TKCompanies *currentCompany = [self.companiesList objectAtIndex:i];
		NSLog(currentCompany.name);
    }
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CompaniesToModelsSegue"]) {
        TKModelsViewController *model = segue.destinationViewController;
        model.companies = [self.companiesList objectAtIndex:self.carousel.currentItemIndex];
        
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    return [(TKAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
		TKCompanies *currentCompany = [self.items objectAtIndex:index];
//		self.companyNameLabel.text = currentCompany.name;
		
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 210.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:currentCompany.icon];
		
        view.contentMode = UIViewContentModeScaleToFill;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:20];
		label.textColor = [UIColor whiteColor];
        label.tag = 1;
        [view addSubview:label];
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
//    label.text = [[items objectAtIndex:index] name];
    
    return view;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
	TKCompanies *currentCompany = [self.items objectAtIndex:carousel.currentItemIndex];
	self.companyNameLabel.text = currentCompany.name;
	NSLog([NSString stringWithFormat:@"%d",self.carousel.currentItemIndex]);
}

@end
