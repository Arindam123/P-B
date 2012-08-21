//
//  Toolbar.m
//  PubAndBar
//
//  Created by User7 on 09/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Toolbar.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@implementation Toolbar
@synthesize btntwitter;
@synthesize btngoogleplus;
@synthesize btnlinkedin;
@synthesize btnfacebook;
@synthesize btnmessage;
@synthesize btnsetting;
@synthesize licenseeLoginButton;
@synthesize visitorSignUpButton;
@synthesize moreButton;
@synthesize backButton;
@synthesize btn_licenceLogin;
@synthesize btn_VisitorSingup;
@synthesize img;


UIInterfaceOrientation orientation;


AppDelegate *app;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self DesignToolBar];
    }
    return self;
}
//--------------------------------------mb-30-05-12----------------------------------//
-(void)DesignToolBar{
   
    
    /*CAGradientLayer *gradient;
    
    gradient = [CAGradientLayer layer];
    gradient.frame=CGRectMake(5, 340, 303, 53);
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:198.0/255.0 green:205.0/255.0 blue:206.0/255.0 alpha:1.0].CGColor,nil];
    [self.layer insertSublayer:gradient atIndex:0];*/
//    UIDevice *currentDevice = [UIDevice currentDevice];
//    if (currentDevice.orientation == UIDeviceOrientationPortrait || currentDevice.orientation == UIDeviceOrientationPortraitUpsideDown) {
//        
//        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 303, 53)];
//        img.image=[UIImage imageNamed:@"FootarBar.png"];
//    }
//    if (currentDevice.orientation == UIDeviceOrientationLandscapeLeft || currentDevice.orientation == UIDeviceOrientationLandscapeRight) {
//        
//        img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 303, 53)];
//        img.image=[UIImage imageNamed:@"FootarBarL.png"];
//    }
//    [self addSubview:img];

    //self.backgroundColor=[UIColor clearColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
      self.frame = CGRectMake(8.5, 377, 303, 53);

    
  
    btntwitter = [UIButton buttonWithType:UIButtonTypeCustom];
    btntwitter.frame=CGRectMake(4, 3, 46, 44);
    btntwitter.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    btntwitter.backgroundColor=[UIColor clearColor];
    [btntwitter addTarget:self action:@selector(ShareOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    
    [btntwitter setImage:[UIImage imageNamed:@"TwitterDeselect.png"] forState:UIControlStateNormal];
    
    btngoogleplus = [UIButton buttonWithType:UIButtonTypeCustom];
    btngoogleplus.frame = CGRectMake(52, 3, 46, 44);
    btngoogleplus.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btngoogleplus.backgroundColor=[UIColor clearColor];
    [btngoogleplus addTarget:self action:@selector(ShareOnGooglePlus:) forControlEvents:UIControlEventTouchUpInside];
    [btngoogleplus setImage:[UIImage imageNamed:@"GPluseButtonDeselect.png"] forState:UIControlStateNormal];
    
    btnlinkedin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnlinkedin.frame = CGRectMake(100, 3, 46, 44);
    btnlinkedin.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnlinkedin.backgroundColor=[UIColor clearColor];
    [btnlinkedin addTarget:self action:@selector(ShareOnLinkedin:) forControlEvents:UIControlEventTouchUpInside];
    [btnlinkedin setImage:[UIImage imageNamed:@"InDeselect.png"]forState:UIControlStateNormal];
    
    btnfacebook = [UIButton buttonWithType:UIButtonTypeCustom];
    btnfacebook.frame = CGRectMake(148, 3, 46, 44);
    btnfacebook.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnfacebook.backgroundColor=[UIColor clearColor];
    [btnfacebook addTarget:self action:@selector(ShareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnfacebook setImage:[UIImage imageNamed:@"FaceBookDeselect.png"] forState:UIControlStateNormal];
    
    btnmessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnmessage.frame = CGRectMake(196, 3, 46, 44);
    btnmessage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnmessage.backgroundColor=[UIColor clearColor];
    [btnmessage addTarget:self action:@selector(Message:) forControlEvents:UIControlEventTouchUpInside];
    [btnmessage setImage:[UIImage imageNamed:@"MailButtonSelect.png"] forState:UIControlStateNormal];
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame= CGRectMake(244, 3, 46, 44);
    moreButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    //moreButton.backgroundColor=[UIColor redColor];
    [moreButton setImage:[UIImage imageNamed:@"MoreButtonDeselect.png"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"MoreButtonSelect.png"] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreButton:) forControlEvents:UIControlEventTouchUpInside];
    //[moreButton setImage:[UIImage imageNamed:@"SettingsButton2.png"] forState:UIControlStateNormal];
    
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  backButton.frame= CGRectMake(150, 2, 44, 44);
    
    backButton.frame= CGRectMake(4, 3, 46, 44);
    backButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    //backButton.backgroundColor=[UIColor redColor];
    [backButton setImage:[UIImage imageNamed:@"BackButtonDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackButtonSelect.png"] forState:UIControlStateHighlighted]; 
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    btnsetting = [UIButton buttonWithType:UIButtonTypeCustom];
    //btnsetting.frame= CGRectMake(170, 2, 44, 44);
    
    btnsetting.frame= CGRectMake(50, 3, 46, 44);
    btnsetting.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnsetting.backgroundColor=[UIColor clearColor];
    [btnsetting addTarget:self action:@selector(Settings:) forControlEvents:UIControlEventTouchUpInside];
    [btnsetting setImage:[UIImage imageNamed:@"SettingsSelect.png"] forState:UIControlStateNormal];
    
    
    btn_licenceLogin = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn_licenceLogin.frame= CGRectMake(195, 2, 44, 44);
    
    btn_licenceLogin.frame= CGRectMake(98, 3, 46, 44);
    btn_licenceLogin.titleLabel.font=[UIFont boldSystemFontOfSize:10];
    btn_licenceLogin.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btn_licenceLogin.titleLabel.numberOfLines=2;
    btn_licenceLogin.titleLabel.textAlignment=UITextAlignmentCenter;
    [btn_licenceLogin setImage:[UIImage imageNamed:@"LoginButtonDeselect.png"] forState:UIControlStateNormal];
    [btn_licenceLogin setImage:[UIImage imageNamed:@"LoginButtonSelect.png"] forState:UIControlStateHighlighted];
    [btn_licenceLogin addTarget:self action:@selector(Licensee:) forControlEvents:UIControlEventTouchUpInside];
  //  [btn_licenceLogin setImage:[UIImage imageNamed:@"SettingsButton2.png"] forState:UIControlStateNormal];

    btn_VisitorSingup = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn_VisitorSingup.frame= CGRectMake(220, 2, 44, 44);
    btn_VisitorSingup.frame= CGRectMake(146, 3, 46, 44);
    btn_VisitorSingup.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
     btn_VisitorSingup.titleLabel.font=[UIFont boldSystemFontOfSize:10];
    btn_VisitorSingup.titleLabel.numberOfLines=2;
    btn_VisitorSingup.titleLabel.textAlignment=UITextAlignmentCenter;
    [btn_VisitorSingup setImage:[UIImage imageNamed:@"SignUpButtonSelect.png"] forState:UIControlStateNormal];
    [btn_VisitorSingup setImage:[UIImage imageNamed:@"SignUpButtonDeselect.png"] forState:UIControlStateHighlighted];
    [btn_VisitorSingup addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    backButton.hidden=YES;
    btnsetting.hidden=YES;
    btn_VisitorSingup.hidden=YES;
    btn_licenceLogin.hidden=YES;
    

    
    // [self setViewFrame];
    [self addSubview:btntwitter];
    [self addSubview:btngoogleplus];
    [self addSubview:btnlinkedin];
    [self addSubview:btnfacebook];
    [self addSubview:btnmessage];
    [self addSubview:moreButton];
    [self addSubview:backButton];
    [self addSubview:btnsetting];
    [self addSubview:btn_licenceLogin];
    [self addSubview:btn_VisitorSingup];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
       orientation = interfaceOrientation;
       return YES;
}
  

-(IBAction)moreButton:(id)sender{
    
    app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.ismore=YES;
    
 
    NSLog(@"moreButton   %d",app.ismore);
   
    moreButton.hidden=YES;
    btntwitter.hidden=YES;
    btnmessage.hidden=YES;
    btnlinkedin.hidden=YES;
    btngoogleplus.hidden=YES;
    btnfacebook.hidden=YES;
    
   
    backButton.hidden=NO;
    btnsetting.hidden=NO;
    btn_VisitorSingup.hidden=NO;
    btn_licenceLogin.hidden=NO;
    
    
 /*   if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.frame = CGRectMake(-320, 387, 640, 48);
    }
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
     
           self.frame= CGRectMake(-480, 240, 960, 48);
        }*/

      
    //self.frame = CGRectMake(-320, 387, 640, 48);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"Linkedin" object:self];
    
}

-(IBAction)backButton:(id)sender{
    app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.ismore=NO; 
    NSLog(@"backButton   %d",app.ismore);
    
 /*   if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
         self.frame = CGRectMake(0, 387, 640, 48);
    }
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        self.frame = CGRectMake(0, 240, 960, 48);
    }*/

    moreButton.hidden=NO;
    btntwitter.hidden=NO;
    btnmessage.hidden=NO;
    btnlinkedin.hidden=NO;
    btngoogleplus.hidden=NO;
    btnfacebook.hidden=NO;
    
    backButton.hidden=YES;
    btnsetting.hidden=YES;
    btn_VisitorSingup.hidden=YES;
    btn_licenceLogin.hidden=YES;

   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"Linkedin" object:self];
    
}


-(IBAction)ShareOnLinkedin:(id)sender{
    
    NSLog(@"ShareOnLinkedin");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Linkedin" object:self];
    
}

-(IBAction)ShareOnTwitter:(id)sender{
    NSLog(@"Twitter");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Twitter" object:self];
    
}

-(IBAction)ShareOnFacebook:(id)sender{
    NSLog(@"ShareOnFacebook");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Facebook" object:self];
}
-(IBAction)Settings:(id)sender{
    NSLog(@"Settings %@",[[sender superview] superview]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Settings" object:self];
    
}

-(IBAction)Licensee:(id)sender{
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Would you like to proceed?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
   
    alert.tag=1;
    
    [alert show];
    [alert release];
    
    
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (alertView.tag==1) {
        
  
    if (buttonIndex==0) 
        
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/Licensee/index.php"]]];
    }
    else  if (buttonIndex==0) 
        
    {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/Visitor/addVisitor.php"]]];
    }
}

-(IBAction)signup:(id)sender{
    
   
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Would you like to proceed?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
    [alert release];

    alert.tag=2;
    
  

}
-(IBAction)ShareOnGooglePlus:(id)sender{
    NSLog(@"ShareOnGooglePlus %@",[[sender superview] superview]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GooglePlus" object:self];
    
}
-(IBAction)Message:(id)sender{
   // NSLog(@"Title %d",[fromClass view].tag);
    
    NSLog(@"Message %@",[[sender superview] superview]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Message" object:self];
    
}

//--------------------------------------------------------//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
