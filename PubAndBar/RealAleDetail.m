//
//  RealAleDetail.m
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "RealAleDetail.h"
#import "PubList.h"
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



@interface RealAleDetail ()

-(void) userDidAddorRemovedText :(NSString *) searchText;

@end

@implementation RealAleDetail
@synthesize tableale;
@synthesize backButton;
@synthesize text_field;
@synthesize aledetails;
@synthesize detailsArray;
@synthesize topLabel;
@synthesize middleLable;
@synthesize nextImg;
@synthesize Realale_ID;
@synthesize _Name;
@synthesize img_1stLbl;

@synthesize searchRadius,searchUnit;

///////////////////////////////////////// JHUMA///////////////////////
@synthesize Title_lbl;
@synthesize vw_search;
@synthesize str_breweryName;
@synthesize strPostcode;
@synthesize oAuthLoginView;

@synthesize str;

UIInterfaceOrientation orientation;
AppDelegate *app;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.eventTextLbl.text=_Name;

    
    detailsArray = [[NSMutableArray alloc]init];
    detailsArray = [[SaveAleDetailInfo GetBeerInfo :Realale_ID radius:searchRadius beer_Name:str] retain]; 
    searchArray = [[NSMutableArray alloc]init];
    searchArray = [detailsArray copy];
    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];

    if ([detailsArray count]!=0) {
        [self CreateView];
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
   

}

#pragma  Mark-
#pragma  Mark- AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
        [self.navigationController popViewControllerAnimated:YES];
}


-(void)CreateView{
   
    tableale = [[UITableView alloc]init];
    tableale.delegate=self;
    tableale.dataSource=self;
    tableale.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    tableale.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    text_field = [[UITextField alloc]init];
    text_field.backgroundColor=[UIColor whiteColor];
    text_field.delegate = self;
    text_field.textAlignment=UITextAlignmentLeft;
    //text_field.font=[UIFont boldSystemFontOfSize:13];
    text_field.textColor=[UIColor blackColor];
    text_field.returnKeyType = UIReturnKeyDone;
    text_field.autocorrectionType = UITextAutocorrectionTypeNo;
    
    lblHeader = [[UILabel alloc] init];
    lblHeader.backgroundColor = [UIColor clearColor];
    lblHeader.textColor = [UIColor whiteColor];
    lblHeader.font = [UIFont boldSystemFontOfSize:14.0];
    lblHeader.text = str_breweryName;
    
    CGSize maximumLabelSize = CGSizeMake(300,30);

    expectedLabelSize = [str_breweryName sizeWithFont:lblHeader.font constrainedToSize:maximumLabelSize]; 
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"< Search by Ale Name";
    searchLabel.font=[UIFont boldSystemFontOfSize:10.0];
    searchLabel.numberOfLines = 2;
    searchLabel.lineBreakMode = UILineBreakModeWordWrap;
    searchLabel.textColor = [UIColor whiteColor];
    searchLabel.backgroundColor = [UIColor clearColor];
   // vw_search=[[UIView alloc]init];
   // vw_search.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
  /*  
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor =[UIColor clearColor];    
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont systemFontOfSize:10];
    Title_lbl.text =[NSString stringWithFormat:@"%@",str_breweryName];
    Title_lbl.textAlignment=UITextAlignmentLeft;

    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];*/

    
    //[self.view addSubview:Title_lbl];
    //[self.view addSubview:vw_search];
    //[self.view addSubview:img_1stLbl];

    [self.view addSubview:backButton];
    [self.view addSubview:tableale];
    [self.view addSubview:searchLabel];
    [self.view addSubview:text_field];
    [self.view addSubview:lblHeader];
    
   

    [backButton release];
    [self setAleViewFrame];

    if (refreshHeaderView == nil) {
        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableale.bounds.size.height, 320.0f, tableale.bounds.size.height)];
        refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        [tableale addSubview:refreshHeaderView];
        [refreshHeaderView release];
    }

    //[vw_search release];
  //  [Title_lbl release];
    //[img_1stLbl release];
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
		tableale.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


- (void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	[tableale reloadData];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[tableale setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
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
    detailsArray = [[SaveAleDetailInfo GetBeerInfo :Realale_ID radius:searchRadius beer_Name:str] retain]; 
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


#pragma mark TextField Delegates

-(void) userDidAddorRemovedText :(NSString *) searchText
{
    detailsArray = [[NSMutableArray alloc] init];
    if([searchText isEqualToString:@""])
    { 
        detailsArray = [searchArray copy];
        [tableale reloadData]; 
        return; 
    } 
    //NSInteger counter = 0; 
    
    else
    {
        for (int i =0; i < [searchArray count]; i++) {
            
            NSString *string = [[searchArray objectAtIndex:i] valueForKey:@"Beer_Name"];
            NSRange r = [string rangeOfString:searchText]; 
            if(r.location != NSNotFound) 
            { 
                //if(r.location== 0)//that is we are checking only the start of the names. 
                { 
                    [detailsArray addObject:[searchArray objectAtIndex:i]];
                } 
            }
        }
        [tableale reloadData]; 
        
    }
    
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



- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    //Terminate editing
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    [text_field resignFirstResponder];
}

/*//-------------------mb-05-06-12----------------------------//
-(IBAction)SearchAle:(id)sender
{
    PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:_Name];
    NSLog(@"BEER ID %@",[[detailsArray objectAtIndex:0] valueForKey:@"Beer_ID"]);
    obj.searchRadius = searchRadius;
    //obj.catID = [[detailsArray objectAtIndex:indexPath.row-1] valueForKey:@"Ale_ID"];
    obj.beerID = [[detailsArray objectAtIndex:0] valueForKey:@"Beer_ID"];
    obj.eventName=[[detailsArray objectAtIndex:0] valueForKey:@"Beer_Name"];
    obj.str_AlePostcode=strPostcode;
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];
}
//---------------------------------------------------------//
 */
-(void)setAleViewFrame{
   
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            tableale.frame=CGRectMake(10, 150, 300, 268);
            tableale.scrollEnabled = YES;
            lblHeader.frame = CGRectMake(10, 120, 125, 25);
            backButton.frame=CGRectMake(8, 90, 50, 25);
             text_field.frame = CGRectMake(80, 93, 140, 20);
            searchLabel.frame = CGRectMake(228, 87, 100, 30);
            
            CGRect newFrame = lblHeader.frame;
            newFrame.size.width = expectedLabelSize.width;
            lblHeader.frame = newFrame;
            //vw_search.frame=CGRectMake(0, 50, 320, 7);
            //Title_lbl.frame=CGRectMake(2, 64, 200, 24);  
            //img_1stLbl.frame=CGRectMake(65, 75, 8, 8);
            if (app.ismore==YES) {
               // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
               // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
          
        }
        
        else{
            tableale.frame=CGRectMake(10, 145, 460, 105); 
            tableale.scrollEnabled = YES;
            backButton.frame = CGRectMake(20, 85, 50, 25);
            text_field.frame = CGRectMake(177, 86, 135, 20);
            lblHeader.frame = CGRectMake(10, 120, 125, 25);
            
            searchLabel.frame = CGRectMake(380, 82, 90, 30);

            CGRect newFrame = lblHeader.frame;
            newFrame.size.width = expectedLabelSize.width;
            lblHeader.frame = newFrame;

            //vw_search.frame=CGRectMake(0, 46, 480, 7);
            //Title_lbl.frame=CGRectMake(2, 62, 200, 20);
            //img_1stLbl.frame=CGRectMake(80, 72, 8, 8);
            if (app.ismore==YES) {
                toolBar.frame =CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            

        }
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
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
    
    
       
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/aleSearchRes.php?bew=%@",str_breweryName];
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }

    
    obj.textString=[NSString stringWithFormat:@"Pubs and Bars availabe beers of %@ %@",str_breweryName,tempurl];
    
   
    
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
    NSString *fb_str;
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/aleSearchRes.php?bew=%@",str_breweryName,str_breweryName];
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    
    fb_str=[NSString stringWithFormat:@"Pubs and Bars availabe beers of %@ %@",tempurl];


    
    [mailController setMessageBody:[NSString stringWithFormat:@"%@",fb_str] isHTML:NO];
    
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
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
   
    
    
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/aleSearchRes.php?bew=%@",str_breweryName,str_breweryName];
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    
    obj.shareText=[NSString stringWithFormat:@"Pubs and Bars availabe beers of %@ %@",tempurl];
    
    
       
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/aleSearchRes.php?bew=%@",str_breweryName,str_breweryName];
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    
    fb_str=[NSString stringWithFormat:@"Pubs and Bars availabe beers of %@ %@",tempurl];
    

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
    
    fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/aleSearchRes.php?bew=%@",str_breweryName];
    
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",fb_str
     // @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v "
     ,@"message",
   //  @"Want to share through Greetings", @"description",
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
    self.tableale = nil;
    self.text_field = nil;
    self.detailsArray = nil;
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

#pragma mark TableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [detailsArray count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}


    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        const NSInteger TOP_LABEL_TAG = 1001;
        const NSInteger MIDDLE_LABEL_TAG = 1002;
        const NSInteger NEXT_IMG_TAG = 1005;
        
        //UILabel *headerlbl;
        
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
            vw.frame =CGRectMake(0, 7, 320, 37);
            vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
            vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            [cell.contentView addSubview:vw];
            [cell.contentView addSubview:vw1];
            
            //        if(indexPath.row==0){
            //        headerlbl = [[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 80, 25)]autorelease];
            //        headerlbl.backgroundColor = [UIColor clearColor];
            //        headerlbl.textColor = [UIColor whiteColor];
            //        headerlbl.textAlignment = UITextAlignmentLeft;
            //        headerlbl.font = [UIFont systemFontOfSize:11];
            //        [vw addSubview:headerlbl];
            //        }
            //        else{
            
            topLabel =[[[UILabel alloc]init]autorelease];
            topLabel.frame =
            CGRectMake(0,0,170,25);
            
            [vw addSubview:topLabel];
            topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            topLabel.tag = TOP_LABEL_TAG;
            topLabel.backgroundColor = [UIColor clearColor];
            topLabel.textColor = [UIColor whiteColor];
            topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            topLabel.font = [UIFont boldSystemFontOfSize:11];
           // topLabel.numberOfLines=2;
            topLabel.backgroundColor=[UIColor clearColor];
            //[topLabel sizeToFit];

            
            middleLable =[[[UILabel alloc]init]autorelease];
            middleLable.frame =
            CGRectMake(180,0,110,25);
            middleLable.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            middleLable.tag = MIDDLE_LABEL_TAG;
            middleLable.backgroundColor = [UIColor clearColor];
            middleLable.textColor = [UIColor whiteColor];
            middleLable.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middleLable.font = [UIFont boldSystemFontOfSize:11];
            //[middleLable sizeToFit];
          //  middleLable.numberOfLines=2;
           
            middleLable.backgroundColor=[UIColor clearColor];
            [vw addSubview:middleLable];
            
            nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 7, 9, 12)]autorelease];
            nextImg.tag = NEXT_IMG_TAG;
            nextImg.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            nextImg.image=[UIImage imageNamed:@"HistoryArrow.png"];    
            [vw addSubview:nextImg];
        }
        
        // }
        else{
            topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
            middleLable = (UILabel *)[cell viewWithTag:MIDDLE_LABEL_TAG];
            nextImg = (UIImageView *)[cell viewWithTag:NEXT_IMG_TAG];
            
        }
        @try {
            //        if(indexPath.row==0){
            //            headerlbl.text =aledetails;
            //        }
            //        else{
            topLabel.text = [[detailsArray objectAtIndex:indexPath.row]valueForKey:@"Beer_Name" ];
            //middleLable.text = [[detailsArray objectAtIndex:indexPath.row]valueForKey:@"Catagory" ];
        }
        //}
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
        [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // if(indexPath.row!=0){
        PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:_Name];
        NSLog(@"BEER ID %@",[[detailsArray objectAtIndex:indexPath.row] valueForKey:@"Beer_ID"]);
        obj.searchRadius = searchRadius;
        //obj.catID = [[detailsArray objectAtIndex:indexPath.row-1] valueForKey:@"Ale_ID"];
         obj.beerID = [[detailsArray objectAtIndex:indexPath.row] valueForKey:@"Beer_ID"];
        obj.eventName=[[detailsArray objectAtIndex:indexPath.row] valueForKey:@"Beer_Name"];
        obj.str_AlePostcode=strPostcode;
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
   // }
    
}

-(void)dealloc{
   
    [tableale release];
    [text_field release];
    [detailsArray release];
    [searchRadius release];
    [searchUnit release];
    [toolBar release];
    [str release];
    [lblHeader release];
    [searchLabel release];
    [super dealloc];
}
@end
