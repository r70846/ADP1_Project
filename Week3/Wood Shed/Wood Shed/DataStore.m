//
//  DataStore.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/12/14.
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

#import "DataStore.h"

@implementation DataStore

static DataStore *_sharedInstance;


- (id) init
{
	if (self = [super init])
	{
        //Built mutable array to hold gig dates (GigDateClass objects)
        _sessions = [[NSMutableArray alloc] init];
        
        //Create "Session" Dictionary Object to hold session data
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
        
        

        //DATA STOREAGE
        
        //find document directory, get the path to the document directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString *path = (NSString*)[paths objectAtIndex:0];
        
        //Log documents path
        //NSLog(@"%@", path);
        
        //get path to my local json data file
        _jsonPath = [path stringByAppendingPathComponent:@"datalog.json"];
        
        //get path to my local csv data file
        _csvPath = [path stringByAppendingPathComponent:@"datalog.csv"];

	}
	return self;
}



+ (DataStore *) sharedInstance
{
	if (!_sharedInstance)
	{
		_sharedInstance = [[DataStore alloc] init];
	}
    
	return _sharedInstance;
}



@end
