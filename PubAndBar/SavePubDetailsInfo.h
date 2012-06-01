//
//  SavePubDetailsInfo.h
//  PubAndBar
//
//  Created by User7 on 18/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavePubDetailsInfo : NSObject{
    }

+(NSMutableArray *)GetPubListInfo:(int)ID withCategoryStr:(NSString *) catStr;

+(NSMutableArray *)GetPubDetailsInfo:(int)_ID;
+(NSMutableArray *)GetEvent_DetailsInfo:(int)eventId;


@end
