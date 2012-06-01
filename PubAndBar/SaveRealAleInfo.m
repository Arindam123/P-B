//
//  SaveRealAleInfo.m
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveRealAleInfo.h"

@implementation SaveRealAleInfo

+(NSMutableArray *)GetAleInfo :(NSString *)_radius
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arr4AleID = [[NSMutableArray alloc]init];

    
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Distinct Ale_ID from Ale_BeerDetail where PubDistance %@",_radius]];
    
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


@end
