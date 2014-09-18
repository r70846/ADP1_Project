//
//  DataStore.m
//  Wood Shed
//
//  Created by Russell Gaspard on 9/12/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

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
