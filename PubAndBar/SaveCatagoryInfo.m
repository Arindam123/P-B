//
//  SaveCatagoryInfo.m
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveCatagoryInfo.h"

@implementation SaveCatagoryInfo

+(NSMutableArray *)GetSport_CatagoryNameInfo :(NSString *) _radius{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4SportID = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];

    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails where Longitude Not Null and Latitude  Not Null"]];
    
    
    NSLog(@"%@",rs.query);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        //NSLog(@"PUBID  %@",[rs stringForColumn:@"PubID"]);

        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
    }
    
    
    //NSLog(@"PUBID  %@",arr4PubID);
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Sport_ID from Sport_Event Where PubID IN %@",arr4PubID]];
    
    
    NSLog(@"%@",rs.query);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_ID"],@"Sport_ID"
                                               ,nil];
        
        //NSLog(@"Sport_ID  %@",[rs stringForColumn:@"Sport_ID"]);

        [arr4SportID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    [arr4PubID release];
    NSLog(@"arr4SportID  %@",arr4SportID);

    
    
    /*rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Sport_ID from Sport_Event where PubDistance %@",_radius]];
    
    NSLog(@"QUERY   %@",[NSString stringWithFormat:@"select Distinct Sport_ID from Sport_Event where PubDistance %@",_radius]);
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_ID"],@"Sport_ID"
                                               ,nil];
        
        
        [arr4SportID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }*/
    
    for (int i =0; i<[arr4SportID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_CatagoryName where Sport_ID=%d",[[[arr4SportID objectAtIndex:i] valueForKey:@"Sport_ID"] intValue]]];
        
        NSLog(@"1  %@  QUERY  %@",rs,[NSString stringWithFormat:@"select * from Sport_CatagoryName where Sport_ID=%d",[[[arr4SportID objectAtIndex:i] valueForKey:@"Sport_ID"] intValue]]);
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"Sport_Name"],@"Sport_Name",
                                                     [rs stringForColumn:@"Sport_ID"],@"Sport_ID"
                                                    ,nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4SportID release];
    
    
    
    return [arr autorelease];
}


//select distinct * from event_detail group by ID

+(NSMutableArray *)GetEvent_DetailInfo :(NSString *)ID  withRadius:(NSString *) _radius{
    
    NSLog(@"ID  %@",ID);
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    
    
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
    
    /*rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct FoodTypeID from Food_Detail where PubID IN %@",arr4PubID]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"FoodTypeID"],@"FoodTypeID"
                                               ,nil];
        
        
        [arr4FoodTypeID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    [arr4PubID release];
    NSLog(@"arr4FoodTypeID  %@",arr4FoodTypeID);*/
   
    
    
    
    
    
    
    
    
    
    
    
    NSString *Qry_CatagoryEvents;
    
   /* if (appDelegate.SelectedRadius==nil) {
        Qry_CatagoryEvents = [NSString stringWithFormat:@"select *from(select distinct * from Event_Detail where Event_Type='%@' group by ID)order by Name",ID];
    }
    else
    {*/
        Qry_CatagoryEvents = [NSString stringWithFormat:@"select *from (select distinct * from Event_Detail where Event_Type='%@' And PubID in %@ group by ID)order by Name",ID,arr4PubID];
   // }
    NSLog(@"%@",Qry_CatagoryEvents);
    rs = [appDelegate.PubandBar_DB executeQuery:Qry_CatagoryEvents];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"ID"],@"Event_ID", 
                                               [rs stringForColumn:@"Name"],@"Event_Name"
                                               ,[rs stringForColumn:@"EventDay"],@"EventDay",nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [arr autorelease];
}


+(NSMutableArray *)GetPubDetailsInfo :(NSString *)Date{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:@"SELECT e.Name,p.PubName, p.PubCity,p.PubDistance FROM PubDetails as p left join Event_Detail as e on p.Event_Type=e.Event_Type where e.Date=%@",Date];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubName"],@"PubName", 
                                               [rs stringForColumn:@"Name"],@"Name",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
        
    }
    
    return [arr autorelease];
}


+(NSMutableArray*)getDateEvent:(NSString*)_date isfortonight:(BOOL)_isnight{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //_date is ending date of event......
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSString *currentdate = [Constant GetCurrentDate];
    NSArray *Arr_OnlyDate = [currentdate componentsSeparatedByString:@" "];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@" " withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *Only_date = [Arr_OnlyDate objectAtIndex:0];
    Only_date = [Only_date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    ResultSet *rs;
    NSLog(@"select  distinct * from (select   abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2)  as datet,*  from event_detail) where datet>%@ and  datet<%@ group by id",Only_date,_date);
    if(!_isnight)
         
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from Event as E left join Event_Detail as ED on e.Event_type=ED.Event_Type left join PubDetails as P on p.PubID=ED.PubId where P.Longitude Not Null and P.Latitude  Not Null)  where datet>=%@ and  datet<=%@ group by Name",Only_date,_date]];
    else
         rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from Event as E left join Event_Detail as ED on e.Event_type=ED.Event_Type left join PubDetails as P on p.PubID=ED.PubId where P.Longitude Not Null and P.Latitude  Not Null)  where   datet=%@ group by Name",Only_date]];
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"ID:1"],@"Event_ID", 
                                               [rs stringForColumn:@"Name"],@"Name",
                                               [rs stringForColumn:@"Event_Name"],@"Event_Name",
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubDistance:1"],@"PubDistance",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubPostcode"],@"PubPostcode",
                                               [rs stringForColumn:@"Event_Type"],@"EventTypeID"
                                               ,nil];        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    if(!_isnight)
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  distinct * from (select   abs(substr(sport_date,1,4)||substr(sport_date,6,2)||substr(sport_date,9,2) ) as datet,*  from sport_event as s left join PubDetails as P on s.PubId=p.PubID where P.Longitude Not Null and P.Latitude  Not Null)  where datet>%@ and  datet<=%@ group by Sport_EventName",Only_date,_date]];
    else
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  distinct * from (select   abs(substr(sport_date,1,4)||substr(sport_date,6,2)||substr(sport_date,9,2) ) as datet,*  from sport_event as s left join PubDetails as P on s.PubId=p.PubID where P.Longitude Not Null and P.Latitude  Not Null) where datet=%@ group by Sport_EventName",Only_date]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Sport_EventID"],@"Event_ID", 
                                               [rs stringForColumn:@"Type"],@"Name",
                                               [rs stringForColumn:@"Sport_EventName"],@"Event_Name",
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubDistance:1"],@"PubDistance",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubPostcode"],@"PubPostcode"
                                               ,nil];        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    NSLog(@"Print ARRAY   %@",arr);
    
    return [arr autorelease];
}




+(NSMutableArray *)GetPubDetailsInfo1{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:@"SELECT e.Name,e.Date,p.PubName, p.PubCity,p.PubDistance FROM PubDetails as p left join Event_Detail as e on p.Event_Type=e.Event_Type  "];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubName"],@"PubName", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Name"],@"Name",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
        
    }
    
    return [arr autorelease];
}

+(NSMutableArray *)GetFood_Type :(NSString *) _radius{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arr4FoodTypeID = [[NSMutableArray alloc] init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    NSLog(@"PUBID  %@",arr4PubID);
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct FoodTypeID from Food_Detail where PubID IN %@",arr4PubID]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"FoodTypeID"],@"FoodTypeID"
                                               ,nil];
        
        
        [arr4FoodTypeID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    [arr4PubID release];
    NSLog(@"arr4FoodTypeID  %@",arr4FoodTypeID);
    
    
    

    /*NSString *query = [NSString stringWithFormat:@"select Distinct FoodTypeID from Food_Detail where PubDistance %@",_radius];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:query];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"FoodTypeID"],@"FoodTypeID"
                                               ,nil];
        
        
        [arr4FoodTypeID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }*/
    
    for (int i =0; i<[arr4FoodTypeID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Food_Type where Food_ID=%d",[[[arr4FoodTypeID objectAtIndex:i] valueForKey:@"FoodTypeID"] intValue]]];
        
        NSLog(@"1  %@",rs);

        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"Food_ID"],@"Food_ID", 
                                                   [rs stringForColumn:@"Food_Name"],@"Food_Name"
                                                   ,nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4FoodTypeID release];
    
    
    
    return [arr autorelease];
}

+(NSMutableArray *)GetAmmenity_NameInfo:(NSString *) _radius{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr4AmmenityID = [[NSMutableArray alloc]init];

    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    NSLog(@"PUBID  %@",arr4PubID);
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Ammenity_ID from Ammenity_Detail where PubID IN %@",arr4PubID]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ammenity_ID"],@"Ammenity_ID"
                                               ,nil];
        
        
        [arr4AmmenityID addObject:[tempDictionary valueForKey:@"Ammenity_ID"]];
        [tempDictionary release];
        
        
    }
    [arr4PubID release];
    NSLog(@"arr4FoodTypeID  %@",arr4AmmenityID);
    
    
    
    
    
    
    
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenities where Ammenity_ID IN %@",arr4AmmenityID]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ammenity_ID"],@"Ammenity_ID", 
                                               [rs stringForColumn:@"Ammenity_Type"],@"Ammenity_Type"
                                               ,nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    [arr4AmmenityID release];
    return [arr autorelease];
}


@end
