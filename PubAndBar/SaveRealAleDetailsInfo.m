//
//  SaveRealAleDetailsInfo.m
//  PubAndBar
//
//  Created by Apple on 22/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveRealAleDetailsInfo.h"
#import "PubDetail.h"
#import "RealAle_Microsite.h"

@implementation SaveRealAleDetailsInfo

+(NSMutableArray *)GetRealAleTypeInfo:(int)ID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct Ale_ID from RealAle_Detail where PubID=%d",ID]];
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Ale_ID"],@"Ale_ID"
                                               ,nil];
        
        [arr4PubID addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    NSLog(@"ARRAY 4 pubID %@",arr4PubID);
    // ResultSet *rs2;
    
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from RealAle_Detail where Ale_ID=%d AND PubID=%d group by Ale_ID",[[[arr4PubID objectAtIndex:i] valueForKey:@"Ale_ID"] intValue],ID]];
        
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                [rs stringForColumn:@"Ale_Name"],@"Ale_Name",
                                                [rs stringForColumn:@"Ale_MailID"],@"Ale_MailID",
                                                [rs stringForColumn:@"Ale_Website"],@"Ale_Website",
                                                [rs stringForColumn:@"Ale_Address"],@"Ale_Address",
                                                [rs stringForColumn:@"Ale_Postcode"],@"Ale_Postcode",
                                          [rs stringForColumn:@"Ale_PhoneNumber"],@"Ale_PhoneNumber",
                                            [rs stringForColumn:@"Ale_District"],@"Ale_District",
                                            [rs stringForColumn:@"Ale_ContactName"],@"Ale_ContactName",
                                                    [rs stringForColumn:@"Ale_ID"],@"Ale_ID",
                                            nil];
            
            [arr addObject:tempDictionary1];
            [tempDictionary1 release];

                      
        }
        
    }
    
    [arr4PubID release];
    
    NSLog(@"ARRAy   %@",arr);
    
    return [arr autorelease];
}

/*
+(NSMutableArray *)GetAleBeerDetailsInfo:(int)ID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct Beer_ID from Ale_BeerDetail where PubID=%d",ID]];
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Beer_ID"],@"Beer_ID"
                                               ,nil];
        
        [arr4PubID addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    NSLog(@"ARRAY 4 pubID %@",arr4PubID);
    // ResultSet *rs2;
    
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Beer_ID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"Beer_ID"] intValue]]];
        
        
        
        while ([rs next]) {
            
            NSMutableDictionary *tempDictionary1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"Beer_Name"],@"Beer_Name",
                                                    [rs stringForColumn:@"Catagory"],@"Catagory",
                                                    [rs stringForColumn:@"Beer_ABV"],@"Beer_ABV",
                                                    [rs stringForColumn:@"Beer_Color"],@"Beer_Color",
                                                    [rs stringForColumn:@"Beer_Smell"],@"Beer_Smell",
                                                    [rs stringForColumn:@"Beer_Taste"],@"Beer_Taste",
                                                    [rs stringForColumn:@"License_Note"],@"License_Note",
//                                                    [rs stringForColumn:@"Ale_District"],@"Ale_District",
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
+(NSMutableArray *)GetAleBeerDetailsInfo:(int)ID withPubID:(int) _pubID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
   
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Ale_BeerDetail where Ale_ID=%d and PubID=%d group by Beer_ID",ID,_pubID]];
    
    NSLog(@"%@  AleID> %d   pubID> %d",rs,ID,_pubID);
    while ([rs next]) {
           
        
       
            
            NSMutableDictionary *tempDictionary1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"Beer_Name"],@"Beer_Name",
                                                    [rs stringForColumn:@"Catagory"],@"Catagory",
                                                    [rs stringForColumn:@"Beer_ABV"],@"Beer_ABV",
                                                    [rs stringForColumn:@"Beer_Color"],@"Beer_Color",
                                                    [rs stringForColumn:@"Beer_Smell"],@"Beer_Smell",
                                                    [rs stringForColumn:@"Beer_Taste"],@"Beer_Taste",
                                                    [rs stringForColumn:@"License_Note"],@"License_Note",
                                                  
                                                    nil];
            
            [arr addObject:tempDictionary1];
            [tempDictionary1 release];
            
            
        }
      
        
    return [arr autorelease];
}



@end
