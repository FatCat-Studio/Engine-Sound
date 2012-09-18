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
    [self onEnterLoadData];
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

#pragma mark - OpenAL methods

- (void) onEnterLoadData
{
	// Initialize the OpenAL device and context here so that it doesn't happen
	// prematurely.
	
	// We'll let OALSimpleAudio deal with the device and context.
	// Since we're not going to use it for playing effects, don't give it any sources.
	[OALSimpleAudio sharedInstance].reservedSources = 0;
	
	startSource = [ALSource source];
	startBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_start reduceToMono:NO];
	
    idleSource = [ALSource source];
	idleBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_idle reduceToMono:NO];
    
    onlowSource = [ALSource source];
	onlowBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_onlow reduceToMono:NO];
    
    offlowSource = [ALSource source];
	offlowBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_offlow reduceToMono:NO];
    
    onmidSource = [ALSource source];
	onmidBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_onmid reduceToMono:NO];
    
    offmidSource = [ALSource source];
	offmidBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_offmid reduceToMono:NO];
    
    onhightSource = [ALSource source];
	onhightBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_onhight reduceToMono:NO];
    
    offhightSource = [ALSource source];
	offhightBuffer = [[OpenALManager sharedInstance] bufferFromFile:self.car.sound_offhight reduceToMono:NO];
    
    [startSource play:startBuffer loop:YES];
    startSource.volume = 0;
	[idleSource play:idleBuffer loop:YES];
    idleSource.volume = 0;
    [onlowSource play:onlowBuffer loop:YES];
    onlowSource.volume = 1;
    [offlowSource play:offlowBuffer loop:YES];
    offlowSource.volume = 0;
    [onmidSource play:onmidBuffer loop:YES];
    onmidSource.volume = 0;
    [offmidSource play:offmidBuffer loop:YES];
    offmidSource.volume = 0;
    [onhightSource play:onhightBuffer loop:YES];
    onhightSource.volume = 0;
    [offhightSource play:offhightBuffer loop:YES];
    offhightSource.volume = 0;
}
@end
