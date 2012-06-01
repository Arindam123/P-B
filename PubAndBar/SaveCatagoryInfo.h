//
//  SaveCatagoryInfo.h
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveCatagoryInfo : NSObject{

}
+(NSMutableArray *)GetSport_CatagoryNameInfo :(NSString *) _radius;
+(NSMutableArray *)GetEvent_DetailInfo :(NSString *)ID;

+(NSMutableArray *)GetPubDetailsInfo :(NSString *)Date;
+(NSMutableArray *)GetPubDetailsInfo1;
+(NSMutableArray *)GetFood_Type :(NSString *) _radius;
+(NSMutableArray *)GetAmmenity_NameInfo;
+(NSMutableArray*)getDateEvent:(NSString*)_date isfortonight:(BOOL)_isnight;
@end
