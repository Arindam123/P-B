//
//  iCodeOauthViewController.h
//  iCodeOauth
//
//  Created by Collin Ruffenach on 9/14/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
//@class LoadingView;
@class SampleGdataAppDelegate;



@interface iCodeOauthViewController : UIViewController <SA_OAuthTwitterEngineDelegate, SA_OAuthTwitterControllerDelegate,UITextViewDelegate/*,UITableViewDelegate,UITableViewDataSource*/> {

	SA_OAuthTwitterEngine *_engine;
	NSMutableArray *tweets;
	NSMutableArray *tempArray;
    IBOutlet UIButton *button4LogOut;
	IBOutlet UIButton *tweetButton;
    IBOutlet UITextView *tweetTxtView;
    IBOutlet UITableView *table;
    UIActivityIndicatorView *spinner;
	//LoadingView *loadingView;

    IBOutlet UIImageView *twtBgVw;
	BOOL callingAfterTwitt;
	SampleGdataAppDelegate *appDel;
	
	UIBarButtonItem *barButton;
    NSString *twt_text;
    

}
@property(nonatomic,retain) NSString *twt_text;

-(IBAction)tweet:(id)sender;
-(IBAction)button4LogOutPressed:(id)sender;

@end

