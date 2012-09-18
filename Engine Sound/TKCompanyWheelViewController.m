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
#import "TKModelsWheelViewController.h"

@interface TKCompanyWheelViewController ()

@property (nonatomic, strong) NSArray *companiesList;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UILabel *companyNameLabel;

@end

@implementation TKCompanyWheelViewController
@synthesize carousel;
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
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //configure carousel
	carousel.type = iCarouselTypeCoverFlow2;
	carousel.contentOffset = CGSizeMake(0,0);
	carousel.decelerationRate = 0;

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
    if(self.companiesList.count != 0){
        if ([segue.identifier isEqualToString:@"CompaniesToModelsSegue"]) {
            TKModelsWheelViewController *model = segue.destinationViewController;
            model.company = [self.companiesList objectAtIndex:self.carousel.currentItemIndex];
        }
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
    return self.companiesList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    
    if (self.companiesList.count == 0) {
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
    
    // if we have one and more companies
	if (button == nil)
	{
		//no button available to recycle, so create new one
        TKCompanies *currentCompany = [self.companiesList objectAtIndex:index];
		UIImage *image = [UIImage imageNamed:currentCompany.icon];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 200.0, 200.0);
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:25];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	return button;
}

- (void)buttonTapped:(UIButton *)sender
{
    //get item index for button
	NSInteger index = [carousel indexOfItemViewOrSubview:sender];
    
	TKCompanies *currentCompany = [self.companiesList objectAtIndex:index];
    
    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped %@", currentCompany.name]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] show];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    if (self.companiesList.count != 0) {
        TKCompanies *currentCompany = [self.companiesList objectAtIndex:carousel.currentItemIndex];
        self.companyNameLabel.text = currentCompany.name;
        //	NSLog([NSString stringWithFormat:@"%d",self.carousel.currentItemIndex]);
    }
}

@end
