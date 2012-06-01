//
//  Constant.m
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Constant.h"
#import "AppDelegate.h"



@implementation Constant


+(NSString*)GetNibName:(NSString*)OriginalnibName{
	if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
		return [NSString stringWithFormat:@"%@_iPad",OriginalnibName];
	}
	else {
		return [NSString stringWithFormat:@"%@_iPhone",OriginalnibName];
	}
}
+(NSString*)GetImageName:(NSString*)OriginalImageName{
    NSLog(@"%@",[Constant GetNibName:OriginalImageName]);
	return [NSString stringWithFormat:@"%@.png",[Constant GetNibName:OriginalImageName]];
}

+(BOOL)isiPad{
	return (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad);
}

+(BOOL)isPotrait:(UIViewController*)controller{
	BOOL Result;
	if ([Constant isiPad]) {
		if (controller.interfaceOrientation == UIDeviceOrientationPortrait || controller.interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
			Result = YES;
		}
		else {
			Result = NO;
		}
	}
	else {
		Result = (controller.interfaceOrientation == UIInterfaceOrientationPortrait || controller.interfaceOrientation == UIDeviceOrientationPortraitUpsideDown);
	}
    
	return Result;
}

+(CLLocationDistance)GetDistanceFromPub:(NSString*)_lat longitude:(NSString*)_long{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:app.currentPoint.coordinate.latitude longitude:app.currentPoint.coordinate.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:[_lat doubleValue] longitude:[_long doubleValue]];
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    return distance;
}


+(NSString*)GetCurrentDateTime{
    NSDate *dateTime = [NSDate date ];                          
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setLocale:[NSLocale currentLocale]];
    NSString *dateString = [dateFormat stringFromDate:dateTime];  
    [dateFormat release];
    NSLog(@"Date: %@:", dateString);    
    return dateString;
    
}

@end
