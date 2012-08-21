//
//  SaveTextSearchInfo.m
//  PubAndBar
//
//  Created by Subhra Da on 05/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveTextSearchInfo.h"

@implementation SaveTextSearchInfo

#pragma mark-
#pragma mark-
+(NSMutableArray *)GetPubDetailsInfo:(NSString *)_pubName
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubName) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
    
    
    
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                [rs stringForColumn:@"PubName"],@"PubName",
                                                [rs stringForColumn:@"PubCity"],@"PubCity",
                                                //                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                [rs stringForColumn:@"PubName"],@"Name",
                                                [rs stringForColumn:@"PubID"],@"ID",
                                                
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    if (![rs next]) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubPostcode) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
        
        
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                    [rs stringForColumn:@"PubName"],@"Name",
                                                    [rs stringForColumn:@"PubID"],@"ID",
                                                    
                                                    nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
        
        
        if (![rs next]) {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubDistrict) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
            
            
            while ([rs next]) {
                
                
                NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                        //                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                        //                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                        //                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                        //                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                        //                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                        //                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                        //                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                        [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                        [rs stringForColumn:@"PubName"],@"Name",
                                                        [rs stringForColumn:@"PubID"],@"ID",
                                                        
                                                        nil];
                
                [arr addObject:tempDictionary2];
                [tempDictionary2 release];
                
                
            }
        }
        
    }
    
    //}
    
    // [arr4PubID release];
    
    return [arr autorelease];
    
}




+(NSMutableArray *)GetSearchByVenue:(NSString *)_pubName
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubName) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
    
    
    
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                [rs stringForColumn:@"PubName"],@"PubName",
                                                [rs stringForColumn:@"PubCity"],@"PubCity",
                                                //                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                [rs stringForColumn:@"PubName"],@"Name",
                                                [rs stringForColumn:@"PubID"],@"ID",
                                                
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return arr;
}



+(NSMutableArray *)GetSearchByCity:(NSString *)_pubName
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubDistrict) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
    
    
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                [rs stringForColumn:@"PubName"],@"PubName",
                                                [rs stringForColumn:@"PubCity"],@"PubCity",
                                                //                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                [rs stringForColumn:@"PubName"],@"Name",
                                                [rs stringForColumn:@"PubID"],@"ID",
                                                
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
        
        
    }
    return arr;
}


+(NSMutableArray *)GetSearchByPostcode:(NSString *)_pubName
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Upper(PubPostcode) LIKE '%%%@%%' and Latitude not null and Longitude not null order by Pubdistance ASC",_pubName,_pubName]];
    
    
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                [rs stringForColumn:@"PubName"],@"PubName",
                                                [rs stringForColumn:@"PubCity"],@"PubCity",
                                                //                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                [rs stringForColumn:@"PubDistance"],@"PubDistance",                                                    
                                                [rs stringForColumn:@"PubName"],@"Name",
                                                [rs stringForColumn:@"PubID"],@"ID",
                                                
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
        
        
    }
    return arr;
}











#pragma mark-
#pragma mark- BeerName

+(NSMutableArray *)GetAle_beerdetailInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Upper(Beer_Name)='%@'group by Beer_Name",_txt]];
    
    
    
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Beer_Name"],@"Name",
                                                [rs stringForColumn:@"Beer_ID"],@"ID",
                                                //                                                
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    //}
    
    // [arr4PubID release];
    
    return [arr autorelease];
    
}

#pragma mark-
#pragma mark- AleName
+(NSMutableArray *)GetRealAle_DetailInfo:(NSString *)_txt{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from RealAle_Detail  where Upper(Ale_Name)='%@' group by Ale_Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Ale_Name"],@"Name",
                                                [rs stringForColumn:@"Ale_ID"],@"ID",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}

#pragma mark-
#pragma mark- Food
+(NSMutableArray *)GetFood_TypeInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Food_Type  where Upper(Food_Name)='%@' group by Food_Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Food_Name"],@"Name",
                                                [rs stringForColumn:@"Food_ID"],@"ID",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}
#pragma mark-
#pragma mark- Ammenities

+(NSMutableArray *)GetAmmenitiesInfo:(NSString *)_txt{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenities  where Upper(Ammenity_Type)='%@' group by Ammenity_Type",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Ammenity_Type"],@"Name",
                                                [rs stringForColumn:@"Ammenity_ID"],@"ID",
                                                [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}
#pragma mark-
#pragma mark- AmmenitiesDetails

+(NSMutableArray *)GetAmmenity_DetailInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenity_Detail  where Upper(Facility_Name)='%@' group by Facility_Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Facility_Name"],@"Name",
                                                [rs stringForColumn:@"Ammenity_TypeID"],@"ID",
                                                [rs stringForColumn:@"Ammenity_ID"],@"Ammenity_ID",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}
#pragma mark-
#pragma mark- Event Name

+(NSMutableArray *)GetEventInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Event  where Upper(Event_Name)='%@' group by Event_Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Event_Name"],@"Name",
                                                [rs stringForColumn:@"Event_Type"],@"ID",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
    
}

#pragma mark-
#pragma mark- event Details

+(NSMutableArray *)GetEvent_DetailInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Event_Detail  where Upper(Name)='%@' group by Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Name"],@"Name",
                                                [rs stringForColumn:@"ID"],@"ID",
                                                [rs stringForColumn:@"Event_Type"],@"Event_Type",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}

#pragma mark-
#pragma mark- Sport Name
+(NSMutableArray *)GetSport_CatagoryNameInfo:(NSString *)_txt
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet * rs;
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_CatagoryName  where Upper(Sport_Name)='%@' group by Sport_Name",_txt]];
    
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Sport_Name"],@"Name",
                                                [rs stringForColumn:@"Sport_ID"],@"ID",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    return [arr autorelease];
}

//+(NSMutableArray *)GetSport_EventInfo:(NSString *)_txt
//{
/* AppDelegate *appDelegate;
 appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
 
 NSMutableArray *arr = [[NSMutableArray alloc]init];
 ResultSet * rs;
 
 
 rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Sport_Event  where Sport_Name='%@' group by Sport_Name",_txt]];
 
 while ([rs next]) {
 
 NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
 [rs stringForColumn:@"Sport_Name"],@"Name",
 [rs stringForColumn:@"Sport_ID"],@"ID",
 nil];
 
 [arr addObject:tempDictionary2];
 [tempDictionary2 release];
 }
 
 return [arr autorelease];*/
//}
@end
