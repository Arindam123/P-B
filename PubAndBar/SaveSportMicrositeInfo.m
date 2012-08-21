//
//  SaveSportMicrositeInfo.m
//  PubAndBar
//
//  Created by Apple on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveSportMicrositeInfo.h"
#import "Sport_Microsite.h"

@implementation SaveSportMicrositeInfo


+(NSMutableArray *)GetSport_EventInfo_Details :(int)Pubid Sport_EventID:(int)SportEventID{
    
    //NSLog(@"ID  %d",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"dd-MM-yyyy"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [dateFormatToday release];   
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_Event where PubID=%d and Sport_EventID=%d group by Sport_EventID",Pubid,SportEventID]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        // NSString *ID = [NSString stringWithFormat:@"%d",[rs intForColumn:@"ID"]];
        //[arr addObject:ID];
        //[arr addObject:[rs stringForColumn:@"Sport_Description"]];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[rs stringForColumn:@"Sport_EventName"],@"Sport_EventName", 
                                               [rs stringForColumn:@"Sport_ID"],@"Sport_ID",                                     
                                               [rs stringForColumn:@"Sport_Date"],@"Sport_Date",
                                               [rs stringForColumn:@"Time"],@"Time",
                                               [rs stringForColumn:@"Type"],@"Type",
                                               [rs stringForColumn:@"Channel"],@"Channel",
                                               [rs stringForColumn:@"Sport_Description"],@"Sport_Description",
                                               [rs stringForColumn:@"Screen"],@"Screen",
                                               [rs stringForColumn:@"Sound"],@"Sound",
                                               [rs stringForColumn:@"HD"],@"HD",
                                               [rs stringForColumn:@"ThreeD"],@"ThreeD",
                                               [rs stringForColumn:@"Sport_EventID"],@"Sport_EventID",
                                               nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    return [arr autorelease];
}





@end
