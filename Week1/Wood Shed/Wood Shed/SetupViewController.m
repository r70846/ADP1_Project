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
    
    //Inititlaize
    _currentTopic = @"";
    
    
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

    //Add cancel button one the end
    topicActionSheet.cancelButtonIndex = [topicActionSheet addButtonWithTitle:@"Cancel"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)chooseTopic
{
    [topicActionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        _currentTopic = [topicArray objectAtIndex:buttonIndex];
        topicDisplay.text = _currentTopic;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
