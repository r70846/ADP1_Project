//
//  DataStore.h
//  Wood Shed
//
//  Created by Russell Gaspard on 9/12/14.
//  Copyright (c) 2014 Russell Gaspard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject
{
    
}

+ (DataStore *) sharedInstance;

@property (nonatomic, strong)NSMutableArray *sessions;
@property (nonatomic, strong)NSString *currentTopic;
@property (nonatomic, strong)NSString *tempoNoteType;
@property (nonatomic, strong)NSString *key;

@end
