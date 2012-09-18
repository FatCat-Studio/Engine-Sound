//
//  TKDriveViewController.m
//  Engine Sound
//
//  Created by Timofey Korchagin on 29/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKDriveViewController.h"
#import "TKCars.h"

@interface TKDriveViewController ()
{
    int gearNow;
    int modeNow; // neutral, comfort sport
    float rpmNow;
    BOOL started;
    NSDate *buttonStartStopWasPressed;
    NSDate *buttonGasPedalWasPressedOn;
    NSDate *buttonGasPedalWasPressedOff;
}

-(IBAction)modeController:(id)sender;
-(IBAction)buttonStartStopPressed:(id)sender;
-(IBAction)gasPedalPressedOn:(id)sender;
-(IBAction)gasPedalPressedOff:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *testLabel;
@property (nonatomic, strong) IBOutlet UIButton *buttonStartStop;
@property (nonatomic, strong) IBOutlet UIButton *gasPedal;
@property (nonatomic, strong) IBOutlet UISegmentedControl *modeController;
@property (nonatomic, strong) IBOutlet UIImageView *speedometerImage;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImage;
@end

@implementation TKDriveViewController
@synthesize car = _car;
@synthesize testLabel = _testLabel;
@synthesize buttonStartStop = _buttonStartStop;
@synthesize gasPedal = _gasPedal;
@synthesize modeController = _modeController;
@synthesize speedometerImage = _speedometerImage;
@synthesize arrowImage = _arrowImage;

- (void)viewDidLoad
{
    self.testLabel.text = self.car.model;
    [super viewDidLoad];
    [self onEnterLoadSounds];
    // Load other information
    gearsNumber = (int)self.car.gearsNumber;
    timeToHundred = [self.car.timeToHundred floatValue];
    gearNow = 1;
    modeNow = 0;
    rpmNow = 0;
    started = NO;
    
    buttonStartStopWasPressed = [NSDate date];
    buttonGasPedalWasPressedOn = [NSDate date];
    buttonGasPedalWasPressedOff = [NSDate date];
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

#pragma mark - Drive Methods

// time to accelerate
#define TIMETOACCELERATE 9
#define TIMETOSTOP 5
-(void)buttonStartStopPressed:(id)sender{
    if(started){
        float dt = 0;
        buttonStartStopWasPressed = [NSDate date];
        while (rpmNow >= 0) {
            dt = -[buttonStartStopWasPressed timeIntervalSinceNow];
            rpmNow -= (1 - dt/TIMETOSTOP)*3;
            [self off];
        }
        gearNow = 1;
        started = NO;
    } else { // we start our engine
        buttonStartStopWasPressed = [NSDate date];
        rpmNow = 0;
        gearNow = 1;
        [startSource play:startBuffer loop:NO];
        startSource.volume = 0.5;
        while ([startSource playing]) {
            //wait...
        }
        [startSource stop];
        idleSource.volume = 1;
        started = YES;
    }
}



#define PERCENT 0.35
#define DPER 0.05

-(void)on{
    float rpm = rpmNow;
    float frRart = rpm - (int)rpm;
    
    if(rpm <= 1 - DPER){
        startSource.volume = 0;
        idleSource.volume = 0;
        
        onlowSource.volume = 1;
        offlowSource.volume = 0;
        
        onmidSource.volume = 0;
        offmidSource.volume = 0;
        
        onhightSource.volume = 0;
        offhightSource.volume = 0;
        
        float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
        onlowSource.pitch = pitch;
    } else {
        if(rpm > 1 - DPER && rpm < 1 + DPER){
            float tmpPart = (1 + DPER - rpm)/(2*DPER); // На левой границе будет равно единице
            startSource.volume = 0;
            idleSource.volume = 0;
            
            onlowSource.volume = tmpPart*tmpPart;
            offlowSource.volume = 0;
            
            onmidSource.volume = 1 - tmpPart*tmpPart;
            offmidSource.volume = 0;
            
            onhightSource.volume = 0;
            offhightSource.volume = 0;
            
            
            float pitchLeft = 1 + PERCENT + 2 * DPER * (1 - tmpPart);
            onlowSource.pitch = pitchLeft;
            
            float pitchRight = 1 - PERCENT - 2 * DPER * tmpPart;
            onmidSource.pitch = pitchRight;
        } else {
            if(rpm >= 1 + DPER && rpm < 2 - DPER){
                startSource.volume = 0;
                idleSource.volume = 0;
                
                onlowSource.volume = 0;
                offlowSource.volume = 0;
                
                onmidSource.volume = 1;
                offmidSource.volume = 0;
                
                onhightSource.volume = 0;
                offhightSource.volume = 0;
                
                float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
                onmidSource.pitch = pitch;
            } else {
                if(rpm >= 2 - DPER && rpm < 2 + DPER){
                    float tmpPart = (2 + DPER - rpm)/(2*DPER); // На левой границе будет равно единице
                    startSource.volume = 0;
                    idleSource.volume = 0;
                    
                    onlowSource.volume = 0;
                    offlowSource.volume = 0;
                    
                    onmidSource.volume = tmpPart*tmpPart;
                    offmidSource.volume = 0;
                    
                    onhightSource.volume = 1 - tmpPart*tmpPart;
                    offhightSource.volume = 0;
                    
                    
                    float pitchLeft = 1 + PERCENT + 2 * DPER * (1 - tmpPart);
                    onmidSource.pitch = pitchLeft;
                    
                    float pitchRight = 1 - PERCENT - 2 * DPER * tmpPart;
                    onhightSource.pitch = pitchRight;
                } else {
                    if(rpm >= 2 + DPER){
                        startSource.volume = 0;
                        idleSource.volume = 0;
                        
                        onlowSource.volume = 0;
                        offlowSource.volume = 0;
                        
                        onmidSource.volume = 0;
                        offmidSource.volume = 0;
                        
                        onhightSource.volume = 1;
                        offhightSource.volume = 0;
                        
                        float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
                        onhightSource.pitch = pitch;
                    } // rpm >= 2 + DPER
                } // rpm >= 2 - DPER && rpm < 2 + DPER
            } // rpm >= 1 + DPER && rpm < 2 - DPER
        } // rpm > 1 - DPER && rpm < 1 + DPER
    } // rpm <= 1 - DPER
}

-(void)off{
    float rpm = rpmNow;
    float frRart = rpm - (int)rpm;
    
    if(rpm <= 1 - DPER){
        startSource.volume = 0;
        idleSource.volume = 0;
        
        onlowSource.volume = 0;
        offlowSource.volume = 1;
        
        onmidSource.volume = 0;
        offmidSource.volume = 0;
        
        onhightSource.volume = 0;
        offhightSource.volume = 0;
        
        float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
        offlowSource.pitch = pitch;
    } else {
        if(rpm > 1 - DPER && rpm < 1 + DPER){
            float tmpPart = (1 + DPER - rpm)/(2*DPER); // На левой границе будет равно единице
            startSource.volume = 0;
            idleSource.volume = 0;
            
            onlowSource.volume = 0;
            offlowSource.volume = tmpPart;
            
            onmidSource.volume = 0;
            offmidSource.volume = 1 - tmpPart*tmpPart;
            
            onhightSource.volume = 0;
            offhightSource.volume = 0;
            
            
            float pitchLeft = 1 + PERCENT + 2 * DPER * (1 - tmpPart);
            offlowSource.pitch = pitchLeft;
            
            float pitchRight = 1 - PERCENT - 2 * DPER * tmpPart;
            offmidSource.pitch = pitchRight;
        } else {
            if(rpm >= 1 + DPER && rpm < 2 - DPER){
                startSource.volume = 0;
                idleSource.volume = 0;
                
                onlowSource.volume = 0;
                offlowSource.volume = 0;
                
                onmidSource.volume = 0;
                offmidSource.volume = 1;
                
                onhightSource.volume = 0;
                offhightSource.volume = 0;
                
                float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
                offmidSource.pitch = pitch;
            } else {
                if(rpm >= 2 - DPER && rpm < 2 + DPER){
                    float tmpPart = (2 + DPER - rpm)/(2*DPER); // На левой границе будет равно единице
                    startSource.volume = 0;
                    idleSource.volume = 0;
                    
                    onlowSource.volume = 0;
                    offlowSource.volume = 0;
                    
                    onmidSource.volume = 0;
                    offmidSource.volume = tmpPart;
                    
                    onhightSource.volume = 0;
                    offhightSource.volume = 1 - tmpPart*tmpPart;
                    
                    
                    float pitchLeft = 1 + PERCENT + 2 * DPER * (1 - tmpPart);
                    offmidSource.pitch = pitchLeft;
                    
                    float pitchRight = 1 - PERCENT - 2 * DPER * tmpPart;
                    offhightSource.pitch = pitchRight;
                } else {
                    if(rpm >= 2 + DPER){
                        onlowSource.volume = 0;
                        offlowSource.volume = 0;
                        
                        onmidSource.volume = 0;
                        offmidSource.volume = 0;
                        
                        onhightSource.volume = 0;
                        offhightSource.volume = 1;
                        
                        float pitch = (1 - PERCENT) + 2*PERCENT*frRart;
                        offhightSource.pitch = pitch;
                    } // rpm >= 2 + DPER
                } // rpm >= 2 - DPER && rpm < 2 + DPER
            } // rpm >= 1 + DPER && rpm < 2 - DPER
        } // rpm > 1 - DPER && rpm < 1 + DPER
    } // rpm <= 1 - DPER
}

#define TIMETOSWITCHGEAR 0.3
#define ACCELERATEMULTIPLY 1
#define STOPMULTIPLY 1

-(void)gasPedalPressedOn:(id)sender{
    if (started) {
        float dt = 0;
        float rpmLast = rpmNow;
        if (modeNow == 0) {
            dt = 0;
            buttonGasPedalWasPressedOn = [NSDate date];
            while (rpmNow < 3 - 0.001) {
                dt = -[buttonGasPedalWasPressedOn timeIntervalSinceNow];
                rpmNow = rpmLast + dt*ACCELERATEMULTIPLY;
                [self on];
            }
        } else {
            dt = 0;
            buttonGasPedalWasPressedOn = [NSDate date];
            while (gearNow <= gearsNumber) {
                if (rpmNow < modeNow + 1) {
                    dt = -[buttonGasPedalWasPressedOn timeIntervalSinceNow];
                    rpmNow = rpmLast + dt*ACCELERATEMULTIPLY;
                    [self on];
                } else {
                    if (gearNow != gearsNumber) {
                        dt = 0;
                        buttonGasPedalWasPressedOn = [NSDate date];
                        while (rpmNow > modeNow) {
                            dt = -[buttonGasPedalWasPressedOn timeIntervalSinceNow];
                            rpmNow = rpmLast - dt*TIMETOSWITCHGEAR;
                            [self on];
                        }
                        gearNow++;
                    }
                } // switch gears
            }
        } // mode != 0 (comfort or sport)
    }
}

-(void)gasPedalPressedOff:(id)sender{
    if (started) {
        float dt = 0;
        float rpmLast = rpmNow;
        if (modeNow == 0) {
            dt = 0;
            buttonGasPedalWasPressedOff = [NSDate date];
            while (rpmNow > 0) {
                dt = -[buttonGasPedalWasPressedOff timeIntervalSinceNow];
                rpmNow = rpmLast - dt*STOPMULTIPLY;
                [self off];
            }
        } else {
            dt = 0;
            buttonGasPedalWasPressedOff = [NSDate date];
            while (gearNow > 1) {
                if (rpmNow > modeNow) {
                    dt = -[buttonGasPedalWasPressedOff timeIntervalSinceNow];
                    rpmNow = rpmLast - dt*STOPMULTIPLY;
                    [self off];
                } else {
                        dt = 0;
                        buttonGasPedalWasPressedOff = [NSDate date];
                        while (rpmNow < modeNow + 1) {
                            dt = -[buttonGasPedalWasPressedOff timeIntervalSinceNow];
                            rpmNow = rpmLast + dt*TIMETOSWITCHGEAR;
                            [self off];
                        }
                        gearNow--;
                } // switch gears
            }
            dt = 0;
            buttonGasPedalWasPressedOff = [NSDate date];
            while (rpmNow > 0) {
                dt = -[buttonGasPedalWasPressedOff timeIntervalSinceNow];
                rpmNow = rpmLast - dt*STOPMULTIPLY;
                [self off];
            }
        } // mode != 0 (comfort or sport)
    }
}

-(void)modeController:(id)sender{
    if(!started){
        modeNow = self.modeController.selectedSegmentIndex;
    }
}

-(void)playSoundOn{
    
}

#pragma mark - OpenAL methods

- (void) onEnterLoadSounds
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
    
    [startSource play:startBuffer loop:NO];
    startSource.volume = 0;
	[idleSource play:idleBuffer loop:YES];
    idleSource.volume = 0;
    [onlowSource play:onlowBuffer loop:YES];
    onlowSource.volume = 0;
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
