//
//  ViewController.h
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

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "DataStore.h"
#import "SetupViewController.h"

@interface ViewController : UIViewController
{
    
    //Provide access to Splash Screen
    IBOutlet UIImageView *splashScreen;
    
    NSTimer *fadeTimer;
    float fAlpha;
    

    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    //DISPLAY PRACTICE TASKS
    IBOutlet UITextField *topicDisplay;
    IBOutlet UITextView *detailsDisplay;
    
    //TIMER
    IBOutlet UITextField *timerDisplay;
    IBOutlet UIButton *beginButton;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *endButton;
    IBOutlet UIButton *viewButton;
    
    int iTotalTime;
    NSString *sDuration;
    NSTimer *durationTimer;
    Boolean bDisplayTimer;
    Boolean bPractice;
    
    //COUNTER
    IBOutlet UITextField *counterDisplay;
    IBOutlet UIButton *plusButton;
    IBOutlet UIButton *minusButton;
    int iTotalCount;
    
    //TONE GENERATOR
    //two audio players and a timer will create identical overlaping loops
    //two looping copies of the same wav file started at a time offest produce the drone
    AVAudioPlayer *drone1;
    AVAudioPlayer *drone2;
    IBOutlet UITextField *droneDisplay;
    NSMutableArray *keyArray;
    Boolean bDrone;
    
    
    IBOutlet UIStepper *droneStepper;
    
    IBOutlet UIButton *droneButton;
    
    //METRONOME
    SystemSoundID Click;
    NSTimer *nomeTimer;
    int BPM;
    Boolean bNome;
    
    IBOutlet UITextField *nomeDisplay;
    IBOutlet UIStepper *stepperOne;
    IBOutlet UIStepper *stepperTen;
    IBOutlet UIButton *nomeButton;
}


//Setup Data & Tools
-(void)getData;
-(IBAction)hideSplash;
-(void)setUpMetronome;
-(void)setUpDrone;
-(void)displayData;

//Timer
-(IBAction)BeginPractice;
-(IBAction)displayTimer;

//Counter
-(IBAction)counterBtn:(UIButton *)button;

//Metronome
-(IBAction)Metronome;
-(IBAction)stepperChange:(UIStepper *)sender;

//Drone
-(IBAction)Drone;
-(IBAction)droneStepperChange:(UIStepper *)sender;

//Save Data
-(void)saveData;

//Start fresh after save
-(void)freshSession;


@end
