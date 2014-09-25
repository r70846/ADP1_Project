//
//  DataStore.h
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

#import <Foundation/Foundation.h>

@interface DataStore : NSObject
{
    
}

+ (DataStore *) sharedInstance;

@property (nonatomic, strong)NSMutableArray *sessions;
@property (nonatomic, strong)NSMutableArray *sorter;
@property (nonatomic, strong)NSMutableDictionary *currentSession;
@property (nonatomic, strong)NSString *jsonPath;
@property (nonatomic, strong)NSString *csvPath;

@end
