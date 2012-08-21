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
#import "Facilities_MicrositeDetails.h"
#import "InternetValidation.h"
#import "Event_Microsite.h"
#import "Sport_Microsite.h"
#import "SavePubDetailsSubCatagoryInfo.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "DBFunctionality4Update.h"
#import "DBFunctionality4Delete.h"
#import "EGORefreshTableHeaderView.h"
#import "URLRequestString.h"


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
@synthesize _Eventpage;
@synthesize bulletPointArray,
openingHours4Day,
openingHours4Hours;
@synthesize array_sportEvent;
@synthesize str_sportDesc;
@synthesize array_EventDetails;
@synthesize array_EventName;
@synthesize Day;
@synthesize eventTypeId;
@synthesize reloading=_reloading;

int noofPubs;
int p;


BOOL valueForCheck=0;

UIInterfaceOrientation orientation;



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
    deletedDataCall = NO;
    shiftToNextPage = NO;
    
    array_realAle=[[NSMutableArray alloc]init];
    if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        self.eventTextLbl.text=_Eventpage;
        str_RefName=@"Events";
    }
    else{
        self.eventTextLbl.text=categoryStr;
    }
    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    array=[[NSMutableArray alloc]init];
    
    if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"Miles"])
    {
        //-------------------------mb-02-06-12------------------//
        NSString *radius;
        if ([searchRadius isEqualToString:@"> 20.0"])
        {              radius=[searchRadius stringByReplacingOccurrencesOfString:@">" withString:@""];
            searchRadius=[NSString stringWithFormat:@">%f",[radius floatValue]*1.609344 ];
        }else
        {
            radius=[searchRadius stringByReplacingOccurrencesOfString:@"<=" withString:@""];
            searchRadius=[NSString stringWithFormat:@"<=%f",[radius floatValue]*1.609344];
        }
        //------------------------------------------------------//
    }
    
    if([categoryStr isEqualToString:@"Food & Offers"]){
    
    array = [[SavePubListInfo GetPubDetailsInfo:[catID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
    }
    else if ([categoryStr isEqualToString:@"Real Ale"])
    {
        array = [[SavePubListInfo GetPubDetailsInfo:[beerID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
    
    }
    else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        array = [[SavePubListInfo GetPubDetailsInfo1:[catID intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr withEventTypeID:eventTypeId] retain];
    }
    
    else if ([categoryStr isEqualToString:@"Sports on TV"]){
        array = [[SavePubListInfo GetPubDetailsInfo:[sport_eventID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
    }
   
    else  if([categoryStr isEqualToString:@"Facilities"]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:1 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:2 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Features" ]){
        array=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:3 radius:searchRadius]retain];
    }
   
    
    else {
        array = [[SavePubListInfo GetPubDetailsInfo1:[Pubid intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr withEventTypeID:eventTypeId]retain];

    }
 
    if ([array count] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub & Bar Network" message:@"No venues available!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.tag = 20;
        [alert show];
        [alert release];
    }

  
    [self CreateView];
    
     
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"ISSELECT  %d  Checkvalue  %d  shiftToNextPage  %d",IsSelect,valueForCheck,shiftToNextPage);
    
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self SetCustomNavBarFrame];

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
    [self performSelector:@selector(showOrHideMorebutton)];
    
    
    if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        table_list.hidden=NO;
        // _venu_btn.hidden=NO;
        [table_list reloadData];
        vw_header.hidden=NO;
        obj_nearbymap.hidden=YES;
        Title_lbl.hidden=NO;
        IsSelect=NO;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                
                
                
                
            }
            else{
                [list_btn setImage:[UIImage imageNamed:@"ListSelectL.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapDeselectL.png"] forState: UIControlStateNormal];
                
            }
        }
        
    }
    
    else
    {
        table_list.hidden=YES;
        obj_nearbymap.hidden=NO;
        vw_header.hidden=YES;
        Title_lbl.hidden=YES;
        
             
        IsSelect=YES;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                
                
            }
            else{
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelectL.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselectL.png"] forState: UIControlStateNormal];
                
            }
        }
    }
    

    
    [self setViewFrame];

   
    
    [self AddNotification];
}


-(void) showOrHideMorebutton
{
    if (!shiftToNextPage) {
        
        _pub_list = [[NSMutableArray alloc] init];
        
        if ([GET_DEFAUL_VALUE(ShowNumberOfPubs) intValue]!=0) {
            noofPubs=[GET_DEFAUL_VALUE(ShowNumberOfPubs) intValue];
        }
        else
            noofPubs=20;
        p=noofPubs;
        if([self.array count]>noofPubs){
            
            for ( int i=0; i<noofPubs; i++) {
                [_pub_list addObject:[array objectAtIndex:i]];
            }
            if([self.array count]==noofPubs){
                
            }
        }
        else
        {
            for ( int i=0; i<[array count]; i++) {
                [_pub_list addObject:[array objectAtIndex:i]];
                
            }
           
        }
        
        [self _callingMapview];
    }
}


-(void) callingServer4Update
{
    if ([InternetValidation checkNetworkStatus]) {
       
        if(!([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ])){
            
           str_RefName =categoryStr;
        }
                       
        if([categoryStr isEqualToString:@"Regular"]||[categoryStr isEqualToString:@"One Off" ]){
                             
            str_RefName=[NSString stringWithFormat:@"Events"];
        }
        
        NSLog(@"%@",str_RefName);
        
                    
        if([str_RefName isEqualToString:@"Food & Offers" ]){
            
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",FoodandOffersURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
            
        }
        
        else if([str_RefName isEqualToString:@"Sports on TV"]){
            
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",SportsURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];

        }
        
        
        else if([str_RefName isEqualToString:@"Facilities" ]||[str_RefName isEqualToString:@"Style(s)"]||[str_RefName isEqualToString:@"Features" ]){
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",FacilitiesURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
      
        }
        
        
        else if([str_RefName isEqualToString:@"Events"]){
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",EventsURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];

        }
        
        else if([str_RefName isEqualToString:@"Theme Nights" ]){
            NSString *strUrl;
             strUrl = [NSString stringWithFormat:@"%@?date=%@",ThemeNightURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];

        }
        else if([str_RefName isEqualToString:@"Real Ale"]){
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",RealAleURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
            
        }
        
        

     
    }
    else
    {
        
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }

    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (!deletedDataCall) {
        
        if([str_RefName  isEqualToString:@"Food & Offers"])
        {
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
                      
            NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
            
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
                   
                    [pubInfoArray release];
                }
               
                
            }
            [foodAndOfferArray release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            [self deletedDataCalling:5];
            
            
           }
        
        if ([str_RefName isEqualToString:@"Events"]) 
        {
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
            
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
            
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
                str_RefName=@"Theme Nights";
                [self callingServer4Update];
                
            }
            else{
                [self deletedDataCalling:0];
                [self deletedDataCalling:2];
            }

           
            
        }
        
        else if ([str_RefName isEqualToString:@"Theme Nights"]) 
        {
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
            
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
                            
                            NSString *dateString = [[dateFormat2 stringFromDate:tempDate] uppercaseString]; 
                            
                            //NSLog(@"%@",dateString);
                            
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"] eventDay:dateString expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
                str_RefName=@"Sports on TV";
                [self callingServer4Update];
                
            }
            else{
                [self deletedDataCalling:1];
            }

            
            
        }
        
        
        if([str_RefName isEqualToString:@"Real Ale"])
        {
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
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
    else if([str_RefName isEqualToString:@"Facilities" ]||[str_RefName isEqualToString:@"Style(s)"]||[str_RefName isEqualToString:@"Features" ]){
        
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
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
                        //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                        
                        for (int k=0; k<[pubInfoArray count]; k++) {
                            
                            
                            
                            [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
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
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];
            
            
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
           
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
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
        if ([deletedEventString isEqualToString:@"FoodDeleted"]) {
            
            {
                NSString *responseString = [request responseString];
                NSDictionary *json = [responseString JSONValue];

                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Food Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                       // NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                       // NSString *EventTypeID;
                        
                        
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FoodID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteFoods:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    //[Arr_events release];
                }
                
            }
        }
        
        else if ([deletedEventString isEqualToString:@"EventsDeleted"]) {
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
                [self deletedDataCalling:1];
            }

        }
        
        else if ([deletedEventString isEqualToString:@"ThemeNightDeleted"]) {
            
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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
            
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
                [self deletedDataCalling:2];
            }

        }
        
        
        else if ([deletedEventString isEqualToString:@"OneOffDeleted"]) {
            
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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
            if([categoryStr isEqualToString:@"What's On Tonight..." ]||[categoryStr isEqualToString:@"What's On Next 7 Days" ]){
                [self deletedDataCalling:3];
            }
        }
        
        
        else if ([deletedEventString isEqualToString:@"SportsDeleted"]) {
            
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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
            
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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
            
            
            NSString *responseString = [request responseString];
            NSDictionary *json = [responseString JSONValue];

            
            
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

        
        deletedDataCall = NO;
        [self performSelector:@selector(myThreadMainMethod:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
        
        [self performSelector:@selector(updateDB) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
        [self performSelector:@selector(doneLoadingTableViewData)];  
    }
    
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error  %@",[error localizedDescription]);
    
    
}


-(void) updateDB
{
    if([categoryStr isEqualToString:@"Food & Offers" ]){
        [_pub_list removeAllObjects];
        _pub_list = [[SavePubListInfo GetPubDetailsInfo:[catID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain]; 
        NSLog(@"catagoryArray   %@",array);
     }
    else if ([categoryStr isEqualToString:@"Real Ale"])
    {
        [_pub_list removeAllObjects];
        _pub_list = [[SavePubListInfo GetPubDetailsInfo:[beerID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
        
    }
    else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        [_pub_list removeAllObjects];
        _pub_list = [[SavePubListInfo GetPubDetailsInfo1:[catID intValue] withID:[sport_eventID intValue] withCategoryStr:categoryStr withEventTypeID:eventTypeId] retain];
    }
    
    else if ([categoryStr isEqualToString:@"Sports on TV"]){
       [_pub_list removeAllObjects];
        _pub_list = [[SavePubListInfo GetPubDetailsInfo:[sport_eventID intValue] withCategoryStr:categoryStr withRadius:searchRadius]retain];
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        [_pub_list removeAllObjects];
        _pub_list=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:1 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        [_pub_list removeAllObjects];
        _pub_list=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:2 radius:searchRadius]retain];
    }
    else if([categoryStr isEqualToString:@"Features" ]){
        [_pub_list removeAllObjects];
        _pub_list=[[SavePubListInfo GetPubDetailsInfo:categoryArray AmmenityID:3 radius:searchRadius]retain];
    }
    

}

-(void) myThreadMainMethod:(id) sender
    {
        [[DBFunctionality4Update sharedInstance] UpdatePubDistance];
        
    }

-(void) deletedDataCalling:(int)_callerNumber
{
    deletedDataCall = YES;
    
                                    
    
    if (_callerNumber == 0) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"EventsDeleted";
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",EventDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
    }
    if (_callerNumber == 1) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"ThemeNightDeleted";
            
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",ThemeNightDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 2) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"OneOffDeleted";
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",OneOffDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 3) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"SportsDeleted";
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",SportsDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 4) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"RealAleDeleted";
            NSString *strUrl;
             strUrl = [NSString stringWithFormat:@"%@?date=%@",RealAleDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 5) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FoodDeleted";
            NSString *strUrl;
            strUrl = [NSString stringWithFormat:@"%@?date=%@",FoodDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];

        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 6) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FacilityDeleted";
            NSString *strUrl;
             strUrl = [NSString stringWithFormat:@"%@?date=%@",FacilityDeleteURL,[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"URL %@",strUrl);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request performThrottling];
            [request setTimeOutSeconds:60.0];
            [request setCachePolicy:ASIUseDefaultCachePolicy];
            [request setDelegate:self];
            [request startSynchronous];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    
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

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    //[self performSelector:@selector(showOrHideMorebutton)];
    
}


#pragma mark- 
#pragma mark- CreateView


-(void)CreateView{
    
    
   table_list = [[UITableView alloc]init];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    vw_header = [[UIView alloc] init];
    
   // vw.backgroundColor = [UIColor colorWithRed:96/255 green:94/255 blue:93/255 alpha:1];
    vw_header.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    vw_header.layer.cornerRadius=5.0;

    vw1 = [[UIView alloc]init];
    vw2 = [[UIView alloc]init];
    vw3 = [[UIView alloc]init];
    vw4 = [[UIView alloc]init];
    //vw5 = [[[UIView alloc]init]autorelease];
    vw1.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw2.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw3.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw4.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    
    //vw5.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];

  

    
    btn_view=[[UIView alloc]init];
    btn_view.backgroundColor=[UIColor whiteColor];
    
    list_btn=[[UIButton alloc]init];
    [list_btn addTarget:self action:@selector(List_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    map_btn=[[UIButton alloc]init];
    [map_btn addTarget:self action:@selector(Map_btnClick:) forControlEvents:UIControlEventTouchUpInside];   
   
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont boldSystemFontOfSize:9];
    Title_lbl.backgroundColor = [UIColor clearColor];
    Title_lbl.numberOfLines=2;
    Title_lbl.lineBreakMode=UILineBreakModeWordWrap;
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
         Title_lbl.font = [UIFont boldSystemFontOfSize:9];
        NSString *str=[NSString stringWithFormat:@"Showing Live %@ ",eventName];
        Title_lbl.text =str;
        Title_lbl.textAlignment=UITextAlignmentLeft;
    }
    else if([categoryStr isEqualToString:@"Food & Offers"]){
        NSString *str=[NSString stringWithFormat:@"%@ ",eventName];
        Title_lbl.text =str;
         Title_lbl.font = [UIFont boldSystemFontOfSize:12];
         Title_lbl.textAlignment=UITextAlignmentCenter;
    }
    
    else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ]|| [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        NSString *str=[NSString stringWithFormat:@"%@ ",eventName];
        Title_lbl.text =str;
        Title_lbl.font = [UIFont boldSystemFontOfSize:12];
        Title_lbl.textAlignment=UITextAlignmentCenter;
    }
    else if([categoryStr isEqualToString:@"Real Ale"]){
        NSString *str;
        if (str_AlePostcode.length == 0) {
           str =[NSString stringWithFormat:@"%@",eventName];
        }
        else
            str=[NSString stringWithFormat:@"%@ - %@ ",eventName,str_AlePostcode];

        Title_lbl.text =str;
        Title_lbl.font = [UIFont boldSystemFontOfSize:12];
        Title_lbl.textAlignment=UITextAlignmentCenter;
    }
    
    if([categoryStr isEqualToString:@"Facilities"]||([categoryStr isEqualToString:@"Style(s)"])||([categoryStr isEqualToString:@"Features"])){
        
        
        Title_lbl.text =eventName;
        Title_lbl.font = [UIFont boldSystemFontOfSize:12];
        Title_lbl.textAlignment=UITextAlignmentCenter;
        
    }
        
    
    Title_lbl.textAlignment=UITextAlignmentCenter;
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];
    img_2ndLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];
    img_3rdLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];
    img_4thLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];
    img_5thLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownArrow.png"]];
    
    
    
    
    frstlbl = [[UILabel alloc]init];
    frstlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ])
    {
        frstlbl.text = @"DAY";
    }
    else
    {
        frstlbl.text = @"CITY/TOWN";
    }
    
    frstlbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [frstlbl addGestureRecognizer:tapGesture];
    [tapGesture release];
    frstlbl.textColor = [UIColor whiteColor];
    frstlbl.font = [UIFont systemFontOfSize:11];
    frstlbl.textAlignment=UITextAlignmentCenter;
    
    
    
    secndlbl = [[UILabel alloc]init];
    secndlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    secndlbl.textColor = [UIColor whiteColor];
    secndlbl.font = [UIFont systemFontOfSize:11];
    secndlbl.userInteractionEnabled = YES;
    if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
    {
        secndlbl.text = @"POSTCODE";
    }
    else
    {
        secndlbl.text = @"VENUE";
    }
   
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [secndlbl addGestureRecognizer:tapGesture2];
    [tapGesture2 release];
    secndlbl.textAlignment=UITextAlignmentCenter;
    
    
    
    thrdlbl = [[UILabel alloc]init];
    thrdlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    thrdlbl.textColor = [UIColor whiteColor];
    thrdlbl.font = [UIFont systemFontOfSize:11];
    thrdlbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [thrdlbl addGestureRecognizer:tapGesture3];
    [tapGesture3 release];    
    
    if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
    {
        thrdlbl.text = @"VENUE";
    }else
    {
        thrdlbl.text = @"CITY/TOWN";
    }
    thrdlbl.textAlignment=UITextAlignmentCenter;

    
    
    
    fourthlbl = [[UILabel alloc]init];
    fourthlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fourthlbl.textColor = [UIColor whiteColor];
    fourthlbl.font = [UIFont systemFontOfSize:11];
    fourthlbl.text = @"DISTRICT";
    fourthlbl.textAlignment=UITextAlignmentCenter;
    fourthlbl.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [fourthlbl addGestureRecognizer:tapGesture4];
    [tapGesture4 release]; 
    
    fifthlbl = [[UILabel alloc]init];
    fifthlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fifthlbl.textColor = [UIColor whiteColor];
    fifthlbl.font = [UIFont systemFontOfSize:11];
    fifthlbl.numberOfLines = 2;
    fifthlbl.lineBreakMode = UILineBreakModeWordWrap;
    fifthlbl.textAlignment=UITextAlignmentCenter;
    fifthlbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [fifthlbl addGestureRecognizer:tapGesture5];
    [tapGesture5 release]; 
    
    
    [self.view addSubview:Title_lbl];

  
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
    [self.view addSubview:list_btn];
    [self.view addSubview:map_btn];
    [vw_header addSubview:vw1];
    [vw_header addSubview:vw2];
    [vw_header addSubview:vw3];
    [vw_header addSubview:vw4];
    
    [self setViewFrame];

    if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_list.bounds.size.height, 320.0f, table_list.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[table_list addSubview:refreshHeaderView];
		[refreshHeaderView release];
	}
    
}


#pragma TapGesture

- (void)didTapLabelWithGesture:(UITapGestureRecognizer *)tapGesture
{
    UILabel *lbl = (UILabel *)[tapGesture view];
    NSLog(@"TEXT %@",lbl.text);
    
    if ([lbl.text isEqualToString:@"DISTRICT"]) {
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubDistrict" ascending:YES selector:@selector(caseInsensitiveCompare:)];
         NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
         NSArray *sortedArray = [_pub_list sortedArrayUsingDescriptors:sortDescriptors];
         
         //NSLog(@"Sorted Array   %@",sortedArray);
        [_pub_list removeAllObjects];
        [_pub_list addObjectsFromArray:sortedArray];
        [table_list reloadData];
    }
    
    if ([lbl.text rangeOfString:@"DISTANCE"].location != NSNotFound) {
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubDistance" ascending:YES selector:@selector(compare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [_pub_list sortedArrayUsingDescriptors:sortDescriptors];
        
        NSLog(@"Sorted Array   %@",sortedArray);
        [_pub_list removeAllObjects];
        [_pub_list addObjectsFromArray:sortedArray];
        [table_list reloadData];
    }
    
    if ([lbl.text isEqualToString:@"CITY/TOWN"]) {
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubCity" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [_pub_list sortedArrayUsingDescriptors:sortDescriptors];
        
        //NSLog(@"Sorted Array   %@",sortedArray);
        [_pub_list removeAllObjects];
        [_pub_list addObjectsFromArray:sortedArray];
        [table_list reloadData];
    }
    
    if ([lbl.text isEqualToString:@"VENUE"]) {
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [_pub_list sortedArrayUsingDescriptors:sortDescriptors];
        
        //NSLog(@"Sorted Array   %@",sortedArray);
        [_pub_list removeAllObjects];
        [_pub_list addObjectsFromArray:sortedArray];
        [table_list reloadData];
    }
    
    if ([lbl.text rangeOfString:@"DAY"].location != NSNotFound) {
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Date" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        NSArray *sortedArray = [_pub_list sortedArrayUsingDescriptors:sortDescriptors];
        
        NSLog(@"Sorted Array   %@",sortedArray);
        [_pub_list removeAllObjects];
        [_pub_list addObjectsFromArray:sortedArray];
        [table_list reloadData];
    }
}


#pragma mark -
#pragma mark - List_btnClick

-(IBAction)List_btnClick:(id)sender{
    
    table_list.hidden = NO;
    [table_list reloadData];
    obj_nearbymap.hidden = YES;
    vw_header.hidden = NO;
    IsSelect=NO;
    backButton.hidden=NO;
    Title_lbl.hidden=NO;
    
    
    if([_pub_list count] == [array count]){
        //_venu_btn.hidden=YES;
    } 
    else
    {
        
    }
        //_venu_btn.hidden=NO;
    
    if ([Constant isiPad]) {
        
    }
    else{
        if ([Constant isPotrait:self]) {
            [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
            //  btn_view.frame=CGRectMake(242, 94, 65.5, 19.5);
            list_btn.frame=CGRectMake(220, 94, 47, 26);
            map_btn.frame=CGRectMake(267, 94, 47, 26);
            
            
            
            
            
        }
        else{
            [list_btn setImage:[UIImage imageNamed:@"ListSelectL.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"MapDeselectL.png"] forState: UIControlStateNormal];
            // btn_view.frame=CGRectMake(410, 24, 65.5, 19.5);
            /*list_btn.frame=CGRectMake(160, 80, 79, 32);
             map_btn.frame=CGRectMake(238, 80, 79, 32);*/
            list_btn.frame=CGRectMake(385, 80, 47, 26);
            map_btn.frame=CGRectMake(427, 80, 47, 26);
        }
    }
    
}

#pragma mark- 
#pragma mark- Map_btnClick

-(IBAction)Map_btnClick:(id)sender{
    
    table_list.hidden = YES;
    obj_nearbymap.hidden = NO;
    vw_header.hidden = YES;
    IsSelect=YES;
    backButton.hidden=NO;
    //_venu_btn.hidden=NO;
    
    [self _callingMapview];
    Title_lbl.hidden=YES;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
            // btn_view.frame=CGRectMake(85, 94, 155, 19.5);
            list_btn.frame=CGRectMake(90, 84, 79, 32);
            map_btn.frame=CGRectMake(168, 84, 79, 32);
            
        }
        else{
            
            [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
            // btn_view.frame=CGRectMake(160, 24, 158, 21);
            list_btn.frame=CGRectMake(160, 80, 79, 32);
            map_btn.frame=CGRectMake(238, 80, 79, 32);
            
        }
    } 
    
}


#pragma mark- 
#pragma mark- MorebtnClick
-(IBAction)MorebtnClick:(id)sender
{
    
    
    
    [_pub_list removeAllObjects];
    
    p=p+noofPubs;
    int r =[array count]%noofPubs;
    NSLog(@"%d",r);
    
    if (p<=([array count]-r)) {
        
        for (int j=0; j<p; j++) {
            [_pub_list addObject:[array objectAtIndex:j]];
            
        }
        [table_list reloadData];
         NSString *msg_str=[NSString stringWithFormat:@"Successfully %d pubs and bars has been added",noofPubs];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:msg_str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        alert.tag=40;
        [alert show];
        [alert release];
        
        
        
       //  if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        
//        [obj_nearbymap removeFromSuperview];
//        [obj_nearbymap release];
        // }   
        //[self _callingMapview];
        
    }
    else
    {
        for (int j=0; j<[array count]; j++) {
            [_pub_list addObject:[array objectAtIndex:j]];
            
        }
        [table_list reloadData];
        
        NSString *msg_str=[NSString stringWithFormat:@"Successfully %d pubs and bars has been added",noofPubs];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:msg_str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         alert.tag=40;
        [alert show];
        [alert release];
        
        
       //  if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        
       
     //    }
       // [self _callingMapview];
        
        //_venu_btn.hidden=YES;
        
    }
    
}


#pragma mark
#pragma mark PullTableViewRefresh Delegates


- (void)reloadTableViewDataSource{
    str_RefName=@"Events";
	
    [self performSelector:@selector(callingServer4Update)];
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
		table_list.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


- (void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	[table_list reloadData];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[table_list setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}




////*********************************** amit-04/06/2012 ***********************//
#pragma mark- 
#pragma mark- callingMapview
-(void)_callingMapview{
    
    NSLog(@"pub_list  %@",_pub_list);
    if (obj_nearbymap) {
        
        [obj_nearbymap removeFromSuperview];
        [obj_nearbymap release];
    }
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            
            obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(10, 124, 300, 285) withArray:_pub_list withController:self];
        }
        else{
            
            obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(10, 115, 460, 135)withArray:_pub_list withController:self];
        }
    }
    [self.view addSubview:obj_nearbymap];
    
    // if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"] && !IsSelect) {
    if (IsSelect==NO){   
        obj_nearbymap.hidden=YES;
        
    }
    else{
        obj_nearbymap.hidden=NO;
        
    }
    
}


#pragma mark-
#pragma mark-

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark-

-(void)setViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
                
                                //vw5.frame=CGRectMake(9, 321, 302.5, 1);               
                img_1stLbl.frame=CGRectMake(46, 30, 10, 10);
                img_2ndLbl.frame=CGRectMake(50, 30, 10, 10);
                img_3rdLbl.frame=CGRectMake(50, 30, 10, 10);
                img_4thLbl.frame=CGRectMake(50, 30, 10, 10);
                img_5thLbl.frame=CGRectMake(50, 30, 10, 10);
                Title_lbl.frame=CGRectMake(55, 91, 167, 30);
                
                vw_header.frame = CGRectMake(8.5, 124, 303, 45);
                
                backButton.frame = CGRectMake(8, 90, 50, 25);
                table_list.frame = CGRectMake( 8.5, 164, 303, 250);
                table_list.scrollEnabled = YES;
                seg_control.frame = CGRectMake(90, 4, 140, 25);
                [obj_nearbymap setFrameOfView:CGRectMake(10, 124, 300, 285)];
                
                if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
                {
                    
                    frstlbl.hidden=NO;
                    vw4.hidden=NO;
                    img_1stLbl.hidden=NO;
                    secndlbl.hidden=YES;
                    
                    vw1.frame=CGRectMake(77, 0, 1, 45);
                    vw2.frame=CGRectMake(155, 0, 1, 45);
                    vw3.frame=CGRectMake(232, 0, 1, 45);

                    
                    frstlbl.frame = CGRectMake(0, 0, 77, 40);
                    thrdlbl.frame = CGRectMake(77, 0, 77, 40);
                    fourthlbl.frame = CGRectMake(154, 0, 77, 40);
                    fifthlbl.frame =  CGRectMake(229, 0, 71, 40);
                    
                    
                    img_1stLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_3rdLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_4thLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_5thLbl.frame=CGRectMake(60, 30, 10, 10);
                    
                    
                   

                }
                else{
                    
                                        
                    vw1.frame=CGRectMake(77, 0, 1, 45);
                    vw2.frame=CGRectMake(155, 0, 1, 45);
                    vw3.frame=CGRectMake(232, 0, 1, 45);
                                      
                    frstlbl.hidden=YES;
                    vw4.hidden=YES;
                    img_1stLbl.hidden=YES;
                    secndlbl.hidden=NO;
                    
                    secndlbl.frame = CGRectMake(0, 0, 77, 40);
                    thrdlbl.frame = CGRectMake(77, 0, 77, 40);
                    fourthlbl.frame = CGRectMake(154, 0, 77, 40);
                    fifthlbl.frame =  CGRectMake(229, 0, 71, 40);
                    
                   
                    img_2ndLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_3rdLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_4thLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_5thLbl.frame=CGRectMake(60, 30, 10, 10);

                }

                
                if (delegate.ismore==YES) {
                    // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                else{
                    //toolBar.frame = CGRectMake(0, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                
                //_venu_btn.frame=CGRectMake(120, 385, 80, 20);
                
                
                
                if (IsSelect==NO) {
                    [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                    
                    list_btn.frame=CGRectMake(220, 94, 47, 26);
                    map_btn.frame=CGRectMake(267, 94, 47, 26);
                }
                else
                {
                    [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                    [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                    // btn_view.frame=CGRectMake(85, 94, 155, 19.5);
                    list_btn.frame=CGRectMake(90, 84, 79, 32);
                    map_btn.frame=CGRectMake(168, 84, 79, 32);
                }
                
                
                
                
            }
            
            if (self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
                
                
                              
                
              
                Title_lbl.frame=CGRectMake(55, 91, 167, 30);
                
                vw_header.frame = CGRectMake(7, 124, 303, 45);
                //_venu_btn.frame=CGRectMake(120, 389, 80, 20);
                
                backButton.frame = CGRectMake(8, 90, 50, 25);
                table_list.frame = CGRectMake( 8.5, 164, 303, 250);
                table_list.scrollEnabled = YES;
                seg_control.frame = CGRectMake(90, 4, 140, 25);
                
                
                if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
                {
                    
                    frstlbl.hidden=NO;
                    vw4.hidden=NO;
                    img_1stLbl.hidden=NO;
                    secndlbl.hidden=YES;
                    img_2ndLbl.hidden=YES;
                    
                    
                    vw1.frame=CGRectMake(77, 0, 1, 45);
                    vw2.frame=CGRectMake(155, 0, 1, 45);
                    vw3.frame=CGRectMake(232, 0, 1, 45);
                    
                    frstlbl.frame = CGRectMake(0, 0, 77, 40);
                    thrdlbl.frame = CGRectMake(77, 0, 77, 40);
                    fourthlbl.frame = CGRectMake(154, 0, 77, 40);
                    fifthlbl.frame =  CGRectMake(229, 0, 71, 40);
                    
                    
                    img_1stLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_3rdLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_4thLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_5thLbl.frame=CGRectMake(60, 30, 10, 10);
                    
                                      
                    
                }
                else{
                    
                                       
                    vw1.frame=CGRectMake(77, 0, 1, 45);
                    vw2.frame=CGRectMake(155, 0, 1, 45);
                    vw3.frame=CGRectMake(232, 0, 1, 45);
                    
                    frstlbl.hidden=YES;
                    vw4.hidden=YES;
                    img_1stLbl.hidden=YES;
                    secndlbl.hidden=NO;
                    img_2ndLbl.hidden=NO;
                    
                    secndlbl.frame = CGRectMake(0, 0, 77, 40);
                    thrdlbl.frame = CGRectMake(77, 0, 77, 40);
                    fourthlbl.frame = CGRectMake(154, 0, 77, 40);
                    fifthlbl.frame =  CGRectMake(229, 0, 71, 40);
                    
                    
                    img_2ndLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_3rdLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_4thLbl.frame=CGRectMake(62, 30, 10, 10);
                    img_5thLbl.frame=CGRectMake(60, 30, 10, 10);
                    
                }
                

                
                [obj_nearbymap setFrameOfView:CGRectMake(10, 124, 300, 285)];
                
                //[obj_nearbymap setFrameOfView:CGRectMake(0, 65, 320, 280)];
                
                if (delegate.ismore==YES) {
                    // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                else{
                    //toolBar.frame = CGRectMake(0, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                
                
                if (IsSelect==NO) {
                    [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                    
                    list_btn.frame=CGRectMake(220, 94, 47, 26);
                    map_btn.frame=CGRectMake(267, 94, 47, 26);
                }
                else
                {
                    [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                    [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                    // btn_view.frame=CGRectMake(85, 94, 155, 19.5);
                    list_btn.frame=CGRectMake(90, 84, 79, 32);
                    map_btn.frame=CGRectMake(168, 84, 79, 32);
                }
            }
            
            
            
        }
        
        else{
            
            
            
            if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
               
              
                
                table_list.frame = CGRectMake(10, 159, 460, 100);
                vw_header.frame = CGRectMake(10, 120, 460, 42);
                //_venu_btn.frame=CGRectMake(190, 229, 100, 20);
                backButton.frame = CGRectMake(10, 85, 50, 25);
                Title_lbl.frame=CGRectMake(135, 83, 210, 25);
                
                
                table_list.scrollEnabled = YES;
                
               
                
              
                if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
                {
                    
                    frstlbl.hidden=NO;
                    vw4.hidden=NO;
                    img_1stLbl.hidden=NO;
                    secndlbl.hidden=YES;
                    img_2ndLbl.hidden=YES;
                    
                    
                    vw1.frame=CGRectMake(116, 0, 1, 42);
                    vw2.frame=CGRectMake(235, 0, 1, 42);
                    vw3.frame=CGRectMake(352, 0, 1, 42);
                    
                    frstlbl.frame = CGRectMake(0, 0, 115, 40);
                    thrdlbl.frame = CGRectMake(115, 0, 115, 40);
                    fourthlbl.frame = CGRectMake(230, 0, 115, 40);
                    fifthlbl.frame =  CGRectMake(345, 0, 115, 40);
                    
                    
                    img_1stLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_3rdLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_4thLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_5thLbl.frame=CGRectMake(100, 26, 10, 10);                  
                    
                }
                else{
                    
                    
                    
                    vw1.frame=CGRectMake(116, 0, 1, 42);
                    vw2.frame=CGRectMake(235, 0, 1, 42);
                    vw3.frame=CGRectMake(352, 0, 1, 42);
                    
                    frstlbl.hidden=YES;
                    vw4.hidden=YES;
                    img_1stLbl.hidden=YES;
                    secndlbl.hidden=NO;
                    img_2ndLbl.hidden=NO;
                    
                    secndlbl.frame = CGRectMake(0, 0, 115, 40);
                    thrdlbl.frame = CGRectMake(115, 0, 115, 40);
                    fourthlbl.frame = CGRectMake(230, 0, 115, 40);
                    fifthlbl.frame =  CGRectMake(345, 0, 115, 40);
                    
                    
                    img_2ndLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_3rdLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_4thLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_5thLbl.frame=CGRectMake(100, 26, 10, 10);
                    
                }
                

                
                
                // table_list.scrollEnabled = YES;
                seg_control.frame = CGRectMake(140, 94, 200, 25);
                
                [obj_nearbymap setFrameOfView:CGRectMake(10, 115, 460, 140)];
                
                
                if (delegate.ismore==YES) {
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                else{
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                
                
                
                
                
                if (IsSelect==NO) {
                    [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                    
                    
                    list_btn.frame=CGRectMake(385, 80, 47, 26);
                    map_btn.frame=CGRectMake(427, 80, 47, 26);
                    //btn_view.frame=CGRectMake(402, 86, 65.5, 19.5);
                    //list_btn.frame=CGRectMake(320, 94, 79, 32);
                    // map_btn.frame=CGRectMake(400, 94, 79, 32);
                }
                else
                {
                    [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                    
                    list_btn.frame=CGRectMake(160, 80, 79, 32);
                    map_btn.frame=CGRectMake(238, 80, 79, 32);                    
                    
                    
                    
                    
                    //btn_view.frame=CGRectMake(402, 86, 158, 21);
                    //list_btn.frame=CGRectMake(320, 94, 79, 32);
                    //map_btn.frame=CGRectMake(400, 94, 79, 32);
                }
                //[table_list reloadData];
                
            }
            
            if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
                               Title_lbl.frame=CGRectMake(100, 83, 250, 30);
                            
                            
                table_list.frame = CGRectMake(10, 159, 460, 100);
                //_venu_btn.frame=CGRectMake(190, 229, 100, 20);
                backButton.frame = CGRectMake(10, 85, 50, 25);
               // Title_lbl.frame=CGRectMake(145, 86, 190, 20);
                
                vw_header.frame = CGRectMake(10, 120, 460, 42);
                table_list.scrollEnabled = YES;
                
                seg_control.frame = CGRectMake(140, 14, 200, 25);
                [obj_nearbymap setFrameOfView:CGRectMake(10, 115, 460, 140)];
                
                if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
                {
                    
                    frstlbl.hidden=NO;
                    vw4.hidden=NO;
                    img_1stLbl.hidden=NO;
                    img_2ndLbl.hidden=YES;
                    secndlbl.hidden=YES;
                    
                    
                    
                    vw1.frame=CGRectMake(116, 0, 1, 42);
                    vw2.frame=CGRectMake(235, 0, 1, 42);
                    vw3.frame=CGRectMake(352, 0, 1, 42);
                    
                    frstlbl.frame = CGRectMake(0, 0, 115, 40);
                    thrdlbl.frame = CGRectMake(115, 0, 115, 40);
                    fourthlbl.frame = CGRectMake(230, 0, 115, 40);
                    fifthlbl.frame =  CGRectMake(345, 0, 115, 40);
                    
                    
                    img_1stLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_3rdLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_4thLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_5thLbl.frame=CGRectMake(100, 26, 10, 10);

                    
                  
           
                    
                }
                else{
                    
                                      
                    vw1.frame=CGRectMake(116, 0, 1, 42);
                    vw2.frame=CGRectMake(235, 0, 1, 42);
                    vw3.frame=CGRectMake(352, 0, 1, 42);
                    
                    frstlbl.hidden=YES;
                    vw4.hidden=YES;
                    img_1stLbl.hidden=YES;
                     img_2ndLbl.hidden=NO;
                    
                    secndlbl.frame = CGRectMake(0, 0, 115, 40);
                    thrdlbl.frame = CGRectMake(115, 0, 115, 40);
                    fourthlbl.frame = CGRectMake(230, 0, 115, 40);
                    fifthlbl.frame =  CGRectMake(345, 0, 115, 40);
                    
                    
                    img_2ndLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_3rdLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_4thLbl.frame=CGRectMake(100, 26, 10, 10);
                    img_5thLbl.frame=CGRectMake(100, 26, 10, 10);
                    
                }

                if (delegate.ismore==YES) {
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                else{
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                
                
                
                if (IsSelect==NO) {
                    [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                    
                    list_btn.frame=CGRectMake(385, 80, 47, 26);
                    map_btn.frame=CGRectMake(427, 80, 47, 26);

                    //btn_view.frame=CGRectMake(402, 86, 65.5, 19.5);
                    //list_btn.frame=CGRectMake(320, 94, 79, 32);
                    // map_btn.frame=CGRectMake(400, 94, 79, 32);
                }
                else
                {
                    [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                    [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                    
                    list_btn.frame=CGRectMake(160, 80, 79, 32);
                    map_btn.frame=CGRectMake(238, 80, 79, 32);             
                
                }
                
            }
             //[table_list reloadData];
            
        }
    }
    if (GET_DEFAUL_VALUE(ShowsResultIN) !=nil) {
        [fifthlbl setText:[NSString stringWithFormat: @"DISTANCE\n(%@)",GET_DEFAUL_VALUE(ShowsResultIN)]];
    }
    //[table_list reloadData];
    
    //
    
    
}


#pragma mark-
#pragma mark-

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
    
    if ([categoryStr isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-sport-on-tv_%d_%d.html",eventName,[sport_eventID intValue],[catID intValue]];
        
        NSLog(@"%@",tempurl);
    
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];

        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars watch %@ %@",eventName,tempurl];
    
    }
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        obj.textString=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/alePubs.php?bid=%d&btit=%@",[beerID intValue],eventName];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars available Beers %@",tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/FoodResult.php?f[%d]=on",[catID intValue]];
        
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
    else if([categoryStr isEqualToString:@"Facilities"]){
        
        NSLog(@"%@",eventID);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }


        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars providing %@ facility %@",eventName,tempurl];
        
    }
    
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        NSLog(@"%@",eventID);
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars providing %@ style %@",eventName,tempurl];
        
    }

    
    else if([categoryStr isEqualToString:@"Features" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }

        
        NSLog(@"%@",eventID);
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars providing %@ feature %@",eventName,tempurl];
        
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
    if ([categoryStr isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-sport-on-tv_%d_%d.html",eventName,sport_eventID,catID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars watch %@ %@",eventName,tempurl];
        
    }
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/alePubs.php?bid=%d&btit=%@",[beerID intValue],eventName];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Beers %@",tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods http://www.pubandbar-network.co.uk/FoodResult.php?f[%d]=on",[catID intValue]];
        
    }
    else if([categoryStr isEqualToString:@"Facilities"]){
        
        NSLog(@"%@",eventID);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ facility %@",eventName,tempurl];
        
    }
    
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ style %@",eventName,tempurl];
        
    }
    
    
    else if([categoryStr isEqualToString:@"Features" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ feature %@",eventName,tempurl];
        
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
    
    shiftToNextPage = NO;
   
        MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
        [obj_MyProfileSetting release];
    }


- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    if ([categoryStr isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-sport-on-tv_%d_%d.html",eventName,sport_eventID,catID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars watch %@ %@",eventName,tempurl];
        
    }
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        obj.shareText=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/alePubs.php?bid=%d&btit=%@",[beerID intValue],eventName];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars available Beers %@",tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars available Foods http://www.pubandbar-network.co.uk/FoodResult.php?f[%d]=on",[catID intValue]];
        
    }
    else if([categoryStr isEqualToString:@"Facilities"]){
        
        NSLog(@"%@",eventID);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars providing %@ facility %@",eventName,tempurl];
        
    }
    
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars providing %@ style %@",eventName,tempurl];
        
    }
    
    
    else if([categoryStr isEqualToString:@"Features" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars providing %@ feature %@",eventName,tempurl];
        
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
    if ([categoryStr isEqualToString:@"Sports on TV"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-sport-on-tv_%d_%d.html",eventName,sport_eventID,catID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars watch %@ %@",eventName,tempurl];
        
    }
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
        
    }
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e[%d]=on",eventID];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Pubs and Bars showing %@ %@",eventName,tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/alePubs.php?bid=%d&btit=%@",[beerID intValue],eventName];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Beers %@",tempurl];
        
    }
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods http://www.pubandbar-network.co.uk/FoodResult.php?f[%d]=on",[catID intValue]];
        
    }
    else if([categoryStr isEqualToString:@"Facilities"]){
        
        NSLog(@"%@",eventID);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ facility %@",eventName,tempurl];
        
    }
    
    else if([categoryStr isEqualToString:@"Style(s)" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ style %@",eventName,tempurl];
        
    }
    
    
    else if([categoryStr isEqualToString:@"Features" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/facilityResult.php?fL0[%d]=on",[eventID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        NSLog(@"%@",eventID);
        fb_str=[NSString stringWithFormat:@"Pubs and Bars providing %@ feature %@",eventName,tempurl];
        
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
    if ([categoryStr isEqualToString:@"Sports on TV"])
      
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-sport-on-tv_%d_%d.html",eventName,sport_eventID,catID];
        
           
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8"];
        
    }
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t%5B%d%5D=on",eventID];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e%5B%d%5D=on",[eventID intValue]];
        
    }
   
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e%5B%d%5D=on ",[eventID intValue]];
    
    }
    else if ([categoryStr isEqualToString:@"Real Ale"]){
        
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/alePubs.php?bid=%d&btit=%@",[beerID intValue],eventName];
        
    }
     else if ([categoryStr isEqualToString:@"Food & Offers"]){
         
         fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/FoodResult.php?f%5B%d%5D=on",[catID intValue]];
         
     }
    
    
    
    
    else
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v "];
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
    
    //[obj_nearbymap removeFromSuperview];
    //[obj_nearbymap release];
    
    //IsSelect = NO;
}



#pragma mark-
#pragma mark- datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"ARRAY   %d",[_pub_list count]);
    if ([array count] == [_pub_list count])
        return [_pub_list count];
    else    
        return [_pub_list count] + 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *topLabel;
    UILabel *middlelbl;
    UILabel *bottomlbl;
    UILabel *endlbl;
    UILabel *extremelbl;
    
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger EXTREME_LABEL_TAG = 1005;
    
    //static NSString *CellIdentifier = @"Cell";
    static NSString *postCellId = @"postCell";
    static NSString *moreCellId = @"moreCell";
    UITableViewCell *cell = nil;

    
    NSUInteger row = [indexPath row];
    NSUInteger count = [_pub_list count];
    
    if (row == count) {
        
        cell = [aTableView dequeueReusableCellWithIdentifier:moreCellId];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] 
                     initWithStyle:UITableViewCellStyleDefault 
                     reuseIdentifier:moreCellId] autorelease];
        }
        
        cell.textLabel.text = @"Touch to load more items...";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];

    }
    else{
        
        cell = [aTableView dequeueReusableCellWithIdentifier:postCellId];

        if (cell == nil) {
            
            cell =	[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellId] autorelease];
            
            
            topLabel = [[[UILabel alloc] initWithFrame: CGRectMake(0, 0, 60.5, 50)]autorelease];
            // topLabel.frame = CGRectMake(0, 0, 60, 50);
            topLabel.tag = TOP_LABEL_TAG;
            topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            topLabel.backgroundColor = [UIColor clearColor];
            topLabel.textColor = [UIColor whiteColor];
            topLabel.numberOfLines = 2;
            topLabel.lineBreakMode = UILineBreakModeWordWrap;
            topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            topLabel.font = [UIFont boldSystemFontOfSize:11];
            topLabel.layer.borderWidth= 1.0;
            topLabel.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            topLabel.textAlignment = UITextAlignmentCenter;
            
            
            
            //middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(61.2, 0, 70, 50)]autorelease];
            middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(59.5, 0, 67, 50)]autorelease];
            middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            middlelbl.tag = MIDDLE_LABEL_TAG;
            middlelbl.numberOfLines = 2;
            middlelbl.lineBreakMode = UILineBreakModeWordWrap;
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor whiteColor];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:11];
            middlelbl.layer.borderWidth= 1.0;
            middlelbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            middlelbl.textAlignment = UITextAlignmentCenter;
            
            
            
            
            // bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(127, 0, 63, 50)]autorelease];
            bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(125, 0, 66, 50)]autorelease];
            bottomlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            bottomlbl.tag = BOTTOM_LABEL_TAG;
            bottomlbl.numberOfLines = 2;
            bottomlbl.lineBreakMode = UILineBreakModeWordWrap;
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
            bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:11];
            bottomlbl.layer.borderWidth= 1.0;
            bottomlbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            bottomlbl.textAlignment = UITextAlignmentCenter;
            
            
            
            
            //  endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(192.1, 0, 65.4, 50)]autorelease];
            endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(190, 0, 65.6, 50)]autorelease];
            endlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth ;//| UIViewAutoresizingFlexibleHeight; 
            endlbl.tag = END_LABEL_TAG;
            endlbl.numberOfLines = 2;
            endlbl.lineBreakMode = UILineBreakModeWordWrap;
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:11];
            endlbl.layer.borderWidth= 1.0;
            endlbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            endlbl.textAlignment = UITextAlignmentCenter;
            
            
            
            //extremelbl =[[[UILabel alloc]initWithFrame:CGRectMake(257.5, 0, 74, 50)]autorelease];
            extremelbl =[[[UILabel alloc]initWithFrame:CGRectMake(253.6, 0, 66.0, 50)]autorelease];
            extremelbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth ;//| UIViewAutoresizingFlexibleHeight; 
            extremelbl.tag = EXTREME_LABEL_TAG;
            extremelbl.numberOfLines = 2;
            extremelbl.lineBreakMode = UILineBreakModeWordWrap;
            extremelbl.backgroundColor = [UIColor clearColor];
            extremelbl.textColor = [UIColor whiteColor];
            extremelbl.highlightedTextColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
            extremelbl.font = [UIFont boldSystemFontOfSize:11];
            extremelbl.layer.borderWidth= 1.0;
            extremelbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            extremelbl.textAlignment = UITextAlignmentCenter;
            
            
            if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
            {
                
                topLabel.frame=CGRectMake(0, 0, 82, 50);
                bottomlbl.frame=CGRectMake(81, 0, 83.5, 50);
                endlbl.frame=CGRectMake(163.5, 0, 82.5, 50);
                extremelbl.frame=CGRectMake(245, 0, 75.5, 50);
                
                
                [cell.contentView addSubview:topLabel];
                // [cell.contentView addSubview:middlelbl];
                [cell.contentView addSubview:bottomlbl];
                [cell.contentView addSubview:endlbl];
                [cell.contentView addSubview:extremelbl];
                
            }
            else{
                
                middlelbl.frame=CGRectMake(0, 0, 82, 50);
                bottomlbl.frame=CGRectMake(81, 0, 83.5, 50);
                endlbl.frame=CGRectMake(163.5, 0, 82.5, 50);
                extremelbl.frame=CGRectMake(245, 0, 75.5, 50);
                
                
                middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;//
                
                bottomlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | 
                //UIViewAutoresizingFlexibleHeight; 
                endlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth ;//| 
                
                extremelbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth ;//| UI
                
                
                
                [cell.contentView addSubview:middlelbl];
                [cell.contentView addSubview:bottomlbl];
                [cell.contentView addSubview:endlbl];
                [cell.contentView addSubview:extremelbl];
                
            }
            
            
            
        }
    }
    

		    
    if (cell != nil){
        topLabel = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
        middlelbl = (UILabel *)[cell.contentView viewWithTag:MIDDLE_LABEL_TAG];
        bottomlbl = (UILabel *)[cell.contentView viewWithTag:BOTTOM_LABEL_TAG];
        endlbl = (UILabel *)[cell.contentView viewWithTag:END_LABEL_TAG];
        extremelbl = (UILabel *)[cell.contentView viewWithTag:EXTREME_LABEL_TAG];
    }
    @try {
        //---------------------------------------------------------------------------------------------//
        if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ])
        {
            /*NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            //[dateFormat setLocale:[NSLocale currentLocale]];
            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"Date"]]];
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@" eeee"];

            NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
            [dateFormat release];
            [dateFormat2 release];
            
            topLabel.text = dateString;*/
            topLabel.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"Date"];
            middlelbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubPostCode" ];
            bottomlbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName"];
        }
        else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
        {
            topLabel.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubCity" ];
            //middlelbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
            bottomlbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
        }
        else{
            topLabel.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubPostCode" ];
            middlelbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
            bottomlbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubCity" ];
        }
        //--------------------------------------------------------------------------------------------//    
        endlbl.text = [[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistrict" ];
        if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
          
            
            extremelbl.text = [NSString stringWithFormat: @"%d",(int)floor([[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"] doubleValue])];
        else
           // extremelbl.text=[NSString stringWithFormat:@"%d",(int)[[[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192]];
            extremelbl.text=[NSString stringWithFormat:@"%d",(int)floor([[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
       
       
       
        
        //NSLog(@"%d district",[[[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192]);
        //NSLog(@"%@distance",[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ]);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
     /*UIImageView *backgroundImageView = [[[UIImageView alloc] init] autorelease];
    if(indexPath.row %2 == 0){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        //cell.backgroundView = backgroundImageView;

    }
    else{
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]];
        //cell.backgroundView = backgroundImageView;
    }
    */
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    if ([indexPath row] % 2) {
        // even row
        cell.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1.0];

    } else {
        // odd row
        cell.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row = [indexPath row];
	NSUInteger count = [_pub_list count];
	
	if (row == count) {
		
		//NSArray *newPosts = [feed newPosts];
		/*NSUInteger newCount = [array count];
		
		if (newCount) {
			
			[self.posts addObjectsFromArray:newPosts];
			[newPosts release];
			
			NSMutableArray *insertIndexPaths = [NSMutableArray array];
			for (NSUInteger item = count; item < count + newCount; item++) {
				
				[insertIndexPaths addObject:[NSIndexPath indexPathForRow:item 
                                                               inSection:0]];
			}
			
			[self.tableView beginUpdates];
			[self.tableView insertRowsAtIndexPaths:insertIndexPaths 
								  withRowAnimation:UITableViewRowAnimationFade];
			[self.tableView endUpdates];
			
			[self.tableView scrollToRowAtIndexPath:indexPath 
								  atScrollPosition:UITableViewScrollPositionNone 
										  animated:YES];
			
			NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
			if (selected) {
				[self.tableView deselectRowAtIndexPath:selected animated:YES];
			}
		}*/
        
        [self performSelector:@selector(MorebtnClick:)];
		
	}
    else{
        
        if ([[delegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]]])
        {
            [self afterSuccessfulConnection:[[delegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]]]];
        }
        else
        {
            [self performSelector:@selector(addMBHud)];
            [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
        }
        
        
    }
    
    //valueForCheck = YES;
    
    
    
    
}

#pragma mark-
#pragma mark- callingServer

-(void) callingServer
{// && [InternetValidation hasConnectivity]
    if([InternetValidation  checkNetworkStatus])
    {
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        NSLog(@"%@",[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]);
        [conn1 getPubDetails:[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]];
        [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        [self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"OK", nil];
        alert.tag = 10;
        [alert  show];
        [alert  release];
    }
}

#pragma mark-
#pragma mark- alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        [self performSelector:@selector(dismissHUD:)];

        if (buttonIndex == 0) {
            
            [self performSelector:@selector(addMBHud)];
            [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
        }
        
    }
    
    if (alertView.tag == 20) {
        
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    if (alertView.tag == 30) {
        
        if (buttonIndex == 0) {
            
            [self performSelector:@selector(dismissHUD:)];
        }
        
    }
    if (alertView.tag == 40) {
        if (buttonIndex == 0) {
            [self _callingMapview];
        }
    }

}


#pragma mark-
#pragma mark- ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    //AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
    NSMutableArray *pubDetailsArray = [[[json valueForKey:@"pubDetails"] valueForKey:@"details"] retain];
    //[[delegate sharedDefaults] removeObjectForKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
    
    
    if ([pubDetailsArray count] != 0) {
        
        
        [[delegate sharedDefaults] setObject:data_Response forKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
        [[delegate sharedDefaults] synchronize];
        
        NSString *PUBID = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"];
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubEmail"]);
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
        NSString *pubAddressAll = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubAddressAll"];
        
        
        
        
        NSString *pubPhoneNo = @"No Info";
        
        
        
        bulletPointArray=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubBullet"] retain];
        
        NSLog(@"%@",bulletPointArray);
        
        
        array_sportEvent=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Event Details"] retain];
        
        if([categoryStr isEqualToString:@"Regular"]){
            
            
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:0] valueForKey:@"Event Details"] retain];
        }
        else if([categoryStr isEqualToString:@"One Off"]){
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:1] valueForKey:@"Event Details"] retain];
        }
        else if([categoryStr isEqualToString:@"Theme Nights"]){
            
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:2] valueForKey:@"Event Details"] retain];
        }
        
        
        array_realAle=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Real Ale"] objectAtIndex:0] valueForKey:@"Real Ale Details"] retain];
        
        
        NSLog(@"Event Array %@",array_realAle);
        
        arry_pubinformation=[pubDetailsArray objectAtIndex:0];
        
        str_sportDesc=[NSString stringWithFormat:@"%@",[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Description"]retain]];
        
        NSLog(@"%@",str_sportDesc);
        
        NSMutableDictionary *OpenHoursDictionary=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubOpenHours"] retain];
        //    NSMutableArray *arr;
        //    [arr addObject:OpenHoursDictionary];
        openingHours4Day = (NSMutableArray *)[[[OpenHoursDictionary keyEnumerator] allObjects] retain];
        openingHours4Hours = [[NSMutableArray alloc] init];
        for (int i = 0; i<[openingHours4Day count]; i++) {
            
            [openingHours4Hours addObject:[OpenHoursDictionary valueForKey:[openingHours4Day objectAtIndex:i]]];
        }
        
        NSLog(@"ARRAy   %@   %@",openingHours4Day,openingHours4Hours); 
        NSLog(@"%d %@",[OpenHoursDictionary count],[[OpenHoursDictionary keyEnumerator] allObjects]);
        
        
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
        
        NSMutableArray *GeneralImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"General Images"] retain];
        NSMutableArray *FunctionRoomImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"Function Room Images"] retain];
        NSMutableArray *FoodordrinkImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"Food or drink Images"] retain];
        
        for (int i = 0; i < [GeneralImagesArray count]; i++) {
            
            if (![GeneralImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID GeneralImages:[[GeneralImagesArray objectAtIndex:i] valueForKey:@"Photo"] GeneralImageID:[[GeneralImagesArray objectAtIndex:i] valueForKey:@"ID"]];
            }
            
        }
        
        for (int m = 0; m < [FunctionRoomImagesArray count]; m++) {
            
            
            if (![FunctionRoomImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID FunctionRoomImages:[[FunctionRoomImagesArray objectAtIndex:m] valueForKey:@"Photo"] FunctionRoomImageID:[[FunctionRoomImagesArray objectAtIndex:m] valueForKey:@"ID"]];
            }
            
        }
        
        for (int l = 0; l < [FoodordrinkImagesArray count]; l++) {
            
            
            
            if (![FoodordrinkImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID FoodDrinkImages:[[FoodordrinkImagesArray objectAtIndex:l] valueForKey:@"Photo"] FoodDrinkImageID:[[FoodordrinkImagesArray objectAtIndex:l] valueForKey:@"ID"]];
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        //******************************* Event ****************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Events"]) {
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
        //}
        
        //******************************* Event ****************************************************
        
        //****************************** Food and offers *******************************************
        //if ([delegate.sharedDefaults objectForKey:@"Food"]) {
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
        //}
        
        //****************************** Food and offers *******************************************
        
        
        //***************************** Facilities *************************************************
       // if ([delegate.sharedDefaults objectForKey:@"Facilities"]) {
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
            
        //}
        //***************************** Facilities *************************************************
        
        
        
        
        
        
        //***************************** Real Ale ***************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Real Ale"]) {
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
                        
                        
                        [[DBFunctionality sharedInstance] UpdateBeerDetailsByPubId:PUBID BeerID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerID"] Beer_Name:Str_BeetTitle Catagory:Str_Breweryname Beer_ABV:Str_Beer_ABV Beer_Color:Str_Beer_Color Beer_Smell:Beer_Smeel Beer_Taste:Beer_Taste License_Note:Str_LicenseNote Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BreweryID"]];
                        
                        
                        
                        [[DBFunctionality sharedInstance] UpdateRealAleDetailsByPubId:PUBID Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BreweryID"] Ale_Name:Str_Ale_Name Ale_MailID:Str_Ale_Email Ale_Website:Str_AleWebsiteurl Ale_Address:Str_Address Ale_Postcode:Str_Postcode Ale_ContactName:Str_Contactname Ale_PhoneNumber:Str_phonenumber Ale_District:Str_District];
                    }
                    
                }
            }
            //NSLog(@"%@",[[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"]);
            
            //}
        //}
        //***************************** Real Ale ***************************************************
        
        
        
        
        
        //***************************** Sports & TV ************************************************
        //Sport_Id will be add in Json,then I have to implement it....
        //if ([delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
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
       // }
        
        
        
        
        [self performSelector:@selector(dismissHUD:)];
        
        
        
        
        
        
        /* if([categoryStr isEqualToString:@"Real Ale"]){
         
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
         }       */
        
        if([categoryStr isEqualToString:@"Real Ale"]){
            
           
            if ([[[array_realAle objectAtIndex:0]valueForKey:@"info"]isEqualToString:@"No Details Available"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"No Details Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
            else{
            
            
            
            RealAle_Microsite *obj_RealAle_Microsite=[[RealAle_Microsite alloc]initWithNibName:[Constant GetNibName:@"RealAle_Microsite"] bundle:[NSBundle mainBundle]];
            
            obj_RealAle_Microsite.Pubid=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
            obj_RealAle_Microsite.category_Str=categoryStr;
            
            obj_RealAle_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                           [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                                           [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                                           [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                                           [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                                           nil];
            
            obj_RealAle_Microsite.OpenDayArray=[openingHours4Day copy];
            obj_RealAle_Microsite.OpenHourArray=[openingHours4Hours copy];
            obj_RealAle_Microsite.bulletPointArray=[bulletPointArray copy];
            obj_RealAle_Microsite.EventID=eventID;
            obj_RealAle_Microsite.share_eventName=eventName;
            obj_RealAle_Microsite.arrRealAlyInfo=[array_realAle copy];
                obj_RealAle_Microsite.BeerID=beerID;
                obj_RealAle_Microsite.share_eventName=eventName;
            NSLog(@"%@",obj_RealAle_Microsite.arrRealAlyInfo);
            [self.navigationController pushViewController:obj_RealAle_Microsite animated:YES];
            [obj_RealAle_Microsite release];
            }
            
        }
        else if ([categoryStr isEqualToString:@"Food & Offers"])
        {
            NSMutableArray *tempArray = [[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ] intValue]] retain];
            if ([tempArray count] != 0) {
                
                FoodDetails_Microsite *obj_FoodDetails_Microsite=[[FoodDetails_Microsite alloc]initWithNibName:[Constant GetNibName:@"FoodDetails_Microsite"] bundle:[NSBundle mainBundle]];
                obj_FoodDetails_Microsite.category_Str=categoryStr;
                obj_FoodDetails_Microsite.Pubid=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
                
                obj_FoodDetails_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                   [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                                                   [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                                                   [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                                                   [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                                                   nil];
                
                
                obj_FoodDetails_Microsite.bulletPointArray=[bulletPointArray copy];
                obj_FoodDetails_Microsite.OpenDayArray=[openingHours4Day copy];
                obj_FoodDetails_Microsite.OpenHourArray=[openingHours4Hours copy];
                obj_FoodDetails_Microsite.FoodID=catID;
                
                
                
                
                [self.navigationController pushViewController:obj_FoodDetails_Microsite animated:YES];
                [obj_FoodDetails_Microsite release];
            }
            else{
                UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub & bar Network" message:@"Food information not availbale." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [altview show];
                [altview release];
            }                
            
        }
        
        
        else if([categoryStr isEqualToString:@"Facilities"]||[categoryStr isEqualToString:@"Style(s)" ]||[categoryStr isEqualToString:@"Features" ]){
            
            Facilities_MicrositeDetails *obj_Facilities_MicrositeDetails=[[Facilities_MicrositeDetails alloc]initWithNibName:[Constant GetNibName:@"Facilities_MicrositeDetails"] bundle:[NSBundle mainBundle]];
            obj_Facilities_MicrositeDetails.Pubid=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
            obj_Facilities_MicrositeDetails.category_Str=categoryStr;
            
            obj_Facilities_MicrositeDetails.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                                                     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                                                     [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                                                     [[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"pubDescription"],@"pubDescription",
                                                                     nil];
            
            NSLog(@"pubDescription %@",[[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"pubDescription"]);
            
            obj_Facilities_MicrositeDetails.OpenDayArray=[openingHours4Day copy];
            obj_Facilities_MicrositeDetails.OpenHourArray=[openingHours4Hours copy];
            obj_Facilities_MicrositeDetails.bulletPointArray=[bulletPointArray copy];
            obj_Facilities_MicrositeDetails.share_eventName=eventName;
            
            [self.navigationController pushViewController:obj_Facilities_MicrositeDetails animated:YES];
            [obj_Facilities_MicrositeDetails release];
            
        }
        
        else if([categoryStr isEqualToString:@"Regular"]||[categoryStr isEqualToString:@"One Off"]||[categoryStr isEqualToString:@"Theme Nights"]){
            
                   
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            obj_detail.Pub_ID=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
            obj_detail.categoryStr=categoryStr;
            
            // obj_detail.headerDictionaryData=[arry_pubinformation copy];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubName"],@"PubName",
                                        [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubDistrict"],@"PubDistrict",
                                        [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCity"],@"PubCity",
                                        [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubPostcode"],@"PubPostCode",nil];
            
            obj_detail.headerDictionaryData = [dic copy];
            
            NSLog(@"headerDictionaryData  %@  %@   %@  %@",[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],[[_pub_list objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"]);
            NSLog(@"Dictionary   %@",obj_detail.headerDictionaryData);
            
            NSLog(@"%@",array_EventDetails);
            obj_detail.OpenDayArray=[openingHours4Day copy];
            obj_detail.OpenHourArray=[openingHours4Hours copy];
            obj_detail.bulletPointArray=[bulletPointArray copy];
            obj_detail.event_type=catID;
            obj_detail.arrSubMain=[array_EventDetails copy];
            obj_detail.EventId=eventID;
            obj_detail.Share_EventName=eventName;
            obj_detail.Day=Day;
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
            [dic release];
            
        }
        
        else if([categoryStr isEqualToString:@"Sports on TV"]){
            
            // Sport_Microsite *obj_Sport_Microsite=[[Sport_Microsite alloc]initWithNibName:[Constant GetNibName:@"Sport_Microsite"] bundle:[NSBundle mainBundle]];
            
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            
            obj_detail.Pub_ID=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
            obj_detail.categoryStr=categoryStr;
            
            obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                               nil];
            
            obj_detail.OpenDayArray=[openingHours4Day copy];
            obj_detail.OpenHourArray=[openingHours4Hours copy];
            obj_detail.bulletPointArray=[bulletPointArray copy];
            obj_detail.Sport_Evnt_id =str_sportDesc;
            obj_detail.EventId=sport_eventID;
            NSLog(@"%@",obj_detail.headerDictionaryData);
            obj_detail.sporeid = catID;
            obj_detail.arrSubMain=[array_sportEvent copy];
            obj_detail.Share_EventName=eventName;
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
            
        }
        
        else if([categoryStr isEqualToString:@"What's On Next 7 Days"]||[categoryStr isEqualToString:@"What's On Tonight..."]){
            
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            obj_detail.Pub_ID=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
            obj_detail.categoryStr=categoryStr;
            
            obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                               [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                               nil];
            
            
            obj_detail.OpenDayArray=[openingHours4Day copy];
            obj_detail.OpenHourArray=[openingHours4Hours copy];
            obj_detail.bulletPointArray=[bulletPointArray copy];
            obj_detail.event_type=catID;
            NSLog(@"%@",str_sportDesc);
            obj_detail.Sport_Evnt_id =str_sportDesc;
            obj_detail.arr_Event_name=[array_EventName copy];
            obj_detail.Share_EventName=eventName;
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
            
            
            
            
            
            
            
            
            
            /*     TonightAnd7Days_Microsite *obj_TonightAnd7Days_Microsite = [[TonightAnd7Days_Microsite alloc]initWithNibName:[Constant GetNibName:@"TonightAnd7Days_Microsite"] bundle:[NSBundle mainBundle]];
             obj_TonightAnd7Days_Microsite.Pub_ID=[[array objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID" ];
             obj_TonightAnd7Days_Microsite.category_Str=categoryStr;
             
             obj_TonightAnd7Days_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
             [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
             [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
             [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
             [[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
             nil];
             
             
             obj_TonightAnd7Days_Microsite.OpenDayArray=[openingHours4Day copy];
             obj_TonightAnd7Days_Microsite.OpenHourArray=[openingHours4Hours copy];
             obj_TonightAnd7Days_Microsite.bulletPointArray=[bulletPointArray copy];
             obj_TonightAnd7Days_Microsite.event_type=catID;
             
             [self.navigationController pushViewController:obj_TonightAnd7Days_Microsite animated:YES];
             [obj_TonightAnd7Days_Microsite release];*/
            
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
            obj_detail.sporeid=catID;//[[array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
            // obj_detail.Sport_Evnt_id =[ [array objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_EventID"];
            
            obj_detail.Sport_Evnt_id =sport_eventID;
            obj_detail.EventId = eventID;
            obj_detail.categoryStr=categoryStr;
            obj_detail.event_type=catID;
            obj_detail.OpenDayArray=[openingHours4Day copy];
            obj_detail.OpenHourArray=[openingHours4Hours copy];
            obj_detail.bulletPointArray=[bulletPointArray copy];
            obj_detail.Share_EventName=eventName;
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
        }
        
        shiftToNextPage = YES;
    }
    
    else{
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venue details Found! Please Try Again......" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert show];
        [alert release];
    }
    
    
}

//-------------------------------------------------------//

-(void)afterFailourConnection:(id)msg
{
	
    //[self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(dismissHUD:)];
    UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //alert.tag = 10;
    [alert  show];
    [alert  release];

}
/*UIImage *rowBackGround;
 UIImage *selectBackGround;*/





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

#pragma mark-
#pragma mark- MemoryCleanup

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [table_list release];
    [seg_control release];
    table_list = nil;
    seg_control=nil;
    
    [obj_nearbymap release];
    obj_nearbymap = nil;
    [vw_header release];
     vw_header= nil;
    [toolBar release];
    toolBar = nil;
    //[eventName release];
    // [str_AlePostcode release];
    //----------------mb/25/05/12/5-45--------------------//
    [categoryArray release]; 
    categoryArray= nil;
    [_hud release];
    _hud = nil;
    [bulletPointArray release];
    bulletPointArray = nil;
    [openingHours4Day release];
    openingHours4Day = nil;
    [openingHours4Hours release];
    openingHours4Hours= nil;
    [btn_view release];
    [list_btn release];
    [map_btn release];
    
    [frstlbl release];
    [secndlbl release];
    [thrdlbl release];
    [fourthlbl release];
    //[fifthlbl release];
    [backButton release];
    [Title_lbl release];
    [img_1stLbl release];
    [img_2ndLbl release];
    [img_3rdLbl release];
    [img_4thLbl release];
    [vw1 release];
    [vw2 release];
    [vw3 release];
    [vw4 release];
    
    btn_view = nil;
    list_btn = nil;
    map_btn = nil;
    frstlbl = nil;
    secndlbl = nil;
    thrdlbl = nil;
    fourthlbl = nil;
    backButton = nil;
    Title_lbl= nil;
    img_1stLbl= nil;
    img_2ndLbl = nil;
    img_3rdLbl = nil;
    img_4thLbl = nil;
    vw1 = nil;
    vw2 = nil;
    vw3 = nil;
    vw4 = nil;
}


-(void)dealloc{
    [table_list release];
    //[catID release];
    [seg_control release];
    [obj_nearbymap release];
    [vw_header release];
    [toolBar release];
    //[eventName release];
   // [str_AlePostcode release];
    //----------------mb/25/05/12/5-45--------------------//
    [categoryArray release];    
    [_hud release];
   
    [bulletPointArray release];
    [openingHours4Day release];
    [openingHours4Hours release];
    [btn_view release];
    [list_btn release];
    [map_btn release];
    
    [frstlbl release];
    [secndlbl release];
    [thrdlbl release];
    [fourthlbl release];
    //[fifthlbl release];
    [backButton release];
    [Title_lbl release];
    [img_1stLbl release];
    [img_2ndLbl release];
    [img_3rdLbl release];
    [img_4thLbl release];
    [vw1 release];
    [vw2 release];
    [vw3 release];
    [vw4 release];
    [super dealloc];
}
@end
