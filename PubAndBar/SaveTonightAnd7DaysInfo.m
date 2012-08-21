//
//  SaveTonightAnd7DaysInfo.m
//  PubAndBar
//
//  Created by Apple on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveTonightAnd7DaysInfo.h"
#import "PubDetail.h"


@implementation SaveTonightAnd7DaysInfo



+(NSMutableArray *)GetNext7DaysRegularEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
        
    
    NSDate *today = [NSDate date];
     NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    
    
    NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormat release];
    
    NSLog(@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet>%@ and  datet<=%@ and Event_Type=1 and PubID=%d",Today,dateAftersevendays,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail) where datet>=%@ and  datet<=%@ and Event_Type=1 and PubID=%d",Today,dateAftersevendays,Pubid];
  
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",[rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
     return [arr autorelease];
}

+(NSMutableArray *)GetNext7DaysOneOffEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormat release];
    
    NSLog(@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet>%@ and  datet<=%@ and Event_Type=1 and PubID=%d",Today,dateAftersevendays,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet>%@ and  datet<=%@ and Event_Type=2 and PubID=%d",Today,dateAftersevendays,Pubid];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",
                                               [rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}


+(NSMutableArray *)GetNext7DaysThemeNightEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormat release];
    
    NSLog(@"select  distinct * from (select   abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))  as datet,*  from event_detail  ) where datet>%@ and  datet<=%@ and Event_Type=1 and PubID=%d",Today,dateAftersevendays,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail) where datet>=%@ and  datet<=%@ and Event_Type=3 and PubID=%d",Today,dateAftersevendays,Pubid];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",[rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay", nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}



+(NSMutableArray *)GetTonightRegularEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [dateFormatToday release];   
    
    NSLog(@"select  distinct * from (select   abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))  as datet,*  from event_detail  ) where datet=%@ and Event_Type=1 and PubID=%d",Today,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet=%@ and Event_Type=1 and PubID=%d",Today,Pubid];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",[rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}


+(NSMutableArray *)GetTonightOneOffEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
        
       [dateFormatToday release];
    
    NSLog(@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet=%@ and Event_Type=2 and PubID=%d",Today,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2)) as datet,* from event_detail) where datet=%@ and Event_Type=2 and PubID=%d",Today,Pubid];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",[rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}

+(NSMutableArray *)GetTonightThemeNightEvent_DetailsInfo:(int)Pubid{

    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    [dateFormatToday release];
    
    NSLog(@"select  distinct * from (select   abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))  as datet,*  from event_detail  ) where datet=%@ and Event_Type=3 and PubID=%d",Today,Pubid);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet=%@ and Event_Type=3 and PubID=%d",Today,Pubid];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",[rs stringForColumn:@"ID"],@"ID",[rs stringForColumn:@"EventDay"],@"EventDay",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}



+(NSMutableArray *)GetTonightSportEvent_DetailsInfo:(int)Pubid{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    [dateFormatToday release];
    
    
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(sport_date,1,4)||substr(sport_date,6,2)||substr(sport_date,9,2)) as datet,* from Sport_Event) where datet=%@ and PubID=%d",Today,Pubid];
    
    NSLog(@"Str_Qry2  %@",Str_Qry2);
    
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_EventName"],@"Sport_EventName", 
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




/*

+(NSMutableArray *)GetTonightThemeNightEvent_DetailsInfo:(int)Pubid{
    
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
        [dateFormatToday release];
    
    
    NSDateFormatter *dateFormatToday1 = [[NSDateFormatter alloc] init];
    [dateFormatToday1 setDateFormat:@"dd-MM-yyyy"];
    [dateFormatToday1 setLocale:[NSLocale currentLocale]];
    NSString *Today1 = [dateFormatToday1 stringFromDate:today];  
    Today1 = [Today1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today1 = [Today1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [dateFormatToday1 release];
    
//    NSLog(@"select  distinct * from (select   abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))  as datet,*  from event_detail  ) where datet=%@ and Event_Type=3 and PubID=%d",Today,Pubid);
//    
//    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2)) as datet,* from event_detail) where datet=%@ and Event_Type=3 and PubID=%d",Today,Pubid];
//    
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select * from(SELECT Sport_EventName as Name,Sport_Date as Date,Sport_Description as Event_Description FROM Sport_Event where abs(substr(date,1,2)||substr(date,4,2)||substr(date,7,4))>=%@ and PubID=%d UNION SELECT Name,Date,Event_Description FROM Event_Detail where abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))>=%@ and PubID=%d)",Today1,Pubid,Today,Pubid]; 
                          
      
        
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],
                                               @"Event_Description",nil];   
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    return [arr autorelease];
}
*/


+(NSMutableArray *)GetNext7daysSportEvent_DetailsInfo:(int)Pubid{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
    [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
    [dateFormatToday setLocale:[NSLocale currentLocale]];
    NSString *Today = [dateFormatToday stringFromDate:today];  
    Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
    Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormat release];
    
    
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(sport_date,1,4)||substr(sport_date,6,2)||substr(sport_date,9,2)) as datet,* from Sport_Event) where datet>%@ and  datet<=%@ and PubID=%d",Today,dateAftersevendays,Pubid];
    
    NSLog(@"%@",Str_Qry2);
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_EventName"],@"Sport_EventName", 
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
