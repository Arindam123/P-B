//
//  SaveHomeInfo.m
//  PubAndBar
//
//  Created by User7 on 10/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveHomeInfo.h"

@implementation SaveHomeInfo

+(NSMutableArray *)GetMain_CatagoryInfo{
    
   AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    ResultSet *rs = [appDelegate.PubandBar_DB executeQuery:@"select * from Main_Catagory"];
    
    NSLog(@"%@",rs);
    while ([rs next]) {
       // NSString *ID = [NSString stringWithFormat:@"%d",[rs intForColumn:@"ID"]];
        //[arr addObject:ID];
         [arr addObject:[rs stringForColumn:@"CatagoryName"]];
        
        
    }
    
    return [arr autorelease];
}


@end
