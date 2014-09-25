//
//  ViewController.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/11/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//
/*
 
 Russ Gaspard
 Full Sail
 Mobile Development
 ADP1 1409
 Milestone 2
 Week 3
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //setup shared instance of data storage in RAM
    dataStore = [DataStore sharedInstance];
    
    //Disable user input of text feilds,( must use interface controls )
    topicDisplay.enabled = FALSE;
    timerDisplay.enabled = FALSE;
    counterDisplay.enabled = FALSE;
    nomeDisplay.enabled = FALSE;
    droneDisplay.enabled = FALSE;

    
    //Initialize main "practice" state variable
    bPractice = FALSE;
    
    //Initialize Duration Timer
    iTotalTime = 0;
    bDisplayTimer = TRUE;
    
    //Initialize Repetition Counter
    iTotalCount = 0;
    counterDisplay.text = [NSString stringWithFormat:@"%i",iTotalCount];
    
    //Retrieve data from local file
    [self getData];
    
    //Set up Metronome
    [self setUpMetronome];
    
    //Set up drone
    [self setUpDrone];
    
    //Hide Splash Screen
    [self hideSplash];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {

    //If user has set up data, then display it!
    [self displayData];
     
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Setup Interface Items
-(void)getData
{
    //If file exists load data
    if([[NSFileManager defaultManager] fileExistsAtPath:dataStore.jsonPath])
    {
        //Read content of file as data object
        NSData* oData = [NSData dataWithContentsOfFile:dataStore.jsonPath];
        
        //Serialize data object to JSON data (Mutable Array)
        dataStore.sessions = [NSJSONSerialization JSONObjectWithData:oData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
}

-(IBAction)hideSplash
{
    fAlpha = 2; //Initialize alpha at 2 but don't start fade till 1. let it linger for a sec!
    
    //Launch repeating timer to run fadeOut
    fadeTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(fadeOut) userInfo:nil repeats:YES];
};

//Support function to hide Splash
-(void)fadeOut
{
    fAlpha = fAlpha - .01;     //Fade Splash Screen
    
    if(fAlpha > 0 && fAlpha < 1) //Don't start fade till 1. let it linger for a sec!
    {
        splashScreen.alpha = fAlpha;
    }
    else if (fAlpha <= 0)       //Once it fades to zclear get it out of users way

    {
        splashScreen.hidden = true;
    }
}

-(void)setUpMetronome
{
    //Initialize Metronome UI
    [self stepperChange:nil];
    
    //Create string to represent "click" resource path. Apparently must be done in this way (?)
    NSString *clickPath = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
    
    //Create File URL based on string representation of "click" path
    NSURL *SoundURL = [NSURL fileURLWithPath:clickPath];
    
    //Create SoundID for "click" sound
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)SoundURL, &Click);
    
    //Initialize metronome state variable
    bNome = FALSE;
}

-(void)setUpDrone
{
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
}

//Show data from setup view
-(void)displayData
{
    //if(![[dataStore.currentSession objectForKey: @"topic"]  isEqual: @""])
    //{
        //Display topic
        topicDisplay.text = [dataStore.currentSession objectForKey: @"topic"];
        
        //Build NOTES string
        NSString *sNotes = [[NSMutableString alloc] init];
        if(![[dataStore.currentSession objectForKey: @"notes"] isEqual: @""])
        {
            sNotes = [[NSString alloc] initWithFormat:@"NOTES: %@\n",[dataStore.currentSession objectForKey: @"notes"]];
        }
        else {sNotes = @"";}
        
        //Build TEMPO string
        NSString *sTempo = [[NSMutableString alloc] init];
        if(![[dataStore.currentSession objectForKey: @"tempo"] isEqual: @""])
        {
            sTempo = [[NSString alloc] initWithFormat:@"TEMPO: %@ = %@\n",[dataStore.currentSession objectForKey: @"tempo"], [dataStore.currentSession objectForKey: @"bpm"]];
        }
        else {sTempo = @"";}
        
        //Build KEY string
        NSString *sKey = [[NSMutableString alloc] init];
        if(![[dataStore.currentSession objectForKey: @"key"] isEqual: @""])
        {
            sKey = [[NSString alloc] initWithFormat:@"KEY: %@\n",[dataStore.currentSession objectForKey: @"key"]];
        }
        else {sKey = @"";}
        
        //Build BOWING string
        NSString *sBowing = [[NSMutableString alloc] init];
        if(![[dataStore.currentSession objectForKey: @"bowing"] isEqual: @""])
        {
            sBowing = [[NSString alloc] initWithFormat:@"BOWING: %@\n",[dataStore.currentSession objectForKey: @"bowing"]];
        }
        else {sBowing = @"";}
        
        NSString *sDetails = [[NSString alloc] initWithFormat:@"%@%@%@%@",sTempo, sKey, sBowing, sNotes];
        
        //Display other tags in "details" text view
        detailsDisplay.text = sDetails;
    //}
}

// ACTION FUNCTIONS //////////////////

// Start or Stop Practice Time
-(IBAction)BeginPractice
{
    if([topicDisplay.text isEqual: @""])
    {
        
        NSString *sMessage = @"Please specify a practice topic from the 'Setup >' menu.";
        
        //Create alert view
        UIAlertView *noTopicAlert = [[UIAlertView alloc] initWithTitle:@"Topic Required" message:sMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        //Display alert view
        [noTopicAlert show];
    }
    else
    {
        if(!bPractice)
        {
            //Set the current date and time
            NSDate *currentDate = [NSDate date];
            
            //Create format for date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            if (dateFormatter != nil)
            {
                [dateFormatter setDateFormat:@"M/dd/YY"];
            }
            
            //Build the date into a string based on my day format
            NSString *dateString = [[NSString alloc] initWithFormat:@"%@", [dateFormatter stringFromDate: currentDate]];
            
            //Create format for times
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
            [timeFormatter setDateFormat:@"h:mm a"];
            
            //Build the start time into a string based on my time format
            NSString *timeString = [[NSString alloc] initWithFormat:@"%@", [timeFormatter stringFromDate: currentDate]];
            
            //Inititlaize time tracker on "begin"
            iTotalTime = 0;
            sDuration = [NSString stringWithFormat:@"%i min",iTotalTime];
            if(bDisplayTimer)
            {
                timerDisplay.text = sDuration;
            }
            
            //Launch repeating timer to run "Tick"
            durationTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(oneRound) userInfo:nil repeats:YES];
            
            //Retitle button
            [beginButton setTitle: @"End" forState: UIControlStateNormal];
            [beginButton setTitle: @"End" forState: UIControlStateApplication];
            [beginButton setTitle: @"End" forState: UIControlStateHighlighted];
            [beginButton setTitle: @"End" forState: UIControlStateReserved];
            [beginButton setTitle: @"End" forState: UIControlStateSelected];
            [beginButton setTitle: @"End" forState: UIControlStateDisabled];
            
            
            //Save date/time tage in current session object
            [dataStore.currentSession setValue:dateString forKey:@"date"];
            [dataStore.currentSession setValue:timeString forKey:@"time"];
            
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
            
            [self saveData];
        }

    }
}

//Support function fpr Practice Timer
-(void)oneRound //Add one minute to timer
{
    iTotalTime++;
    sDuration = [NSString stringWithFormat:@"%i min",iTotalTime];
    
    if(bDisplayTimer)
    {
        timerDisplay.text = sDuration;
    }
}

//Support function fpr Practice Timer
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

//Change Repetition Counter
-(IBAction)counterBtn:(UIButton *)button
{
    //Which button?
    NSInteger iTag = button.tag;
    
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

//Start or Stop Metronome
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

//Support function for metronome
-(void)Beat  //Runs on each click
{
    AudioServicesPlaySystemSound(Click);
}

//Support function for metronome
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
    nomeDisplay.text = [NSString stringWithFormat:@"%03lu",(unsigned long)setting];
    
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




//Start or Stop Drone Tone
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

//Support function for Drone Tone
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


//Save session data to record storage
-(void)saveData
{
    //Save final duration to current session object
    [dataStore.currentSession setValue:sDuration forKey:@"duration"];
    
    //Save any repetitions from counter to current session object
    [dataStore.currentSession setValue:counterDisplay.text forKey:@"repetitions"];
    
    //Add current session to the records
    [dataStore.sessions addObject:dataStore.currentSession];
    
    //Switch to view data for debug
    if(false)
    {
        //Log data from session being saved
        NSLog(@"Topic: %@", [dataStore.currentSession objectForKey: @"topic"]);
        NSLog(@"Date: %@", [dataStore.currentSession objectForKey: @"date"]);
        NSLog(@"Start: %@", [dataStore.currentSession objectForKey: @"time"]);
        NSLog(@"Duration: %@", [dataStore.currentSession objectForKey: @"duration"]);
        NSLog(@"Notes: %@", [dataStore.currentSession objectForKey: @"notes"]);
        NSLog(@"Tempo %@", [dataStore.currentSession objectForKey: @"tempo"]);
        NSLog(@"BPM: %@", [dataStore.currentSession objectForKey: @"bpm"]);
        NSLog(@"Key: %@", [dataStore.currentSession objectForKey: @"key"]);
        NSLog(@"Bowing: %@", [dataStore.currentSession objectForKey: @"bowing"]);
        NSLog(@"Repetitions: %@", [dataStore.currentSession objectForKey: @"repetitions"]);
    }
    
    //Save as a JSON file
    if ([NSJSONSerialization isValidJSONObject: dataStore.sessions]) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject: dataStore.sessions options: NSJSONWritingPrettyPrinted error: NULL];
        [jsonData writeToFile:dataStore.jsonPath atomically:YES];
    }else
    {
        NSLog (@"can't save as JSON");
        NSLog(@"%@", [dataStore.sessions description]);
    }
    
    //Retrieve data from local file
    [self getData];
    
    //Clear the slate, prepare for new session
    [self freshSession];
    

}


-(void)freshSession
{
    
    [dataStore.currentSession setValue:@"" forKey:@"topic"];
    
    [dataStore.currentSession  setValue:@"" forKey:@"date"];
    [dataStore.currentSession  setValue:@"" forKey:@"time"];
    
    [dataStore.currentSession  setValue:@"" forKey:@"duration"];
    [dataStore.currentSession  setValue:@"" forKey:@"repetitions"];
    
    [dataStore.currentSession  setValue:@"0" forKey:@"bpm"];
    [dataStore.currentSession  setValue:@"" forKey:@"tempo"];
    [dataStore.currentSession  setValue:@"" forKey:@"key"];
    [dataStore.currentSession  setValue:@"" forKey:@"bowing"];
    [dataStore.currentSession  setValue:@"" forKey:@"notes"];
     
    //Refresh topic display
    //topicDisplay.text = @"";
    [self displayData];
    
    
    //Initialize Duration Timer
    iTotalTime = 0;
    timerDisplay.text = @"-";
    bDisplayTimer = TRUE;
    
    //Initialize Repetition Counter
    iTotalCount = 0;
    counterDisplay.text = [NSString stringWithFormat:@"%i",iTotalCount];
    
    //Kill any metronome
    if(bNome){[self Metronome];}
    
    //Kill any drone
    if(bDrone){[self Drone];}
    
    //Show splash and fade
    splashScreen.hidden = false;
    
    [self hideSplash];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
        SetupViewController *destViewController = segue.destinationViewController;

        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
}
@end
