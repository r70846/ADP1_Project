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
 Week 1
 
 */

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "DataStore.h"

@interface ViewController : UIViewController
{
    
    //Provide access to Splash Screen
    IBOutlet UIImageView *splashScreen;
    
    NSTimer *fadeTimer;
    float fAlpha;
    

    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    NSString *localPath;     //Variable to access my local data file
    
    
    //DATA TRACKING GENERATED FROM MAIN UI
    NSDate *currentDate;
    NSString *dateString;
    NSString *timeString;
    
    
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

-(IBAction)hideSplash;

-(IBAction)BeginPractice;
-(IBAction)displayTimer;

-(void)saveData;

-(IBAction)counterBtn:(UIButton *)button;


-(IBAction)Metronome;
-(IBAction)stepperChange:(UIStepper *)sender;

-(IBAction)Drone;
-(IBAction)droneStepperChange:(UIStepper *)sender;

@end
