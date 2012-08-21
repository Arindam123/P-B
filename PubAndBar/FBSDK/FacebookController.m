//
//  FacebookController.m
//  FBSSO
//
//  Created by ARINDAM GHOSH on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookController.h"
//#import "AppDelegate.h"



//App Secret d7d3198dec412b36d224ab2900b550bc
static NSString* kAppId = @"212756008760";//@"149607808476669";


@interface FacebookController ()

-(void) login;
-(void) postToFacebook :(NSMutableDictionary*)_params;

@end

@implementation FacebookController

@synthesize permissions,fbDelegate,facebook;


/*-(id) init
{
    if ((self = [super init])) {
     
        //[[self fbDelegate] FBLoginDone:self];
    }
    return self;
}*/


+ (FacebookController *)sharedInstance
{
    static FacebookController *sharedInstance_;

	if (!sharedInstance_) {
		sharedInstance_ = [[FacebookController alloc] init];
		
	}
	return sharedInstance_;
}

- (BOOL)sessionValid
{
    return [facebook isSessionValid];
}



-(void) initialize
{
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    
    // Check App ID:
    // This is really a warning for the developer, this should not
    // happen in a completed app
    if (!kAppId) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Setup Error"
                                  message:@"Missing app ID. You cannot run the app until you provide this in the code."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil,
                                  nil];
        [alertView show];
        [alertView release];
    } else {
        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
        // be opened, doing a simple check without local app id factored in here
        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([aBundleURLTypes isKindOfClass:[NSArray class]] &&
            ([aBundleURLTypes count] > 0)) {
            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                    ([aBundleURLSchemes count] > 0)) {
                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                    if ([scheme isKindOfClass:[NSString class]] &&
                        [url hasPrefix:scheme]) {
                        bSchemeInPlist = YES;
                    }
                }
            }
        }
        // Check if the authorization callback will work
        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
        if (!bSchemeInPlist || !bCanOpenUrl) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Setup Error"
                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil,
                                      nil];
            [alertView show];
            [alertView release];
        }
    }
    
//    permissions = [[NSArray alloc] initWithObjects:@"offline_access",@"email", nil];

    
    NSLog(@"token  %@  %@",facebook.accessToken,facebook.expirationDate);
    
    permissions = [[NSArray alloc] initWithObjects:@"publish_stream", nil];
    [self login];

}

#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[self facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions {
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[self facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}



#pragma - Private Helper Methods

/**
 * Show the logged in menu
 */

- (void)showLoggedIn {
    /* [self.navigationController setNavigationBarHidden:NO animated:NO];
     
     self.backgroundImageView.hidden = YES;
     loginButton.hidden = YES;
     self.menuTableView.hidden = NO;*/
    
    [self apiFQLIMe];
}

/**
 * Show the logged in menu
 */

- (void)showLoggedOut {
    /*   [self.navigationController setNavigationBarHidden:YES animated:NO];
     
     self.menuTableView.hidden = YES;
     self.backgroundImageView.hidden = NO;
     loginButton.hidden = NO;
     
     // Clear personal info
     nameLabel.text = @"";
     // Get the profile image
     [profilePhotoImageView setImage:nil];
     
     [[self navigationController] popToRootViewControllerAnimated:YES];*/
}

/**
 * Show the authorization dialog.
 */
- (void)login {
   // AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[self facebook] isSessionValid]) {
        [[self facebook] authorize:permissions];
    } else {
        [self showLoggedIn];
    }
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[self facebook] logout];
}



- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    
    NSLog(@"token  %@  %@",accessToken,expiresAt);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}



#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self showLoggedIn];
    
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[self facebook] accessToken] expiresAt:[[self facebook] expirationDate]];
    
    //[pendingApiCallsController userDidGrantPermission];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    //NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    //[pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    //pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}

-(void) postToFacebook :(NSMutableDictionary*)_params
{
    //NSLog(@"postToFacebook _params  %@",_params);
    [[self facebook] requestWithGraphPath:@"me/feed" andParams:_params andHttpMethod:@"POST" andDelegate:self];
}
/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
   // NSLog(@"FbResult    %@",result);
    if ([result objectForKey:@"name"]) {
        // If basic information callback, set the UI objects to
        // display this.
        //nameLabel.text = [result objectForKey:@"name"];
        //NSLog(@"Name   %@  object   %@",[result objectForKey:@"name"],result);
        // Get the profile image
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
        
        // Resize, crop the image to make sure it is square and renders
        // well on Retina display
        float ratio;
        float delta;
        float px = 100; // Double the pixels of the UIImageView (to render on Retina)
        CGPoint offset;
        CGSize size = image.size;
        if (size.width > size.height) {
            ratio = px / size.width;
            delta = (ratio*size.width - ratio*size.height);
            offset = CGPointMake(delta/2, 0);
        } else {
            ratio = px / size.height;
            delta = (ratio*size.height - ratio*size.width);
            offset = CGPointMake(0, delta/2);
        }
        /*CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                     (ratio * size.width) + delta,
                                     (ratio * size.height) + delta);
        UIGraphicsBeginImageContext(CGSizeMake(px, px));
        UIRectClip(clipRect);
        [image drawInRect:clipRect];
        UIImage *imgThumb = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [profilePhotoImageView setImage:imgThumb];*/
        
        [self apiGraphUserPermissions];
        if ([fbDelegate respondsToSelector:@selector(FBLoginDone:)]) {
            
            [fbDelegate FBLoginDone:result];
            
        }
        
    } else {
        // Processing permissions information
        //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //[delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
       
        if ([fbDelegate respondsToSelector:@selector(GetFBData:)]) {
            
            [fbDelegate GetFBData:result];
            
        }
    }
   
    
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    //NSLog(@"Err code: %d", [error code]);
    //NSLog(@"ERR DEscription   %@",[error description]);
 
    if ([fbDelegate respondsToSelector:@selector(RequestError:)]) {
        
        [fbDelegate RequestError:error];
        
    }
}



#pragma mark - Memory Cleanup

-(void) dealloc
{
    [permissions release];
    [fbDelegate release];
    [facebook release];
    [super dealloc];
}



@end
