//
//  SaveSportDetailInfo.m
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveSportDetailInfo.h"

@implementation SaveSportDetailInfo
/*
+(NSMutableArray *)GetSport_EventInfo :(NSString *)ID{
    
    NSLog(@"ID  %@",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_Event where Sport_ID=%@",ID]];
    
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
        [rs stringForColumn:@"Channel"],@"Channel",[rs stringForColumn:@"Sport_Description"],@"Sport_Description", [rs stringForColumn:@"Screen"],@"Screen", [rs stringForColumn:@"Sound"],@"Sound",[rs stringForColumn:@"HD"],@"HD", [rs stringForColumn:@"ThreeD"],@"ThreeD",nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        //[arr addObject:[rs stringForColumn:@"Reservation"]];
        //[arr addObject:[rs stringForColumn:@"Screen"]];
        //[arr addObject:[rs stringForColumn:@"Sound"]];
        //[arr addObject:[rs stringForColumn:@"HD"]];
        //[arr addObject:[rs stringForColumn:@"ThreeD"]];
       
        
    }
    
    return [arr autorelease];
}*/

+(NSMutableArray *)GetSport_EventInfo :(NSString *)ID withRadius:(NSString *) _radius currentDate:(NSString *)date{
    
    NSLog(@"ID  %@",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4EventID = [[NSMutableArray alloc]init];

    ResultSet *rs;
    if (_radius==nil) {
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select *,abs( substr(sport_date,1,4)||substr(sport_date,6,2) ||substr(sport_date,9,2)) as rdate from Sport_Event where Sport_ID=%@ and rdate>=%@ group by Sport_EventID ORDER by rdate",ID,date]];// and rdate>=%@ 
    }
    else
    {
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select *,abs( substr(sport_date,1,4)||substr(sport_date,6,2) ||substr(sport_date,9,2)) as rdate from Sport_Event where Sport_ID=%@ and rdate>=%@ group by Sport_EventID ORDER by rdate",ID,date]];//and rdate>=%@
    }

    
    
    
   // ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select *,abs( substr(sport_date,1,2)||substr(sport_date,4,2) ||substr(sport_date,7,4)) as rdate from Sport_Event where Sport_ID=%@ AND PubDistance %@ and rdate>%@ group by Sport_EventID ORDER by rdate",ID,_radius,date]];
    
    
   
    
    
    
    NSLog(@"QUERY   %@",rs.query);
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        // NSString *ID = [NSString stringWithFormat:@"%d",[rs intForColumn:@"ID"]];
        //[arr addObject:ID];
        //[arr addObject:[rs stringForColumn:@"Sport_Description"]];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_EventID"],@"Sport_EventID",                                       
                                                nil];
        
        [arr4EventID addObject:tempDictionary];
        [tempDictionary release];        
        
    }
    
    
    //for (int i =0; i<[arr4EventID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from Sport_Event where Sport_EventID in %@ group by Sport_EventID",[arr4EventID  valueForKey:@"Sport_EventID"]]];
        
        NSLog(@"1  %@ QUERY  %@",rs,[NSString stringWithFormat:@"select distinct * from Sport_Event where Sport_EventID in %@ group by Sport_EventID",[arr4EventID  valueForKey:@"Sport_EventID"]]);
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"Sport_EventName"],@"Sport_EventName", 
                                                   [rs stringForColumn:@"Sport_ID"],@"Sport_ID", 
                                                   [rs stringForColumn:@"Sport_EventID"],@"Sport_EventID",                                       
                                                   [rs stringForColumn:@"Sport_Date"],@"Sport_Date",
                                                   [rs stringForColumn:@"Time"],@"Time",
                                                   [rs stringForColumn:@"Type"],@"Type",
                                                   [rs stringForColumn:@"Channel"],@"Channel",
                                                   [rs stringForColumn:@"PubID"],@"PubID",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    //}
    
    [arr4EventID release];
    
    return [arr autorelease];
}
/*
+(NSMutableArray *)GetSport_EventInfo_Details :(int)Pubid  {
    
    //NSLog(@"ID  %d",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_Event where PubID=%d",Pubid]];
    
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
                                               nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    return [arr autorelease];
}*/

+(NSMutableArray *)GetSport_EventInfo_Details :(int)Pubid Sport_EventID:(int)SportEventID _id:(int )_ID  {
    
    //NSLog(@"ID  %d",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_Event where PubID=%d and Sport_ID=%d and Sport_EventID=%d",Pubid,SportEventID,_ID]];
    
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
                                               nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    return [arr autorelease];
}


@end
