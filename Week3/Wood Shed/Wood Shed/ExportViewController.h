//
//  ExportViewController.h
//  Wood Shed
//
//  Created by Russell Gaspard on 9/22/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface ExportViewController : UIViewController <UIAlertViewDelegate>
{
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    
    //Branding Graphic
    IBOutlet UIImageView *brandImage;
    
    //Message Label
    IBOutlet UILabel *messageLabel;
    
    //Email Field
    IBOutlet UITextField *exportEmail;
    
    //Email Button
    IBOutlet UIButton *exportButton;
    
    //Path to csv data file
    NSString *csvPath;     //Variable to access my csv data file
    
    
    
    Boolean bEmailView;
}

-(IBAction)showEmailView;
-(IBAction)clearData;
-(void)createCSVFile;
-(void)appendToFile:(NSString *)sData;

@end
