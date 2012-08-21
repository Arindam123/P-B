//
//  SaveEventCatagoryInfo.m
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveEventCatagoryInfo.h"

@implementation SaveEventCatagoryInfo

NSMutableArray *arr;

AppDelegate *appDelegate;
NSString *Only_date;

-(id)init{
    self = [super init];
    if (self != nil) {
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


+(void)ServiceEvents :(NSString*)rad{
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc] init];
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails where Longitude Not Null and Latitude  Not Null"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    NSLog(@"PUBID  %@",arr4PubID);
    
    
    NSString *Str_qry = [NSString stringWithFormat:@"select * from Event , Event_detail where Event.Event_type=Event_detail.Event_type And Event_detail.pubid in %@ group by Event_detail.Event_type",arr4PubID];
    rs = [appDelegate.PubandBar_DB executeQuery:Str_qry];
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Event_Name"],@"Event_Name", 
                                               [rs stringForColumn:@"Event_Type"],@"Event_Type"
                                               ,nil];
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
}

+(void)ToNightEvents :(NSString *) _radius{
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc] init];
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails where Longitude Not Null and Latitude  Not Null"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    NSLog(@"PUBID  %@",arr4PubID);
    
    
    
    NSString *currentdate = [Constant GetCurrentDateTime];
    NSArray *Arr_OnlyDate = [currentdate componentsSeparatedByString:@" "];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@" " withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@":" withString:@""];
    Only_date = [Arr_OnlyDate objectAtIndex:0];
    Only_date = [Only_date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *Str_qry1 = [NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail where pubid in %@) where datet=%@",arr4PubID,Only_date];
    rs = [appDelegate.PubandBar_DB executeQuery:Str_qry1];
    if ([rs next]) {
        NSLog(@"%@",rs.query);
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               @"What's On Tonight...",@"Event_Name", 
                                               @"4",@"Event_Type"
                                               ,nil];
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    
    NSString *Str_qry4Sports = [NSString stringWithFormat:@"select  distinct * from (select abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,* from Sport_Event where pubid in %@) where datet=%@",arr4PubID,Only_date];
    
    ResultSet *rs2 = [appDelegate.PubandBar_DB executeQuery:Str_qry4Sports];
    if ([rs2 next]) {
        NSLog(@"%@",rs.query);
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               @"What's On Tonight...",@"Event_Name", 
                                               @"4",@"Event_Type"
                                               ,nil];
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    
    NSArray *copy = [arr copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([arr indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [arr removeObjectAtIndex:index];
        }
        index--;
    }
    [copy release];
}



+(void)SevenDaysEvent :(NSString *) _radius{
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc] init];
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails where Longitude Not Null and Latitude  Not Null"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    
    NSDate *today = [NSDate date];
    NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormat release];
    NSLog(@"select  distinct * from (select abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))  as datet,*  from event_detail) where datet>%@ and  datet<%@ and pubdistance %@",Only_date,dateAftersevendays,appDelegate.SelectedRadius);
    
    NSString *Str_Qry2 = [NSString stringWithFormat:@"select  distinct * from (select abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail where pubid in %@) where datet>=%@ and  datet<=%@",arr4PubID,Only_date,dateAftersevendays];
    
    rs = [appDelegate.PubandBar_DB executeQuery:Str_Qry2];
    if ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               @"What's On Next 7 Days",@"Event_Name", 
                                               @"5",@"Event_Type"
                                               ,nil];
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    
    NSString *Str_Qry4Sports = [NSString stringWithFormat:@"select  distinct * from (select abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,* from Sport_Event where pubid in %@) where datet>=%@ and  datet<=%@",arr4PubID,Only_date,dateAftersevendays];
    
     ResultSet *rs2 = [appDelegate.PubandBar_DB executeQuery:Str_Qry4Sports];
    
    if ([rs2 next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               @"What's On Next 7 Days",@"Event_Name", 
                                               @"5",@"Event_Type"
                                               ,nil];
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
    
    NSArray *copy = [arr copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([arr indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [arr removeObjectAtIndex:index];
        }
        index--;
    }
    [copy release];
    
    NSLog(@"Seven days array   %@",arr);
}


+(NSMutableArray *)GetEventInfo :(NSString *) _radius{
    arr = [[NSMutableArray alloc]init];
    [self ServiceEvents:_radius];//:_radius];
    [self ToNightEvents:_radius];
    [self SevenDaysEvent:_radius];
    
    
    /*AppDelegate *appDelegate;
     appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     ResultSet *rs;
     
     NSLog(@"select E.* from Event_detail as ED left join Event as E on ED.Event_Type = E.Event_Type  where ED.pubdistance %@ group by ED.Event_type",appDelegate.SelectedRadius);
     //ResultSet *rs = [[appDelegate.PubandBar_DB executeQuery:@"select E.* from Event_detail as ED left join Event as E on ED.Event_Type = E.Event_Type where ED.pubdistance %@ group by ED.Event_type",appDelegate.SelectedRadius] retain];//[appDelegate.PubandBar_DB executeQuery:@"select * from Event"];
     NSLog(@"SELECT * FROM EVENT where Event_Type IN(select Event_Type from Event_Detail where PubDistance %@ group by Event_Type)",appDelegate.SelectedRadius);*/
    
    
    return [arr autorelease];
}


+(BOOL)Pub_isInDistnce_Intype:(NSString*)event_type{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([app.SelectedRadius isEqualToString:@"> 20.0"]) {
        return YES;
    }
    NSString *Qry_allDistance = [NSString stringWithFormat:@"select pubdistance from event_detail where Event_Type='%@'",event_type];
    NSString *Str_radius = app.SelectedRadius;
    Str_radius = [Str_radius stringByReplacingOccurrencesOfString:@" " withString:@""];
    Str_radius = [Str_radius stringByReplacingOccurrencesOfString:@">" withString:@""];
    Str_radius = [Str_radius stringByReplacingOccurrencesOfString:@"<" withString:@""];
    Str_radius = [Str_radius stringByReplacingOccurrencesOfString:@"=" withString:@""];
    ResultSet *rs = [app.PubandBar_DB executeQuery:Qry_allDistance];
    while ([rs next]) {
        if ([Str_radius doubleValue] >= [rs doubleForColumn:@"pubdistance"]) {
            return YES;
        }
    }
    return NO;
}



@end
