//
//  Toolbar.h
//  PubAndBar
//
//  Created by User7 on 09/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toolbar : UIView{

    UIButton *btntwitter;
    UIButton *btngoogleplus;
    UIButton *btnlinkedin;
    UIButton *btnfacebook;
    UIButton *btnmessage;
    UIButton *btnsetting;
    UIButton *moreButton;
    UIButton *backButton;
    UIButton *licenseeLoginButton;
    UIButton *visitorSignUpButton;
    UIButton *btn_licenceLogin;
    UIButton *btn_VisitorSingup;
    UIImageView *img;

}
@property(nonatomic,retain)UIButton *btn_VisitorSingup;
@property(nonatomic,retain)UIButton *btn_licenceLogin;
@property(nonatomic,retain)UIButton *btntwitter;
@property(nonatomic,retain)UIButton *btngoogleplus;
@property(nonatomic,retain)UIButton *btnlinkedin;
@property(nonatomic,retain)UIButton *btnfacebook;
@property(nonatomic,retain)UIButton *btnmessage;
@property(nonatomic,retain)UIButton *btnsetting;
@property(nonatomic,retain)UIButton *licenseeLoginButton;
@property(nonatomic,retain)UIButton *visitorSignUpButton;
@property(nonatomic,retain)UIButton *moreButton;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UIImageView *img;





-(void)DesignToolBar;


@end
