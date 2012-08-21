//
//  SaveEventMicrositeInfo.m
//  PubAndBar
//
//  Created by Apple on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveEventMicrositeInfo.h"
#import "Event_Microsite.h"

@implementation SaveEventMicrositeInfo


+(NSMutableArray *)GetEvent_DetailsInfo:(int)Pubid EventType:(int)eventType{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Event_Detail where PubID=%d and Event_Type=%d group by ID,Event_Description",Pubid,eventType]];
    
    NSLog(@"%@ %d",rs,Pubid);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",
                                               [rs stringForColumn:@"ID"],@"ID",nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [arr autorelease];
}

@end
