//
//  SetupViewController.m
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

#import "SetupViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //setup shared instance of data storage in RAM
    dataStore = [DataStore sharedInstance];
    
    //Disable Input in Fields
    topicDisplay.enabled = false;
    bpmDisplay.enabled = false;
    noteTypeDisplay.enabled = false;
    keyDisplay.enabled = false;
    bowingDisplay.enabled = false;
    
    //Place any Currrent Data in Fields
    topicDisplay.text = [dataStore.currentSession objectForKey: @"topic"];
    notesField.text = [dataStore.currentSession objectForKey: @"notes"];
    bpmDisplay.text = [dataStore.currentSession objectForKey: @"bpm"];
    noteTypeDisplay.text = [dataStore.currentSession objectForKey: @"tempo"];
    keyDisplay.text = [dataStore.currentSession objectForKey: @"key"];
    bowingDisplay.text = [dataStore.currentSession objectForKey: @"bowing"];
    
    //Setup Interface Items
    [self setUpTopicUI];
    [self setUpNotesUI];
    [self setUpTempoUI];
    [self setUpKeyUI];
    [self setUpBowingUI];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if([topicDisplay.text isEqual: @""]) //MUST choose topic if blank
    {
        [topicActionSheet showInView:self.view];
    }
    
    [super viewDidAppear:animated];
}

-(void)setUpTopicUI
{

    //Create Array to hold all possible topics
    topicArray = [[NSMutableArray alloc] init];
	[topicArray addObject:@"Major Scale"];
	[topicArray addObject:@"Natural Minor Scale"];
	[topicArray addObject:@"Harmonic Minor Scale"];
	[topicArray addObject:@"Melodic Minor Scale"];
	[topicArray addObject:@"[ Add New Topic ]"];
    
    //Build "actionsheet" as a drop down menu
    topicActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];
    //Tag it so I can add more later...
    topicActionSheet.tag = 100;
    
    //Add button for each topic in array
    for (NSString *topic in topicArray) {
        [topicActionSheet addButtonWithTitle:topic];
    }
    
    //if(![topicDisplay.text isEqual: @""]) //MUST choose topic if blank
    //{
        //Add cancel button on the end
        topicActionSheet.cancelButtonIndex = [topicActionSheet addButtonWithTitle:@"Cancel"];
    //}
    
    //This is a bit of a hack but effective...
    //Bottom button can't be clicked due to tab bar in the superview
    //Adding a blank button at the bottom makes others accessible
    [topicActionSheet addButtonWithTitle:@""];
    
    //To handle keyboard
    [topicDisplay setDelegate:self];
        
}

-(void)setUpNotesUI
{
    //To handle keyboard
    [notesField setDelegate:self];
}

-(void)setUpTempoUI
{
    //Set BPM to stepper setting
    //[self stepperChange:nil];
    
    //Create Array to hold possible note types for tempo indication
    tempoArray = [[NSMutableArray alloc] init];
	[tempoArray addObject:@"Quarter Note"];
	[tempoArray addObject:@"Eighth Note"];
	[tempoArray addObject:@"Sixteenth Note"];
	[tempoArray addObject:@"Half Note (1 & 3)"];
	[tempoArray addObject:@"Half Note (2 & 4)"];
	[tempoArray addObject:@"Whole Note"];
    
    //Build "actionsheet" as a drop down menu
    tempoActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];
    //Tag it so I can add more later...
    tempoActionSheet.tag = 200;
    
    //Add button for each topic in array
    for (NSString *tempo in tempoArray) {
        [tempoActionSheet addButtonWithTitle:tempo];
    }
    
    //Add cancel button on the end
    tempoActionSheet.cancelButtonIndex = [tempoActionSheet addButtonWithTitle:@"Cancel"];
    
    //Adding a blank button at the bottom makes others accessible
    [tempoActionSheet addButtonWithTitle:@""];
}

-(void)setUpKeyUI{
    //Create Array to hold possible tonics for key indication
    keyArray = [[NSMutableArray alloc] init];
	[keyArray addObject:@"-"];
	[keyArray addObject:@"A"];
	[keyArray addObject:@"A#"];
	[keyArray addObject:@"Bb"];
	[keyArray addObject:@"C"];
	[keyArray addObject:@"C#"];
	[keyArray addObject:@"Db"];
	[keyArray addObject:@"D"];
	[keyArray addObject:@"D#"];
	[keyArray addObject:@"Eb"];
	[keyArray addObject:@"E"];
	[keyArray addObject:@"F"];
	[keyArray addObject:@"F#"];
	[keyArray addObject:@"Gb"];
	[keyArray addObject:@"G"];
	[keyArray addObject:@"G#"];
	[keyArray addObject:@"Ab"];
    
    //Build "actionsheet" as a drop down menu
    keyActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                 delegate:self
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
    //Tag it so I can add more later...
    keyActionSheet.tag = 300;
    
    //Add button for each topic in array
    for (NSString *key in keyArray) {
        [keyActionSheet addButtonWithTitle:key];
    }
    
    //Add cancel button on the end
    keyActionSheet.cancelButtonIndex = [keyActionSheet addButtonWithTitle:@"Cancel"];
    
    //Adding a blank button at the bottom makes others accessible
    [keyActionSheet addButtonWithTitle:@""];
}

-(void)setUpBowingUI{
    //Create Array to hold possible tonics for key indication
    bowingArray = [[NSMutableArray alloc] init];
	[bowingArray addObject:@"Straight"];
	[bowingArray addObject:@"Chain"];
	[bowingArray addObject:@"Jazz"];
	[bowingArray addObject:@"Shuffle"];
    
    //Build "actionsheet" as a drop down menu
    bowingActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                    delegate:self
                                           cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];
    //Tag it so I can add more later...
    bowingActionSheet.tag = 400;
    
    //Add button for each topic in array
    for (NSString *bowing in bowingArray) {
        [bowingActionSheet addButtonWithTitle:bowing];
    }
    
    //Add cancel button on the end
    bowingActionSheet.cancelButtonIndex = [bowingActionSheet addButtonWithTitle:@"Cancel"];
    
    //Adding a blank button at the bottom makes others accessible
    [bowingActionSheet addButtonWithTitle:@""];
}

- (IBAction)stepperChange:(UIStepper *)sender //Change BPM on metronome
{
    
    NSUInteger stepOne = stepperOne.value;
    NSUInteger stepTen = stepperTen.value;
    
    //if its first adjustment, start at 40 BPM
    if([bpmDisplay.text isEqual: @"0"])
    {
        stepperOne.value = 0;
        stepperTen.value = 40;
        
        //Set note type to default
        if([noteTypeDisplay.text isEqual: @""])
        {
            noteTypeDisplay.text = @"Quarter Note";
        }
    }
    else  //Conditionals to coordinate dual steppers
    {
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
    }
    
    //Update display
    stepOne = stepperOne.value;
    stepTen = stepperTen.value;
    NSUInteger setting = stepOne + stepTen;
    bpmDisplay.text = [NSString stringWithFormat:@"%03lu",(unsigned long)setting];

}

-(IBAction)onClick:(UIButton *)button
{
    if(button.tag == 100){[topicActionSheet showInView:self.view];}
    if(button.tag == 200){[tempoActionSheet showInView:self.view];}
    if(button.tag == 300){[keyActionSheet showInView:self.view];}
    if(button.tag == 400){[bowingActionSheet showInView:self.view];}
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {               //Topic
        

        if(buttonIndex < [topicArray count])
        {
            if([[topicArray objectAtIndex:buttonIndex] isEqual:@"[ Add New Topic ]"])
            {
                NSLog(@"NEW");
                topicDisplay.enabled = true;
                [topicDisplay selectAll:nil];
            }
            else
            {
                topicDisplay.text = [topicArray objectAtIndex:buttonIndex];
            }
        }
        else
        {
            if([topicDisplay.text isEqual: @""])
            {
                //MUST choose topic if blank! If no topic dismiss view controller
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    if (actionSheet.tag == 200) {               //Tempo
        if(buttonIndex < [tempoArray count])
        {
            noteTypeDisplay.text = [tempoArray objectAtIndex:buttonIndex];
            
            //If bpm not set yet, setto minimum tempo
            if([bpmDisplay.text isEqual: @"0"])
            {
                [self stepperChange:nil];
            }
        }
    }
    if (actionSheet.tag == 300) {               //Key
        if(buttonIndex < [keyArray count])
        {
            keyDisplay.text = [keyArray objectAtIndex:buttonIndex];
        }
    }
    if (actionSheet.tag == 400) {               //Bowing
        if(buttonIndex < [keyArray count])
        {
            bowingDisplay.text = [bowingArray objectAtIndex:buttonIndex];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


//Return keyboard on return
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//Save data to current record on exit
- (void)viewWillDisappear:(BOOL)animated
{
    //If user has set topc, record data on exit
    if(![topicDisplay.text isEqual: @""])
    {
        [dataStore.currentSession setValue:topicDisplay.text forKey:@"topic"];
        [dataStore.currentSession setValue:notesField.text forKey:@"notes"];
        [dataStore.currentSession setValue:noteTypeDisplay.text forKey:@"tempo"];
        [dataStore.currentSession setValue:bpmDisplay.text forKey:@"bpm"];
        [dataStore.currentSession setValue:keyDisplay.text forKey:@"key"];
        [dataStore.currentSession setValue:bowingDisplay.text forKey:@"bowing"];
    }
    
}
@end
