//
//  SavePreferenceInfo.h
//  PubAndBar
//
//  Created by Subhra Da on 28/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SavePreferenceInfo : NSObject
+(NSMutableArray *)GetFavourites_DetailsInfo;
+(NSMutableArray *)GetRecentSearch_DetailsInfo;
+(void)RemoveData_Preference_Favourites:(int) pubId;
+(void)RemoveData_Preference_RecentHistory:(int)pubId;
@end
