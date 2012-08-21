//
//  SavePubDetailsInfo.h
//  PubAndBar
//
//  Created by User7 on 18/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavePubDetailsInfo : NSObject{
//    NSMutableArray *OpenHourArray;
//    NSMutableArray *OpenDayArray;

    }

//@property(nonatomic,retain) NSMutableArray *OpenHourArray;
//@property(nonatomic,retain) NSMutableArray *OpenDayArray;

+(NSMutableArray *)GetPubListInfo:(int)ID withCategoryStr:(NSString *) catStr;

+(NSMutableArray *)GetPubDetailsInfo:(int)_ID;
//+(NSMutableArray *)GetEvent_DetailsInfo:(int)eventId;
+(NSMutableArray *)GetEvent_DetailsInfo:(int)eventType event_ID:(int)ID;
+(NSMutableArray *)GetPhotoGalaryInfo:(int)_ID;
+(NSMutableArray *)GetFunctionRoomImagesInfo:(int)_ID;
+(NSMutableArray *)GetFoodDrinkImagesInfo:(int)_ID;
@end
