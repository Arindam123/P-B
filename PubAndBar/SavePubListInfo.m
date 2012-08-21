//
//  SavePubListInfo.m
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SavePubListInfo.h"

@implementation SavePubListInfo

+(NSMutableArray *)GetPubDetailsInfo:(int)ID withCategoryStr:(NSString *) catStr withRadius:(NSString *) _radius
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    if ([catStr isEqualToString:@"Food & Offers"]) {
        //if ([_radius isEqualToString:@"<=0.000000"])
        {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Food_Detail where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and FoodTypeID=%d",ID]];
        }
       /* else
        {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Food_Detail where FoodTypeID=%d AND PubDistance %@",ID,_radius]];
        }*/
        
    }
    
    if ([catStr isEqualToString:@"Real Ale"]) {
        //        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Ale_BeerDetail where Beer_ID=%d AND PubDistance %@",ID,_radius]];
        //if ([_radius floatValue]==0.0) 
        {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Ale_BeerDetail where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Beer_ID=%d ",ID]];
        }
       /* else
        {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Ale_BeerDetail where Beer_ID=%d AND PubDistance %@",ID,_radius]];
        }*/
    }
    
    if ([catStr isEqualToString:@"Sports on TV"]) {
       // rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Sport_Event where Sport_EventID=%d AND PubDistance %@",ID,_radius]];
    
        //if ([_radius isEqualToString:@"<=0.000000"])
        {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Sport_Event where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Sport_EventID=%d",ID]];
        }
       /* else
        {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Sport_Event where Sport_EventID=%d AND PubDistance %@",ID,_radius]];
        }*/
    }
    
    NSLog(@"%@   %d  %@",rs,ID,[NSString stringWithFormat:@"select distinct PubID from Sport_Event where Sport_EventID=%d AND PubDistance %@",ID,_radius]);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        [arr4PubID addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    NSLog(@"ARRAY 4 pubID %@",arr4PubID);
    // ResultSet *rs2;
    
    
    //for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID in %@ ORDER BY PubDistance ASC",[arr4PubID valueForKey:@"PubID"]]];
        
        
        
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    //}
    
    [arr4PubID release];
    
    NSLog(@"ARRAy   %@",arr);
    
    return [arr autorelease];
}

+(NSMutableArray *)GetPubDetailsInfo1:(int)CatagoryID withID:(int)ID withCategoryStr:(NSString *) catStr withEventTypeID:(NSString *) eventTypeID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    ResultSet *rs;
    
    
    if([catStr isEqualToString:@"Sports on TV"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d ORDER BY PubDistance ASC",CatagoryID]];
        
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                   [rs stringForColumn:@"PubName"],@"PubName",
                                                   [rs stringForColumn:@"PubCity"],@"PubCity",
                                                   [rs stringForColumn:@"PubID"],@"PubID",
                                                   [rs stringForColumn:@"Latitude"],@"Latitude",
                                                   [rs stringForColumn:@"Longitude"],@"Longitude",
                                                   [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                   [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
            
            [arr addObject:tempDictionary];
            [tempDictionary release];
            
            
            
        }
        
    }
    
    else if([catStr isEqualToString:@"Real Ale"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d ORDER BY PubDistance ASC",CatagoryID]];
        
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                   [rs stringForColumn:@"PubName"],@"PubName",
                                                   [rs stringForColumn:@"PubCity"],@"PubCity",
                                                   [rs stringForColumn:@"PubID"],@"PubID",
                                                   [rs stringForColumn:@"Latitude"],@"Latitude",
                                                   [rs stringForColumn:@"Longitude"],@"Longitude",
                                                   [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                   [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
            
            [arr addObject:tempDictionary];
            [tempDictionary release];
            
            
            
        }
        
    }
    
    else if([catStr isEqualToString:@"What's On Next 7 Days"] || [catStr isEqualToString:@"What's On Tonight..."]){
        //rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Event_Type=%d",CatagoryID]];
        //AppDelegate *appDelegate;
        //appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
        //NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        //ResultSet *rs;
        
        if ([catStr isEqualToString:@"What's On Tonight..."]) {
            
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormatToday = [[NSDateFormatter alloc] init];
            [dateFormatToday setDateFormat:@"yyyy-MM-dd"];
            [dateFormatToday setLocale:[NSLocale currentLocale]];
            NSString *Today = [dateFormatToday stringFromDate:today];  
            Today = [Today stringByReplacingOccurrencesOfString:@"-" withString:@""];
            Today = [Today stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            
            [dateFormatToday release];
            
            
            NSLog(@"%@",appDelegate.SelectedRadius);
            //  rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where PubDistance %@ AND ID=%d",appDelegate.SelectedRadius,ID]];
            
         /*   if (appDelegate.SelectedRadius==nil) {
                rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where ID=%d",ID,Today]];// AND abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))=%@
            }
            else
            {*/
                //select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet=%@ and Event_Type=1 and PubID=%d
                
                rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from(select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail) where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and ID=%d AND event_type=%@ AND datet=%@",ID,eventTypeID,Today]];// AND abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))=%@
           // }
            // }
            NSLog(@"%@",[NSString stringWithFormat:@"select distinct pubID from(select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail ) where PubDistance %@ AND ID=%d AND datet=%@",appDelegate.SelectedRadius,ID,Today]);
            
            NSLog(@"Query 1    %@",rs.query);
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                       [rs stringForColumn:@"PubID"],@"PubID"
                                                       ,nil];
                
                [arr4PubID addObject:tempDictionary];
                [tempDictionary release];
                
            }
            
            
            
         /*   if (appDelegate.SelectedRadius==nil)
            {
                
                NSString *query = [NSString stringWithFormat:@"select distinct pubID from (select   abs(substr(Sport_Date,7,4)||substr(Sport_Date,4,2)||substr(Sport_Date,1,2)) as datet,*  from Sport_Event )  where Sport_EventID=%d AND datet=%@",ID,Today];// AND abs(substr(sport_date,7,4)||substr(sport_date,4,2)||substr(sport_date,1,2))=%@
                rs = [appDelegate.PubandBar_DB executeQuery:query];
            }
            else
            {*/
                NSString *query = [NSString stringWithFormat:@"select distinct pubID from (select   abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,*  from Sport_Event )  where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Sport_EventID=%d AND datet=%@",ID,Today];// AND abs(substr(sport_date,7,4)||substr(sport_date,4,2)||substr(sport_date,1,2))=%@
                rs = [appDelegate.PubandBar_DB executeQuery:query];
                  NSLog(@"Query 2  %@  %@",rs,query);
            //}
            
          // port_date,1,2)=%@
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                       [rs stringForColumn:@"PubID"],@"PubID"
                                                       ,nil];
                
                [arr4PubID addObject:tempDictionary];
                [tempDictionary release];
                
            }
            
            NSLog(@"ARRAY 4 pubID %@",arr4PubID);
            // ResultSet *rs2;
        }
        
        if ([catStr isEqualToString:@"What's On Next 7 Days"]) {
            
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
            
                          
            NSLog(@"%@",appDelegate.SelectedRadius);
            //  rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where PubDistance %@ AND ID=%d",appDelegate.SelectedRadius,ID]];
            
          /*  if (appDelegate.SelectedRadius==nil) {
                rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail) Event_Detail where ID=%d AND datet>%@ and  datet<%@",ID,Today,dateAftersevendays]];// AND abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))=%@
            }
            else
            {*/
                //select  distinct * from (select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,*  from event_detail  ) where datet=%@ and Event_Type=1 and PubID=%d
                
                rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from(select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail) where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and  ID=%d AND event_type=%@ AND datet>%@ and  datet<=%@",ID,eventTypeID,Today,dateAftersevendays]];// AND abs(substr(date,1,4)||substr(date,6,2)||substr(date,9,2))=%@
            //}
            // }
            NSLog(@"%@",[NSString stringWithFormat:@"select distinct pubID from(select   abs(substr(ExpiryDate,7,4)||substr(ExpiryDate,4,2)||substr(ExpiryDate,1,2)) as datet,* from event_detail) where PubDistance %@ AND ID=%d AND datet>%@ and  datet<%@",appDelegate.SelectedRadius,ID,Today,dateAftersevendays]);
            
            NSLog(@"Query 1    %@",rs.query);
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                       [rs stringForColumn:@"PubID"],@"PubID"
                                                       ,nil];
                
                [arr4PubID addObject:tempDictionary];
                [tempDictionary release];
                
            }
            
            
            
         /*   if (appDelegate.SelectedRadius==nil)
            {
                
                NSString *query = [NSString stringWithFormat:@"select distinct pubID from Sport_Event where Sport_EventID=%d",ID,Today];// AND abs(substr(sport_date,7,4)||substr(sport_date,4,2)||substr(sport_date,1,2))=%@
                rs = [appDelegate.PubandBar_DB executeQuery:query];
            }
            else*/
            //{
                NSString *query = [NSString stringWithFormat:@"select distinct pubID from (select   abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,* from Sport_Event)  where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Sport_EventID=%d AND datet>%@ and  datet<=%@",ID,Today,dateAftersevendays];// AND abs(substr(sport_date,7,4)||substr(sport_date,4,2)||substr(sport_date,1,2))=%@
                rs = [appDelegate.PubandBar_DB executeQuery:query];
                
                 NSLog(@"Query 2  %@  %@",rs,query);
          //  }
            
           //AND abs(substr(sport_date,7,4)||substr(sport_date,4,2)||substr(sport_date,1,2)=%@
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                       [rs stringForColumn:@"PubID"],@"PubID"
                                                       ,nil];
                
                [arr4PubID addObject:tempDictionary];
                [tempDictionary release];
                
            }
            
            NSLog(@"ARRAY 4 pubID %@",arr4PubID);
            // ResultSet *rs2;
        }
        
        

        
        
        
        
        //for (int i =0; i<[arr4PubID count]; i++) {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID in  %@ ORDER BY PubDistance ASC",[arr4PubID  valueForKey:@"PubID"] ]];
            
            NSLog(@"Query 3    %@",rs.query);

            
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                        [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                        [rs stringForColumn:@"PubName"],@"PubName",
                                                        [rs stringForColumn:@"PubCity"],@"PubCity",
                                                        [rs stringForColumn:@"PubID"],@"PubID",
                                                        [rs stringForColumn:@"Latitude"],@"Latitude",
                                                        [rs stringForColumn:@"Longitude"],@"Longitude",
                                                        [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                        [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
                
                [arr addObject:tempDictionary2];
                [tempDictionary2 release];
            }
            
        //}
        [arr4PubID release];
        
        NSLog(@"ARRAy   %@",arr);
        
        //return [arr autorelease];
    }
    
    else if ([catStr isEqualToString:@"Regular"] || [catStr isEqualToString:@"One Off" ] || [catStr isEqualToString:@"Theme Nights"])
    {
        //rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Event_Type=%d",CatagoryID]];
        //AppDelegate *appDelegate;
        //appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
        //NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        //ResultSet *rs;
        
        NSLog(@"%@",appDelegate.SelectedRadius);
     /*   if (appDelegate.SelectedRadius == nil) {
           
            
                      
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where Event_type=%d AND ID=%d",CatagoryID,ID]];
            
        }*/
        //else
       // {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Event_type=%d AND ID=%d",CatagoryID,ID]];
            
       // }
        // }
        
        //NSLog(@"%@   %d  %@",rs,ID,[NSString stringWithFormat:@"select distinct pubID from Food_Detail where FoodTypeID=%d AND PubDistance %@",ID,_radius]);
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubID"],@"PubID"
                                                   ,nil];
            
            [arr4PubID addObject:tempDictionary];
            [tempDictionary release];
            
        }
        //[NSString stringWithFormat:@"SELECT  Ammenity_typeID,Facility_Name FROM Ammenity_Detail where pubid in (select distinct pubid from pubdetails where pubdistance %@) and Ammenity_ID=%d group by Ammenity_typeID,Facility_Name",appDelegate.SelectedRadius,ID]
        NSLog(@"ARRAY 4 pubID %@",arr4PubID);
        // ResultSet *rs2;
        
        
        //for (int i =0; i<[arr4PubID count]; i++) {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select PubDetails. *,Event_detail.eventday from PubDetails,Event_detail where PubDetails.PubID= Event_detail.PubID and PubDetails.PubID in %@ and Event_detail.ID=%d group by PubDetails.PubID order by pubdistance ASC",[arr4PubID  valueForKey:@"PubID"] ,ID]];
            
            
            
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                        [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                                        [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                        [rs stringForColumn:@"PubName"],@"PubName",
                                                        [rs stringForColumn:@"EventDay"],@"Date",
                                                        [rs stringForColumn:@"PubID"],@"PubID",
                                                        [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                        [rs stringForColumn:@"Latitude"],@"Latitude",
                                                        [rs stringForColumn:@"Longitude"],@"Longitude",
                                                        
                                                       nil];
                
                [arr addObject:tempDictionary2];
                [tempDictionary2 release];
            }
            
        //}
        
        [arr4PubID release];
        
        NSLog(@"ARRAy   %@",arr);
        
        //return [arr autorelease];
        
        
        
        
        
    }
    
    
    NSLog(@"ARRAy   %@",arr);

    return [arr autorelease];
    
}

//--------------------------mb------25/05/12/5-45----------------------------//
+(NSMutableArray *)GetPubDetailsInfo:(NSMutableArray *)array AmmenityID:(int)ammenityID radius:(NSString *)rad
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    for (int i=0; i<[array count]; i++) {
        NSString *qry;
        //if ([rad isEqualToString:@"<=0.000000"])
        {
            qry=[NSString stringWithFormat:@"select * from Ammenity_Detail where pubid in (select distinct pubid from pubdetails where latitude not null and longitude not null) and Ammenity_TypeID=%d and Ammenity_ID=%d",[[array objectAtIndex:i]intValue],ammenityID];
        }
        /*else
        {
            qry=[NSString stringWithFormat:@"select * from Ammenity_Detail where Ammenity_TypeID=%d and Ammenity_ID=%d and PubDistance %@",[[array objectAtIndex:i]intValue],ammenityID,rad];
        }*/
        
        rs = [appDelegate.PubandBar_DB executeQuery:qry];   
        
        NSLog(@"%@   %d",rs,ammenityID);
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubID"],@"PubID"
                                                   ,nil];        
            [arr4PubID addObject:tempDictionary];
            [tempDictionary release];
            
            
            
        }
    }
    
    //for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID in %@ ORDER BY PubDistance ASC",[arr4PubID valueForKey:@"PubID"]]];
        
        
        
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance", [rs stringForColumn:@"pubDescription"],@"pubDescription",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    //}
    
    [arr4PubID release];
    
    return [arr autorelease];
}
//--------------------------------------------------------------------//

@end
