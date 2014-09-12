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

    //PRACTICE SESSION AND TIMER
    bPractice = FALSE;
    

    iTotalTime = 0;             //Initialize time counter
    bDisplayTimer = TRUE;
    
    
    //COUNTER
    iTotalCount = 0;             //Initialize time counter
    counterDisplay.text = [NSString stringWithFormat:@"%i",iTotalCount];
    
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
    
    //Build array of 12 keys
    keyArray = [[NSMutableArray alloc] init];
	[keyArray addObject:@"A"];
	[keyArray addObject:@"A#"];
	[keyArray addObject:@"B"];
	[keyArray addObject:@"C"];
	[keyArray addObject:@"C#"];
	[keyArray addObject:@"D"];
	[keyArray addObject:@"D#"];
	[keyArray addObject:@"E"];
	[keyArray addObject:@"F"];
	[keyArray addObject:@"F#"];
	[keyArray addObject:@"G"];
	[keyArray addObject:@"G#"];
    
    //Display the tonic from the stepper
    droneDisplay.text = [NSString stringWithFormat:@"%@",[keyArray objectAtIndex:(int)droneStepper.value]];
    
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


-(IBAction)BeginPractice
{
    
    if(!bPractice)
    {
        //Begin time display on click
        iTotalTime = 0;             //Initialize time counter
        timerDisplay.text = [NSString stringWithFormat:@"%i min",iTotalTime];
        
        //Launch repeating timer to run "Tick"
        durationTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(oneRound) userInfo:nil repeats:YES];
        
        //Retitle button
        [beginButton setTitle: @"End" forState: UIControlStateNormal];
        [beginButton setTitle: @"End" forState: UIControlStateApplication];
        [beginButton setTitle: @"End" forState: UIControlStateHighlighted];
        [beginButton setTitle: @"End" forState: UIControlStateReserved];
        [beginButton setTitle: @"End" forState: UIControlStateSelected];
        [beginButton setTitle: @"End" forState: UIControlStateDisabled];
        
        //State Change
        bPractice = TRUE;
    }
    else
    {
        //Retitle button
        [beginButton setTitle: @"Begin" forState: UIControlStateNormal];
        [beginButton setTitle: @"Begin" forState: UIControlStateApplication];
        [beginButton setTitle: @"Begin" forState: UIControlStateHighlighted];
        [beginButton setTitle: @"Begin" forState: UIControlStateReserved];
        [beginButton setTitle: @"Begin" forState: UIControlStateSelected];
        [beginButton setTitle: @"Begin" forState: UIControlStateDisabled];
        
        //kill timer
        [durationTimer invalidate];
        
        //State Change
        bPractice = FALSE;
    }
}

-(void)oneRound
{
    iTotalTime++;
    
    if(bDisplayTimer)
    {
        timerDisplay.text = [NSString stringWithFormat:@"%i min",iTotalTime];
    }
}

-(IBAction)displayTimer
{
    if(bDisplayTimer)
    {
        //Retitle button
        [viewButton setTitle: @"View" forState: UIControlStateNormal];
        [viewButton setTitle: @"View" forState: UIControlStateApplication];
        [viewButton setTitle: @"View" forState: UIControlStateHighlighted];
        [viewButton setTitle: @"View" forState: UIControlStateReserved];
        [viewButton setTitle: @"View" forState: UIControlStateSelected];
        [viewButton setTitle: @"View" forState: UIControlStateDisabled];
        
        timerDisplay.text = @"-";
        bDisplayTimer = FALSE;
    }
    else
    {
        //Retitle button
        [viewButton setTitle: @"Hide" forState: UIControlStateNormal];
        [viewButton setTitle: @"Hide" forState: UIControlStateApplication];
        [viewButton setTitle: @"Hide" forState: UIControlStateHighlighted];
        [viewButton setTitle: @"Hide" forState: UIControlStateReserved];
        [viewButton setTitle: @"Hide" forState: UIControlStateSelected];
        [viewButton setTitle: @"Hide" forState: UIControlStateDisabled];
        
        timerDisplay.text = [NSString stringWithFormat:@"%i min",iTotalTime];
        bDisplayTimer = TRUE;
    }
}


-(IBAction)counterBtn:(UIButton *)button
{
    //Which button?
    int iTag = button.tag;
    
    if(iTag == 1)
    {
        iTotalCount++;
    }
    else
    {
      if(iTotalCount > 0)
      {
        iTotalCount--;
      }
    }
    counterDisplay.text = [NSString stringWithFormat:@"%i",iTotalCount];
    
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


-(IBAction)droneStepperChange:(UIStepper *)sender;
{
    if(bDrone)
    {
        //Stop Drone Audio
        [drone1 stop];
        [drone2 stop];
        
        //Reset drone audio playback
        drone1.currentTime = 0;
        drone2.currentTime = 5;
        
        //Change State
        bDrone = FALSE;
        
        //Restart
        [self Drone];
        
    }
    //Display the tonic note user has chosen
    droneDisplay.text = [NSString stringWithFormat:@"%@",[keyArray objectAtIndex:(int)droneStepper.value]];
}

-(IBAction)Drone
{
    
    if(!bDrone)
    {
        NSError *error;
        
        //Get the tonic note from my array
        NSString *sTonic = [[NSString alloc] initWithFormat:@"%@", [keyArray objectAtIndex:(int)droneStepper.value]];
        
        //Create string to represent resource path.
        NSString *dronePath = [[NSBundle mainBundle] pathForResource:sTonic ofType:@"wav"];
        
        //Create File URL based on string representation of path
        NSURL *DroneURL = [NSURL fileURLWithPath:dronePath];
        
        //Point AVPlayers to File URL for wav file
        drone1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DroneURL error:&error];
        drone2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DroneURL error:&error];
        
        //Trigger Loop 1 of drone
        [drone1 setNumberOfLoops: -1];
        [drone1 prepareToPlay];
        
        //Trigger Loop 2 of drone
        [drone2 setNumberOfLoops: -1];
        [drone2 prepareToPlay];
        
        //Offset timing of two drone copies
        drone1.currentTime = 0;
        drone2.currentTime = 5;
        
        //Play drones
        [drone1 play];
        [drone2 play];
    
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
        drone2.currentTime = 5;
        
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




@end
