//
//  ViewController.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/11/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{

    //Disable user input of text feilds,( must use interface controls )
    topicDisplay.enabled = FALSE;
    timerDisplay.enabled = FALSE;
    counterDisplay.enabled = FALSE;
    nomeDisplay.enabled = FALSE;

    
    
    
    //METRONOME SETUP
    
    //Set BPM to stepper setting
    [self stepperChange:nil];
    
    //Create string to represent resource path. Apparently must be done in this way (?)
    NSString *clickPath = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
    
    //Create File URL based on string representation of path
    NSURL *SoundURL = [NSURL fileURLWithPath:clickPath];
    
    //Create SoundID for click sound
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)SoundURL, &Click);
    
    //Initialize metronome state variable
    bNome = FALSE;
    
    //DRONE SETUP
    NSError *error;
    
    //Create string to represent resource path.
    NSString *dronePath1 = [[NSBundle mainBundle] pathForResource:@"A" ofType:@"wav"];
    NSString *dronePath2 = [[NSBundle mainBundle] pathForResource:@"A" ofType:@"wav"];
    
    //Create File URL based on string representation of path
    NSURL *DroneURL1 = [NSURL fileURLWithPath:dronePath1];
    NSURL *DroneURL2 = [NSURL fileURLWithPath:dronePath2];
    
    //Point AVPlayers to File URL for wav file
    drone1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DroneURL1 error:&error];
    drone2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DroneURL2 error:&error];
    
    //Initialize drone state variable
    bDrone = FALSE;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Metronome
{
    
    if(!bNome)
    {
        //Set "Beats Per Minute" to user's choice
        BPM = [nomeDisplay.text intValue];
    
        //Set time interval to BPM
        float interval = (float)60.00/(float)BPM;
    
        //Launch repeating timer to run "Tick"
        nomeTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(Beat) userInfo:nil repeats:YES];
    
        //Produce first click on button tap
        AudioServicesPlaySystemSound(Click);
        
        //Change state
        [nomeButton setTitle: @"Stop" forState: UIControlStateNormal];
        [nomeButton setTitle: @"Stop" forState: UIControlStateApplication];
        [nomeButton setTitle: @"Stop" forState: UIControlStateHighlighted];
        [nomeButton setTitle: @"Stop" forState: UIControlStateReserved];
        [nomeButton setTitle: @"Stop" forState: UIControlStateSelected];
        [nomeButton setTitle: @"Stop" forState: UIControlStateDisabled];
        bNome = TRUE;
    }
    else
    {
        //Stop timer
        [nomeTimer invalidate];
        
        //Change state
        [nomeButton setTitle: @"Start" forState: UIControlStateNormal];
        [nomeButton setTitle: @"Start" forState: UIControlStateApplication];
        [nomeButton setTitle: @"Start" forState: UIControlStateHighlighted];
        [nomeButton setTitle: @"Start" forState: UIControlStateReserved];
        [nomeButton setTitle: @"Start" forState: UIControlStateSelected];
        [nomeButton setTitle: @"Start" forState: UIControlStateDisabled];
        bNome = FALSE;
    }
}


-(void)Beat  //For each click of metronome
{
    AudioServicesPlaySystemSound(Click);
}

- (IBAction)stepperChange:(UIStepper *)sender //Change BPM on metronome
{
    
    NSUInteger stepOne = stepperOne.value;
    NSUInteger stepTen = stepperTen.value;
    
    if(stepOne == 10)
    {
        stepperOne.value = 0;
        stepperTen.value = stepTen + 10;
    }
    if(stepOne == -1)
    {
        stepperOne.value = 9;
        stepperTen.value = stepTen - 10;
    }
    
    stepOne = stepperOne.value;
    stepTen = stepperTen.value;
    NSUInteger setting = stepOne + stepTen;
    nomeDisplay.text = [NSString stringWithFormat:@"%03d",setting];
    
    if(bNome)
    {
        //Kill active metronome
        [nomeTimer invalidate];
        
        //Change state
        bNome = FALSE;
        
        //Restart
        [self Metronome];
    }
}

-(IBAction)Drone
{
    
    if(!bDrone)
    {
        //Set timer to launch second drone sound half way through the first drone sound (at 5 seconds)
        droneTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(DroneAgain) userInfo:nil repeats:NO];
    
        //Trigger Loop 1 of drone
        [drone1 setNumberOfLoops: -1];
        [drone1 prepareToPlay];
        [drone1 play];
    
        //Change State
        [droneButton setTitle: @"Stop" forState: UIControlStateNormal];
        [droneButton setTitle: @"Stop" forState: UIControlStateApplication];
        [droneButton setTitle: @"Stop" forState: UIControlStateHighlighted];
        [droneButton setTitle: @"Stop" forState: UIControlStateReserved];
        [droneButton setTitle: @"Stop" forState: UIControlStateSelected];
        [droneButton setTitle: @"Stop" forState: UIControlStateDisabled];
        bDrone = TRUE;
    }
    else
    {
        //Stop Drone Audio
        [drone1 stop];
        [drone2 stop];
        
        //Reset drone audio playback
        drone1.currentTime = 0;
        drone2.currentTime = 0;
        
        //Change State
        [droneButton setTitle: @"Start" forState: UIControlStateNormal];
        [droneButton setTitle: @"Start" forState: UIControlStateApplication];
        [droneButton setTitle: @"Start" forState: UIControlStateHighlighted];
        [droneButton setTitle: @"Start" forState: UIControlStateReserved];
        [droneButton setTitle: @"Start" forState: UIControlStateSelected];
        [droneButton setTitle: @"Start" forState: UIControlStateDisabled];
        bDrone = FALSE;
    }
}



-(void)DroneAgain
{
    
    //Trigger Loop 2 of drone
    [drone2 setNumberOfLoops: -1];
    [drone2 prepareToPlay];
    [drone2 play];
}

@end
