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
 Week 1
 
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
    
    
    // TOPIC ////////////////////////////////
    
    //Create Array to hold all possible topics
    topicArray = [[NSMutableArray alloc] init];
	[topicArray addObject:@"Major Scale"];
	[topicArray addObject:@"Natural Minor Scale"];
	[topicArray addObject:@"Harmonic Minor Scale"];
	[topicArray addObject:@"Melodic Minor Scale"];

    
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

    //Add cancel button on the end
    topicActionSheet.cancelButtonIndex = [topicActionSheet addButtonWithTitle:@"Cancel"];
    
    //This is a bit of a hack but effective...
    //Bottom button can't be clicked due to tab bar in the superview
    //Adding a blank button at the bottom makes others accessible
    [topicActionSheet addButtonWithTitle:@""];
    
    // NOTES //////////////////////////////////
    
    [notesField setDelegate:self];
    
    [topicDisplay setDelegate:self];
    //notesField.delegate = self;
    
    // TEMPO //////////////////////////////////
    
    //Set BPM to stepper setting
    [self stepperChange:nil];
    
    //Create Array to hold possible note types for tempo indication
    tempoArray = [[NSMutableArray alloc] init];
	[tempoArray addObject:@"Quarter"];
	[tempoArray addObject:@"Eighth"];
	[tempoArray addObject:@"Sixteenth"];
	[tempoArray addObject:@"Half Note (1 & 3)"];
	[tempoArray addObject:@"Half Note (2 & 4)"];
	[tempoArray addObject:@"Whole"];
	[tempoArray addObject:@"No Tempo"];

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
    
    
    // KEY ///////////////////////////////////
    
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
    
    // BOWING /////////////////////////////
    
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

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    bpmDisplay.text = [NSString stringWithFormat:@"%03d",setting];

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
            dataStore.currentTopic = [topicArray objectAtIndex:buttonIndex];
            topicDisplay.text = dataStore.currentTopic;
        }
    }
    if (actionSheet.tag == 200) {               //Tempo
        if(buttonIndex < [tempoArray count])
        {
            dataStore.tempoNoteType = [tempoArray objectAtIndex:buttonIndex];
            noteTypeDisplay.text = dataStore.tempoNoteType;
        }
    }
    if (actionSheet.tag == 300) {               //Key
        if(buttonIndex < [keyArray count])
        {
            dataStore.key = [keyArray objectAtIndex:buttonIndex];
            keyDisplay.text = dataStore.key;
        }
    }
    if (actionSheet.tag == 400) {               //Bowing
        if(buttonIndex < [keyArray count])
        {
            dataStore.bowing = [bowingArray objectAtIndex:buttonIndex];
            bowingDisplay.text = dataStore.bowing;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
@end
