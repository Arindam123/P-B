//
//  SaveTextSearchInfo.h
//  PubAndBar
//
//  Created by Subhra Da on 05/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveTextSearchInfo : NSObject
+(NSMutableArray *)GetPubDetailsInfo:(NSString *)_pubName;

+(NSMutableArray *)GetAle_beerdetailInfo:(NSString *)_txt;
+(NSMutableArray *)GetRealAle_DetailInfo:(NSString *)_txt;

+(NSMutableArray *)GetFood_TypeInfo:(NSString *)_txt;
+(NSMutableArray *)GetAmmenitiesInfo:(NSString *)_txt;
+(NSMutableArray *)GetAmmenity_DetailInfo:(NSString *)_txt;
+(NSMutableArray *)GetEventInfo:(NSString *)_txt;
+(NSMutableArray *)GetEvent_DetailInfo:(NSString *)_txt;
+(NSMutableArray *)GetSport_CatagoryNameInfo:(NSString *)_txt;
//+(NSMutableArray *)GetSport_EventInfo:(NSString *)_txt;


+(NSMutableArray *)GetSearchByVenue:(NSString *)_pubName;
+(NSMutableArray *)GetSearchByPostcode:(NSString *)_pubName;
+(NSMutableArray *)GetSearchByCity:(NSString *)_pubName;
@end
