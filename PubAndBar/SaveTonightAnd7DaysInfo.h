//
//  SaveTonightAnd7DaysInfo.h
//  PubAndBar
//
//  Created by Apple on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTonightAnd7DaysInfo : NSObject

+(NSMutableArray *)GetNext7DaysRegularEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetNext7DaysOneOffEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetNext7DaysThemeNightEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetTonightRegularEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetTonightOneOffEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetTonightThemeNightEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetTonightSportEvent_DetailsInfo:(int)Pubid;
+(NSMutableArray *)GetNext7daysSportEvent_DetailsInfo:(int)Pubid;
@end
