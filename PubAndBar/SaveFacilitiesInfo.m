//
//  SaveFacilitiesInfo.m
//  PubAndBar
//
//  Created by Apple on 01/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveFacilitiesInfo.h"
#import "PubDetail.h"
#import "Facilities_MicrositeDetails.h"

@implementation SaveFacilitiesInfo
/*
+(NSMutableArray *)GetFacilitiesDetailsInfo:(int)ID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct Ammenity_TypeID from Ammenity_Detail where PubID=%d",ID]];
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ammenity_TypeID"],@"Ammenity_TypeID"
                                               ,nil];
        
        [arr4PubID addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    NSLog(@"ARRAY 4 pubID %@",arr4PubID);
    // ResultSet *rs2;
    
    
    for (int i =0; i<[arr4PubID count]; i++) {
       NSString *strQry=[NSString stringWithFormat:@"select distinct Facility_Name,FacilitiesInformation from Ammenity_Detail where Ammenity_TypeID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"Ammenity_TypeID"] intValue]];
        rs = [appDelegate.PubandBar_DB executeQuery:strQry];
        
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Facility_Name"],@"Facility_Name",
                                    [rs stringForColumn:@"FacilitiesInformation"],@"FacilitiesInformation",
                                    nil];
            
            [arr addObject:tempDictionary1];
            [tempDictionary1 release];
            
            
        }
        
    }
    
    [arr4PubID release];
    
    NSLog(@"ARRAy   %@",arr);
    
    return [arr autorelease];
}
*/


+(NSMutableArray *)GetFacilityInfo:(int)ID{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenity_Detail where PubID=%d and Ammenity_ID=1 group by Ammenity_TypeID",ID]];
    
    
    //NSMutableArray *arr;
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        //arr = [[NSMutableArray alloc]initWithObjects:
                                               //[rs stringForColumn:@"Facility_Name"],nil];
        
        //[arr addObject:tempDictionary];
       // [tempDictionary release];
        
        NSString *str=[NSString stringWithFormat:@"%@",[rs stringForColumn:@"Facility_Name"]];
        [arr addObject:str];
    }
    
    return [arr autorelease];
    
}

+(NSMutableArray *)GetFeatureInfo:(int)ID{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenity_Detail where PubID=%d and Ammenity_ID=2 group by Ammenity_TypeID",ID]];
    
    
    
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSString *str=[NSString stringWithFormat:@"%@",[rs stringForColumn:@"Facility_Name"]];
        [arr addObject:str];
        
        
        
    }
    
    return [arr autorelease];
    
}

+(NSMutableArray *)GetStyleInfo:(int)ID{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ammenity_Detail where PubID=%d and Ammenity_ID=3 group by Ammenity_TypeID",ID]];
    
    
    
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSString *str=[NSString stringWithFormat:@"%@",[rs stringForColumn:@"Facility_Name"]];
        [arr addObject:str];        
        
    }
    
    return [arr autorelease];
    
}



@end
