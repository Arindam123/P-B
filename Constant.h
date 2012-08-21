//
//  Constant.h
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Constant : NSObject{
    
}

+(NSString*)GetNibName:(NSString*)OriginalnibName;
+(NSString*)GetImageName:(NSString*)OriginalImageName;
+(BOOL)isiPad;
+(BOOL)isPotrait:(UIViewController*)controller;
+(CLLocationDistance)GetDistanceFromPub:(NSString*)_lat longitude:(NSString*)_long;
+(NSString*)GetCurrentDate;
+(NSString*)GetCurrentDateTime;

@end
