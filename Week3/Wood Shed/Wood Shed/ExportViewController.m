//
//  ExportViewController.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/22/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import "ExportViewController.h"
#import <MessageUI/MessageUI.h>

@interface ExportViewController () <MFMailComposeViewControllerDelegate>


@end

@implementation ExportViewController

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
    
    //To indicate email view
    bEmailView = false;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    if(bEmailView){  //If we're coming from Email View
        
        //Hide branding graphic
        brandImage.hidden = true;
        
        //Track status - No longer in Email View
        bEmailView = false;
    }
    else            //Coming from Tab Bar Controller
    {
        
        //Rebuild comma delimited data file
        [self createCSVFile];
        
        //Show graphic and hide message
        brandImage.hidden = false;
        messageLabel.text = @"";
    }


    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createCSVFile
{
    
    
    //Write header to file - overwrites old or create if absent
    NSString *sHeader = @"Topic,Date,Time,Duration,Repetitions,Tempo,Key,Bowing,Notes\n";
    [sHeader writeToFile:dataStore.csvPath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    //Loop through practice sessions data
    for (NSInteger i=0; i<[dataStore.sessions count]; i++)
    {
        //Verify all data and format for csv
        NSString *sTopic = [[NSMutableString alloc] init];    // Check for "topic" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"topic"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"topic"] isEqual: @""])
        {
            sTopic = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"topic"]];
        }else {sTopic = @",";}
        
        NSString *sDate = [[NSMutableString alloc] init];    // Check for "date" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"date"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"date"] isEqual: @""])
        {
            sDate =[[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"date"]];
        }else {sDate = @",";}
        
        NSString *sTime = [[NSMutableString alloc] init];    // Check for "time" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"time"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"time"] isEqual: @""])
        {
            sTime = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"time"]];
        }else {sTime = @",";}
        
        NSString *sDur = [[NSMutableString alloc] init];    // Check for "duration" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"duration"]!= nil)
        {
            sDur = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"duration"]];
        }else {sDur = @",";}
        
        NSString *sReps = [[NSMutableString alloc] init]; // Check for "repetitions"
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"repetitions"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"repetitions"] isEqual: @"0"])
        {
            sReps = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"repetitions"]];
        }else {sReps = @",";}
        
        NSString *sTempo = [[NSMutableString alloc] init];    // Check for "tempo" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"tempo"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"tempo"] isEqual: @""])
        {
            sTempo = [[NSString alloc] initWithFormat:@"%@ = %@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"bpm"],[[dataStore.sessions objectAtIndex:i] objectForKey: @"tempo"]];
        }else {sTempo = @",";}
         
        NSString *sKey = [[NSMutableString alloc] init];    // Check for "key" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"key"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"key"] isEqual: @""])
        {
            sKey = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"key"]];
        }else {sKey = @",";}
        
        NSString *sBowing = [[NSMutableString alloc] init];    // Check for "bowing" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"bowing"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"bowing"] isEqual: @""])
        {
            sBowing = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"bowing"]];
        }else {sBowing = @",";}
        
        NSString *sNotes = [[NSMutableString alloc] init];    // Check for "notes" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"notes"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"notes"] isEqual: @""])
        {
            sNotes = [[NSString alloc] initWithFormat:@"%@,",[[dataStore.sessions objectAtIndex:i] objectForKey: @"notes"]];
        }else {sNotes = @",";}
        
        //Compile all valid date to a single string for display
        NSString *sDetails = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@%@%@\n", sTopic,sDate, sTime, sDur, sReps, sTempo, sKey, sBowing, sNotes];
        
        //Add row to current data
        [self appendToFile:sDetails];
    }
}


-(void)appendToFile:(NSString *)sData
{
    NSFileHandle *oHandle = [NSFileHandle fileHandleForWritingAtPath:dataStore.csvPath];
    [oHandle seekToEndOfFile];
    [oHandle writeData:[sData dataUsingEncoding:NSUTF8StringEncoding]];
}

-(IBAction)showEmailView{
    
    if([dataStore.sessions count] > 0)
    {
        NSString *sSubject = @"Practice History";
        NSString *sMessage = @"Practice History";
        NSArray *sRecipents = [NSArray arrayWithObject:@"russellmgaspard@yahoo.com"];
    
        MFMailComposeViewController *emailView = [[MFMailComposeViewController alloc] init];
        emailView.mailComposeDelegate = self;
        [emailView setSubject:sSubject];
        [emailView setMessageBody:sMessage isHTML:NO];
        [emailView setToRecipients:sRecipents];
    
        //Get reference to file as data object
        NSData *dFile = [NSData dataWithContentsOfFile:dataStore.csvPath];
    
        //Attach csv records file to email
        [emailView addAttachmentData:dFile mimeType:@"csv" fileName:@"datalog"];
    
        // Show email controller
        [self presentViewController:emailView animated:YES completion:NULL];
    
        //To indicate email view
        bEmailView = true;
    }
    else
    {
        //Hide graphic and show message
        brandImage.hidden = true;
        messageLabel.text = @"No Records\n Available";
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            messageLabel.text = @"Export to Email\n Cancelled";
            break;
        case MFMailComposeResultSaved:
            messageLabel.text = @"Export to Email\n Saved";
            break;
        case MFMailComposeResultSent:
            messageLabel.text = @"Export to Email\n Sent";
            break;
        case MFMailComposeResultFailed:
            messageLabel.text = [error localizedDescription];
            break;
        default:
            break;
    }
    
    // Dismiss Email View
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)clearData
{
    NSString *sMessage = @"Are you sure you want to clear all practice records from Wood Shed?";
    
    //Create alert view
    UIAlertView *noTopicAlert = [[UIAlertView alloc] initWithTitle:@"Delete Records?" message:sMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
    
    //Display alert view
    [noTopicAlert show];
    
}

//User response to Clear Data Confirmation Alert...
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)  //[ CANCELLED ]
    {
        brandImage.hidden = false;
        messageLabel.text = @"";
    }
    else                    //[ CONFIRMED ]
    {
        //Clear all session data from main array
        [dataStore.sessions removeAllObjects];
        
        //Save empty array to file
        if ([NSJSONSerialization isValidJSONObject: dataStore.sessions]) {
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject: dataStore.sessions options: NSJSONWritingPrettyPrinted error: NULL];
            [jsonData writeToFile:dataStore.jsonPath atomically:YES];
        }else
        {
            NSLog (@"Export View: can't save as JSON");
        }

        //Hide graphic and show message
        brandImage.hidden = true;
        messageLabel.text = @"Practice Records\n Cleared";
    }
}

@end
