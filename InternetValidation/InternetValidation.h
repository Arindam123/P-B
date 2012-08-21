//
//  InternetValidation.h
//  UrbanChat
//
//  Created by Subhra Roy on 09/07/11.
//  Copyright 2011 Indusnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>

@interface InternetValidation : NSObject {
	
}
+ (BOOL) connectedToNetwork;
+(BOOL) checkNetworkStatus;
+(BOOL)hasConnectivity;
@end
