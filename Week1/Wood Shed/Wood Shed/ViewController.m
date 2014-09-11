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
        bNome = TRUE;
    }
    else
    {
        //Stop timer
        [nomeTimer invalidate];
        
        //Change state
        bNome = FALSE;
    }
}


-(void)Beat
{
    AudioServicesPlaySystemSound(Click);
}

- (IBAction)stepperChange:(UIStepper *)sender
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
@end
