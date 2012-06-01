//
//  SaveEventCatagoryInfo.h
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveEventCatagoryInfo : NSObject{
    
    

}
+(NSMutableArray *)GetEventInfo;
+(BOOL)Pub_isInDistnce_Intype:(NSString*)event_type;
//+(NSMutableArray *)GetEventInfo:(NSString*)_radius;
+(BOOL)Pub_isInDistnce_Intype:(NSString*)event_type;
+(void)ServiceEvents;//:(NSString*)rad;
+(void)ToNightEvents;
+(void)SevenDaysEvent;

@end
