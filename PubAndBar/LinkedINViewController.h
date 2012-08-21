//
//  LinkedINViewController.h
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"

@interface LinkedINViewController : UIViewController<UITextViewDelegate>{
    
    IBOutlet UIImageView *bgImageView;
    IBOutlet UITextView *textView;
    IBOutlet UIButton *shareButton;
    NSString *shareText;
    OAuthLoginView *oAuthLoginView;
    OAConsumer *consumer;
    OAToken *accessToken;
    
    NSUserDefaults *defaults;


}
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property(nonatomic, retain) OAConsumer *consumer;
@property(nonatomic, retain) OAToken *accessToken;
@property (nonatomic, retain) NSString *shareText;


- (IBAction)shareButtonAction:(id)sender;

@end
