//
//  RealAle.m
//  PubAndBar
//
//  Created by User7 on 25/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "RealAle.h"
#import "DistenceWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "RealAleDetail.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "ASIHTTPRequest.h"

#import "URLRequestString.h"
#import "InternetValidation.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "DBFunctionality4Update.h"
#import "DBFunctionality4Delete.h"


@interface RealAle ()

-(void) userDidAddorRemovedText :(NSString *) searchText;
-(void) getBreweryNames;    
@end



@implementation RealAle
@synthesize table_realale;
@synthesize aleArray;
@synthesize backButton;
@synthesize btnsearch;
@synthesize text_field;
@synthesize topLabel;
@synthesize nextImg;
@synthesize ale_name;
@synthesize realale;
@synthesize vari;
@synthesize searchRadius;
@synthesize searchUnit;
//@synthesize searchingBar;

///////////////////////////////////////// JHUMA///////////////////////
@synthesize Title_lbl;
@synthesize vw_search;
@synthesize img_1stLbl;

@synthesize oAuthLoginView;
@synthesize reloading=_reloading;


UIInterfaceOrientation orientation;
AppDelegate *app;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str4
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.eventTextLbl.text=realale;

    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
   

    aleArray = [[NSMutableArray alloc]init];
    searchArray = [[NSMutableArray alloc]init];

    
    //-----------------------------------mb-05-06-12---------------------------//
    aleArray = [[SaveRealAleInfo GetAleInfo]retain]; 
    searchArray = [aleArray copy];
    //------------------------------------------------------------------------//
    
    
    //-----------------------------------mb----------------------------//
    if ([aleArray count]==0) {
   
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    [self CreateView];
    //----------------------------------------------------------------//

    
}


-(void) getBreweryNames
{
    NSMutableArray *tempArray;
    
    tempArray = [[SaveRealAleInfo GetSearchAleInfo:text_field.text] retain];
    
    if ([tempArray count]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"No result found....." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        [aleArray removeAllObjects];
        aleArray = [tempArray retain];
    }
    [table_realale reloadData];

}




#pragma  Mark-
#pragma  Mark- AlertView Delegate
//--------------------------mb----------------------------------//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
        [self.navigationController popViewControllerAnimated:YES];
}
//------------------------------------------------------------//

-(void)CreateView{
    
    
//    searchingBar = [[UISearchBar alloc] init];
//    [searchingBar setDelegate:self];
//    searchingBar.autocorrectionType = UITextAutocorrectionTypeYes;
//    searchingBar.placeholder = @"Search by Brewery Name";
    
    
    table_realale = [[UITableView alloc]init];
    table_realale.delegate=self;
    table_realale.dataSource=self;
    table_realale.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_realale.separatorStyle=UITableViewCellSeparatorStyleNone;
    table_realale.userInteractionEnabled = YES;
    
    text_field = [[UITextField alloc]init];
    text_field.delegate=self;
    text_field.backgroundColor=[UIColor whiteColor];
    text_field.returnKeyType = UIReturnKeyDone;
    text_field.autocorrectionType = UITextAutocorrectionTypeNo;
    
    line_vw=[[UIView alloc]init];
    line_vw.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

   
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
//    btnsearch = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnsearch addTarget:self action:@selector(SearchBreweryOrAle:) forControlEvents:UIControlEventTouchUpInside];
//    [btnsearch setTitle:@"< Search by Brewery Name" forState:UIControlStateNormal];
//    [btnsearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnsearch.backgroundColor = [UIColor clearColor];
//    btnsearch.titleLabel.font=[UIFont boldSystemFontOfSize:8];
    
    searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"< Search by Brewery Name";
    searchLabel.font = [UIFont boldSystemFontOfSize:10];
    searchLabel.numberOfLines = 2;
    searchLabel.lineBreakMode = UILineBreakModeWordWrap;
    searchLabel.textColor = [UIColor whiteColor];
    searchLabel.backgroundColor = [UIColor clearColor];
    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
    
    vw_search=[[UIView alloc]init];
    vw_search.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    
    
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor =[UIColor clearColor];    
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont boldSystemFontOfSize:10];
    Title_lbl.text =@"Search by Brewery Below";
    Title_lbl.textAlignment=UITextAlignmentLeft;
    
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];

    

    
    [self setAleViewFrame];
    [self.view addSubview:vw_search];
    [self.view addSubview:Title_lbl];
    [self.view addSubview:backButton];
    [self.view addSubview:table_realale];
    //[self.view addSubview:btnsearch];
    [self.view addSubview:text_field];
    [self.view addSubview:img_1stLbl];
    [self.view addSubview:line_vw];
    [self.view addSubview:searchLabel];
    //[self.view addSubview:searchingBar];
    
    if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_realale.bounds.size.height, 320.0f, table_realale.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[table_realale addSubview:refreshHeaderView];
		[refreshHeaderView release];
	}
    
    [backButton release];
    [vw_search release];
    [Title_lbl release];
    [img_1stLbl release];
    //[btnsearch release];
}

#pragma mark
#pragma mark PullTableViewRefresh Delegates


- (void)reloadTableViewDataSource{
	
    [self performSelector:@selector(callingServer)];
}



- (void)doneLoadingTableViewData{
    
  	[self dataSourceDidFinishLoadingNewData];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
    
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		_reloading = YES;
		[self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:0.2];
		[refreshHeaderView setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		table_realale.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


- (void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	[table_realale reloadData];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[table_realale setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}
-(void) callingServer
{    
    if([InternetValidation  checkNetworkStatus])
    {
        
        //str_RefName =;
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        
        [conn1 getRealAleData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
        
        [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
}

-(void)afterSuccessfulConnection:(NSString*)data_Response
{
    if (!deletedDataCall) {
        
        NSDictionary *json = [data_Response JSONValue];
        
        
        NSMutableArray *realAleArray = [[[json valueForKey:@"Details"] valueForKey:@"Brewery Details"] retain];
        
        
        if ([realAleArray count] !=0) {
            
            for (int i = 0; i<[realAleArray count]; i++) {
                
                
                
                NSMutableArray *beerDetailsArray = [[[realAleArray objectAtIndex:i] valueForKey:@"Beer Details"] retain];
                
                for (int j = 0; j<[beerDetailsArray count]; j++) {
                    
                    
                    NSMutableArray *pubDetailsArray = [[[beerDetailsArray objectAtIndex:j] valueForKey:@"Pub Information"] retain];
                    
                    
                    for (int k = 0; k< [pubDetailsArray count]; k++) {
                        
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] pubDistance:0.0];//distance/1000
                        
                        [[DBFunctionality sharedInstance] InsertValue_Beer_Detail:[[[beerDetailsArray objectAtIndex:j] valueForKey:@"Beer ID"] intValue] withBreweryID:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withBeerName:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Ale Name"] withBeerCategory:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Category"] pubDistance:0.0];//distance/1000
                        
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubDetailsArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000 
                    }
                    [pubDetailsArray release];
                }
                
                [beerDetailsArray release];
            }
            
            
        }
        [realAleArray release];
        
        
        [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
        [self deletedDataCalling:4];
        
    }
    
    
    else
    {
        NSDictionary *json = [data_Response JSONValue];
        
        
        NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
        NSLog(@"%d",[Arr_events count]);
        
        if ([Arr_events count] != 0) {
            
            [[DBFunctionality4Delete sharedInstance] deleteRealAle:[[json valueForKey:@"Details"] valueForKey:@"Non Active Ales"]];
            
            for (int i = 0; i < [Arr_events count]; i++) {
                
                //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                //NSLog(@"%@",Str_Event);
                NSString *EventTypeID;
                
                if ([Str_Event isEqualToString:@"RegularEvent"])
                    EventTypeID = @"1";
                else if([Str_Event isEqualToString:@"OneOffEvent"])
                    EventTypeID = @"2";
                else if([Str_Event isEqualToString:@"ThemeNight"])
                    EventTypeID = @"3";
                
                NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                
                for (int j = 0; j < [Arr_EventDetails count]; j++) {
                    
                    int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                    
                    
                    NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                    //NSLog(@"%d",[Arr_PubInfo count]);
                    
                    for (int k = 0; k < [Arr_PubInfo count]; k++) {
                        
                        
                        int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                        
                        [[DBFunctionality4Delete sharedInstance] deleteRealAle:pubid andEventID:EventId];
                        
                        
                    }
                }
                
            }
        }
        
    }
    deletedDataCall = NO;
    [self performSelector:@selector(myThreadMainMethod:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    
    [self performSelector:@selector(updateDB) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    [self performSelector:@selector(doneLoadingTableViewData)];  
}


-(void) updateDB
{
     aleArray = [[SaveRealAleInfo GetAleInfo]retain];
}
-(void)afterFailourConnection:(id)msg
{
    NSLog(@"MESSAGE  %@",msg);
    //[self callingNonSubPubs:nonSubValue];
    
    //[self performSelector:@selector(dismissHUD:)];
    [self performSelector:@selector(doneLoadingTableViewData)];	
    UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = 10;
    [alert  show];
    [alert  release];
    
}

-(void) deletedDataCalling:(int)_callerNumber
{
    deletedDataCall = YES;
    if (_callerNumber == 4) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"RealAleDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteRealAleData:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
}
-(void) myThreadMainMethod:(id) sender
{
    [[DBFunctionality4Update sharedInstance] UpdatePubDistance];
    
}


-(IBAction)ClickBack:(id)sender{
     [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}
//-------------------mb-05-06-12----------------------------//

#pragma  mark-
#pragma mark -SearchBreweryOrAle
-(IBAction)SearchBreweryOrAle:(id)sender
{
    /*NSMutableArray *arr_aleID;
    NSMutableString *str=[ NSMutableString stringWithFormat: @"ale"];
    arr_aleID=[SaveRealAleInfo GetSearchAleInfo:[text_field.text capitalizedString]];
    if ([arr_aleID count]==0) {
         arr_aleID=[SaveRealAleInfo GetSearchBeerInfo:[text_field.text capitalizedString]];
    str=[ NSMutableString stringWithFormat:@"beer"];
    }
    if ([arr_aleID count]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"No result found....." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
        [alert release];
       
    }
    else
    {
        RealAleDetail *obj = [[RealAleDetail alloc]initWithNibName:[Constant GetNibName:@"RealAleDetail"] bundle:[NSBundle mainBundle]];
        if ([str isEqualToString:@"ale"]) {
             obj.Realale_ID =    [[arr_aleID objectAtIndex:0] valueForKey:@"Ale_ID"];
            obj.str_breweryName=[[arr_aleID objectAtIndex:0] valueForKey:@"Ale_Name"];
            obj.strPostcode=[[arr_aleID objectAtIndex:0] valueForKey:@"Ale_Postcode"];
        }
        else
        {
            obj.Realale_ID =    [[arr_aleID objectAtIndex:0] valueForKey:@"Beer_ID"];
            NSMutableArray *arr1=[SaveRealAleInfo GetSearchAleInfoFromBeer:[[arr_aleID objectAtIndex:0] valueForKey:@"Ale_ID"]];
            
            obj.str_breweryName=[[arr1 objectAtIndex:0] valueForKey:@"Ale_Name"];
            obj.strPostcode=[[arr1 objectAtIndex:0] valueForKey:@"Ale_Postcode"];
        }
       
        obj._Name = realale;
        
        obj.searchRadius = searchRadius;
        
        obj.str=str;
        
       
        
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
    }*/
    
}
//---------------------------------------------------------//



-(void)setAleViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            table_realale.frame=CGRectMake(10, 180, 300, 240);
            table_realale.scrollEnabled = YES;
            backButton.frame=CGRectMake(8, 90, 50, 25);

            text_field.frame = CGRectMake(80, 93, 140, 20);
//            searchingBar.frame = CGRectMake(73, 85, 235, 40);
//            UITextField *textField = [[searchingBar subviews] objectAtIndex:1];
//            [textField setFrame:CGRectMake(73, 85, 235, 30)];
            

            //btnsearch.frame = CGRectMake(210, 88, 105, 30);
            searchLabel.frame = CGRectMake(228, 88, 95, 30);
            vw_search.frame=CGRectMake(10, 132, 300, 2);
            Title_lbl.frame=CGRectMake(11, 145, 200, 24);
           // line_vw.frame=CGRectMake(11, 172, 130, 2);
            img_1stLbl.frame=CGRectMake(137, 155, 8, 8);
            if (app.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
               // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
                        


        }
        
        else{
            table_realale.frame=CGRectMake(10, 160, 460, 98);
            table_realale.scrollEnabled = YES;
            backButton.frame = CGRectMake(20, 85, 50, 25);
            text_field.frame = CGRectMake(177, 86, 135, 20);
            //searchingBar.frame = CGRectMake(98, 93, 125, 44);
            searchLabel.frame = CGRectMake(380, 82, 90, 30);

            //btnsearch.frame = CGRectMake(345, 83, 100, 30);
            vw_search.frame=CGRectMake(10, 116, 460, 2);
            Title_lbl.frame=CGRectMake(11, 132, 200, 20);
            img_1stLbl.frame=CGRectMake(136, 138, 8, 8);
            if (app.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }

        }
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     app =(AppDelegate*) [[UIApplication sharedApplication]delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
   // app.ismore=NO;
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setAleViewFrame];
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
    
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/realalebreweries.htm"];
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }
    
    
    obj.textString=[NSString stringWithFormat:@"Pubs and Bars showing breweries %@",tempurl];
    

    
    
    
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    GooglePlusViewController *obj = [[GooglePlusViewController alloc] initWithNibName:@"GooglePlusViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [obj release];;
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
     [mailController setMessageBody:[NSString stringWithFormat:@"Pubs and Bars showing breweries http://www.pubandbar-network.co.uk/realalebreweries.htm"] isHTML:NO];
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"The Big Fish Experience"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

/*
#pragma mark Searchbar Delegates

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"searchText   %@",searchText);
    aleArray = [[NSMutableArray alloc] init];
    
    if([searchingBar.text isEqualToString:@""]|| searchText == nil)
    { 
        aleArray = searchArray;
        [table_realale reloadData]; 
        return; 
    } 
    NSInteger counter = 0; 
    
    for (int i =0; i < [searchArray count]; i++) {
        
        NSString *str = [[searchArray objectAtIndex:i] valueForKey:@"Ale_Name"];
        NSRange r = [str rangeOfString:searchText]; 
        if(r.location != NSNotFound) 
        { 
            if(r.location== 0)//that is we are checking only the start of the names. 
            { 
                [aleArray addObject:[[searchArray objectAtIndex:i] valueForKey:@"Ale_Name"]];
            } 
        }
    }
    
    for(id result in searchArray) 
    { 
        NSRange r = [[result valueForKey:@"Ale_Name"] rangeOfString:searchingBar.text]; 
        if(r.location != NSNotFound) 
        { 
            //if(r.location== 0)//that is we are checking only the start of the names. 
            { 
                [aleArray addObject:[result valueForKey:@"Ale_Name"]];
            } 
        } 
        counter++; 
    } 
    NSLog(@"Counter :- '%d'",[aleArray count]);
    
    [table_realale reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
}

*/
#pragma mark TextField Delegates


-(void) userDidAddorRemovedText :(NSString *) searchText
{
    aleArray = [[NSMutableArray alloc] init];
    if([searchText isEqualToString:@""])
    { 
        aleArray = [searchArray copy];
        [table_realale reloadData]; 
        return; 
    } 
    //NSInteger counter = 0; 
    
    else
    {
        for (int i =0; i < [searchArray count]; i++) {
            
            NSString *str = [[searchArray objectAtIndex:i] valueForKey:@"Ale_Name"];
            NSRange r = [str rangeOfString:searchText]; 
            if(r.location != NSNotFound) 
            { 
                //if(r.location== 0)//that is we are checking only the start of the names. 
                { 
                    [aleArray addObject:[searchArray objectAtIndex:i]];
                } 
            }
        }
        [table_realale reloadData]; 

    }
    
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    /*NSString *textToChange  = [[textField text] substringWithRange:range];
//    NSRange rangeOld = [textToChange rangeOfString:@"@"];
//    NSRange rangeNew = [string rangeOfString:@"@"];
//    if (rangeOld.location != NSNotFound && rangeNew.location == NSNotFound ) {
//        [self userDidAddorRemovedText];
//    }
//    return YES;*/
//    
//    if (range.length > 0) {
//        
//        NSLog(@"HAAA %@",textField.text);
//        if (textField.text.length == 1) {
//            
//            aleArray = [[SaveRealAleInfo GetAleInfo]retain];
//            [table_realale reloadData];
//        }
//    }
//    else
//    {
//        NSLog(@"HIII  %@",string);
//    }
//    return YES;
//}
//NSMutableString *text;


- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    //Terminate editing
    [textField resignFirstResponder];
    return YES;
}


- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString *) string {
    //if ([string isEqualToString:@"⌫"]) {
        // NSLog(@"Backspace Pressed");
        NSMutableString *text = [textField.text mutableCopy];
        // NSLog(@"Length: %d Location: %d", range.length, range.location);
        if (range.length > 0) {
            [text deleteCharactersInRange:range];
            
        }
        else {
            //NSRange backward = NSMakeRange(range.location - 1, 1);
            // NSLog(@"Length: %d Location: %d", backward.length, backward.location);
            //[text deleteCharactersInRange:backward];
            [text appendString:string];
        }
         NSLog(@"TEXTTTTT %@", text);
        [self userDidAddorRemovedText:[text capitalizedString]];
        //textField.text = text;
        return YES;
    //} 
//    else 
//    {
//        return YES;
//    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing  %@",textField.text);

}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing  %@",textField.text);
    //[self getBreweryNames];
    [textField resignFirstResponder];
    //text_field.text = @"";
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    [text_field resignFirstResponder];
}


#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}

- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    obj.shareText=[NSString stringWithFormat:@"Pubs and Bars showing breweries http://www.pubandbar-network.co.uk/realalebreweries.htm"];
    
        
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
    
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    
    NSString *fb_str;
    
    fb_str=[NSString stringWithFormat:@"Pubs and Bars showing breweries http://www.pubandbar-network.co.uk/realalebreweries.htm"];
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = [NSString stringWithFormat:@"%@",fb_str];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
    

}

-(void) FBLoginDone:(id)objectDictionay
{
    [self wallPosting];
}
-(void) wallPosting
{
     NSString *fb_str;
    
    fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/realalebreweries.htm"];

    
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",fb_str,
      //@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v ",
     @"message",
    // @"Want to share through Greetings", @"description",
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
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    [self setAleViewFrame];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table_realale = nil;
    self.aleArray = nil;
    self.text_field = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
    }
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [aleArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger NEXT_IMG_TAG = 1005;
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
        UIView *vw1=[[UIView alloc]init];//]autorelease];
        if ([Constant isiPad]) {
            ;
        }
        
        else{
            if ([Constant isPotrait:self]) {
                
                
                vw1.frame =CGRectMake(3, 41, 314, 1);
            }
            else
            {
                vw1.frame =CGRectMake(8, 41, 464, 1);
                
            }
        }
        vw1.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
        vw1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        
        UIView *vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 7, 320, 39);
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        [cell.contentView addSubview:vw1];
		
		topLabel =[[[UILabel alloc]initWithFrame:CGRectMake(20,0,170,25)]autorelease];
        
		[vw addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:13];
        
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 8, 11, 11)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.image=[UIImage imageNamed:@"HistoryArrow.png"];
        [vw addSubview:nextImg];
    }
    else{
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		nextImg = (UIImageView *)[cell viewWithTag:NEXT_IMG_TAG];
    }
    @try {
        topLabel.text = [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Name"];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ale_name = [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Name"];
    RealAleDetail *obj = [[RealAleDetail alloc]initWithNibName:[Constant GetNibName:@"RealAleDetail"] bundle:[NSBundle mainBundle]];
    obj._Name=realale;
    obj.Realale_ID =[[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_ID"];
    obj.str_breweryName=ale_name;
    
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];    
    
}



-(void)dealloc{
    [table_realale release];
    [aleArray release];
    [text_field release];
    [toolBar release];
    [searchRadius release];
    [searchUnit release];
    [searchLabel release];
    [super dealloc];

}
@end
