//
//  EventCatagory.m
//  PubAndBar
//
//  Created by User7 on 24/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "EventCatagory.h"
#import "Catagory.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "RecomendedVenue.h"

#import "JSON.h"
#import "DBFunctionality.h"
#import "InternetValidation.h"
#import "DBFunctionality4Update.h"
#import "DBFunctionality4Delete.h"



@implementation EventCatagory
@synthesize table_eventcatagory;
@synthesize eventArray;
@synthesize lbl_heading;
@synthesize backButton;
@synthesize lbl_bottom;
@synthesize btn_bottom;
@synthesize view_line;
@synthesize title;
@synthesize topLabel;
@synthesize nextImg;
@synthesize strPagename;
@synthesize reloading=_reloading;

@synthesize oAuthLoginView;
UIInterfaceOrientation orientation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *) _str2
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
    
     
    
    self.eventTextLbl.text=strPagename;
   str_RefName=@"Events";
    
    toolBar = [[Toolbar alloc]init];
   // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    eventArray = [[NSArray alloc]init];
     eventArray = [[SaveEventCatagoryInfo GetEventInfo:delegate.SelectedRadius] retain];
    if ([eventArray count]==0) {
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
    
    [self CreateView];
    deletedDataCall = NO;

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)CreateView{
    
    table_eventcatagory = [[UITableView alloc]init];
    table_eventcatagory.delegate=self;
    table_eventcatagory.dataSource=self;
    table_eventcatagory.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_eventcatagory.separatorStyle=UITableViewCellSeparatorStyleNone;
   // table_eventcatagory.separatorColor = [UIColor colorWithRed:57.6/255.0 green:64.7/255.0 blue:86.3/255.0 alpha:1.0];
    
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    lbl_heading.text = @"Choose Event Type";
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:12];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.view addSubview:backButton];
    
    lbl_bottom = [[UILabel alloc]init];
    lbl_bottom.text = @"Recommend a venue ?";
    lbl_bottom.textColor = [UIColor greenColor];
    lbl_bottom.backgroundColor = [UIColor clearColor];
    lbl_bottom.font = [UIFont boldSystemFontOfSize:16];
    
    reccomonendVenueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reccomonendVenueBtn addTarget:self action:@selector(OpenMailComposer:) forControlEvents:UIControlEventTouchUpInside];
    reccomonendVenueBtn.backgroundColor=[UIColor clearColor];
    

    btn_bottom = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_bottom setTitle:@"Add the name of a guest venue you there to Pub not Label on the facebook!" forState:UIControlStateNormal];
    [btn_bottom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_bottom.backgroundColor = [UIColor clearColor];
    btn_bottom.titleLabel.font =[UIFont boldSystemFontOfSize:7];
    
    view_line = [[UIView alloc]init];
    view_line.backgroundColor = [UIColor whiteColor];
    
    [self setEventCatagoryViewFrame];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:lbl_bottom];
    [self.view addSubview:btn_bottom];
    [self.view addSubview:view_line];
    [self.view addSubview:table_eventcatagory];
    [self.view addSubview:reccomonendVenueBtn];
    
    if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_eventcatagory.bounds.size.height, 320.0f, table_eventcatagory.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[table_eventcatagory addSubview:refreshHeaderView];
		[refreshHeaderView release];
	}
    
    [view_line release];
    [lbl_heading release];
    [lbl_bottom release];
    [backButton release];
}

-(IBAction)ClickBack:(id)sender{
     [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setEventCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            table_eventcatagory.frame=CGRectMake(0, 131, 320, 220);
            lbl_heading.frame = CGRectMake(100, 89, 125, 27);
            lbl_bottom.frame = CGRectMake(70, 350, 200, 50);
            btn_bottom.frame = CGRectMake(35, 375, 255, 30);
            view_line.frame = CGRectMake(36, 394, 252, 1);
           backButton.frame = CGRectMake(8, 90, 50, 25);
            reccomonendVenueBtn.frame=CGRectMake(70, 350, 200, 50);
            
            if (delegate.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
                       
            
        }
        
        else{
            table_eventcatagory.frame=CGRectMake(0, 121, 480, 102); 
            lbl_heading.frame = CGRectMake(200, 84, 125, 27);
            lbl_bottom.frame = CGRectMake(160, 208, 200, 50);
            btn_bottom.frame = CGRectMake(120, 230, 255, 30);
            view_line.frame = CGRectMake(120, 250, 252, 1);
            backButton.frame = CGRectMake(20, 85, 50, 25);
             reccomonendVenueBtn.frame=CGRectMake(160, 208, 200, 50);
            if (delegate.ismore==YES) {
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
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
   // delegate.ismore=NO;
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setEventCatagoryViewFrame];
    
    [self AddNotification];
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
		table_eventcatagory.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


-(void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	[table_eventcatagory reloadData];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[table_eventcatagory setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}
-(void) callingServer
{    
    
    
    
    if([InternetValidation  checkNetworkStatus])
    {
        //
             
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        
        if([str_RefName isEqualToString:@"Sports on TV"]){
            
            [conn1 getSportsData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
        }
        
        else if([str_RefName isEqualToString:@"Events"]){
            [conn1 geteventsData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
        }
        
        else if([str_RefName isEqualToString:@"Theme Nights" ]){
            [conn1 getThmeNightData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
        }
        
        
       
        
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
        
           
        if ([str_RefName isEqualToString:@"Events"]) 
        {

        
        NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    
                    NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                    NSString *EventTypeID;
                    
                    if ([Str_Event isEqualToString:@"RegularEvent"])
                        EventTypeID = @"1";
                    else if([Str_Event isEqualToString:@"OneOffEvent"])
                        EventTypeID = @"2";
                    else if([Str_Event isEqualToString:@"ThemeNight"])
                        EventTypeID = @"3";
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            
                            
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"createDate"] eventDay:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDay"] expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"expiryDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            
            [Arr_events release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            str_RefName=@"Theme Nights";
            [self callingServer];
            
        }
            
       else if ([str_RefName isEqualToString:@"Theme Nights"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            
            if ([Arr_events count] != 0) {
                
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
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            
                            
                            if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil){ 
                                
                            }
                            
                            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat setDateFormat:@"yyyy-MM-dd"];
                            //[dateFormat setLocale:[NSLocale currentLocale]];
                            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]]];
                            
                            NSDateFormatter *dateFormat2 = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat2 setDateFormat:@"EEE"];
                            
                            NSString *dateString1 = [[dateFormat2 stringFromDate:tempDate] uppercaseString]; 
                            
                            //NSLog(@"%@",dateString);
                            
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"] eventDay:dateString1 expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
           
            str_RefName=@"Sports on TV";
            [self callingServer];
            
            
        }
        else if([str_RefName  isEqualToString:@"Sports on TV"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *sportsArray = [[[json valueForKey:@"Details"] valueForKey:@"Sports Details"] retain];
            
            if ([sportsArray count] != 0) {
                
                for (int i = 0; i<[sportsArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Sports_Type:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] withName:[[sportsArray objectAtIndex:i] valueForKey:@"Category Name"]];
                    
                    NSMutableArray *sportDetailsArray = [[[sportsArray objectAtIndex:i] valueForKey:@"event"] retain];
                    //NSLog(@"sportDetailsArray  %d",[sportDetailsArray count]);
                    
                    for (int j = 0; j<[sportDetailsArray count]; j++) {
                        
                        NSMutableArray *pubInfoArray=[[[sportDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                        
                        for (int k=0; k<[pubInfoArray count]; k++) {
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Sports_Detail:[[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventID"] intValue] sport_TypeID:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] event_Name:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventName"] event_Description:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventDescription"] event_Date:[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"] event_Channel:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Channel"] reservation:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Reservation"] sound:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Sound"] hd:[[sportDetailsArray objectAtIndex:j] valueForKey:@"HD"] threeD:[[sportDetailsArray objectAtIndex:j] valueForKey:@"threeD"] screen:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Screen"] PubID:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withPubDistance:0.0 event_Time:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Time"] event_Type:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Type"]];//distance/1000
                            
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                        }
                        
                        [pubInfoArray release];
                    }
                    [sportDetailsArray release];
                }
            }
            
            [sportsArray release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
           
            deletedDataCall = YES;
            NSLog(@"Sports on TV Updated");
            [self DataCalling4deleted:0];

            
        }
            
    }
        
       
    else
    {
         if ([deletedEventString isEqualToString:@"EventsDeleted"]) {
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                [[DBFunctionality4Delete sharedInstance] deleteRegularEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                
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
                            
                            [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                            
                            
                        }
                        
                    }
                    
                }
                
            }
             [self DataCalling4deleted:1];
        }
        
        else if ([deletedEventString isEqualToString:@"ThemeNightDeleted"]) {
            
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                [[DBFunctionality4Delete sharedInstance] deleteThemenightEvents:[[json valueForKey:@"Details"] valueForKey:@"Active Theme"]];
                
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
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
             [self DataCalling4deleted:2];
        }
        
        
        else if ([deletedEventString isEqualToString:@"OneOffDeleted"]) {
            
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                [[DBFunctionality4Delete sharedInstance] deleteOneOffEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                
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
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                            
                            
                        }
                        
                    }
                    
                }
            }
             [self DataCalling4deleted:3];
            
        }
        
        else if ([deletedEventString isEqualToString:@"SportsDeleted"]) {
            
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                NSMutableArray *sportsIDArray = [[NSMutableArray alloc] init];
                
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
                    
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"sportID"] intValue];
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            [[DBFunctionality4Delete sharedInstance] deleteSports:pubid andEventID:EventId];
                            
                            [sportsIDArray addObject:[NSString stringWithFormat:@"%d",EventId]];
                        }
                        //[Arr_PubInfo release];
                    }
                    //[Arr_EventDetails release];
                }
                
                [[DBFunctionality4Delete sharedInstance] deleteSports:sportsIDArray];
            }
            [self performSelector:@selector(myThreadMainMethod:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
            
            [self performSelector:@selector(updateDB) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
            [self performSelector:@selector(doneLoadingTableViewData)];
        }

        
        
    }
    
    
}


-(void) updateDB
{
   eventArray = [[SaveEventCatagoryInfo GetEventInfo:delegate.SelectedRadius] retain];
    
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

-(void) DataCalling4deleted:(int)_callerNumber
{
    //deletedDataCall = YES;
    
    if (_callerNumber == 0) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"EventsDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteEventsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
    }
    
    if (_callerNumber == 1) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"ThemeNightDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteThemeNightData:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    
    if (_callerNumber == 2) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"OneOffDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteOneOffData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    
    if (_callerNumber == 3) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"SportsDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteSportsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
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



#pragma mark -
#pragma  mark - recccomenndVenueBtn Action
-(IBAction)OpenMailComposer:(id)sender
{
 
    RecomendedVenue *obj_RecomendedVenue=[[RecomendedVenue alloc]initWithNibName:[Constant GetNibName:@"RecomendedVenue"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_RecomendedVenue animated:YES];
    [obj_RecomendedVenue release];

    
    
    /*  Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
       
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
        
    }*/
    
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
    
    obj.textString = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}               


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
    
    [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"Pub & bar Network"];
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
    
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
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
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
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
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     //@"Want to share through Greetings", @"description",
     @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
     @"https://m.facebook.com/apps/Greetings/", @"link",
     //@"http://fbrell.com/f8.jpg", @"picture",
     nil];  
    [[FacebookController sharedInstance].facebook dialog:@"feed"
                                               andParams:params
                                             andDelegate:self];    
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
    [self setEventCatagoryViewFrame];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"events array   %d",[eventArray count]);
    return [eventArray count];
    
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
        vw1=[[[UIView alloc]init]autorelease];
        if ([Constant isiPad]) {
            ;
        }
        
        else{
            if ([Constant isPotrait:self]) {
                
                
                vw1.frame =CGRectMake(10, 41, 300, 1);
            }
            else
            {
                vw1.frame =CGRectMake(10, 41, 460, 1);
                
            }
        }
        vw1.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
        vw1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        
       
        UIView *vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 0, 320, 37);
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
		 [cell.contentView addSubview:vw1];
		topLabel =[[[UILabel alloc]initWithFrame:CGRectMake(20,1,170,37)]autorelease];
        
		[vw addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:13];
        
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(292, 18, 9, 12)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.image=[UIImage imageNamed:@"HistoryArrow.png"];
        [vw addSubview:nextImg];
        
        if([[[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"] isEqualToString:@"What's On Tonight..."]){
            topLabel.textColor = [UIColor greenColor];
        }
        
    }
    else{
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		nextImg = (UIImageView *)[cell viewWithTag:NEXT_IMG_TAG];
    }
    @try {
        topLabel.text = [[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    title = [[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
    NSLog(@"DATA");
    NSLog(@"NAME  %@ ",[[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"]);
    Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
    obj_catagory.Name = title;
    obj_catagory.Event_page=strPagename;

    //obj_catagory.Name=strPagename;
    //NSLog(@"EVENT ARRAY %@ %@",eventArray,[[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Type"]);
    obj_catagory.eventID = [[eventArray objectAtIndex:indexPath.row] valueForKey:@"Event_Type"];
    [self.navigationController pushViewController:obj_catagory animated:YES];
    [obj_catagory release];

    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table_eventcatagory =nil;
    //self.eventArray = nil;
    //self.btn_bottom = nil;
    
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
-(void)dealloc{
    [table_eventcatagory release];
    [eventArray release];
    [strPagename release];
    //[btn_bottom release];
    [toolBar release];
    [super dealloc];

    
}
@end
