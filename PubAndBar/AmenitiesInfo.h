//
//  AmenitiesInfo.h
//  PubAndBar
//
//  Created by Subhra Da on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AmenitiesInfo : NSObject
+(NSMutableArray *)GetAmmenity_NameInfo:(NSInteger)ID radius:(NSString *)rad;
@end
