//
//  HistoryViewController.h
//  Wood Shed
//
//  Created by Russell Gaspard on 9/11/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    IBOutlet  UITableView *mainTableView;
}
@end
