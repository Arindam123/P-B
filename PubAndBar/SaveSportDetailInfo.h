//
//  SaveSportDetailInfo.h
//  PubAndBar
//
//  Created by User7 on 11/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveSportDetailInfo : NSObject{

}
+(NSMutableArray *)GetSport_EventInfo :(NSString *)ID withRadius:(NSString *) _radius;

+(NSMutableArray *)GetSport_EventInfo_Details :(int)Pubid;
@end
