//
//  iPhone OAuth Starter Kit
//
//  Supported providers: LinkedIn (OAuth 1.0a)
//
//  Lee Whitney
//  http://whitneyland.com
//
#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "OAConsumer_LinkedIn.h"
#import "OAMutableURLRequest_LinkedIn.h"
#import "OADataFetcher_LinkedIn.h"
#import "OATokenManager.h"


@interface OAuthLoginView : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *addressBar;
    
    OAToken_LinkedIn *requestToken;
    OAToken_LinkedIn *accessToken;
    
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
    OAConsumer_LinkedIn *consumer;
    
}

@property(nonatomic, retain) OAToken_LinkedIn *requestToken;
@property(nonatomic, retain) OAToken_LinkedIn *accessToken;
@property(nonatomic, retain) NSDictionary *profile;

- (void)initLinkedInApi;
- (void)requestTokenFromProvider;
- (void)allowUserToLogin;
- (void)accessTokenFromProvider;
- (void)testApiCallForGroups;
- (void)testApiCallForGroupDiscussionsWithGroupId:(int)groupId;

@end
