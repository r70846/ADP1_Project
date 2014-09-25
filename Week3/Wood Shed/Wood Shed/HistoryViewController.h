//
//  HistoryViewController.h
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

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    IBOutlet  UITableView *mainTableView;
}


@property (strong, nonatomic) IBOutlet UISegmentedControl * segSorter;

//Clicked control
- (IBAction)segControlClicked:(id)sender;

//Save Data
-(void)sortByTopic;

@end
