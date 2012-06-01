//
//  SaveNearMeInfo.m
//  PubAndBar
//
//  Created by ARINDAM GHOSH on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveNearMeInfo.h"
#import "PubDetail.h"


@implementation SaveNearMeInfo

+(NSMutableArray *)GetNearMePubsInfo{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *_arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    rs =[appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Longitude Not Null and Latitude  Not Null  ORDER BY PubDistance ASC"]];
    
    
    NSLog(@"%@  ",rs);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               
                                               [rs stringForColumn:@"PubName"],@"PubName",                                
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                               [rs stringForColumn:@"Longitude"],@"Longitude",
                                               [rs stringForColumn:@"Latitude"],@"Latitude",
                                               [rs stringForColumn:@"venuePhoto"],@"venuePhoto",
                                               nil];                                               
        
        
        [_arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [_arr autorelease];
}


@end
