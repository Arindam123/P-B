//
//  TwitterViewController.h
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterView.h"

@interface TwitterViewController : UIViewController<TwitterViewDelegate,UITextViewDelegate>{
    
    IBOutlet UIImageView *bgImageView;
    IBOutlet UITextView *textView;
    IBOutlet UIButton *shareButton;
    NSString *textString;
    TwitterView *twitterObj;
    
    OAToken *accessToken;
    OAConsumer *consumer;
    
    NSUserDefaults *defaults;
}

@property (nonatomic, retain) NSString *textString;
@property (nonatomic, retain) TwitterView *twitterObj;
@property (nonatomic, retain) OAToken *accessToken;
@property (nonatomic, retain) OAConsumer *consumer;


- (IBAction)shareButtonAction:(id)sender;

@end
