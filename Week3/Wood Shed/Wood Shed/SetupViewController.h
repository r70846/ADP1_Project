//
//  SetupViewController.h
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
 Final Project
 Week 4
 
 */

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface SetupViewController : UIViewController <UIActionSheetDelegate, UITextViewDelegate, UITextFieldDelegate>

{
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    //TOPIC
    IBOutlet UITextField *topicDisplay;
    IBOutlet UIButton *topicButton;
    NSMutableArray *topicArray;
    UIActionSheet *topicActionSheet;
    
    //NOTES
    IBOutlet UITextView *notesField;
    
    //TEMPO
    IBOutlet UITextField *bpmDisplay;
    IBOutlet UITextField *noteTypeDisplay;
    IBOutlet UIStepper *stepperOne;
    IBOutlet UIStepper *stepperTen;
    IBOutlet UIButton *tempoButton;
    NSMutableArray *tempoArray;
    UIActionSheet *tempoActionSheet;
    
    //KEY
    IBOutlet UITextField *keyDisplay;
    IBOutlet UIButton *keyButton;
    NSMutableArray *keyArray;
    UIActionSheet *keyActionSheet;
    
    //BOWING
    IBOutlet UITextField *bowingDisplay;
    IBOutlet UIButton *bowingButton;
    NSMutableArray *bowingArray;
    UIActionSheet *bowingActionSheet;
    
}

//To set up UI Interface
-(void)setUpTopicUI;
-(void)setUpNotesUI;
-(void)setUpTempoUI;
-(void)setUpKeyUI;
-(void)setUpBowingUI;

-(IBAction)onClick:(UIButton *)button;

-(IBAction)stepperChange:(UIStepper *)sender;


@end
