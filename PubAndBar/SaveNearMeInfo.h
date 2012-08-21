//
//  SaveNearMeInfo.h
//  PubAndBar
//
//  Created by ARINDAM GHOSH on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveNearMeInfo : NSObject{
    

}
+(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude;

+(NSMutableArray *)GetNearMePubsInfo:(NSString *)pubDistance;
+(NSMutableArray *)GetNearMeNonSubPubsInfo:(NSString *)pubDistance withLimitValue:(int) _limitVal hitCount:(int)_count;

@end
