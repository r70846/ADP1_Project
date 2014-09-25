//
//  ExportViewController.h
//  Wood Shed
//
//  Created by Russell Gaspard on 9/22/14.
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

@interface ExportViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>
{
    //DATA STORAGE
    DataStore *dataStore;    //shared instance of my data store object
    
    //Default email for export
    NSString *defaultEmail;
    
    //Branding Graphic
    IBOutlet UIImageView *brandImage;
    
    //Message Label
    IBOutlet UILabel *messageLabel;
    
    //Email Field
    IBOutlet UITextField *exportEmail;
    
    //Email Button
    IBOutlet UIButton *exportButton;

    //Keep track of where I'm coming from - (Tab Bar |or| Email View)
    Boolean bEmailView;
}

-(IBAction)showEmailView;
-(IBAction)clearData;

-(IBAction)onChange;

-(void)createCSVFile;
-(void)appendToFile:(NSString *)sData;

@end
