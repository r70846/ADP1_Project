//
//  HistoryViewController.m
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
        
        //Show title, date anad time in cell
        cell.textLabel.text = [dCurrentSession objectForKey: @"topic"];
        cell.detailTextLabel.text = dateTime;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create "Session" Dictionary to hold data
    NSMutableDictionary *dCurrentSession = [[NSMutableDictionary alloc]init];
    dCurrentSession = (NSMutableDictionary *)[dataStore.sessions objectAtIndex:indexPath.row];
    
 /*
Topic: Major Scale
Date: 9/18/14
Start: 4:50 AM
Duration: 0 min
Notes: Hi
Tempo Quarter Note
BPM: 040
Key: D
Bowing: Shuffle
Repetitions: 3
    
  _currentSession = [[NSMutableDictionary alloc]init];
  
  [_currentSession setValue:@"" forKey:@"topic"];
  
  [_currentSession setValue:@"" forKey:@"date"];
  [_currentSession setValue:@"" forKey:@"time"];
  
  [_currentSession setValue:@"" forKey:@"duration"];
  [_currentSession setValue:@"" forKey:@"repetitions"];
  
  [_currentSession setValue:@"0" forKey:@"bpm"];
  [_currentSession setValue:@"" forKey:@"tempo"];
  [_currentSession setValue:@"" forKey:@"key"];
  [_currentSession setValue:@"" forKey:@"bowing"];
  [_currentSession setValue:@"" forKey:@"notes"];
  
  NSLog(@"Topic: %@", [dataStore.currentSession objectForKey: @"topic"]);
  NSLog(@"Date: %@", [dataStore.currentSession objectForKey: @"date"]);
  NSLog(@"Start: %@", [dataStore.currentSession objectForKey: @"time"]);
  NSLog(@"Duration: %@", [dataStore.currentSession objectForKey: @"duration"]);
  NSLog(@"Repetitions: %@", [dataStore.currentSession objectForKey: @"repetitions"]);
  NSLog(@"Tempo %@", [dataStore.currentSession objectForKey: @"tempo"]);
  NSLog(@"BPM: %@", [dataStore.currentSession objectForKey: @"bpm"]);
  NSLog(@"Key: %@", [dataStore.currentSession objectForKey: @"key"]);
  NSLog(@"Bowing: %@", [dataStore.currentSession objectForKey: @"bowing"]);
  NSLog(@"Notes: %@", [dataStore.currentSession objectForKey: @"notes"]);
  
  //Display topic
  topicDisplay.text = [dataStore.currentSession objectForKey: @"topic"];
  
  
  //Build NOTES string
  NSString *sNotes = [[NSMutableString alloc] init];
  if(![[dataStore.currentSession objectForKey: @"notes"] isEqual: @""])
  {
  sNotes = [[NSString alloc] initWithFormat:@"NOTES: %@\n",[dataStore.currentSession objectForKey: @"notes"]];
  }
  else {sNotes = @"";}
  
  //Build TEMPO string
  NSString *sTempo = [[NSMutableString alloc] init];
  if(![[dataStore.currentSession objectForKey: @"tempo"] isEqual: @""])
  {
  sTempo = [[NSString alloc] initWithFormat:@"TEMPO: %@ = %@\n",[dataStore.currentSession objectForKey: @"tempo"], [dataStore.currentSession objectForKey: @"bpm"]];
  }
  else {sTempo = @"";}
  
  //Build KEY string
  NSString *sKey = [[NSMutableString alloc] init];
  if(![[dataStore.currentSession objectForKey: @"key"] isEqual: @""])
  {
  sKey = [[NSString alloc] initWithFormat:@"KEY: %@\n",[dataStore.currentSession objectForKey: @"key"]];
  }
  else {sKey = @"";}
  
  //Build BOWING string
  NSString *sBowing = [[NSMutableString alloc] init];
  if(![[dataStore.currentSession objectForKey: @"bowing"] isEqual: @""])
  {
  sBowing = [[NSString alloc] initWithFormat:@"BOWING: %@\n",[dataStore.currentSession objectForKey: @"bowing"]];
  }
  else {sBowing = @"";}
  
  NSString *sDetails = [[NSString alloc] initWithFormat:@"%@%@%@%@",sTempo, sKey, sBowing, sNotes];
  
  //Display other tags in "details" text view
  detailsDisplay.text = sDetails;
*/
    
    
    
	NSString *sTopic = [[NSMutableString alloc] init];    // Check for "topic" before reporting
    if([dCurrentSession objectForKey:@"topic"]!= nil && ![[dCurrentSession objectForKey:@"topic"] isEqual: @""])
    {
		sTopic = [[NSString alloc] initWithFormat:@"%@",[dCurrentSession objectForKey: @"topic"]];
	}else {sTopic = @"";}
    
	NSString *sDate = [[NSMutableString alloc] init];    // Check for "date" before reporting
    if([dCurrentSession objectForKey:@"date"]!= nil && ![[dCurrentSession objectForKey:@"date"] isEqual: @""])
    {
		sDate = [[NSString alloc] initWithFormat:@"DATE: %@\n",[dCurrentSession objectForKey: @"date"]];
	}else {sDate = @"";}
    
	NSString *sTime = [[NSMutableString alloc] init];    // Check for "time" before reporting
    if([dCurrentSession objectForKey:@"time"]!= nil && ![[dCurrentSession objectForKey:@"time"] isEqual: @""])
    {
		sTime = [[NSString alloc] initWithFormat:@"TIME: %@\n",[dCurrentSession objectForKey: @"time"]];
	}else {sTime = @"";}
    
	NSString *sDur = [[NSMutableString alloc] init];    // Check for "duration" before reporting
    if([dCurrentSession objectForKey:@"duration"]!= nil)
    {
		sDur = [[NSString alloc] initWithFormat:@"DURATION: %@\n",[dCurrentSession objectForKey: @"duration"]];
	}else {sDur = @"";}
    
	NSString *sReps = [[NSMutableString alloc] init];    // Check for "repetitions" before reporting
    if([dCurrentSession objectForKey:@"repetitions"]!= nil && ![[dCurrentSession objectForKey:@"repetitions"] isEqual: @"0"])
    {
		sReps = [[NSString alloc] initWithFormat:@"REPETITIONS: %@\n",[dCurrentSession objectForKey: @"repetitions"]];
	}else {sReps = @"";}
    
	NSString *sTempo = [[NSMutableString alloc] init];    // Check for "tempo" before reporting
    if([dCurrentSession objectForKey:@"tempo"]!= nil && ![[dCurrentSession objectForKey:@"tempo"] isEqual: @""])
    {
		sTempo = [[NSString alloc] initWithFormat:@"TEMPO: %@ = %@ \n",[dCurrentSession objectForKey: @"bpm"],[dCurrentSession objectForKey: @"tempo"]];
	}else {sTempo = @"";}
    
	NSString *sKey = [[NSMutableString alloc] init];    // Check for "key" before reporting
    if([dCurrentSession objectForKey:@"key"]!= nil && ![[dCurrentSession objectForKey:@"key"] isEqual: @""])
    {
		sKey = [[NSString alloc] initWithFormat:@"KEY: %@\n",[dCurrentSession objectForKey: @"key"]];
	}else {sKey = @"";}
    
	NSString *sBowing = [[NSMutableString alloc] init];    // Check for "bowing" before reporting
    if([dCurrentSession objectForKey:@"bowing"]!= nil && ![[dCurrentSession objectForKey:@"bowing"] isEqual: @""])
    {
		sBowing = [[NSString alloc] initWithFormat:@"BOWING: %@\n",[dCurrentSession objectForKey: @"bowing"]];
	}else {sBowing = @"";}
    
	NSString *sNotes = [[NSMutableString alloc] init];    // Check for "notes" before reporting
    if([dCurrentSession objectForKey:@"notes"]!= nil && ![[dCurrentSession objectForKey:@"notes"] isEqual: @""])
    {
		sNotes = [[NSString alloc] initWithFormat:@"NOTES: %@\n",[dCurrentSession objectForKey: @"notes"]];
	}else {sNotes = @"";}
	
  	NSString *sDetails = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@%@",sDate, sTime, sDur, sReps, sTempo, sKey, sBowing, sNotes];
    
   UIAlertView *detailPopup = [[UIAlertView alloc] initWithTitle:sTopic message:sDetails delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //Display alert view
    [detailPopup show];
}


@end
