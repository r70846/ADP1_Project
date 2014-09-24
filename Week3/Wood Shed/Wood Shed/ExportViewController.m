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

    //Hide graphic
    brandImage.hidden = true;
    
    
    //find document directory, get the path to the document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *path = (NSString*)[paths objectAtIndex:0];
    
    //get path to my local data file
    csvPath = [path stringByAppendingPathComponent:@"datalog.csv"];

    
    
    [self createCSVFile];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    messageLabel.text = @"";
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createCSVFile
{
    
    int asciiCode = 184;
    NSString *string = [NSString stringWithFormat:@"%c", asciiCode];
    
    NSString *sDetails = [[NSString alloc] initWithFormat:@"Topic,Date,Time,Duration,Repetitions,Tempo,Key,Bowing,Notes%@%@",string,@"Notes\n"];
 
    /*
    for (NSInteger i=0; i<255; i++)
    {
        NSLog(@"%i %@", i, [NSString stringWithFormat:@"%c", i]);
    }
     
     */
    /*
    
    for (NSInteger i=0; i<[dataStore.sessions count]; i++)
    {
        
        //Verify all data and format for popup display
        NSString *sTopic = [[NSMutableString alloc] init];    // Check for "topic" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"topic"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"topic"] isEqual: @""])
        {
            sTopic = [[NSString alloc] initWithFormat:@"%@",[[dataStore.sessions objectAtIndex:i] objectForKey: @"topic"]];
        }else {sTopic = @"";}
        
        NSString *sDate = [[NSMutableString alloc] init];    // Check for "date" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"date"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"date"] isEqual: @""])
        {
            sDate = [[NSString alloc] initWithFormat:@"DATE: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"date"]];
        }else {sDate = @"";}
        
        NSString *sTime = [[NSMutableString alloc] init];    // Check for "time" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"time"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"time"] isEqual: @""])
        {
            sTime = [[NSString alloc] initWithFormat:@"TIME: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"time"]];
        }else {sTime = @"";}
        
        NSString *sDur = [[NSMutableString alloc] init];    // Check for "duration" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"duration"]!= nil)
        {
            sDur = [[NSString alloc] initWithFormat:@"DURATION: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"duration"]];
        }else {sDur = @"";}
        
        NSString *sReps = [[NSMutableString alloc] init];    // Check for "repetitions" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"repetitions"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"repetitions"] isEqual: @"0"])
        {
            sReps = [[NSString alloc] initWithFormat:@"REPETITIONS: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"repetitions"]];
        }else {sReps = @"";}
        
        NSString *sTempo = [[NSMutableString alloc] init];    // Check for "tempo" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"tempo"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"tempo"] isEqual: @""])
        {
            sTempo = [[NSString alloc] initWithFormat:@"TEMPO: %@ = %@ \n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"bpm"],[[dataStore.sessions objectAtIndex:i] objectForKey: @"tempo"]];
        }else {sTempo = @"";}
        
        NSString *sKey = [[NSMutableString alloc] init];    // Check for "key" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"key"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"key"] isEqual: @""])
        {
            sKey = [[NSString alloc] initWithFormat:@"KEY: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"key"]];
        }else {sKey = @"";}
        
        NSString *sBowing = [[NSMutableString alloc] init];    // Check for "bowing" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"bowing"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"bowing"] isEqual: @""])
        {
            sBowing = [[NSString alloc] initWithFormat:@"BOWING: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"bowing"]];
        }else {sBowing = @"";}
        
        NSString *sNotes = [[NSMutableString alloc] init];    // Check for "notes" before reporting
        if([[dataStore.sessions objectAtIndex:i] objectForKey:@"notes"]!= nil && ![[[dataStore.sessions objectAtIndex:i] objectForKey:@"notes"] isEqual: @""])
        {
            sNotes = [[NSString alloc] initWithFormat:@"NOTES: %@\n",[[dataStore.sessions objectAtIndex:i] objectForKey: @"notes"]];
        }else {sNotes = @"";}
        
        //Compile all valid date to a single string for display
        NSString *sDetails = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@%@",sDate, sTime, sDur, sReps, sTempo, sKey, sBowing, sNotes];
    }
        */
        
        //[sDetails writeToFile:csvPath atomically:YES];
        
    [sDetails writeToFile:csvPath atomically:YES encoding:NSASCIIStringEncoding error:nil];

}

-(IBAction)showEmailView{
    
    NSString *sSubject = @"Practice History";
    NSString *sMessage = @"Practice History";
    NSArray *sRecipents = [NSArray arrayWithObject:@"russellmgaspard@yahoo.com"];
    
    MFMailComposeViewController *emailView = [[MFMailComposeViewController alloc] init];
    emailView.mailComposeDelegate = self;
    [emailView setSubject:sSubject];
    [emailView setMessageBody:sMessage isHTML:NO];
    [emailView setToRecipients:sRecipents];
    
    //Get reference to file as data object
    NSData *dFile = [NSData dataWithContentsOfFile:csvPath];
    
    //Attach csv records file to email
    [emailView addAttachmentData:dFile mimeType:@"text/csv" fileName:@"datalog"];
    
    // Show email controller
    [self presentViewController:emailView animated:YES completion:NULL];
    
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



@end
