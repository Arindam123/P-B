//
//  NavigationBar.h
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import "SFCustomNavigationBar.h"

@interface NavigationBar : UIViewController{
    
    UINavigationBar *navBar;
    UIView *mainNavigationView;
    UILabel *headline;
    UIButton *homeimg;
    UILabel *statuslbl;
    UIButton *btn_licenselogin;
    UIView *bar_vw;
    UILabel *homeTextLbl;
    UILabel *eventTextLbl;
}
@property(nonatomic,retain)UINavigationBar *navBar;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UIView *mainNavigationView;
@property(nonatomic,retain)UIButton *homeimg;
@property(nonatomic,retain)UILabel *statuslbl;
@property(nonatomic,retain)UIButton *btn_licenselogin;
@property(nonatomic,retain)UIView *bar_vw;
@property(nonatomic,retain)UILabel *eventTextLbl;


-(UIView *)CreateCustomNavigationView;
-(void)SetCustomNavBarFrame ;

//-(void)CreateBackView;
//-(void)setbackViewFrame;
@end
