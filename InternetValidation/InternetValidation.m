//
//  InternetValidation.m
//  UrbanChat
//
//  Created by Subhra Roy on 09/07/11.
//  Copyright 2011 Indusnet. All rights reserved.
//

#import "InternetValidation.h"
#import "Reachability.h"

@implementation InternetValidation

+ (BOOL) connectedToNetwork
{
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		//[Design showConfirmAlert:@"Urban Chat" :@"No Internet Connection \n\nThe application cannot go further because you are not connected to the internet. Please check your connection and try again. Also check to make sure your device is not currently in Airplane Mode" :nil :[NSMutableArray arrayWithObjects:@"OK",nil] :FALSE];
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	
	if (!isReachable && !needsConnection) {
		;//[Design showConfirmAlert:@"Urban Chat" :@"No Internet Connection \n\nThe application cannot go further because you are not connected to the internet. Please check your connection and try again. Also check to make sure your device is not currently in Airplane Mode" :nil :[NSMutableArray arrayWithObjects:@"OK",nil] :FALSE];
	}
	
	return (isReachable && !needsConnection) ? YES : NO;
}



+(BOOL) checkNetworkStatus
{
    BOOL status;
    Reachability *internetReachable=[Reachability reachabilityForInternetConnection];
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            //NSLog(@"The internet is down.");
            
            status=NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"The internet is working via WIFI.");
            status=YES;

            
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"The internet is working via WWAN.");
            status=YES;

            break;
        }
    }
    return status;
}



+ (BOOL) hasConnectivity
{
   
    return ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com/"] encoding:NSUTF8StringEncoding error:nil]!=NULL)?YES:NO;
}


@end
