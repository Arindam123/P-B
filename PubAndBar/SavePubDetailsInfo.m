//
//  SavePubDetailsInfo.m
//  PubAndBar
//
//  Created by User7 on 18/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SavePubDetailsInfo.h"
#import "PubDetail.h"

@implementation SavePubDetailsInfo

+(NSMutableArray *)GetPubListInfo:(int)ID withCategoryStr:(NSString *) catStr{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    if ([catStr isEqualToString:@"Food & Offers"]) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Food_ID=%d",ID]];
    }
    
    else if([catStr isEqualToString:@"Sports on TV"]){
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Sport_ID=%d",ID]];
        
    }
    
    
    NSLog(@"%@  %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"PubPostCode"],@"PubPostCode",
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubDistrict"],@"PubDistrict",       
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                               [rs stringForColumn:@"PhoneNumber"],@"PhoneNumber", 
                                               [rs stringForColumn:@"PubAddress"],@"PubAddress", 
                                               [rs stringForColumn:@"Mobile"],@"Mobile", 
                                               [rs stringForColumn:@"PubWebsite"],@"PubWebsite", 
                                               [rs stringForColumn:@"PubDescription"],@"PubDescription",
                                               [rs stringForColumn:@"VenueStyle"],@"VenueStyle",
                                               [rs stringForColumn:@"VenueCapacity"],@"VenueCapacity",
                                               [rs stringForColumn:@"NearestRail"],@"NearestRail", 
                                               [rs stringForColumn:@"NearestTube"],@"NearestTube",
                                               [rs stringForColumn:@"PubCompany"],@"PubCompany",
                                               [rs stringForColumn:@"LocalBuses"],@"LocalBuses",
                                               [rs stringForColumn:@"Sport_EventID"],@"Sport_EventID",nil];                                               
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
        
    }
    
    return [arr autorelease];
}
+(NSMutableArray *)GetPubDetailsInfo1:(int)CatagoryID:(int)ID withCategoryStr:(NSString *) catStr{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    
    if([catStr isEqualToString:@"Sports on TV"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Sport_ID=%d and Sport_EventID=%d",CatagoryID,ID]];
        
    }
    
    else if([catStr isEqualToString:@"Real Ale"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Beer_ID=%d and Ale_ID=%d",ID,CatagoryID]];
        
    }
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               //[rs stringForColumn:@"Latitude"],@"Latitude",
                                               //[rs stringForColumn:@"Longitude"],@"Longitude",
                                               [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
        
    }
    
    return [arr autorelease];
    
}

+(NSMutableArray *)GetPubDetailsInfo:(int)_ID{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *_arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    rs =[appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d ",_ID]];
    
    
    NSLog(@"%@  %d",rs,_ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"PubPostCode"],@"PubPostCode",
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubDistrict"],@"PubDistrict",       
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                               [rs stringForColumn:@"PhoneNumber"],@"PhoneNumber", 
                                               [rs stringForColumn:@"PubAddress"],@"PubAddress", 
                                               [rs stringForColumn:@"Mobile"],@"Mobile", 
                                               [rs stringForColumn:@"PubWebsite"],@"PubWebsite", 
                                               [rs stringForColumn:@"PubDescription"],@"PubDescription",
                                               [rs stringForColumn:@"VenueStyle"],@"VenueStyle",
                                               [rs stringForColumn:@"VenueCapacity"],@"VenueCapacity",
                                               [rs stringForColumn:@"NearestRail"],@"NearestRail", 
                                               [rs stringForColumn:@"NearestTube"],@"NearestTube",
                                               [rs stringForColumn:@"PubCompany"],@"PubCompany", 
                                               [rs stringForColumn:@"LocalBuses"],@"LocalBuses",
                                               [rs stringForColumn:@"venuePhoto"],@"venuePhoto",
                                              nil];                                               
        
        
        NSLog(@"%@",[rs stringForColumn:@"PubCompany"]);
        [_arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [_arr autorelease];
}

+(NSMutableArray *)GetEvent_DetailsInfo:(int)eventId{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:@"select * from Event_Detail where PubID=%d",eventId];
    
    NSLog(@"%@ %d",rs,eventId);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Name"],@"Name", 
                                               [rs stringForColumn:@"Date"],@"Date",
                                               [rs stringForColumn:@"Event_Description"],@"Event_Description",nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [arr autorelease];
}





@end