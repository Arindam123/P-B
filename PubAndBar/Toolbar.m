//
//  Toolbar.m
//  PubAndBar
//
//  Created by User7 on 09/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Toolbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation Toolbar
@synthesize btntwitter;
@synthesize btngoogleplus;
@synthesize btnlinkedin;
@synthesize btnfacebook;
@synthesize btnmessage;
@synthesize btnsetting;

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
    self.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1.0];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.02f;
    self.frame = CGRectMake(0, 380, 320, 48);
    self.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    NSLog(@"%@",self.frame);
    //self.backgroundColor = [UIColor darkGrayColor];
    
    btntwitter = [UIButton buttonWithType:UIButtonTypeCustom];
    btntwitter.frame=CGRectMake(10, 2, 44, 44);
    btntwitter.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    btntwitter.backgroundColor=[UIColor clearColor];
    [btntwitter addTarget:self action:@selector(ShareOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    
    [btntwitter setImage:[UIImage imageNamed:@"TwitterButton.png"] forState:UIControlStateNormal];
    
    btngoogleplus = [UIButton buttonWithType:UIButtonTypeCustom];
    btngoogleplus.frame = CGRectMake(63, 2, 44, 44);
    btngoogleplus.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btngoogleplus.backgroundColor=[UIColor clearColor];
    [btngoogleplus addTarget:self action:@selector(ShareOnGooglePlus:) forControlEvents:UIControlEventTouchUpInside];
    [btngoogleplus setImage:[UIImage imageNamed:@"GooglePlusButton.png"] forState:UIControlStateNormal];
    
    btnlinkedin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnlinkedin.frame = CGRectMake(114, 2, 44, 44);
    btnlinkedin.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnlinkedin.backgroundColor=[UIColor clearColor];
    [btnlinkedin addTarget:self action:@selector(ShareOnLinkedin:) forControlEvents:UIControlEventTouchUpInside];
    [btnlinkedin setImage:[UIImage imageNamed:@"InButton.png"] forState:UIControlStateNormal];
    
    btnfacebook = [UIButton buttonWithType:UIButtonTypeCustom];
    btnfacebook.frame = CGRectMake(164, 2, 44, 44);
    btnfacebook.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnfacebook.backgroundColor=[UIColor clearColor];
    [btnfacebook addTarget:self action:@selector(ShareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnfacebook setImage:[UIImage imageNamed:@"FaceBookButton.png"] forState:UIControlStateNormal];
    
    btnmessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnmessage.frame = CGRectMake(214, 2, 44, 44);
    btnmessage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnmessage.backgroundColor=[UIColor clearColor];
    [btnmessage addTarget:self action:@selector(Message:) forControlEvents:UIControlEventTouchUpInside];
    [btnmessage setImage:[UIImage imageNamed:@"EmailButton.png"] forState:UIControlStateNormal];
    
    btnsetting = [UIButton buttonWithType:UIButtonTypeCustom];
    btnsetting.frame= CGRectMake(270, 2, 44, 44);
    btnsetting.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
    btnsetting.backgroundColor=[UIColor clearColor];
    [btnsetting addTarget:self action:@selector(Settings:) forControlEvents:UIControlEventTouchUpInside];
    [btnsetting setImage:[UIImage imageNamed:@"SettingsButton2.png"] forState:UIControlStateNormal];
    
    // [self setViewFrame];
    [self addSubview:btntwitter];
    [self addSubview:btngoogleplus];
    [self addSubview:btnlinkedin];
    [self addSubview:btnfacebook];
    [self addSubview:btnmessage];
    [self addSubview:btnsetting];
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
-(IBAction)ShareOnGooglePlus:(id)sender{
    NSLog(@"Settings %@",[[sender superview] superview]);
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
