//
//  TwitterViewController.h
//  TestTwitter
//
//  Created by Biswajit Chatterjee on 30/11/11.
//  Copyright 2011 Web Spiders (India) Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"
//#import "BaseViewController.h"


@protocol TwitterViewDelegate <NSObject>
@optional
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username;					//implement these methods to store off the creds returned by Twitter
- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username;										//if you don't do this, the user will have to re-authenticate every time they run
- (void) twitterOAuthConnectionFailedWithData: (NSData *) data; 
@end

@interface TwitterView : UIViewController <UIWebViewDelegate>{
	
	IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    OAToken *requestToken;
    OAToken *accessToken;
    OAConsumer *consumer;
    
    NSDictionary *profile;
    
    // Theses ivars could be made into a provider class
    // Then you could pass in different providers for Twitter, LinkedIn, etc
    NSString *apikey;
    NSString *secretkey;
    NSString *requestTokenURLString;
    NSURL *requestTokenURL;
    NSString *accessTokenURLString;
    NSURL *accessTokenURL;
    NSString *userLoginURLString;
    NSURL *userLoginURL;
    NSString *linkedInCallbackURL;

    id <TwitterViewDelegate> _delegate;

}

@property(nonatomic, retain) OAToken *requestToken;
@property(nonatomic, retain) OAToken *accessToken;
@property(nonatomic, retain) NSDictionary *profile;
@property(nonatomic, retain) OAConsumer *consumer;
@property (nonatomic, assign) id <TwitterViewDelegate> _delegate;


- (void)initTwitterInApi;
- (void)requestTokenFromProvider;
- (void)allowUserToLogin;
- (void)accessTokenFromProvider;
- (NSString *) extractUsernameFromHTTPBody: (NSString *) body;
- (BOOL) isAuthorized;

@end
