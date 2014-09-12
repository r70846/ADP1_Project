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
