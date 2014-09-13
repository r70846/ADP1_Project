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

@interface SetupViewController : UIViewController <UIActionSheetDelegate>

{
    IBOutlet UITextField *topicDisplay;
    IBOutlet UIButton *topicButton;
    NSMutableArray *topicArray;
    UIActionSheet *topicActionSheet;
}


-(IBAction)chooseTopic;

@property (nonatomic, strong)NSString *currentTopic;

@end
