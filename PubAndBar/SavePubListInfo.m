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
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Food_Detail where FoodTypeID=%d AND PubDistance %@",ID,_radius]];
    }
    
    if ([catStr isEqualToString:@"Real Ale"]) {
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Ale_BeerDetail where Beer_ID=%d AND PubDistance %@",ID,_radius]];
    }
    
    if ([catStr isEqualToString:@"Sports on TV"]) {
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct PubID from Sport_Event where Sport_EventID=%d AND PubDistance %@",ID,_radius]];
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
    
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"PubID"] intValue]]];
        
        
        
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
        
    }
    
    [arr4PubID release];
    
    NSLog(@"ARRAy   %@",arr);
    
    return [arr autorelease];
}

+(NSMutableArray *)GetPubDetailsInfo1:(int)CatagoryID withID:(int)ID withCategoryStr:(NSString *) catStr{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    
    if([catStr isEqualToString:@"Sports on TV"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",CatagoryID]];
        
    }
    
    else if([catStr isEqualToString:@"Real Ale"]){
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",CatagoryID]];
        
    }
    
    else if([catStr isEqualToString:@"What's On Next 7 Days"] || [catStr isEqualToString:@"What's On Tonight..."]){
        //rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Event_Type=%d",CatagoryID]];
        AppDelegate *appDelegate;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        ResultSet *rs;
        
        NSLog(@"%@",appDelegate.SelectedRadius);
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where PubDistance %@ AND ID=%d",appDelegate.SelectedRadius,ID]];
        // }
        
        //NSLog(@"%@   %d  %@",rs,ID,[NSString stringWithFormat:@"select distinct pubID from Food_Detail where FoodTypeID=%d AND PubDistance %@",ID,_radius]);
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubID"],@"PubID"
                                                   ,nil];
            
            [arr4PubID addObject:tempDictionary];
            [tempDictionary release];
            
        }
        
        NSLog(@"ARRAY 4 pubID %@",arr4PubID);
        // ResultSet *rs2;
        
        
        for (int i =0; i<[arr4PubID count]; i++) {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"PubID"] intValue]]];
            
            
            
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
            
        }
        [arr4PubID release];
        
        NSLog(@"ARRAy   %@",arr);
        
        return [arr autorelease];
    }
    
    else if ([catStr isEqualToString:@"Regular"] || [catStr isEqualToString:@"One Off" ] || [catStr isEqualToString:@"Theme Nights"])
    {
        //rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Event_Type=%d",CatagoryID]];
        AppDelegate *appDelegate;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        ResultSet *rs;
        
        NSLog(@"%@",appDelegate.SelectedRadius);
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct pubID from Event_Detail where Event_type=%d AND PubDistance %@ AND ID=%d",CatagoryID,appDelegate.SelectedRadius,ID]];
        // }
        
        //NSLog(@"%@   %d  %@",rs,ID,[NSString stringWithFormat:@"select distinct pubID from Food_Detail where FoodTypeID=%d AND PubDistance %@",ID,_radius]);
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                   [rs stringForColumn:@"PubID"],@"PubID"
                                                   ,nil];
            
            [arr4PubID addObject:tempDictionary];
            [tempDictionary release];
            
        }
        
        NSLog(@"ARRAY 4 pubID %@",arr4PubID);
        // ResultSet *rs2;
        
        
        for (int i =0; i<[arr4PubID count]; i++) {
            
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"PubID"] intValue]]];
            
            
            
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
            
        }
        
        [arr4PubID release];
        
        NSLog(@"ARRAy   %@",arr);
        
        return [arr autorelease];
        
        
        
        
        
    }
    
    NSLog(@"%@   %d",rs,ID);
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
        NSString *qry=[NSString stringWithFormat:@"select * from Ammenity_Detail where Ammenity_TypeID=%d and Ammenity_ID=%d and PubDistance %@",[[array objectAtIndex:i]intValue],ammenityID,rad];
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
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where PubID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"PubID"] intValue]]];
        
        
        
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
        
    }
    
    [arr4PubID release];
    
    return [arr autorelease];
}
//--------------------------------------------------------------------//

@end
