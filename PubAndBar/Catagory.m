//
//  Catagory.m
//  PubAndBar
//
//  Created by User7 on 23/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Catagory.h"
#import "PubList.h"
#import "SportDetail.h"
#import "NearByMap.h"
#import <QuartzCore/QuartzCore.h>

//-------------------//
#import "AmenitiesDetails.h"
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "Constant.h"
#import "Global.h"
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "InternetValidation.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "DBFunctionality4Update.h"
#import "DBFunctionality4Delete.h"

@interface Catagory()

- (void)dataSourceDidFinishLoadingNewData;
-(void) deletedDataCalling:(int)_callerNumber;

@end

@implementation Catagory
@synthesize table_catagory;
@synthesize lbl_heading;
@synthesize catagoryArray;
@synthesize Name;
@synthesize backButton;
@synthesize topLabel;
@synthesize nextImg;
@synthesize middlelbl;
@synthesize bottomlbl;
@synthesize endlbl;
@synthesize firstlbl;
@synthesize datelbl;
//@synthesize temparray;
@synthesize eventID;
@synthesize dateString;
@synthesize searchRadius;
@synthesize searchUnit;

@synthesize  oAuthLoginView;
@synthesize Event_page;
@synthesize hud = _hud;
@synthesize reloading=_reloading;


SportDetail *obj_sportdetail ;
UIInterfaceOrientation orientation;
AppDelegate *delegate ;

BOOL addedDone=NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil// withRadius:(NSString *)_str1
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
    deletedDataCall = NO;
    
    
    // delegate.ismore=NO;
    NSLog(@"RADIUS   %@",searchRadius );
    
    if ([Name isEqualToString:@"Regular"] || [Name isEqualToString:@"One Off" ] || [Name isEqualToString:@"Theme Nights" ] || [Name isEqualToString:@"What's On Next 7 Days" ] || [Name isEqualToString:@"What's On Tonight..." ]) {
        
        self.eventTextLbl.text=Event_page;  
    }
    else{
        
        self.eventTextLbl.text=Name;
        
    }
    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"Miles"])
    {
        //-------------------------mb-02-06-12------------------//
        NSString *radius;
        if ([searchRadius isEqualToString:@"> 20.0"])
        {              radius=[[searchRadius stringByReplacingOccurrencesOfString:@">" withString:@""]retain];
            searchRadius=[[NSString stringWithFormat:@">%f",[radius floatValue]*1.609344 ]retain];
        }else
        {
            radius=[[searchRadius stringByReplacingOccurrencesOfString:@"<=" withString:@""]retain];
            searchRadius=[[NSString stringWithFormat:@"<=%f",[radius floatValue]*1.609344]retain];
        }
        //------------------------------------------------------//
    }
    
    
    if([Name isEqualToString:@"Sports on TV"]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetSport_CatagoryNameInfo:searchRadius] retain];            
    }
    else if([Name isEqualToString:@"Food & Offers" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetFood_Type:searchRadius]retain]; 
        NSLog(@"catagoryArray   %@",catagoryArray);
    }
    else if([Name isEqualToString:@"Facilities" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetAmmenity_NameInfo:searchRadius]retain]; 
    }
    else if([Name isEqualToString:@"Regular"]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain];  
    }
    else if([Name isEqualToString:@"One Off" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain]; 
    }
    else if([Name isEqualToString:@"Theme Nights" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain]; 
    }
    else if([Name isEqualToString:@"What's On Tonight..." ]){
        NSString *currentdate = [Constant GetCurrentDateTime];
        NSArray *arr_date_time = [currentdate componentsSeparatedByString:@" "];
        NSString *nightdaytime = [NSString stringWithFormat:@"%@235959",[arr_date_time objectAtIndex:0]];
        nightdaytime = [nightdaytime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        catagoryArray = [[NSMutableArray alloc]init];
        //catagoryArray = [[SaveCatagoryInfo GetPubDetailsInfo:dateString]retain];   
        catagoryArray = [[SaveCatagoryInfo getDateEvent:nightdaytime isfortonight:YES]retain];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubDistance" ascending:YES selector:@selector(compare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [catagoryArray sortedArrayUsingDescriptors:sortDescriptors];
        
        NSLog(@"Sorted Array   %@",sortedArray);
        [catagoryArray removeAllObjects];
        [catagoryArray addObjectsFromArray:sortedArray];
        
    }
    else if([Name isEqualToString:@"What's On Next 7 Days" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        //catagoryArray = [SaveCatagoryInfo GetPubDetailsInfo1]; 
        NSDate *today = [NSDate date];
        
        // All intervals taken from Google
        //NSDate *yesterday = [today dateByAddingTimeInterval: 86400.0];
        NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        [dateFormat setLocale:[NSLocale currentLocale]];
        NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
        [dateFormat release];
        catagoryArray = [[SaveCatagoryInfo getDateEvent:dateAftersevendays isfortonight:NO] retain];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubDistance" ascending:YES selector:@selector(compare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [catagoryArray sortedArrayUsingDescriptors:sortDescriptors];
        
        NSLog(@"Sorted Array   %@",sortedArray);
        [catagoryArray removeAllObjects];
        [catagoryArray addObjectsFromArray:sortedArray];
    }
    
    //-----------------------------------mb----------------------------//
    if ([catagoryArray count]==0) {
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    /*  else
     {
     NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES comparator:^(id obj1, id obj2) {
     
     if ([obj1 integerValue] > [obj2 integerValue]) {
     return (NSComparisonResult)NSOrderedDescending;
     }
     if ([obj1 integerValue] < [obj2 integerValue]) {
     return (NSComparisonResult)NSOrderedAscending;
     }
     return (NSComparisonResult)NSOrderedSame;
     }];
     
     NSArray *sortedArray= [catagoryArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]];
     }*/
    [self CreateView];
    //----------------------------------------------------------------//
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
    
    
    
    table_catagory = [[UITableView alloc]init];
    //table_catagory.frame=CGRectMake(0, 44, 320, 315);
    //table_catagory.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    table_catagory.delegate=self;
    table_catagory.dataSource=self;
    table_catagory.backgroundColor =[UIColor clearColor];
    table_catagory.separatorStyle=UITableViewCellSeparatorStyleNone;
    table_catagory.separatorColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    datelbl = [[UILabel alloc]init];
    datelbl.textColor = [UIColor whiteColor];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.font = [UIFont boldSystemFontOfSize:9];
    
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.backgroundColor=[UIColor clearColor];
    // lbl_heading.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:13];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    if([Name isEqualToString: @"Sports on TV" ]){
        lbl_heading.text = @"Choose a Sport";
        // lbl_heading.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
    }
    else if([Name isEqualToString:@"Food & Offers" ]){
        lbl_heading.text = @"Choose a Food";
        lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];    
    }
    //------------------------mb-25/05/12/5-45---------------------//
    else if([Name isEqualToString:@"Facilities" ]){
        lbl_heading.text = @"Amenities";
        // lbl_heading.backgroundColor = [UIColor clearColor];
    }
    //----------------------------------------------//
    
    else if([Name isEqualToString:@"Regular"]){
        lbl_heading.text = @"Choose a Regular Event";
        //lbl_heading.backgroundColor = [UIColor clearColor];
    }
    
    else if([Name isEqualToString:@"One Off" ]){
        lbl_heading.text = @"Choose a One off Event";
        //lbl_heading.backgroundColor = [UIColor clearColor];
    }
    
    else if([Name isEqualToString:@"Theme Nights" ]){
        lbl_heading.text = @"Choose a Theme Night";
        //lbl_heading.backgroundColor = [UIColor clearColor];
    }
    else if([Name isEqualToString:@"What's On Tonight..." ]){
        lbl_heading.text = @"What's On Tonight";
        lbl_heading.textColor = [UIColor greenColor];
        lbl_heading.backgroundColor = [UIColor clearColor];
        NSDate *date = [NSDate date]; 
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterLongStyle]; 
        [df setTimeStyle:NSDateFormatterNoStyle];  
        
        NSString *tempdateString = [df stringFromDate:date]; 
        NSLog(@"%@",tempdateString);
        datelbl.text = tempdateString;
        [df release];
        str_RefName=@"Events";
    }
    else if([Name isEqualToString:@"What's On Next 7 Days" ]){
        lbl_heading.text = @"What's On Next 7 Days";
        str_RefName=@"Events";
    }
    
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table_catagory];
    [lbl_heading release];
    [backButton release];
    [datelbl release];
    
    if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_catagory.bounds.size.height, 320.0f, table_catagory.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[table_catagory addSubview:refreshHeaderView];
		[refreshHeaderView release];
	}
}

-(void) callingServer
{    
    if([InternetValidation  checkNetworkStatus])
    {
         if(!([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ])){
        
        str_RefName =Name;
         }
        
        if([Name isEqualToString:@"Regular"]||[Name isEqualToString:@"One Off" ]){
            
            
            
            str_RefName=@"Events";
        }
        
        NSLog(@"%@",str_RefName);
        
        
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        
        if([str_RefName isEqualToString:@"Food & Offers" ]){
            
            [conn1 getFoodandOffersData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            
        }
        
        else if([str_RefName isEqualToString:@"Sports on TV"]){
            
            [conn1 getSportsData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
        }
        
        
        else if([str_RefName isEqualToString:@"Facilities" ]){
            [conn1 getEventsData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];             
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
        
        if([str_RefName  isEqualToString:@"Food & Offers"])
        {
            //SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
            //[parser release];
            
            
            if ([foodAndOfferArray count]!=0)
            {
                
                for (int i = 0; i<[foodAndOfferArray count]; i++)
                {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Food_Type:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] withName:[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food and Offers Type"]];
                    
                    NSMutableArray *pubInfoArray = [[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Pub Information"] retain];
                    
                    for (int j = 0; j<[pubInfoArray count]; j++)
                    {
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Food_Detail:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withFoodID:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] pubDistance:0.0];//distance/1000
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:j] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:j] valueForKey:@"venuePhoto"]];//distance/1000
                    }
                    //NSLog(@"pubInfoArray   %@",pubInfoArray);
                    [pubInfoArray release];
                }
                //   [self performSelector:@selector(dismissHUD:)];
            }
            [foodAndOfferArray release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            [self deletedDataCalling:5];
            
        }
       else if ([str_RefName isEqualToString:@"Events"]) 
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
            
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
                str_RefName=@"Theme Nights";
                [self callingServer];
                
            }
            else{
            [self deletedDataCalling:0];
            [self deletedDataCalling:2];
            }
            
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
           
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
                str_RefName=@"Sports on TV";
                [self callingServer];
                
            }
            else{
                [self deletedDataCalling:1];
            }

                   
        }
        
        
       else if([str_RefName isEqualToString:@"Real Ale"])
        {
            
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
        
        //----------------------mb-25/05/12/5-45p.m.------------------------//
        else if([str_RefName  isEqualToString:@"Facilities"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            NSMutableArray *AmenitiesArray = [[[json valueForKey:@"Details"] valueForKey:@"Amenities Details"] retain];
            
            if ([AmenitiesArray count] != 0) {
                
                for (int i = 0; i<[AmenitiesArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Amenities_Type:i+1 withName:[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]];
                    
                    //NSLog(@"facilityDetailsArray  %d",[facilityDetailsArray count]);
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Facilities"]) {
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Facility Details"] retain];
                        
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                        
                    }
                    
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Style(s)"]) {
                        
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Style Details"] retain];
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                    }
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Features"]) {
                        
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Features Details"] retain];
                        
                        
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Features ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Features Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                    }
                    
                    
                }
            }
            [AmenitiesArray release];
            
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            [self deletedDataCalling:6];
            
        }
        //-----------------------------5-45------------------------//
        
        //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
        
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
           
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
                deletedDataCall = YES;
                [self deletedDataCalling:0];
                
            }
            else{
                [self deletedDataCalling:3];
           
                       
            }
        
       }
    }
    else
    {
        if ([deletedEventString isEqualToString:@"FoodDeleted"])
        {
            
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Food Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FoodID"] intValue];
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            
                            [[DBFunctionality4Delete sharedInstance] deleteFoods:pubid andEventID:EventId];
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
        
        else if ([deletedEventString isEqualToString:@"EventsDeleted"]) {
            
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
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
            [self deletedDataCalling:1];
            }
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
            
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
                [self deletedDataCalling:2];
            }

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
            if([Name isEqualToString:@"What's On Tonight..." ]||[Name isEqualToString:@"What's On Next 7 Days" ]){
                [self deletedDataCalling:3];
            }

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
            
            
        }
        
        else if ([deletedEventString isEqualToString:@"RealAleDeleted"]) {
            
            
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
        
        
        else if ([deletedEventString isEqualToString:@"FacilityDeleted"]) {
            
            
            NSDictionary *json = [data_Response JSONValue];
            
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Facility Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                int EventTypeID;
                if ([[[Arr_events objectAtIndex:0] valueForKey:@"Event Name"] isEqualToString:@"Facility"])
                    EventTypeID = 1;
                else if([[[Arr_events objectAtIndex:1] valueForKey:@"Event Name"] isEqualToString:@"Style"])
                    EventTypeID = 2;
                else if([[[Arr_events objectAtIndex:2] valueForKey:@"Event Name"] isEqualToString:@"Features"])
                    EventTypeID = 3;
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FacilityID"] intValue];
                        
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            [[DBFunctionality4Delete sharedInstance] deleteFacilities:pubid andEventID:EventId facilityID:EventTypeID];
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        //if(![Name isEqualToString:@"What's On Tonight..."] || ![Name isEqualToString:@"What's On Next 7 Days" ]){
            deletedDataCall = NO;
            [self performSelector:@selector(myThreadMainMethod:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
            
            [self performSelector:@selector(updateDB) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];    
            [self performSelector:@selector(doneLoadingTableViewData)];
        //}
        
        

    }
    
}

-(void) updateDB
{
    if([Name isEqualToString:@"Food & Offers" ]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetFood_Type:searchRadius]retain]; 
        NSLog(@"catagoryArray   %@",catagoryArray);
    }
    
    if([Name isEqualToString:@"Sports on TV"]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetSport_CatagoryNameInfo:searchRadius] retain];            
    }
    else if([Name isEqualToString:@"Facilities" ]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetAmmenity_NameInfo:searchRadius]retain]; 
    }
    else if([Name isEqualToString:@"Regular"]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain];  
    }
    else if([Name isEqualToString:@"One Off" ]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain]; 
    }
    else if([Name isEqualToString:@"Theme Nights" ]){
        [catagoryArray removeAllObjects];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID withRadius:searchRadius]retain]; 
    }
    
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
    if (_callerNumber == 4) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"RealAleDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteRealAleData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 5) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FoodDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteFoodData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 6) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FacilityDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteFacilityData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
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

#pragma mark
#pragma mark PullTableViewRefresh Delegates


- (void)reloadTableViewDataSource{
	
	//[self performSelector:@selector(addMBHud)];
    [self performSelector:@selector(callingServer)];
    //self.navigationController.view.userInteractionEnabled = NO;
    
}



- (void)doneLoadingTableViewData{
    
    //self.navigationController.view.userInteractionEnabled = YES;
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
		table_catagory.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


- (void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	[table_catagory reloadData];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[table_catagory setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}

-(IBAction)ClickBack:(id)sender{
    
    
    // delegate.ismore=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    
    else{
        if ([Constant isPotrait:self]) {
            
            table_catagory.frame=CGRectMake(10, 136, 300, 280);
            lbl_heading.frame = CGRectMake(90, 89, 160, 27);
            backButton.frame = CGRectMake(8, 90, 50, 25);
            datelbl.frame = CGRectMake(238, 58, 125, 27);
            // vw1.frame =CGRectMake(10, 59, 300, 1);
            
            if (delegate.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                
            }
            else{
                
                //toolBar.frame = CGRectMake(0, 387, 640, 48);01
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
            
        }
        
        else{
            table_catagory.frame=CGRectMake(10, 115, 460, 141);
            lbl_heading.frame = CGRectMake(110, 90, 240, 27); 
            backButton.frame = CGRectMake(20, 85, 50, 25);
            datelbl.frame = CGRectMake(398, 51, 125, 27);
            // vw1.frame =CGRectMake(10, 59, 460, 1);
            
            if (delegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            
            [table_catagory reloadData];
            
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    // delegate.ismore=NO;
    
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
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
- (void)ShareInTwitter:(NSNotification *)notification {
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    
    
    
    
    if ([Name isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/sportspubs-sportsbars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars showing sports %@",tempurl];
    }
    
    else if ([Name isEqualToString:@"Food & Offers"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/barfood-gastropubs.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars available Foods %@",tempurl];
        
        
        
        
        
    }
    
    
    else if ([Name isEqualToString:@"What's On Next 7 Days"] || [Name isEqualToString:@"What's On Tonight..."]){
        
        
        
        obj.textString=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([Name isEqualToString:@"Theme Nights" ]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs_and_bars-theme_nights.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars showing Theme Night Events %@",tempurl];
        
    }
    
    
    else if ([Name isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubsandbars-nitelife.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars showing One Off Events %@",tempurl];
        
    }
    
    
    
    else if ([Name isEqualToString:@"Regular"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/nightlife_pubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars showing Regular Events %@",tempurl];
        
    }
    
    else if([Name isEqualToString:@"Facilities" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars showing Amenities %@",tempurl];
        
    }
    
    
    
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
    
    NSString *fb_str;
    if ([Name isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/sportspubs-sportsbars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing sports %@",tempurl];
    }
    
    else if ([Name isEqualToString:@"Food & Offers"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/barfood-gastropubs.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods %@",tempurl];
        
        
        
        
        
    }
    
    
    else if ([Name isEqualToString:@"What's On Next 7 Days"] || [Name isEqualToString:@"What's On Tonight..."]){
        
        
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([Name isEqualToString:@"Theme Nights" ]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs_and_bars-theme_nights.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing Theme Night Events %@",tempurl];
        
    }
    
    
    else if ([Name isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubsandbars-nitelife.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing One Off Events %@",tempurl];
        
    }
    
    
    
    else if ([Name isEqualToString:@"Regular"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/nightlife_pubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing Regular Events %@",tempurl];
        
    }
    
    else if([Name isEqualToString:@"Facilities" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing Amenities %@",tempurl];
        
    }
    
    
    
    
    [mailController setMessageBody:[NSString stringWithFormat:@"%@",fb_str] isHTML:NO];
    
    
    
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
    
    if ([Name isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/sportspubs-sportsbars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars showing sports %@",tempurl];
    }
    
    else if ([Name isEqualToString:@"Food & Offers"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/barfood-gastropubs.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars available Foods %@",tempurl];
        
        
        
        
        
    }
    
    
    else if ([Name isEqualToString:@"What's On Next 7 Days"] || [Name isEqualToString:@"What's On Tonight..."]){
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([Name isEqualToString:@"Theme Nights" ]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs_and_bars-theme_nights.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars showing Theme Night Events %@",tempurl];
        
    }
    
    
    else if ([Name isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubsandbars-nitelife.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars showing One Off Events %@",tempurl];
        
    }
    
    
    
    else if ([Name isEqualToString:@"Regular"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/nightlife_pubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars showing Regular Events %@",tempurl];
        
    }
    
    else if([Name isEqualToString:@"Facilities" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars showing Amenities %@",tempurl];
        
    }
    
    
    
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
    if ([Name isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/sportspubs-sportsbars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing sports %@",tempurl];
    }
    
    else if ([Name isEqualToString:@"Food & Offers"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/barfood-gastropubs.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods %@",tempurl];
        
        
        
        
        
    }
    
    
    else if ([Name isEqualToString:@"What's On Next 7 Days"] || [Name isEqualToString:@"What's On Tonight..."]){
        
        
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([Name isEqualToString:@"Theme Nights" ]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs_and_bars-theme_nights.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing Theme Night Events %@",tempurl];
        
    }
    
    
    else if ([Name isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubsandbars-nitelife.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing One Off Events %@",tempurl];
        
    }
    
    
    
    else if ([Name isEqualToString:@"Regular"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/nightlife_pubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing Regular Events %@",tempurl];
        
    }
    
    else if([Name isEqualToString:@"Facilities" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing Amenities %@",tempurl];
        
    }
    
    
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
    if ([Name isEqualToString:@"Sports on TV"])
        
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/sportspubs-sportsbars.html"];
    
    else if ([Name isEqualToString:@"Food & Offers"]){
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/barfood-gastropubs.html"];
        
    }
    
    
    else if ([Name isEqualToString:@"What's On Next 7 Days"] || [Name isEqualToString:@"What's On Tonight..."]){
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8"];
        
    }
    
    else if ([Name isEqualToString:@"Theme Nights" ]){
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs_and_bars-theme_nights.html"];
        
    }
    
    
    else if ([Name isEqualToString:@"One Off"]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubsandbars-nitelife.html"];
        
    }
    
    
    
    else if ([Name isEqualToString:@"Regular"]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/nightlife_pubs-bars.html"];
        
    }
    
    else if([Name isEqualToString:@"Facilities" ]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        
    }
    
    
    
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     fb_str,@"message",
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
    
    
    [self performSelector:@selector(dismissHUD:)];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table_catagory=nil;
    self.catagoryArray = nil;
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
	/*if(Name==@"What's On Tonight..."){
     return 7;
     }
     else if(Name==@"What's On Next 7 Days"){
     return 7;
     }
     else{
     return [catagoryArray count];
     }*/
    // if([Name isEqualToString:@"Facilities" ]){
    //     return 2;
    // }
    //  else
    
    return [catagoryArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Name isEqualToString:@"What's On Next 7 Days" ] || [Name isEqualToString:@"What's On Tonight..." ]) {
        return 60;
    }
    else{
        return 44;	
    }
	
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger NEXT_IMG_TAG = 1005;
    const NSInteger FIRST_LABEL_TAG = 1006;
    const NSInteger EVENT_LABEL_TAG = 1007;
    
    UILabel *lbl_event;
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
        cell.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        //cell.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        
		vw1=[[[UIView alloc]init]autorelease];
        vw = [[[UIView alloc]init]autorelease];
        vw.autoresizingMask= UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if ([Constant isiPad]) {
            ;
        }
        
        else{
            if ([Constant isPotrait:self]) {
                
                
                vw1.frame =CGRectMake(0, 41, 480, 1);
            }
            else
            {
                vw1.frame =CGRectMake(0, 41, 480, 1);
                
            }
        }
        if ([Name isEqualToString:@"What's On Next 7 Days" ] || [Name isEqualToString:@"What's On Tonight..." ]) {
            vw.frame =CGRectMake(10, 2, 300, 57);
            vw1.frame =CGRectMake(0, 65, 480, 1);
        }
        
        else if([Name isEqualToString:@"Facilities" ]){
            
            vw.frame =CGRectMake(0, 7, 320, 50);
        }
        
        
        else{
            vw.frame =CGRectMake(0, 7, 320, 40);
        }
        
        
        //vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth; 
        vw.backgroundColor =[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        
        
        vw1.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
        // vw1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        
        //[cell.contentView addSubview:vw];
        
        [cell.contentView addSubview:vw1];
		topLabel =[[[UILabel alloc]init]autorelease];
        topLabel.frame =
        CGRectMake(20,0,170,37);
        
		[cell.contentView addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:13];
        topLabel.lineBreakMode = UILineBreakModeWordWrap;
        topLabel.numberOfLines = 2;
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 13, 11, 11)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.contentMode = UIViewContentModeScaleAspectFit;
        nextImg.image=[UIImage imageNamed:@"HistoryArrow.png"];
        [cell.contentView addSubview:nextImg];
        
        if([Name isEqualToString:@"What's On Tonight..." ]){
            
            lbl_event=[[[UILabel alloc]initWithFrame:CGRectMake(4, 35, 95, 15)]autorelease];
            lbl_event.tag=EVENT_LABEL_TAG;
            lbl_event.backgroundColor = [UIColor clearColor];
            lbl_event.textColor = [UIColor whiteColor];
            lbl_event.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            lbl_event.font = [UIFont boldSystemFontOfSize:8];
            lbl_event.lineBreakMode = UILineBreakModeWordWrap;
            lbl_event.numberOfLines = 2;
            
            lbl_event.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            [cell.contentView addSubview:lbl_event];
            
            nextImg.frame=CGRectMake(300, 26, 11, 11);
            
            topLabel.frame =CGRectMake(2, 3, 110, 30);
            topLabel.font = [UIFont boldSystemFontOfSize:9];
            topLabel.numberOfLines=3;
            
            topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            
            middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(120, 2, 125, 20)]autorelease]
            ;
            middlelbl.tag = MIDDLE_LABEL_TAG;
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor colorWithRed:0.0 green:189.0/255.0 blue:243.0/255.0 alpha:1.0];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:9];
            middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            [cell.contentView addSubview:middlelbl];
            
            bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(120, 22, 125, 20)]autorelease];
            bottomlbl.tag = BOTTOM_LABEL_TAG;
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
            bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:10];
            bottomlbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            [cell.contentView addSubview:bottomlbl];
            
            endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(235, 15, 100, 35)]autorelease];
            endlbl.tag = END_LABEL_TAG;
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:9];
            endlbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            [cell.contentView addSubview:endlbl];
            
            
            
        }
        
        if([Name isEqualToString:@"What's On Next 7 Days" ]){
            
            nextImg.frame=CGRectMake(300, 26, 11, 11);
            firstlbl = [[[UILabel alloc]initWithFrame:CGRectMake(2, 33, 100, 16)]autorelease];
            firstlbl.tag = FIRST_LABEL_TAG;
            firstlbl.font = [UIFont boldSystemFontOfSize:8];
            firstlbl.numberOfLines = 2;
            firstlbl.lineBreakMode = UILineBreakModeWordWrap;
            firstlbl.backgroundColor = [UIColor clearColor];
            firstlbl.textColor = [UIColor whiteColor];
            firstlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            firstlbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            [cell.contentView addSubview:firstlbl];
            
            topLabel.frame = CGRectMake(2, 2, 110, 34);
            topLabel.font = [UIFont boldSystemFontOfSize:9];
            topLabel.lineBreakMode = UILineBreakModeWordWrap;
            topLabel.numberOfLines = 2;
            
            topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            
            middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(120, 6, 125, 20)]autorelease]
            ;
            middlelbl.tag = MIDDLE_LABEL_TAG;
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor colorWithRed:0.0 green:189.0/255.0 blue:243.0/255.0 alpha:1.0];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:9];
            middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            [cell.contentView addSubview:middlelbl];
            
            bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(120, 22, 125, 20)]autorelease];
            bottomlbl.tag = BOTTOM_LABEL_TAG;
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
            bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:10];
            bottomlbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            
            [cell.contentView addSubview:bottomlbl];
            
            endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(235, 15, 100, 35)]autorelease];
            endlbl.tag = END_LABEL_TAG;
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:9];
            endlbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
            [cell.contentView addSubview:endlbl];
        }
    }
    /*  else{
     
     if([Name isEqualToString:@"Facilities" ]){
     
     vw.frame =CGRectMake(0, 7, 320, 50);
     }*/
    
    firstlbl = (UILabel *)[cell.contentView viewWithTag:FIRST_LABEL_TAG];
    topLabel = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
    middlelbl = (UILabel *)[cell.contentView viewWithTag:MIDDLE_LABEL_TAG];
    bottomlbl = (UILabel *)[cell.contentView viewWithTag:BOTTOM_LABEL_TAG];
    endlbl = (UILabel *)[cell.contentView viewWithTag:END_LABEL_TAG];
    nextImg = (UIImageView *)[cell.contentView viewWithTag:NEXT_IMG_TAG];
    lbl_event=(UILabel *)[cell.contentView viewWithTag:EVENT_LABEL_TAG];
    
    
    //}
    @try {
        if([Name isEqualToString:@"Sports on TV"]){
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_Name"];
            NSLog(@"ID  %@",[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"]);
            
        }
        else if([Name isEqualToString:@"Food & Offers" ]){
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Food_Name"];
        }
        else if([Name isEqualToString:@"What's On Tonight..." ])
        {
            lbl_event.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Name" ];
            middlelbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
            bottomlbl.text = [ NSString stringWithFormat:@" %@",[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubCity" ]];
            // endlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ];
            
            
            if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
            {
                
                endlbl.text= [NSString stringWithFormat: @"%d Km",(int)floor([[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"] doubleValue])];
                
            }
            else
                endlbl.text=[NSString stringWithFormat:@"%d Miles",(int)floor([[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
            
            
            
            
            
            
            /*       endlbl.text= [NSString stringWithFormat: @"%@ Km",[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]];
             NSLog(@"Value  %@",[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]);
             }
             else
             endlbl.text=[NSString stringWithFormat:@"%0.2f Miles",[[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192];*/
            //  NSLog(@"DISTANCE   %@",[NSString stringWithFormat:@"%0.2f Miles",[[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192]);
            
            
            
            
            
            
            // topLabel.backgroundColor = [UIColor clearColor];
            //  topLabel.frame = CGRectMake(10, 0, 250, 18);
            //topLabel.font = [UIFont boldSystemFontOfSize:13];
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
        }
        else if([Name isEqualToString:@"What's On Next 7 Days"]){
            
            firstlbl.text= [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Name"];
            
            
            
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Event_Name"];
            middlelbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubName"];
            NSLog(@"%@",[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubCity"]);
            bottomlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubCity"];
            // endlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"];
            
            
            if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
                endlbl.text= [NSString stringWithFormat: @"%d Km",(int)floor([[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"] doubleValue])];
            else
                endlbl.text=[NSString stringWithFormat:@"%d Miles",(int)floor([[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
            
            
            //            topLabel.backgroundColor = [UIColor orangeColor];
            //            topLabel.frame = CGRectMake(10, 0, 250, 40);
            //            topLabel.font = [UIFont boldSystemFontOfSize:13];
            //            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
        }
        //-------------------mb--25/05/12/5-45----------------------//
        else if([Name isEqualToString:@"Facilities" ])
        {
            NSLog(@"catagoryArray   %@",catagoryArray);
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Ammenity_Type" ];
        }
        //-----------------------------------------//
        else
        {
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"]; 
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSelector:@selector(addMBHud)];
    
    [self performSelector:@selector(MoveToNextPage) withObject:nil afterDelay:1.0];
    
    
    
}

-(void)MoveToNextPage{
    
    
    if([Name isEqualToString:@"Sports on TV"]){
        
        // vw.backgroundColor=[UIColor redColor];
        
        
        obj_sportdetail = [[SportDetail alloc]initWithNibName:[Constant GetNibName:@"SportDetail"] bundle:[NSBundle mainBundle]];  
        obj_sportdetail.searchRadius = searchRadius;
        obj_sportdetail.sportID = [[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
        obj_sportdetail.sport_name=Name;
        obj_sportdetail.str_title=[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row] valueForKey:@"Sport_Name"];
        
        [self.navigationController pushViewController:obj_sportdetail animated:YES];
        [obj_sportdetail release];
        
    }
    
    else if ([Name isEqualToString:@"Food & Offers"]) {
        
        PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
        obj.catID = [[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row] valueForKey:@"Food_ID"];
        obj.searchRadius = searchRadius;
        obj.eventName=[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"Food_Name"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
    }
    
    else if ([Name isEqualToString:@"Regular"] || [Name isEqualToString:@"One Off" ] || [Name isEqualToString:@"Theme Nights" ] || [Name isEqualToString:@"What's On Next 7 Days" ] || [Name isEqualToString:@"What's On Tonight..." ])
    {
        
        PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
        obj.categoryStr=Name;
        obj.eventTypeId = [[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"EventTypeID"];
        NSLog(@"ID %@",[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"EventTypeID"]);
        obj._Eventpage=Event_page;
        obj.eventName=[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"Event_Name"];
        
        obj.Day=[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"EventDay"];
        
        NSMutableArray *arr_EventName=[[NSMutableArray alloc]init];        
        for (int i=0; i<[catagoryArray count]; i++) {
            
            [arr_EventName addObject:[[catagoryArray objectAtIndex:i]valueForKey:@"Event_Name"]];
            
        }
        
        //        [arr_EventName addObject:@"Regular"];
        //        [arr_EventName addObject:@"Sport on Tv"];
        
        NSArray *copy = [arr_EventName copy];
        NSInteger index = [copy count] - 1;
        for (id object in [copy reverseObjectEnumerator]) {
            if ([arr_EventName indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
                [arr_EventName removeObjectAtIndex:index];
            }
            index--;
        }
        [copy release];
        
        
        
        
        NSLog(@"Event Name ARRAY %@",arr_EventName);
        
        // [arr_EventName addObject:@"Regular"];
        
        
        obj.array_EventName=[arr_EventName copy]; 
        
        NSLog(@"Event Name ARRAY %@",obj.array_EventName);
        
        
        obj.catID = eventID;//[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_ID"];
        obj.sport_eventID = [[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row] valueForKey:@"Event_ID"];
        obj.eventID= [[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row] valueForKey:@"Event_ID"];
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
        [arr_EventName release];
    }
    
    //-------------mb------25/05/12/5-45---------------------//
    else if([Name isEqualToString:@"Facilities"])
    {
        NSLog(@"catagoryArray   %@",[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"Ammenity_Type" ]);
        
        AmenitiesDetails  *obj_aminitiesDtls=[[AmenitiesDetails alloc]initWithNibName:[Constant GetNibName:@"AmenitiesDetails"] bundle:[NSBundle mainBundle] withString:[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"Ammenity_Type" ]];
        
        obj_aminitiesDtls.Name=[[catagoryArray objectAtIndex:[table_catagory indexPathForSelectedRow].row]valueForKey:@"Ammenity_Type" ];
        obj_aminitiesDtls.searchRadius=searchRadius;
        //obj_aminitiesDtls.Name=Name;
        [self.navigationController pushViewController:obj_aminitiesDtls animated:YES];
        [obj_aminitiesDtls release];
    }
    //-----------------------------------// 
    
    
}

#pragma mark-
#pragma mark-addMBHud
-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"Loading...";
    // _hud.detailsLabelText = @"Loading Sport Event Details.";
    
}
#pragma mark Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}

-(void)dealloc{
    [table_catagory release];
    [catagoryArray release];
    [searchRadius release];
    [searchUnit release];
    [toolBar release];
    [super dealloc];
    
}

@end
