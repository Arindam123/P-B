//
//  SaveAleDetailInfo.h
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveAleDetailInfo : NSObject{

  
}


+(NSMutableArray *)GetBeerInfo :(NSString*)ID radius:(NSString *)_rad beer_Name:(NSString *)_str;

+(NSMutableArray *)GetSearchBeerInfo:(NSString*)Ale radius:(NSString *)_rad;

@end
