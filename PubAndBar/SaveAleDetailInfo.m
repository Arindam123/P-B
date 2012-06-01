//
//  SaveAleDetailInfo.m
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveAleDetailInfo.h"

@implementation SaveAleDetailInfo


+(NSMutableArray *)GetBeerInfo :(NSString*)ID{
    
     NSLog(@"ID  %@",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Ale_ID=%@",ID]];
   
    NSLog(@"%@",rs);
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Beer_Name"],@"Beer_Name", 
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID",
                                               [rs stringForColumn:@"Beer_ID"],@"Beer_ID",
                                               [rs stringForColumn:@"Catagory"],@"Catagory",
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"Beer ABV"],@"Beer ABV",
                                               [rs stringForColumn:@"Beer_Color"],@"Beer_Color",
                                               [rs stringForColumn:@"Beer_Smell"],@"Beer_Smell",
                                               [rs stringForColumn:@"Beer_Taste"],@"Beer_Taste",
                                               [rs stringForColumn:@"License_Note"],@"License_Note",
                                               nil];
                                            
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
                
        
    }
    
    return arr;
}

@end
