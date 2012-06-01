//
//  PubList.m
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "PubList.h"
#import "PubDetail.h"
#import "FoodDetails_Microsite.h"
#import "RealAle_Microsite.h"
#import "ServerConnection.h"
#import "JSON.h"
#import "DBFunctionality.h"
#import "Global.h"



@implementation PubList
@synthesize vw_header;
@synthesize frstlbl;
@synthesize secndlbl;
@synthesize thrdlbl;
@synthesize fourthlbl;
@synthesize fifthlbl;
@synthesize backButton;
@synthesize table_list;
@synthesize array;
@synthesize catID;
@synthesize seg_control;
@synthesize beerID;
@synthesize sport_eventID;
@synthesize eventID;
@synthesize searchRadius;
@synthesize Pubid;
//------------//
@synthesize categoryArray;
@synthesize hud = _hud;
@synthesize eventName;
@synthesize str_AlePostcode;

@synthesize Title_lbl;
@synthesize img_1stLbl,img_2ndLbl,img_3rdLbl,img_4thLbl,img_5thLbl;

@synthesize oAuthLoginView;
@synthesize categoryStr;



UILabel *topLabel;
UILabel *middlelbl;
UILabel *bottomlbl;
UILabel *endlbl;
UILabel *extremelbl;
UIImage *rowBackGround;
UIImage *selectBackGround;
BOOL IsSelect;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        categoryStr = categoryString;
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
    
    self.eventTextLbl.text=categoryStr;

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    array=[[NSMutableArray alloc]init];
    
    if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"MLS"])
    {
        NSString *radius;
        if ([searchRadius isEqualToString:@"Above 20.0"])
        {              radius=[searchRadius stringByReplacingOccurrencesOfString:@">" withString:@""];
            searchRadius=[NSString stringWithFormat:@">%f",[radius floatValue]*1.609344 ];
        }else
        {
            radius=[searchRadius stringByReplacingOccurrencesOfString:@"<=" withString:@""];
            searchRadius=[NSString stringWithFormat:@"<=%f",[radius floatValue]*1.609344];
        }
    }
    
    if([categoryStr isEqualToString:@"Food & Offers"]){
    
    array = [[SavePubListInfo GetPubDetailsInfo:[catID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
    }
    else if ([categoryStr isEqualToString:@"Real Ale"])
    {
        array = [[SavePubListInfo GetPubDetailsInfo:[beerID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];//[[SavePubListInfo GetPubDetailsInfo1:[Pubid intValue] withID:[beerID intValue] withCategoryStr:categoryStr]retain];
     //------------------------mb-------------------------//   
      /*  if ([array count] == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No venues available!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            [alert release];
        }
*/
        //-----------------------------------------------//
    }
    else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        array = [[SavePubListInfo GetPubDetailsInfo1:[catID intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr]retain];
    }
    
    else if ([categoryStr isEqualToString:@"Sports on TV"]){
        array = [[SavePubListInfo GetPubDetailsInfo:[sport_eventID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];//[[SavePubListInfo GetPubDetailsInfo1:[catID intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr]retain];
    }
    //------------------------------------mb-25/05/12/5-45-----------------------------//
    else  if([categoryStr isEqualToString:@"Facilities"]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:1 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:2 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Features" ]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:3 radius:searchRadius]retain];
    }
    //------------------------------------------------------------------------//
    
    else {
        array = [[SavePubListInfo GetPubDetailsInfo1:[Pubid intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr]retain];

    }
    //----------------------------------------mb-----------------------------------//
    if ([array count] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No venues available!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
    }

    //-----------------------------------------------------------// 
    [self CreateView];
    
     
}



-(void)CreateView{
    
    obj_nearbymap = [[NearByMap alloc] initWithFrame:CGRectMake(0, 38, 320, 310) withArray:array];
    //obj_nearbymap.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;


   table_list = [[UITableView alloc]init];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    vw_header = [[UIView alloc]init];
    
   // vw.backgroundColor = [UIColor colorWithRed:96/255 green:94/255 blue:93/255 alpha:1];
    vw_header.backgroundColor = [UIColor grayColor];
    
//    seg_control = [[UISegmentedControl alloc]init];
//    NSArray *itemArray = [NSArray arrayWithObjects: @"List", @"Map", nil];
//    seg_control = [[UISegmentedControl alloc] initWithItems:itemArray];
//    seg_control.segmentedControlStyle = UISegmentedControlStyleBar;
//    seg_control.backgroundColor=[UIColor clearColor];
//    seg_control.tintColor=[UIColor lightGrayColor];
//    seg_control.tintColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
//    seg_control.selectedSegmentIndex =0;
//    [seg_control addTarget:self action:@selector(ClickSegCntrl:) forControlEvents:UIControlEventValueChanged];
//    
    //*************************************************************
    if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        table_list.hidden=NO;
        // venu_btn.hidden=NO;
        vw_header.hidden=NO;
    }
    else
    {
        table_list.hidden=YES;
        obj_nearbymap.hidden=NO;
        vw_header.hidden=YES;
        // venu_btn.hidden=YES;
    }
    //**************************************************************
    
    btn_view=[[UIView alloc]init];
    btn_view.backgroundColor=[UIColor whiteColor];
    
    list_btn=[[UIButton alloc]init];
    [list_btn addTarget:self action:@selector(List_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    map_btn=[[UIButton alloc]init];
    [map_btn addTarget:self action:@selector(Map_btnClick:) forControlEvents:UIControlEventTouchUpInside];   
   
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor = [UIColor clearColor];
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont boldSystemFontOfSize:9];
    Title_lbl.numberOfLines=2;
    Title_lbl.lineBreakMode=UILineBreakModeWordWrap;
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        NSString *str=[NSString stringWithFormat:@"Showing Live %@ ",eventName];
        Title_lbl.text =str;
    }
    else if([categoryStr isEqualToString:@"Food & Offers"]){
        NSString *str=[NSString stringWithFormat:@"%@ ",eventName];
        Title_lbl.text =str;
    }
    else if([categoryStr isEqualToString:@"Real Ale"]){
        NSString *str=[NSString stringWithFormat:@"%@ - %@ ",eventName,str_AlePostcode];
        Title_lbl.text =str;
    }
    
    Title_lbl.textAlignment=UITextAlignmentCenter;
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];
    img_2ndLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];
    img_3rdLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];
    img_4thLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];
    img_5thLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];
    
    
    
    frstlbl = [[UILabel alloc]init];
    frstlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    frstlbl.text = @"POSTCODE";
    frstlbl.textColor = [UIColor whiteColor];
    frstlbl.font = [UIFont systemFontOfSize:9];
    frstlbl.textAlignment=UITextAlignmentCenter;
    
    secndlbl = [[UILabel alloc]init];
    secndlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    secndlbl.textColor = [UIColor whiteColor];
    secndlbl.font = [UIFont systemFontOfSize:9];
    secndlbl.text = @"VENUE";
    secndlbl.textAlignment=UITextAlignmentCenter;
    
    thrdlbl = [[UILabel alloc]init];
    thrdlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    thrdlbl.textColor = [UIColor whiteColor];
    thrdlbl.font = [UIFont systemFontOfSize:9];
    thrdlbl.text = @"CITY/TOWN";
    thrdlbl.textAlignment=UITextAlignmentCenter;
    
    fourthlbl = [[UILabel alloc]init];
    fourthlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fourthlbl.textColor = [UIColor whiteColor];
    fourthlbl.font = [UIFont systemFontOfSize:9];
    fourthlbl.text = @"DISTRICT";
    fourthlbl.textAlignment=UITextAlignmentCenter;
    
    fifthlbl = [[UILabel alloc]init];
    fifthlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fifthlbl.textColor = [UIColor whiteColor];
    fifthlbl.font = [UIFont systemFontOfSize:9];
    if (GET_DEFAUL_VALUE(ShowsResultIN) !=nil) {
        [fifthlbl setText:[NSString stringWithFormat: @"DISTANCE(%@)",GET_DEFAUL_VALUE(ShowsResultIN)]];
    }    fifthlbl.textAlignment=UITextAlignmentLeft;
    
    [self setViewFrame];
    [self.view addSubview:Title_lbl];

    [self.view addSubview:obj_nearbymap];
    [vw_header addSubview:frstlbl];
    [frstlbl addSubview:img_1stLbl];

    [vw_header addSubview:secndlbl];
    [secndlbl addSubview:img_2ndLbl];

    [vw_header addSubview:thrdlbl];
    [thrdlbl addSubview:img_3rdLbl];

    [vw_header addSubview:fourthlbl];
    [fourthlbl addSubview:img_4thLbl];

    [vw_header addSubview:fifthlbl];
    [fifthlbl addSubview:img_5thLbl];

    [self.view addSubview:vw_header];
    [self.view addSubview:table_list];
    [self.view addSubview:backButton];
    [self.view addSubview:btn_view];
    [btn_view addSubview:list_btn];
    [btn_view addSubview:map_btn];
    [btn_view release];
    [list_btn release];
    [map_btn release];
    
    //[self.view addSubview:seg_control];
    [frstlbl release];
    [secndlbl release];
    [thrdlbl release];
    [fourthlbl release];
    [fifthlbl release];
    [backButton release];
    [Title_lbl release];
    [img_1stLbl release];
    [img_2ndLbl release];
    [img_3rdLbl release];
    [img_4thLbl release];
    [img_5thLbl release];
    
    //;
}

-(IBAction)List_btnClick:(id)sender{
    
    table_list.hidden = NO;
    obj_nearbymap.hidden = YES;
    vw_header.hidden = NO;
    IsSelect=NO;
    backButton.hidden=NO;
    // Title_lbl.hidden=NO;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
            btn_view.frame=CGRectMake(250, 10, 65.5, 19.5);
              list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
               map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);
            
            
            
            
            
        }
        else{
            [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
            // btn_view.frame=CGRectMake(160, 15, 65.5, 19.5);
            btn_view.frame=CGRectMake(410, 15, 65.5, 19.5);
            list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
            map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);
            
            
        }
    }
    
}
-(IBAction)Map_btnClick:(id)sender{
    
    table_list.hidden = YES;
    obj_nearbymap.hidden = NO;
    vw_header.hidden = YES;
    IsSelect=YES;
    backButton.hidden=YES;
    
    
    // Title_lbl.hidden=YES;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
            btn_view.frame=CGRectMake(81, 10, 158, 21);
            list_btn.frame=CGRectMake(1, 1, 79, 19);
            map_btn.frame=CGRectMake(81, 1, 76, 19);
            
        }
        else{
            
            [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
            btn_view.frame=CGRectMake(160, 14, 158, 21);
            list_btn.frame=CGRectMake(1, 1, 79, 19);
            map_btn.frame=CGRectMake(81, 1, 76, 19);
            
        }
    } 
    
}

//-(IBAction)ClickSegCntrl:(id)sender{
//    
//    
//    if(seg_control.selectedSegmentIndex==0)
//    {
//       
//        table_list.hidden = NO;
//        obj_nearbymap.hidden = YES;
//        vw_header.hidden = NO;
//
//    }
//    
//    else if(seg_control.selectedSegmentIndex==1)
//    {
//        table_list.hidden = YES;
//        obj_nearbymap.hidden = NO;
//        vw_header.hidden = YES;
//    }
//    
//}
-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setViewFrame{
      
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            img_1stLbl.frame=CGRectMake(46, 30, 10, 10);
            img_2ndLbl.frame=CGRectMake(50, 30, 10, 10);
            img_3rdLbl.frame=CGRectMake(50, 30, 10, 10);
            img_4thLbl.frame=CGRectMake(50, 30, 10, 10);
            img_5thLbl.frame=CGRectMake(50, 30, 10, 10);
            Title_lbl.frame=CGRectMake(56, 11, 170, 30);
            
            vw_header.frame = CGRectMake(0, 38, 320, 40);
            frstlbl.frame = CGRectMake(0, 0, 60, 40);
            secndlbl.frame = CGRectMake(60.5, 0, 66, 40);
            thrdlbl.frame = CGRectMake(127, 0, 63, 40);
            fourthlbl.frame = CGRectMake(190.5, 0, 67, 40);
            fifthlbl.frame = CGRectMake(257.5, 0, 74, 40);
            backButton.frame = CGRectMake(10, 15, 50, 20);
            table_list.frame = CGRectMake(0, 78, 320, 270);
            table_list.scrollEnabled = YES;
            seg_control.frame = CGRectMake(90, 4, 140, 25);
            
            if (IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
                
                btn_view.frame=CGRectMake(250, 10, 65.5, 19.5);
                list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
                map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
                
                btn_view.frame=CGRectMake(81, 10, 158, 21);
                list_btn.frame=CGRectMake(1, 1, 79, 19);
                map_btn.frame=CGRectMake(81, 1, 76, 19);            }
        }
        
        else{
            
            img_1stLbl.frame=CGRectMake(50, 30, 10, 10);
            img_2ndLbl.frame=CGRectMake(85, 30, 10, 10);
            img_3rdLbl.frame=CGRectMake(90, 30, 10, 10);
            img_4thLbl.frame=CGRectMake(50, 30, 10, 10);
            img_5thLbl.frame=CGRectMake(50, 30, 10, 10);
            Title_lbl.frame=CGRectMake(69, 11, 240, 30);
            
            frstlbl.frame = CGRectMake(0, 0, 88.5, 40);
            secndlbl.frame = CGRectMake(89.5, 0, 99.5, 40);
            thrdlbl.frame = CGRectMake(189.5, 0, 93, 40);
            fourthlbl.frame = CGRectMake(283.5, 0, 102.5, 40);
            fifthlbl.frame = CGRectMake(386.5, 0, 93, 40);
            backButton.frame = CGRectMake(20, 15, 50, 20);
            table_list.frame = CGRectMake(0, 77, 480, 150);
            vw_header.frame = CGRectMake(0, 38, 480, 40);
            table_list.scrollEnabled = YES;
            seg_control.frame = CGRectMake(140, 14, 200, 25);
            
            if (IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
                
                btn_view.frame=CGRectMake(410, 15, 65.5, 19.5);
                list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
                map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
                
                btn_view.frame=CGRectMake(160, 14, 158, 21);
                list_btn.frame=CGRectMake(1, 1, 79, 19);
                map_btn.frame=CGRectMake(81, 1, 76, 19);
            }
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
     [self AddNotification];
}

-(void)AddNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInTwitter:)name:@"Twitter"  object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInGooglePlus:)name:@"GooglePlus"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInLinkedin:)name:@"Linkedin"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInFacebook:)name:@"Facebook"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInMessage:)name:@"Message"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Settings:)name:@"Settings"  object:nil];
    
}
#pragma  mark-
#pragma mark- share

- (void)ShareInTwitter:(NSNotification *)notification {
    iCodeOauthViewController *obj_twt=[[iCodeOauthViewController alloc]initWithNibName:nil bundle:nil];
    if ([categoryStr isEqualToString:@"Sports on TV"])
        obj_twt.twt_text=[NSString stringWithFormat: @"http://tinyurl.com/89u8erm = (media text) #Pubs and Bars showing %@ http://tinyurl.com/bncphw2 Possibly use existing text for these pages?",eventName];
    
    else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
        obj_twt.twt_text=[NSString stringWithFormat: @"http://tinyurl.com/75l9zfbon   (media text) #Pubs and #Bars with updated %@ info http://tinyurl.com/yaww8wx",categoryStr];
    else
         obj_twt.twt_text=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it."];
    
    [self.navigationController pushViewController:obj_twt animated:YES];
    [obj_twt release];
}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    ;
}


- (void)ShareInMessage:(NSNotification *)notification {
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            [self displayEmailComposerSheet];
        }
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }
    
}
-(void)displayEmailComposerSheet
{
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"The Big Fish Experience"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    MyPreferences *obj_mypreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_mypreferences animated:YES];
    [obj_mypreferences release];
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loginViewDidFinish:) 
                                                 name:@"loginViewDidFinish" 
                                               object:oAuthLoginView];
    
    
    [self presentModalViewController:oAuthLoginView animated:YES];
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    [[FacebookController sharedInstance] setFbDelegate:self];
    [[FacebookController sharedInstance] initialize];
}

-(void) FBLoginDone:(id)objectDictionay
{
    [self wallPosting];
}
-(void) wallPosting
{
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     @"Want to share through Greetings", @"description",
     @"https://m.facebook.com/apps/Greetings/", @"link",
     //@"http://fbrell.com/f8.jpg", @"picture",
     nil];  
    [[FacebookController sharedInstance].facebook dialog:@"feed"
                                               andParams:params
                                             andDelegate:self];    
    // barButton.enabled = YES;
}

-(void) fbDidLogin
{
    //NSLog(@"TOKEn  fbDidLogin %@",[facebook accessToken]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self wallPosting];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    // barButton.enabled = YES;
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error{
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		myAlert.tag = 6;
		[myAlert show];
		[myAlert release];
        
    }
    
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url{
	
	//NSLog(@"URL  %@",url);
    
}

-(void) dialogDidComplete:(FBDialog *)dialog{
    
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	//NSLog(@"did not login");
}

- (void) fbDidLogout {
	// Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
}    
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Twitter" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GooglePlus" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Linkedin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Facebook" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Message" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Settings" object:nil];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"ARRAY   %d",[array count]);
    return [array count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger EXTREME_LABEL_TAG = 1005;
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
        
        
        
        topLabel =
		[[[UILabel alloc]init]autorelease]
        ;
        topLabel.frame =
        CGRectMake(0, 0, 60, 50);
        
		[cell.contentView addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
        topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
        topLabel.numberOfLines = 2;
        topLabel.lineBreakMode = UILineBreakModeWordWrap;
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:9];
        topLabel.layer.borderWidth= .5;
        topLabel.layer.borderColor = [[UIColor grayColor]CGColor];
        topLabel.textAlignment = UITextAlignmentCenter;
        
        middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(61.2, 0, 70, 50)]autorelease];
        middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        middlelbl.tag = MIDDLE_LABEL_TAG;
        middlelbl.numberOfLines = 2;
        middlelbl.lineBreakMode = UILineBreakModeWordWrap;
        middlelbl.backgroundColor = [UIColor clearColor];
        middlelbl.textColor = [UIColor whiteColor];
        middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        middlelbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:middlelbl];
        middlelbl.layer.borderWidth= .5;
        middlelbl.layer.borderColor = [[UIColor grayColor]CGColor];
        middlelbl.textAlignment = UITextAlignmentCenter;
        
        
        bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(127, 0, 63, 50)]autorelease];
        bottomlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        bottomlbl.tag = BOTTOM_LABEL_TAG;
        bottomlbl.numberOfLines = 2;
        bottomlbl.lineBreakMode = UILineBreakModeWordWrap;
        bottomlbl.backgroundColor = [UIColor clearColor];
        bottomlbl.textColor = [UIColor whiteColor];
        bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        bottomlbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:bottomlbl];
        bottomlbl.layer.borderWidth= .5;
        bottomlbl.layer.borderColor = [[UIColor grayColor]CGColor];
        bottomlbl.textAlignment = UITextAlignmentCenter;

        
        endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(192.1, 0, 65.4, 50)]autorelease];
        endlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        endlbl.tag = END_LABEL_TAG;
        endlbl.numberOfLines = 2;
        endlbl.lineBreakMode = UILineBreakModeWordWrap;
        endlbl.backgroundColor = [UIColor clearColor];
        endlbl.textColor = [UIColor whiteColor];
        endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        endlbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:endlbl];
        endlbl.layer.borderWidth= .5;
        endlbl.layer.borderColor = [[UIColor grayColor]CGColor];
        endlbl.textAlignment = UITextAlignmentCenter;
        
        extremelbl =[[[UILabel alloc]initWithFrame:CGRectMake(257.5, 0, 74, 50)]autorelease];
        extremelbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        extremelbl.tag = EXTREME_LABEL_TAG;
        extremelbl.numberOfLines = 2;
        extremelbl.lineBreakMode = UILineBreakModeWordWrap;
        extremelbl.backgroundColor = [UIColor clearColor];
        extremelbl.textColor = [UIColor whiteColor];
        extremelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        extremelbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:extremelbl];
        extremelbl.layer.borderWidth= .5;
        extremelbl.layer.borderColor = [[UIColor grayColor]CGColor];
        extremelbl.textAlignment = UITextAlignmentCenter;

    }

		    
    else{
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        middlelbl = (UILabel *)[cell viewWithTag:MIDDLE_LABEL_TAG];
        bottomlbl = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
        endlbl = (UILabel *)[cell viewWithTag:END_LABEL_TAG];
        extremelbl = (UILabel *)[cell viewWithTag:EXTREME_LABEL_TAG];
            }
    @try {
        topLabel.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubPostCode" ];
        middlelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
        bottomlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubCity" ];
        endlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubDistrict" ];
        if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
            extremelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ];
        else
            extremelbl.text=[NSString stringWithFormat:@"%0.2f",[[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192];
        //NSLog(@"%@district",[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistrict" ]);
        //NSLog(@"%@distance",[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ]);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
     UIImageView *backgroundImageView = [[[UIImageView alloc] init] autorelease];
    if(indexPath.row %2 == 0){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        cell.backgroundView = backgroundImageView;

    }
    else{
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]];
        cell.backgroundView = backgroundImageView;
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSelector:@selector(addMBHud)];

    
    ServerConnection *conn1 = [[ServerConnection alloc] init];
    NSLog(@"%@",[[array objectAtIndex:indexPath.row] valueForKey:@"PubID"]);
    [conn1 getPubDetails:[[array objectAtIndex:indexPath.row] valueForKey:@"PubID"]];
    [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
    [conn1 release];
    
    /*if([categoryStr isEqualToString:@"Real Ale"]){
        
        RealAle_Microsite *obj_RealAle_Microsite=[[RealAle_Microsite alloc]initWithNibName:[Constant GetNibName:@"RealAle_Microsite"] bundle:[NSBundle mainBundle]];
        
        obj_RealAle_Microsite.Pubid=[[array objectAtIndex:indexPath.row]valueForKey:@"PubID" ];
         obj_RealAle_Microsite.category_Str=categoryStr;
        
        obj_RealAle_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                       [[array objectAtIndex:indexPath.row] valueForKey:@"PubName"],@"PubName",
                                                       [[array objectAtIndex:indexPath.row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                                       [[array objectAtIndex:indexPath.row] valueForKey:@"PubCity"],@"PubCity",
                                                       [[array objectAtIndex:indexPath.row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                                       nil];
        

        [self.navigationController pushViewController:obj_RealAle_Microsite animated:YES];
        [obj_RealAle_Microsite release];
        
    }
    
    else
    {
        NSLog(@"ARRAy   %@",array);
        PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
        obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           [[array objectAtIndex:indexPath.row] valueForKey:@"PubName"],@"PubName",
                                           [[array objectAtIndex:indexPath.row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                           [[array objectAtIndex:indexPath.row] valueForKey:@"PubCity"],@"PubCity",
                                           [[array objectAtIndex:indexPath.row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                           nil];
        obj_detail.Pub_ID= [[array objectAtIndex:indexPath.row] valueForKey:@"PubID"];
        obj_detail.sporeid=[[array objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"];
        obj_detail.Sport_Evnt_id =[ [array objectAtIndex:indexPath.row] valueForKey:@"Sport_EventID"];
        obj_detail.EventId = eventID;
        obj_detail.categoryStr=categoryStr;
        [self.navigationController pushViewController:obj_detail animated:YES];
        [obj_detail release];
    }*/
    
}

#pragma mark ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
    NSMutableArray *pubDetailsArray = [[[json valueForKey:@"pubDetails"] valueForKey:@"details"] retain];
    NSString *PUBID = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"];
    //NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubEmail"]);
    NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"Mobile"]);
    NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubWebsite"]);
    NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubDescription"]);
    NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"venuePhoto"]);
    NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueCapacity"]);
    NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestRail"]);
    NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestTube"]);
    NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"LocalBuses"]);
    NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"]);
    //NSArray *Arr_PubComp = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"]
    
    //**************************** Biswa ******************************************************
    //*********************** Update Pub Details **********************************************  
    
    NSString *pubEmail = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubEmail"];
    NSString *pubMobile = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Mobile"];
    NSString *pubWebsite = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubWebsite"];
    NSString *pubDescription = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubDescription"];
    NSString *venuePhoto = [[pubDetailsArray objectAtIndex:0] valueForKey:@"venuePhoto"];
    NSString *venueStyle = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueStyle"];
    NSString *venueCapacity = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueCapacity"];
    NSString *pubNearestRail = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestRail"];
    NSString *pubNearestTube = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestTube"];
    NSString *pubLocalBuses = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"LocalBuses"];
    NSString *pubCompany = [[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"] objectAtIndex:0] valueForKey:@"pubCompany"];
    NSString *pubAddressAll = [[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"] objectAtIndex:0] valueForKey:@"pubAddressAll"];
    NSString *pubPhoneNo = @"No Info";
    
    if (pubEmail.length == 0) {
        
        pubEmail = @"No Info";
    }
    if (pubMobile.length == 0) {
        
        pubMobile = @"No Info";
    }
    if (pubWebsite.length == 0) {
        
        pubWebsite = @"No Info";
    }
    if (pubDescription.length == 0) {
        
        pubDescription = @"No Info";
    }
    if (venuePhoto.length == 0) {
        
        venuePhoto = @"No Info";
    }
    if (venueStyle.length == 0) {
        
        venueStyle = @"No Info";
    }
    if (venueCapacity.length == 0) {
        
        venueCapacity = @"No Info";
    }
    if (pubNearestRail.length == 0) {
        
        pubNearestRail = @"No Info";
    }
    if (pubNearestTube.length == 0) {
        
        pubNearestTube = @"No Info";
    }
    if (pubLocalBuses.length == 0) {
        
        pubLocalBuses = @"No Info";
    }
    if (pubCompany.length == 0) {
        
        pubCompany = @"No Info";
    }
    if (pubAddressAll.length == 0) {
        
        pubAddressAll = @"No Info";
    }
    
    
    
    
    [[DBFunctionality sharedInstance] InsertValue_Pub_details:pubEmail pubMobile:pubMobile pubWebsite:pubWebsite pubdescription:pubDescription pubImage:venuePhoto venueStyle:venueStyle venueCapacity:venueCapacity nearestRail:pubNearestRail nearestTube:pubNearestTube localBuses:pubLocalBuses pubCompany:pubCompany PubID:PUBID PubAddress:pubAddressAll PubPhoneNo:pubPhoneNo];
    //*********************** Update Pub Details **********************************************
    
    
    //******************************Pub_Photo*************************************************** 
    
    NSString *GeneralImages = [[[[pubDetailsArray objectAtIndex:0]valueForKey:@"General Images"] objectAtIndex:0] valueForKey:@"Photo"];
    NSString *FunctionRoomImages = [[[[pubDetailsArray objectAtIndex:0]valueForKey:@"Function Room Images"] objectAtIndex:0] valueForKey:@"Photo"];
    NSString *FoodordrinkImages = [[[[pubDetailsArray objectAtIndex:0]valueForKey:@"Food or drink Images"] objectAtIndex:0] valueForKey:@"Photo"];
    
    if (GeneralImages.length == 0) {
        GeneralImages = @"No Info";
    }
    if (FunctionRoomImages.length == 0) {
        FunctionRoomImages = @"No Info";
    }
    if (FoodordrinkImages.length == 0) {
        FoodordrinkImages = @"No Info";
    }
    
    
    [[DBFunctionality sharedInstance]InsertValue_Pub_PhotoWithPubID:PUBID GeneralImages:GeneralImages FunctionRoomImages:FunctionRoomImages FoodDrinkImages:FoodordrinkImages];
    //******************************Pub_Photo***************************************************  
    
    
    
    //******************************* Event ****************************************************
    if ([delegate.sharedDefaults objectForKey:@"Events"]) {
        NSMutableArray *Arr_AllEvent = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"];
        NSLog(@"%@",[Arr_AllEvent valueForKey:@"info"]);
        
        for (int i = 0; i < [Arr_AllEvent count]; i++) {
            NSMutableDictionary *Dict_Event = [Arr_AllEvent objectAtIndex:i];
            NSString *Event_Type_ID = [[Dict_Event valueForKey:@"Event ID"] retain];
            NSString *event_name = [[Dict_Event valueForKey:@"Event Name"] retain];
            NSMutableArray *Arr_EventDetails = [[Dict_Event valueForKey:@"Event Details"] retain];
            NSLog(@"%@",Event_Type_ID);
            NSLog(@"%@",event_name);
            NSLog(@"%@",Arr_EventDetails);
            for (int j = 0; j < [Arr_EventDetails count]; j++) {
                NSLog(@"%@",[Arr_EventDetails valueForKey:@"info"]);
                NSString *Event_ID = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"ID"];
                NSString *Date = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Event Date"];
                NSString *Event_Desc = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Event Description"];
                if (![[[Arr_EventDetails objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"No Details Available"]) {
                    
                    
                    if (Date.length == 0) {
                        Date = [Constant GetCurrentDateTime];
                    }
                    if (Event_Desc.length == 0) {
                        Event_Desc = @"No Info";
                    }
                    
                    [[DBFunctionality sharedInstance] UpdateEvent_DetailByID:Event_ID eventtypeid:Event_Type_ID date:Date eventdesc:Event_Desc PUBID:PUBID isNoInfo:NO];
                }
                else{
                    [[DBFunctionality sharedInstance] UpdateEvent_DetailByID:Event_ID eventtypeid:Event_Type_ID date:nil eventdesc:@"No Info" PUBID:PUBID isNoInfo:YES];
                    
                }
                //[Event_ID release];
                //[Date release];
                //[Event_Desc release];
            }
            [Arr_EventDetails release];
        }
        [Arr_AllEvent release];
    }
    
    //******************************* Event ****************************************************
    
    //****************************** Food and offers *******************************************
    if ([delegate.sharedDefaults objectForKey:@"Food"]) {
        //NSMutableDictionary *foodDictioinary = [[pubDetailsArray valueForKey:@"Food & Offers"] retain];
        NSMutableArray *Arr_Foodandoffers = [[pubDetailsArray valueForKey:@"Food & Offers"] retain];
        //if ([foodDictioinary ob] != nil) {
        NSString *str_foodinfo = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Information"] retain];
        NSString *str_foodservingtime = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Serving Time"] retain];
        NSString *str_chefdescription = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Chef Description"] retain];
        NSString *str_special_offers = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Special Offers"] retain];
        
        if (str_foodinfo.length == 0) {
            
            str_foodinfo = @"No Info";
        }
        if (str_foodservingtime.length == 0) {
            
            str_foodservingtime = @"No Info";
        }
        if (str_chefdescription.length == 0) {
            
            str_chefdescription = @"No Info";
        }
        if (str_special_offers.length == 0) {
            
            str_special_offers = @"No Info";
        }
        
        NSMutableArray *Arr_foodType = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Type"] retain];
        //if (![[[Arr_foodType objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
        for (int i = 0; i < [Arr_foodType count]; i++) {
            [[DBFunctionality sharedInstance] UpdateFoodDetailsByFoodTypeId:[[Arr_foodType objectAtIndex:0] valueForKey:@"ID"] byPubID:PUBID FoodInfor:str_foodinfo FoodServingTime:str_foodservingtime Chiefdesc:str_chefdescription SpeicalOffers:str_special_offers];
            //[[DBFunctionality sharedInstance] UpdateFoodDetailsByFoodTypeId:[[Arr_foodType objectAtIndex:0] valueForKey:@"ID"] byPubID:[[pubDetailsArray objectAtIndex:0] valueForKey:@"PubID"] FoodInfor:nil FoodServingTime:str_foodservingtime Chiefdesc:str_chefdescription SpeicalOffers:str_special_offers];
            //}
        }
        //}
    }
    
    //****************************** Food and offers *******************************************
    
    
    //***************************** Facilities *************************************************
    if ([delegate.sharedDefaults objectForKey:@"Facilities"]) {
        NSMutableArray *Array_Facilities = [pubDetailsArray valueForKey:@"Facilities"];
        NSString *Str_FacilitiesInfo = [[[Array_Facilities objectAtIndex:0] valueForKey:@"Facility Information"] retain];
        
        if (Str_FacilitiesInfo.length == 0) {
            
            Str_FacilitiesInfo = @"No Info";
        }
        
        NSMutableArray *Arr_FacilitiesType = [[Array_Facilities objectAtIndex:0] valueForKey:@"Facilities Type"];
        //if (![[[Arr_FacilitiesType objectAtIndex:0]valueForKey:@"info"] isEqualToString:@"<null>"]){
            for (int i = 0; i < [Arr_FacilitiesType count]; i++) {
                NSString *Str_FacilitiesTypeId = [[Arr_FacilitiesType objectAtIndex:i] valueForKey:@"ID"];
                [[DBFunctionality sharedInstance] UpdateAmmenitiesDetailsbyPubId:PUBID AmmnitiesID:Str_FacilitiesTypeId FacilitiesInfo:Str_FacilitiesInfo];
            }
       // }
        
    }
    //***************************** Facilities *************************************************
    
    
    
    
    
    
    //***************************** Real Ale ***************************************************
    if ([delegate.sharedDefaults objectForKey:@"Real Ale"]) {
        NSMutableArray *Arr_RealAle = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Real Ale"];
        //if (![[[Arr_RealAle objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
            NSMutableArray *Arr_RealAleDetails = [[Arr_RealAle objectAtIndex:0] valueForKey:@"Real Ale Details"];
        if (![[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
            
            NSLog(@"%@",[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"]);
            //NSLog(@"%@",[[[Arr_RealAleDetails objectAtIndex:0]valueForKey:@"info"] objectAtIndex:0]);
            if (![[[Arr_RealAleDetails objectAtIndex:0]valueForKey:@"info"] isEqualToString:@"<null>"]) {
                NSLog(@"%d",[Arr_RealAleDetails count]);
                for (int i = 0; i < [Arr_RealAleDetails count]; i++) {
                    NSLog(@"%@",[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerTitle"]);
                    
                    NSString *Str_BeetTitle = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerTitle"];
                    if(Str_BeetTitle.length == 0)
                        Str_BeetTitle = @"No Info";
                    
                    NSString *Str_Breweryname = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BreweryName"];
                    if(Str_Breweryname.length == 0)
                        Str_Breweryname = @"No Info";
                    
                    NSString *Str_Beer_ABV = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"ABV"];
                    if(Str_Beer_ABV.length == 0)
                        Str_Beer_ABV = @"No Info";
                    
                    NSString *Str_Beer_Color = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"See"];
                    if(Str_Beer_Color.length == 0)
                        Str_Beer_Color = @"No Info";
                    
                    NSString *Beer_Smeel = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Smell"];
                    if(Beer_Smeel.length == 0)
                        Beer_Smeel = @"No Info";
                    
                    NSString *Beer_Taste = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Taste"];
                    if(Beer_Taste.length == 0)
                        Beer_Taste = @"No Info";
                    
                    NSString *Str_LicenseNote = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"LicenseeNotes"];
                    if(Str_LicenseNote.length == 0)
                        Str_LicenseNote = @"No Info";
                    
                    NSString *Str_Ale_Name = [[Arr_RealAleDetails objectAtIndex:i] valueForKey:@"BreweryName"];
                    if(Str_Ale_Name.length == 0)
                        Str_Ale_Name = @"No Info";
                    
                    NSString *Str_Ale_Email = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Email"];
                    if(Str_Ale_Email.length == 0)
                        Str_Ale_Email = @"No Info";
                    
                    NSString *Str_AleWebsiteurl = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Email"];
                    if(Str_AleWebsiteurl.length == 0)
                        Str_AleWebsiteurl = @"No Info";
                    
                    NSString *Str_Address = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Address"];
                    if(Str_Address.length == 0)
                        Str_Address = @"No Info";
                    
                    NSString *Str_Postcode = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"postCode"];
                    if(Str_Postcode.length == 0)
                        Str_Postcode = @"No Info";
                    
                    NSString *Str_Contactname = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"ContactName"];
                    if(Str_Contactname.length == 0)
                        Str_Contactname = @"No Info";
                    
                    NSString *Str_phonenumber = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"PhoneNumber"];
                    if(Str_phonenumber.length == 0)
                        Str_phonenumber = @"No Info";
                    
                    NSString *Str_District = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"District"];
                    if(Str_District.length == 0)
                        Str_District = @"No Info";
                    
                    
                    [[DBFunctionality sharedInstance] UpdateBeerDetailsByPubId:PUBID BeerID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerID"] Beer_Name:Str_BeetTitle Catagory:Str_Breweryname Beer_ABV:Str_Beer_ABV Beer_Color:Str_Beer_Color Beer_Smell:Beer_Smeel Beer_Taste:Beer_Taste License_Note:Str_LicenseNote Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"AleID"]];
                    
                    
                    
                    [[DBFunctionality sharedInstance] UpdateRealAleDetailsByPubId:PUBID Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"AleID"] Ale_Name:Str_Ale_Name Ale_MailID:Str_Ale_Email Ale_Website:Str_AleWebsiteurl Ale_Address:Str_Address Ale_Postcode:Str_Postcode Ale_ContactName:Str_Contactname Ale_PhoneNumber:Str_phonenumber Ale_District:Str_District];
                }
                
            }
        }
            //NSLog(@"%@",[[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"]);
            
        //}
    }
    //***************************** Real Ale ***************************************************
    
    
    
    
    
    //***************************** Sports & TV ************************************************
    //Sport_Id will be add in Json,then I have to implement it....
    if ([delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
        NSMutableArray *Arr_SportsEvent = [[pubDetailsArray valueForKey:@"SportsEvent"] retain];
        if (![[[[Arr_SportsEvent objectAtIndex:0] objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
            NSMutableArray *Arr_SportsEventDetails = [[[[Arr_SportsEvent objectAtIndex:0] objectAtIndex:0] valueForKey:@"Sports Event Details"] retain];
            if (![[[Arr_SportsEventDetails objectAtIndex:0]  valueForKey:@"info"] isEqualToString:@"<null>"]) {
                NSLog(@"%d",[Arr_SportsEventDetails count]);
                for (int i = 0; i < [Arr_SportsEventDetails count]; i++) {
                    
                    
                    NSString *Str_Type = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Type"];
                    if(Str_Type.length == 0)
                        Str_Type = @"No Info";
                    
                    NSString *Str_ThreeD = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"threeD"];
                    if(Str_ThreeD.length == 0)
                        Str_ThreeD = @"No Info";
                    
                    NSString *Str_sportsdesc = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"sportsDescription"];
                    if(Str_sportsdesc.length == 0)
                        Str_sportsdesc = @"No Info";
                    
                    NSString *Str_Sound = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Sound"];
                    if(Str_Sound.length == 0)
                        Str_Sound = @"No Info";
                    
                    NSString *Str_Screen = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Screen"];
                    if(Str_Screen.length == 0)
                        Str_Screen = @"No Info";
                    
                    NSString *Str_hd = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"HD"];
                    if(Str_hd.length == 0)
                        Str_hd = @"No Info";
                    
                    NSString *Str_eventname = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"eventName"];
                    if(Str_eventname.length == 0)
                        Str_eventname = @"No Info";
                    
                    NSString *Str_dateshow = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Date Show"];
                    if(Str_dateshow.length == 0)
                        Str_dateshow = @"No Info";
                    
                    NSString *Str_channel = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Channel"];
                    if(Str_channel.length == 0)
                        Str_channel = @"No Info";
                    
                    NSString *Str_timeshow = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Time Show"];
                    if(Str_timeshow.length == 0)
                        Str_timeshow = @"No Info";
                    
                    
                    
                    [[DBFunctionality sharedInstance] Update_Sport_DetailsbyPubId:PUBID SportEventID:[[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"event ID"] Type:Str_Type ThreeD:Str_ThreeD SportsDescription:Str_sportsdesc Sound:Str_Sound Screen:Str_Screen HD:Str_hd eventName:Str_eventname Date:Str_dateshow Channel:Str_channel Time:Str_timeshow SportID:[[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Sports ID"]];
                }
            }
        }
    }
    
    
    
    
    [self performSelector:@selector(dismissHUD:)];
    
    
    
    
    
    
    if([categoryStr isEqualToString:@"Real Ale"]){
     
     RealAle_Microsite *obj_RealAle_Microsite=[[RealAle_Microsite alloc]initWithNibName:[Constant GetNibName:@"RealAle_Microsite"] bundle:[NSBundle mainBundle]];
     
     obj_RealAle_Microsite.Pubid=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
     obj_RealAle_Microsite.category_Str=categoryStr;
     
     obj_RealAle_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
     nil];
     
     
     [self.navigationController pushViewController:obj_RealAle_Microsite animated:YES];
     [obj_RealAle_Microsite release];
     
     }
     
     else
     {
     NSLog(@"ARRAy   %@",array);
     PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
     obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
     nil];
     obj_detail.Pub_ID= [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"];
     obj_detail.sporeid=[[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
     obj_detail.Sport_Evnt_id =[ [array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_EventID"];
     obj_detail.EventId = eventID;
     obj_detail.categoryStr=categoryStr;
     [self.navigationController pushViewController:obj_detail animated:YES];
     [obj_detail release];
     }       
}

//-------------------------------------------------------//

-(void)afterFailourConnection:(id)msg
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Error Occurred!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
	
	
}
/*UIImage *rowBackGround;
 UIImage *selectBackGround;*/


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    table_list = nil;
    seg_control=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        toolBar.frame = CGRectMake(0, 387, 320, 48);
        [obj_nearbymap setFrameOfView:CGRectMake(0, 38, 320, 310)];

    }
    else{
        toolBar.frame = CGRectMake(0, 240, 480, 48);
        [obj_nearbymap setFrameOfView:CGRectMake(0, 38, 480, 190)];

    }
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark-
#pragma mark-addMBHud
-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"Loading...";
    
}
#pragma mark Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}

-(void)dealloc{
    [table_list release];
    [catID release];
    [seg_control release];
    [obj_nearbymap release];
    [vw_header release];
    [toolBar release];
    [eventName release];
    [str_AlePostcode release];
    //----------------mb/25/05/12/5-45--------------------//
    [categoryArray release];
    [self.categoryStr release];
    
    [_hud release];
    _hud = nil;
    
    [super dealloc];
}
@end
