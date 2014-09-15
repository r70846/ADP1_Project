//
//  HistoryViewController.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/11/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

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

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //NSLog(@"Total Records: %i", [dataStore.sessions count]);
    [self->mainTableView reloadData]; // to reload selected cell
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Number of rows in table will equal the number of session objects in my data array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [dataStore.sessions count];
    
}

//Set each custom cell to reflect data from the same index of my dictionary "session" objects array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProtoCell"];
    
    if (cell != nil)
    {
        //PracticeSession *currentSession = [aPracticeArray objectAtIndex:indexPath.row];
        //[cell refreshCellWithInfo:currentSession.topic instString:currentMusician.instrument cellImage:currentMusician.instImage];
        
        //dataStore.sessions
        
        //Create "Session" Dictionary to hold data
        NSMutableDictionary *dCurrentSession = [[NSMutableDictionary alloc]init];
        dCurrentSession = (NSMutableDictionary *)[dataStore.sessions objectAtIndex:indexPath.row];

        //Combine date and time into single string
        NSString *dateTime = [[NSString alloc] initWithFormat:@"%@ %@",[dCurrentSession objectForKey: @"date"],[dCurrentSession objectForKey: @"time"]];
        
        //Shoe title, date anad time in cell
        cell.textLabel.text = [dCurrentSession objectForKey: @"topic"];
        cell.detailTextLabel.text = dateTime;
        
    }
    return cell;
}

@end
