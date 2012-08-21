//
//  SaveAleDetailInfo.m
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveAleDetailInfo.h"

@implementation SaveAleDetailInfo


+(NSMutableArray *)GetBeerInfo :(NSString*)ID radius:(NSString *)_rad beer_Name:(NSString *)_str{
    
    NSLog(@"ID  %@",ID);
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ResultSet * rs;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct PubID from PubDetails"]];
    
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"PubID"],@"PubID"
                                               ,nil];
        
        
        [arr4PubID addObject:[tempDictionary valueForKey:@"PubID"]];
        [tempDictionary release];
        
        
    }
    
    
    NSLog(@"PUBID  %@",arr4PubID);
    
    
  /*  if (_rad==nil) {
        if ([_str isEqualToString:@"ale"]) {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Ale_ID=%@",ID]];
        }else
        {
            rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Beer_ID=%@ group by Beer_ID",ID]];
        }
        
    }else
    {
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Ale_ID=%@ and PubID IN %@ group by Beer_ID",ID,arr4PubID]];
    }
    */
     rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Ale_ID=%@ and PubID IN %@ group by Beer_ID",ID,arr4PubID]];
    NSLog(@"%@",rs);
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Beer_Name"],@"Beer_Name", 
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID",
                                               [rs stringForColumn:@"Beer_ID"],@"Beer_ID",
                                               [rs stringForColumn:@"Catagory"],@"Catagory",
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"Beer_ABV"],@"Beer_ABV",
                                               [rs stringForColumn:@"Beer_Color"],@"Beer_Color",
                                               [rs stringForColumn:@"Beer_Smell"],@"Beer_Smell",
                                               [rs stringForColumn:@"Beer_Taste"],@"Beer_Taste",
                                               [rs stringForColumn:@"License_Note"],@"License_Note",
                                               nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    [arr4PubID release];
    
    return [arr autorelease];
}


+(NSMutableArray *)GetSearchBeerInfo:(NSString*)Ale radius:(NSString *)_rad
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Beer_Name=%@ and PubDistance %@",Ale,_rad]];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Beer_Name"],@"Beer_Name", 
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID",
                                               [rs stringForColumn:@"Beer_ID"],@"Beer_ID",
                                               [rs stringForColumn:@"Catagory"],@"Catagory",
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"Beer_ABV"],@"Beer_ABV",
                                               [rs stringForColumn:@"Beer_Color"],@"Beer_Color",
                                               [rs stringForColumn:@"Beer_Smell"],@"Beer_Smell",
                                               [rs stringForColumn:@"Beer_Taste"],@"Beer_Taste",
                                               [rs stringForColumn:@"License_Note"],@"License_Note",
                                               nil];
        
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [arr autorelease];
}
@end
