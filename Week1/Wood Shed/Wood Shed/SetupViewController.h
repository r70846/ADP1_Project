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
 Week 1
 
 */

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface SetupViewController : UIViewController <UIActionSheetDelegate>

{
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    IBOutlet UITextField *topicDisplay;
    IBOutlet UIButton *topicButton;
    NSMutableArray *topicArray;
    UIActionSheet *topicActionSheet;
}


-(IBAction)chooseTopic;


@end
