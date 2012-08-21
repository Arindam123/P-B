//
//  SaveSportMicrositeInfo.h
//  PubAndBar
//
//  Created by Apple on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveSportMicrositeInfo : NSObject

+(NSMutableArray *)GetSport_EventInfo_Details :(int)Pubid Sport_EventID:(int)SportEventID;
@end
