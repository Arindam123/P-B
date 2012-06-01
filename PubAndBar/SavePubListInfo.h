//
//  SavePubListInfo.h
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SavePubListInfo : NSObject{
    
}
+(NSMutableArray *)GetPubDetailsInfo:(int)ID withCategoryStr:(NSString *) catStr withRadius:(NSString *) _radius;
+(NSMutableArray *)GetPubDetailsInfo1:(int)CatagoryID withID:(int)ID withCategoryStr:(NSString *) catStr;

//--------------------------mb---25/05/12/5-45-------------------------------//
+(NSMutableArray *)GetPubDetailsInfo:(NSMutableArray *)array AmmenityID:(int)ammenityID radius:(NSString *)rad ;
@end
