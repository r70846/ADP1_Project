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
    topicActionSheet.tag = 1;

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
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)chooseTopic
{
    [topicActionSheet showInView:self.view];
    //[topicActionSheet showFromTabBar:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if(buttonIndex < [topicArray count])
        {
            dataStore.currentTopic = [topicArray objectAtIndex:buttonIndex];
            topicDisplay.text = dataStore.currentTopic;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
