//
//  AmenitiesInfo.m
//  PubAndBar
//
//  Created by Subhra Da on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "AmenitiesInfo.h"

@implementation AmenitiesInfo

+(NSMutableArray *)GetAmmenity_NameInfo:(NSInteger)ID radius:(NSString *)rad
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSString *qury;
    if (rad==nil) {
        qury=[NSString stringWithFormat:@"SELECT  Ammenity_typeID,Facility_Name FROM Ammenity_Detail where Ammenity_ID=%d group by Ammenity_typeID,Facility_Name",ID];
    }
    else
    {
        qury=[NSString stringWithFormat:@"SELECT  Ammenity_typeID,Facility_Name FROM Ammenity_Detail where pubid in (select distinct pubid from pubdetails) and Ammenity_ID=%d group by Ammenity_typeID,Facility_Name",ID];
    }
    
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:qury];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ammenity_TypeID"],@"Ammenity_TypeID", 
                                               [rs stringForColumn:@"Facility_Name"],@"Facility_Name"
                                               ,nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [arr autorelease];
}

@end
