//
//  NavigationBar.m
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "NavigationBar.h"
#import "Home.h"
#import <QuartzCore/QuartzCore.h>

/*@implementation UINavigationBar (UINavigationBarCategory)

-(void)setBackgroundImage:(UIImage*)image{
    if(image == NULL){ //might be called with NULL argument
        return;
    }
    UIImageView *aTabBarBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TopBar_iPhone.png"]];
    aTabBarBackground.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self addSubview:aTabBarBackground];
    [self sendSubviewToBack:aTabBarBackground];
    [aTabBarBackground release];
}
@end*/




@implementation NavigationBar

@synthesize navBar;
@synthesize backButton;
@synthesize mainNavigationView;
@synthesize homeimg;
@synthesize statuslbl;
@synthesize btn_licenselogin;
@synthesize bar_vw;
@synthesize eventTextLbl;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
    
    navBar = [self.navigationController navigationBar];
    //[navBar setBackgroundImage:[UIImage imageNamed:@"TopBar_iPhone.png"]];//
    navBar.hidden = NO;
    
    self.navigationItem.hidesBackButton = YES;
    UIView *navMainView = [self CreateCustomNavigationView];
    //navMainView.layer.borderWidth = 0.5;
    //navMainView.layer.borderColor = [UIColor grayColor].CGColor;
    
    UIBarButtonItem *navView = [[[UIBarButtonItem alloc]initWithCustomView:navMainView] autorelease];
    self.navigationItem.leftBarButtonItem = navView;
    
    //[self CreateBackView];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainNavigationView=nil;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIView *)CreateCustomNavigationView
{
    mainNavigationView = [[UIView alloc]init];
//    if ([Constant isiPad]) {
//        ;
//    }
//    else{
//        mainNavigationView.frame = CGRectMake(0, 0, 300, 44);
//    }
    mainNavigationView.backgroundColor = [UIColor clearColor];
    
    headline = [[UILabel alloc]init];
//    if ([Constant isiPad]) {
//        ;
//    }
//    else{
//        headline.frame = CGRectMake(100, 8, 200, 24);
//    }
    
        
    headline.backgroundColor = [UIColor clearColor];
    headline.font = [UIFont systemFontOfSize:22];
    headline.textColor = [UIColor whiteColor];
    headline.text = @"Pub & Bar Network";

    
    homeimg = [[UIButton alloc] init];

    [homeimg setImage:[UIImage imageNamed:@"HomeButton.png"] forState:UIControlStateNormal];
    [homeimg addTarget:self action:@selector(ClickHomeView:) forControlEvents:UIControlEventTouchUpInside];
    
    statuslbl = [[UILabel alloc]init];

    statuslbl.font = [UIFont systemFontOfSize:10];
    statuslbl.textColor = [UIColor colorWithRed:149.0/255.0 green:162.0/255.0 blue:176.0/255.0 alpha:1.0];
    //////////////////JHUMA///////////////////////////////////
    
    statuslbl.text = @"updated daily by the licensee";
    statuslbl.backgroundColor = [UIColor clearColor];
    
    btn_licenselogin=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_licenselogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_licenselogin setTitle:@"Licensee Login" forState:UIControlStateNormal];
    
    /////////////////////////////////////////////////////////////////
   
    
    btn_licenselogin.backgroundColor=[UIColor clearColor];    
    btn_licenselogin.titleLabel.font=[UIFont boldSystemFontOfSize:8];   
    [mainNavigationView addSubview:btn_licenselogin];
    
    bar_vw = [[UIView alloc]init];
    bar_vw.backgroundColor= [UIColor whiteColor];
    
    homeTextLbl = [[UILabel alloc] init];
    homeTextLbl.text = @"HOME";
    homeTextLbl.numberOfLines = 4;
    homeTextLbl.backgroundColor = [UIColor clearColor];
    homeTextLbl.textColor = [UIColor colorWithRed:149.0/255.0 green:162.0/255.0 blue:176.0/255.0 alpha:1.0];
    homeTextLbl.font = [UIFont boldSystemFontOfSize:8];
    homeTextLbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    eventTextLbl = [[UILabel alloc] init];
    eventTextLbl.numberOfLines = 2;
    eventTextLbl.backgroundColor = [UIColor clearColor];
    eventTextLbl.textColor = [UIColor colorWithRed:149.0/255.0 green:162.0/255.0 blue:176.0/255.0 alpha:1.0];
    eventTextLbl.font = [UIFont boldSystemFontOfSize:9];
    eventTextLbl.lineBreakMode = UILineBreakModeWordWrap;
    
    [self SetCustomNavBarFrame];
    
    [mainNavigationView addSubview:eventTextLbl];
    [mainNavigationView addSubview:homeTextLbl];
    [mainNavigationView addSubview:bar_vw];
    [mainNavigationView addSubview:statuslbl];
    [mainNavigationView addSubview:headline];
    [mainNavigationView addSubview:homeimg];
    [headline release];
    [homeimg release];
    [statuslbl release];
    [bar_vw release];
    [homeTextLbl release];
    [eventTextLbl release];
    
    return mainNavigationView;
    
}

-(IBAction)ClickHomeView:(id)sender{
    Home *obj = [[Home alloc] initWithNibName:[Constant GetNibName:@"Home"] bundle:[NSBundle mainBundle]] ;
    if(obj.l==0){
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
    }
    else{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self.navigationController popToViewController:del.homeView animated:YES];
    }
    
}

//////////////////JHUMA///////////////////////////////////

-(void)SetCustomNavBarFrame {
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            navBar.frame = CGRectMake(0, 0, 320, 44);
            mainNavigationView.frame = CGRectMake(0, 0, 320, 44);
            headline.frame = CGRectMake(110, 8, 200, 24);
            homeimg.frame = CGRectMake(-3, 0, 50, 44);
            homeTextLbl.frame = CGRectMake(47, 0, 10, 44);
            statuslbl.frame = CGRectMake(110, 32, 200, 10);
            btn_licenselogin.frame=CGRectMake(249, 26, 70, 20);
            bar_vw.frame = CGRectMake(255, 40, 57, 1);
            eventTextLbl.frame = CGRectMake(60, 10, 53, 30);
            
        }
        else{
            navBar.frame = CGRectMake(0, 0, 480, 44);
            mainNavigationView.frame = CGRectMake(0, 0, 460, 44);
            headline.frame = CGRectMake(200, 8, 200, 24);
            homeimg.frame = CGRectMake(-3, 0, 50, 44);
            homeTextLbl.frame = CGRectMake(47, 0, 10, 44);
            statuslbl.frame = CGRectMake(200, 32, 200, 10);
            btn_licenselogin.frame=CGRectMake(359, 26, 70, 20);
            bar_vw.frame = CGRectMake(364.2, 40, 58.4, 1);
            eventTextLbl.frame = CGRectMake(60, 10, 130, 30);
            
            
        }
    }
}
//////////////////////////////////////////////////////////////////////


@end
