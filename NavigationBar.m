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
@synthesize btn_Refresh;
@synthesize maskLayer;
@synthesize refreshIconBg;



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
    [self.view addSubview:navMainView];
    

    //navMainView.layer.borderWidth = 0.5;
    //navMainView.layer.borderColor = [UIColor grayColor].CGColor;
    
    //UIBarButtonItem *navView = [[[UIBarButtonItem alloc]initWithCustomView:navMainView] autorelease];
    //self.navigationItem.leftBarButtonItem = navView;
    
    //[self CreateBackView];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainNavigationView=nil;
    
    
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"Navbar  viewWillDisappear");
    [btn_Refresh removeFromSuperview];
    [refreshIconBg removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIView *)CreateCustomNavigationView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomePageAction:)name:@"Added on Home"  object:nil]; 
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRotating)name:@"callingServerFinished"  object:nil]; 


    mainNavigationView = [[UIView alloc]init];
    mainNavigationView.layer.cornerRadius = 5.0;
    mainNavigationView.layer.masksToBounds = YES;
//    if ([Constant isiPad]) {
//        ;
//    }
//    else{
//        mainNavigationView.frame = CGRectMake(0, 0, 300, 44);
//    }
    mainNavigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HeaderOne.png"]];
   // mainNavigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HeaderOne.png"]]; 
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
   // headline.text = @"Pub & Bar Network";

    
    homeimg = [[UIButton alloc] init];

    [homeimg setImage:[UIImage imageNamed:@"HomeButton.png"] forState:UIControlStateNormal];
    [homeimg addTarget:self action:@selector(ClickHomeView:) forControlEvents:UIControlEventTouchUpInside];
    
    statuslbl = [[UILabel alloc]init];

    statuslbl.textColor = [UIColor whiteColor];
    statuslbl.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    statuslbl.font = [UIFont boldSystemFontOfSize:10];
    statuslbl.backgroundColor = [UIColor clearColor];
    
//    btn_licenselogin=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_licenselogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn_licenselogin setTitle:@"Licensee Login" forState:UIControlStateNormal];
//    
//    /////////////////////////////////////////////////////////////////
//   
//    
//    btn_licenselogin.backgroundColor=[UIColor clearColor];    
//    btn_licenselogin.titleLabel.font=[UIFont boldSystemFontOfSize:8];   
//    [mainNavigationView addSubview:btn_licenselogin];
    
//    bar_vw = [[UIView alloc]init];
//    bar_vw.backgroundColor= [UIColor whiteColor];
    
    homeTextLbl = [[UILabel alloc] init];
    //homeTextLbl.text = @"HOME";
    homeTextLbl.numberOfLines = 4;
    homeTextLbl.backgroundColor = [UIColor clearColor];
    homeTextLbl.textColor = [UIColor colorWithRed:149.0/255.0 green:162.0/255.0 blue:176.0/255.0 alpha:1.0];
    homeTextLbl.font = [UIFont boldSystemFontOfSize:8];
    homeTextLbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    eventTextLbl = [[UILabel alloc] init];
    eventTextLbl.numberOfLines = 2;
    eventTextLbl.backgroundColor = [UIColor clearColor];
    eventTextLbl.textColor = [UIColor whiteColor];//[UIColor colorWithRed:149.0/255.0 green:162.0/255.0 blue:176.0/255.0 alpha:1.0];
    eventTextLbl.font = [UIFont boldSystemFontOfSize:9];
    eventTextLbl.lineBreakMode = UILineBreakModeWordWrap;
    
    [self SetCustomNavBarFrame];
    
    [mainNavigationView addSubview:eventTextLbl];
    [mainNavigationView addSubview:homeTextLbl];
    //[mainNavigationView addSubview:bar_vw];
    [mainNavigationView addSubview:statuslbl];
    [mainNavigationView addSubview:headline];
    [mainNavigationView addSubview:homeimg];
    
    
    return mainNavigationView;
    
}


/*-(void) addLayer
{
    self.maskLayer = [CALayer layer];
    [self.maskLayer setBounds:self.bounds];
    [self.maskLayer setPosition:CGPointMake(self.bounds.size.width/ 2, self.bounds.size.height/2)];
    [self.maskLayer setContents:(id)[UIImage imageNamed:kMaskImageName].CGImage];
    
    newPieLayer.mask = self.maskLayer;

}*/



-(void)HomePageAction:(id)sender{
   /* refreshIconBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BlackButton.png"]];
    [mainNavigationView addSubview:refreshIconBg];
    NSLog(@"ShareOnLinkedin");
    
    btn_Refresh = [[UIButton alloc]init];
    [btn_Refresh setBackgroundImage:[UIImage imageNamed:@"refreshButton.png"] forState:UIControlStateNormal];
    [btn_Refresh setBackgroundColor:[UIColor clearColor]];
  
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
    
            btn_Refresh.frame= CGRectMake(262, 9, 30, 30);
            refreshIconBg.frame=CGRectMake(257, 7, 40, 36);
            
        }
        else{
             btn_Refresh.frame= CGRectMake(416, 5, 30, 30);
            refreshIconBg.frame=CGRectMake(410, 3, 40, 36);
        }
    }
    
    [btn_Refresh addTarget:self action:@selector(refreshButtonAction) forControlEvents:UIControlEventTouchUpInside];    
    [mainNavigationView addSubview:btn_Refresh];*/
    
    
}


-(void) refreshButtonAction
{
   /* [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
        btn_Refresh.transform = transform;
    } completion:NULL];*/
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = 2.5f;             // this might be too fast
    animation.repeatCount = HUGE_VALF;     // HUGE_VALF is defined in math.h so import it
    [btn_Refresh.layer addAnimation:animation forKey:@"rotation"];

    /*CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationOptionCurveLinear];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationRepeatCount:5.0];
    [UIView setAnimationRepeatAutoreverses:YES];
    
    ///btn_Refresh.transform = CGAffineTransformRotate( btn_Refresh.transform, M_PI);
    btn_Refresh.transform = CGAffineTransformRotate( btn_Refresh.transform, - M_PI);

    [UIView commitAnimations];*/
    
    
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"callingServer" object:self];

}




- (void)stopRotating {
     /*[UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear animations:^{
     CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2 * 0.05);
     btn_Refresh.transform = transform;
     } completion:NULL];*/
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI_2 * 0.05];
    animation.duration = 0.0f;             // this might be too fast
    animation.repeatCount = 0.0;     // HUGE_VALF is defined in math.h so import it
    [btn_Refresh.layer addAnimation:animation forKey:@"rotation"];
    
    /*CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationOptionCurveLinear];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationRepeatCount:0.0];
    
    btn_Refresh.transform = CGAffineTransformRotate( btn_Refresh.transform, M_PI_2 * 0.05);
    
    [UIView commitAnimations];*/
    
    
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
            //navBar.frame = CGRectMake(8.5, 10, 303, 44);
            mainNavigationView.frame = CGRectMake(8.5, 10, 303, 70);
            headline.frame = CGRectMake(110, 8, 200, 24);
            homeimg.frame = CGRectMake(1, 5, 50, 44);
            homeTextLbl.frame = CGRectMake(47, 0, 10, 44);
            statuslbl.frame = CGRectMake(90, 55, 200, 10);
            btn_licenselogin.frame=CGRectMake(249, 26, 70, 20);
            bar_vw.frame = CGRectMake(255, 40, 57, 1);
            eventTextLbl.frame = CGRectMake(8, 54, 90, 10);
            mainNavigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HeaderOne.png"]];
            [homeimg setImage:[UIImage imageNamed:@"HomeButton.png"] forState:UIControlStateNormal];
             //btn_Refresh.frame= CGRectMake(262, 9, 30, 30);
            //refreshIconBg.frame=CGRectMake(257, 7, 40, 36);
            
        }
        else{
            //navBar.frame = CGRectMake(0, 0, 480, 44);
            mainNavigationView.frame = CGRectMake(8.5, 10, 463, 65);
            headline.frame = CGRectMake(200, 8, 200, 24);
            homeimg.frame = CGRectMake(3, 0, 50, 44);
            homeTextLbl.frame = CGRectMake(47, 0, 10, 44);
            statuslbl.frame = CGRectMake(180, 55, 200, 10);
            btn_licenselogin.frame=CGRectMake(359, 26, 70, 20);
            bar_vw.frame = CGRectMake(364.2, 40, 58.4, 1);
            eventTextLbl.frame = CGRectMake(6, 42, 130, 30);
            mainNavigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3rdHeaderOneL.png"]];
            [homeimg setImage:[UIImage imageNamed:@"HomeButton.png"] forState:UIControlStateNormal];
            //btn_Refresh.frame= CGRectMake(422, 5, 30, 30);
            //refreshIconBg.frame=CGRectMake(418, 3, 40, 36);
        }
    }
}
//////////////////////////////////////////////////////////////////////


-(void) dealloc
{
    [headline release];
    [homeimg release];
    [statuslbl release];
    [bar_vw release];
    [homeTextLbl release];
    [eventTextLbl release];
    //Added on Home
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Added on Home" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"callingServerFinished" object:nil];

    [super dealloc];
}



@end
