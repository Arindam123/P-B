//
//  SavePreferenceInfo.m
//  PubAndBar
//
//  Created by Subhra Da on 28/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SavePreferenceInfo.h"

@implementation SavePreferenceInfo

+(NSMutableArray *)GetFavourites_DetailsInfo
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];  
    
     ResultSet * rs;
           
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  Favourites FROM Preference_Favourites "]];
        
        while ([rs next]) {
            
                  
            [arr4PubID addObject:[rs stringForColumn:@"Favourites"]];
           // [tempDictionary release];
            
            
            
        }
        
    for (int i =0; i<[arr4PubID count]; i++) {

         rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[arr4PubID objectAtIndex:i]  intValue]]];
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                                    [rs stringForColumn:@"venuePhoto"],@"venuePhoto",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4PubID release];
    
    return [arr autorelease];

}


+(NSMutableArray *)GetRecentHistory_DetailsInfo
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];  
    
    ResultSet * rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  RecentHistory FROM Preference_RecentHistory "]];
    
    while ([rs next]) {
        
        
        [arr4PubID addObject:[rs stringForColumn:@"RecentHistory"]];
        // [tempDictionary release];
        
        
        
    }
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
      //  rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[arr4PubID objectAtIndex:i]  intValue]]];//Select PubDetails.PubDetails, PubDetails.PubCity, Pub_Photo.GeneralImages from PubDetails  Join Pub_Photo ON PubDetails.PubID=Pub_Photo.PubID =2
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[arr4PubID objectAtIndex:i]  intValue]]];
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                                    [rs stringForColumn:@"venuePhoto"],@"venuePhoto",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4PubID release];
    
    return [arr autorelease];
    
}



+(NSMutableArray *)GetRecentSearch_DetailsInfo
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];  
    
    ResultSet * rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select  RecentSearch FROM Preference_RecentSearch limit 5"]];
    
    while ([rs next]) {
        
        
        [arr4PubID addObject:[rs stringForColumn:@"RecentSearch"]];
        // [tempDictionary release];
        
        
        
    }
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        //  rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[arr4PubID objectAtIndex:i]  intValue]]];//Select PubDetails.PubDetails, PubDetails.PubCity, Pub_Photo.GeneralImages from PubDetails  Join Pub_Photo ON PubDetails.PubID=Pub_Photo.PubID =2
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[arr4PubID objectAtIndex:i]  intValue]]];
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                                    [rs stringForColumn:@"PubName"],@"PubName",
                                                    [rs stringForColumn:@"PubCity"],@"PubCity",
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                                    [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                                    [rs stringForColumn:@"venuePhoto"],@"venuePhoto",nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4PubID release];
    
    return [arr autorelease];
    
}




+(void)RemoveData_Preference_Favourites:(int) pubId
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
   
    
    [appDelegate.PubandBar_DB executeUpdate:[NSString stringWithFormat:@"DELETE FROM Preference_Favourites WHERE Favourites=%d ",pubId]];
}

+(void)RemoveData_Preference_RecentSearch:(int) pubId
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    [appDelegate.PubandBar_DB executeUpdate:[NSString stringWithFormat:@"DELETE FROM Preference_RecentSearch WHERE RecentSearch=%d ",pubId]];
}

+(void)RemoveData_Preference_RecentHistory:(int) pubId
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    [appDelegate.PubandBar_DB executeUpdate:[NSString stringWithFormat:@"DELETE FROM Preference_RecentHistory WHERE RecentHistory=%d ",pubId]];
}
@end
