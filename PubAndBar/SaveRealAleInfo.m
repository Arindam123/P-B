//
//  SaveRealAleInfo.m
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveRealAleInfo.h"

@implementation SaveRealAleInfo

+(NSMutableArray *)GetAleInfo 
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arr4AleID = [[NSMutableArray alloc]init];

    
    
   // ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Ale_ID from Ale_BeerDetail where PubDistance %@",_radius]];
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Ale_ID from Ale_BeerDetail"]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID"
                                               ,nil];
        
        
        [arr4AleID addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    
    for (int i =0; i<[arr4AleID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from RealAle_Detail where Ale_ID=%d group by Ale_ID",[[[arr4AleID objectAtIndex:i] valueForKey:@"Ale_ID"] intValue]]];
        
        NSLog(@"1  %@",rs);
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"Ale_ID"],@"Ale_ID", 
                                                    [rs stringForColumn:@"Ale_Name"],@"Ale_Name",
                                                    [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode"
                                                    ,nil];
            
            [arr addObject:tempDictionary2];
            [tempDictionary2 release];
        }
        
    }
    
    [arr4AleID release];
    
    
    
    return [arr autorelease];
}


+(NSMutableArray *)GetSearchAleInfo:(NSString *)_name
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from RealAle_Detail where Ale_name='%@' group by Ale_ID",_name]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID", 
                                               [rs stringForColumn:@"Ale_Name"],@"Ale_Name",
                                               [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode"
                                               ,nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    return [arr autorelease];
}


+(NSMutableArray *)GetSearchBeerInfo:(NSString *)_name
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from Ale_BeerDetail where Beer_name='%@' group by Beer_ID",_name]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID",
                                               [rs stringForColumn:@"Beer_ID"],@"Beer_ID"
                                               ,nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
//    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
//    for (int i=0; i<[arr count]; i++) {
//      rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from RealAle_Detail where Ale_ID=%@ and Beer_ID=%@ group by Ale_ID",[[arr objectAtIndex:i]valueForKey:@"Ale_ID"],[[arr objectAtIndex:i]valueForKey:@"Beer_ID"]]];
//        
//        NSLog(@"%@",rs);
//        while ([rs next]) {
//            
//            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
//                                                   [rs stringForColumn:@"Ale_ID"],@"Ale_ID", 
//                                                   [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode",
//                                                   [rs stringForColumn:@"Ale_Name"],@"Ale_Name",
//                                                   [rs stringForColumn:@"Beer_ID"], @"Beer_ID",
//                                                   nil];
//            
//            
//            [arr1 addObject:tempDictionary];
//            [tempDictionary release];
//            
//            
//        }
//
//    }
  
    return [arr autorelease];

}

+(NSMutableArray *)GetSearchAleInfoFromBeer:(NSString *)_name
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct * from RealAle_Detail where Ale_ID=%@ group by Ale_ID",_name]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID", 
                                               [rs stringForColumn:@"Ale_Name"],@"Ale_Name",
                                               [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode"                                               ,nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
    }
        return [arr autorelease];
}

@end
