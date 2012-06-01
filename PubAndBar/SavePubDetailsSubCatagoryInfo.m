//
//  SavePubDetailsSubCatagoryInfo.m
//  PubAndBar
//
//  Created by Apple on 22/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SavePubDetailsSubCatagoryInfo.h"
#import "FoodDetails_Microsite.h"

@implementation SavePubDetailsSubCatagoryInfo


+(NSMutableArray *)GetFoodDetailsInfo:(int)ID{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from Food_Detail where PubID=%d",ID]];
        

    
       
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Food_Information"],@"Food_Information", 
                                               [rs stringForColumn:@"Food_ServingTime"],@"Food_ServingTime",
                                               [rs stringForColumn:@"Food_ChefDescription"],@"Food_ChefDescription",
                                               [rs stringForColumn:@"Food_SpecialOffer"],@"Food_SpecialOffer"
                                               ,nil];
        
        [arr addObject:tempDictionary];
        [tempDictionary release];
        
        
        
    }
    
    return [arr autorelease];
    
}


+(NSMutableArray *)GetFoodTypeInfo:(int)ID
{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr4PubID = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs;
    
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select distinct FoodTypeID from Food_Detail where PubID=%d",ID]];
    
    NSLog(@"%@   %d",rs,ID);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               [rs stringForColumn:@"FoodTypeID"],@"FoodTypeID"
                                                ,nil];
        
        [arr4PubID addObject:tempDictionary];
        [tempDictionary release];
        
    }
    
    NSLog(@"ARRAY 4 pubID %@",arr4PubID);
    // ResultSet *rs2;
    
    
    for (int i =0; i<[arr4PubID count]; i++) {
        
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select Food_Name from Food_Type where Food_ID=%d",[[[arr4PubID objectAtIndex:i] valueForKey:@"FoodTypeID"] intValue]]];
        
        
        
        while ([rs next]) {
                                      

            
            [arr addObject:[rs stringForColumn:@"Food_Name"]]; 
           // [tempDictionary2 release];
        }
        
    }
      
    [arr4PubID release];
    
    NSLog(@"ARRAy   %@",arr);
    
    return [arr autorelease];
}




@end
