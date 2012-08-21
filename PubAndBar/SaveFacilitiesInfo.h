//
//  SaveFacilitiesInfo.h
//  PubAndBar
//
//  Created by Apple on 01/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveFacilitiesInfo : NSObject

+(NSMutableArray *)GetFacilityInfo:(int)ID;
+(NSMutableArray *)GetFeatureInfo:(int)ID;
+(NSMutableArray *)GetStyleInfo:(int)ID;
@end
