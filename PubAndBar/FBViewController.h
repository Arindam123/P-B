//
//  FBViewController.h
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookController.h"
#import "MBProgressHUD.h"


@interface FBViewController : UIViewController<FacebookControllerDelegate,UITextViewDelegate>{
    
    IBOutlet UIImageView *bgImage;
    IBOutlet UITextView *textVIew;
    IBOutlet UIButton *submitButton;
    MBProgressHUD *_hud;
    NSString *shareText;

}
@property (retain) MBProgressHUD *hud;
@property (nonatomic, retain) NSString *shareText;

- (IBAction)submitButtonAction:(id)sender;

@end
