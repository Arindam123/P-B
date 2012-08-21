//
//  PubDetail.m
//  PubAndBar
//
//  Created by User7 on 03/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "PubDetail.h"
#import "Design.h"
#import "SavePubListInfo.h"
#import "SaveSportDetailInfo.h"
#import "AppDelegate.h"
#import "SavePubDetailsInfo.h"
#import "SaveSportDetailInfo.h"
#import "PubList.h"
#import "FoodDetails_Microsite.h"
#import "DBFunctionality.h"
#import "ImagesList.h"
#import "SavePubDetailsSubCatagoryInfo.h"
#import "SaveSportMicrositeInfo.h"
#import "Sport_Microsite.h"
#import "SaveEventMicrositeInfo.h"
#import "Event_Microsite.h"
#import "SaveTonightAnd7DaysInfo.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "AsyncImageView_New.h"
#import "ASIHTTPRequest.h"
#import "PictureShowsInFullScreen.h"
#define MAXFLOAT_Height ((float)3.40282346638528860e+38)

@implementation PubDetail
//@synthesize table;
@synthesize backButton;
@synthesize Array;
@synthesize heardervw;
@synthesize image;
@synthesize name_lbl;
@synthesize address_lbl;

@synthesize show_map;
@synthesize arrSubMain;
@synthesize arrMain;
@synthesize arr;
@synthesize my_table;
@synthesize Array_section;
@synthesize Pub_ID;
@synthesize sporeid;
@synthesize Sport_Evnt_id;
@synthesize EventId;
@synthesize categoryStr;
@synthesize headerDictionaryData;
@synthesize OpenDayArray,OpenHourArray;
@synthesize bulletPointArray;
@synthesize event_type;
@synthesize fabBtn;
@synthesize managerBtn;
@synthesize emailBtn;
@synthesize oAuthLoginView;
@synthesize _ID;
@synthesize sportEventDic;
@synthesize lbl_heading;
@synthesize current_date;
@synthesize arr_Event_name;
@synthesize Share_EventName;
@synthesize Day;
@synthesize BeerID;
@synthesize imageURL;


AppDelegate *app;
PubList *obj_PubList;
SavePubDetailsInfo *obj_SavePubDetailsInfo;
UIInterfaceOrientation orientation;

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
    
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    self.eventTextLbl.text=categoryStr;
    toolBar = [[Toolbar alloc]init];
    // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    NSLog(@"%@",arr_Event_name);
    
    //----------------------------mb-2-05-12------------------------------------------//
    [[DBFunctionality sharedInstance] InsertPubId_IntoPreference_RecentHistory:[Pub_ID intValue]];
    //-------------------------------------------------------------------------------//
    
    arrMain=[[NSMutableArray alloc]init];
    //arr=[[NSMutableArray alloc]init];
    
    NSLog(@"%@",bulletPointArray);
    
    if(app.IsNonsubscribed==NO){
        
        
        NSMutableArray *temp_array1 =[OpenHourArray copy];
        NSMutableArray *tempArray2 = [[NSMutableArray alloc] initWithArray:OpenHourArray];
        NSMutableArray *tempArray3 = [[NSMutableArray alloc] initWithArray:OpenDayArray];
        
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i] isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i] isEqualToString:@"No Info"]||[[temp_array1 objectAtIndex:i] isEqualToString:@""]) {
                [tempArray2 replaceObjectAtIndex:i withObject:@" "];
                [tempArray3 replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [tempArray2 removeObjectIdenticalTo:@" "];
        [tempArray3 removeObjectIdenticalTo:@" "];
        OpenHourArray = [tempArray2 retain];
        OpenDayArray = [tempArray3 retain];
        
        [tempArray2 release];
        [tempArray3 release];
        NSLog(@"other Details %@",OpenHourArray);
        
        
        
        NSMutableArray *temp_array4=[bulletPointArray copy];
        NSMutableArray *tempArray5 = [[NSMutableArray alloc] initWithArray:bulletPointArray];
        
        for (int i=0; i<[temp_array4 count]; i++) {
            if ([[[temp_array4 objectAtIndex:i] valueForKey:@"bullet"]isEqualToString:@"Not Available"]||[[[temp_array4 objectAtIndex:i] valueForKey:@"bullet"]isEqualToString:@"No Info"]||[[[temp_array4 objectAtIndex:i] valueForKey:@"bullet"]isEqualToString:@""]) {
                [tempArray5 replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        
        [tempArray5 removeObjectIdenticalTo:@" "];
        bulletPointArray = [tempArray5 retain];
        [tempArray5 release];
        NSLog(@"other Details %@",bulletPointArray);
        
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"ddMMyyyy"];
    
    NSDate *now = [[NSDate alloc] init];
    
    current_date = [format stringFromDate:now];
    NSLog(@"%@",current_date);
    
    
    arr_Event_name=[[NSMutableArray alloc]init];
    
    
    if (app.IsNonsubscribed) {
        
        
        latitude = [[bulletPointArray valueForKey:@"Latitude"] retain];
        longitude = [[bulletPointArray valueForKey:@"Longitude"] retain];
        
    }
    
    
    
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        
        
        isOneOffEventexit=YES;
        isRegularEventExit=YES;
        isThemeNightExit=YES;
        issportsEvent=YES;
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"] || [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Sports Description",@"Sports Event",@"Food Details",@"Photos", nil]; 
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Sports Description",@"Sports Event",@"Food Details",@"Photos", nil]; 
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        
        
        
        
        
        my_table.contentOffset=CGPointMake(0, 100);
        
    }
    
    
    else if([categoryStr isEqualToString:@"Regular"])
        
    {
        
        
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isregularEvent=YES;
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]];
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        my_table.contentOffset=CGPointMake(10, 100);
        // [arrMain replaceObjectAtIndex:1 withObject:@"No Info"];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        [arrMain replaceObjectAtIndex:1 withObject:@"No Info"];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Regular Event",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Regular Event",@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            if([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:4 withObject:@" "];
            
            else if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
    }
    
    
    
    else if([categoryStr isEqualToString:@"Style(s)"])
    {
        
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isGeneralExpanded=YES;
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;            
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        
        
    }
    
    else if([categoryStr isEqualToString:@"Features"])
    {
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isGeneralExpanded=YES;
        // Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil]; 
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;  
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
    }
    
    else if([categoryStr isEqualToString:@"Facilities"])
    {
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isGeneralExpanded=YES;
        //    Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil]; 
        
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;           
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
    }
    
    else if([categoryStr isEqualToString:@"Near me now!"])
    {
        
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isGeneralExpanded=YES;
        
        
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude = [[[arr objectAtIndex:0]valueForKey:@"Latitude"] retain];
        longitude = [[[arr objectAtIndex:0]valueForKey:@"Longitude"] retain];
        
        NSLog(@"Latitude %@ Longitude %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;           
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        
    }
    
    else if([categoryStr isEqualToString:@"Text Search"])
    {
        
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isGeneralExpanded=YES;
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;          
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
    }
    
    else if([categoryStr isEqualToString:@"Real Ale"])
    {
        isThemeNightExit=YES;
        isOneOffEventexit=YES;
        isRegularEventExit=YES;
        isSportsDetailsExit=YES;
        issportsEventExit=YES;
        
        isGeneralExpanded=YES;
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl; 
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
    }
    
    else if ([categoryStr isEqualToString:@"Food & Offers"])
    {
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        
        isGeneralExpanded=YES;
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Food Details",@"Photos", nil];   
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
    }
    
    else if ([categoryStr isEqualToString:@"What's On Tonight..."])
    {
        arr=[[SaveTonightAnd7DaysInfo GetTonightRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Regular"];
            [arr removeAllObjects];
            //isregularEvent=YES;
        }
        
        
        
        arr=[[SaveTonightAnd7DaysInfo GetTonightSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Sport on Tv"];
            [arr removeAllObjects];
        }
        
        arr=[[SaveTonightAnd7DaysInfo GetTonightOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"One Off"];
            [arr removeAllObjects];
            
            
        }
        
        arr=[[SaveTonightAnd7DaysInfo GetTonightThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Theme Nights"];
            [arr removeAllObjects];
            
        }
        
        if ([Share_EventName isEqualToString: @"Regular"]) {
            isregularEvent=YES;
        }
        else if ([Share_EventName isEqualToString: @"One Off"]) {
            isoneoffEvent=YES;
        }
        else if ([Share_EventName isEqualToString: @"Theme Nights"]) {
            isthemenightEvent=YES;
        }
        else
            issportsEvent=YES;
        
        Array_section = [[NSMutableArray alloc]initWithObjects:@" ",@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@" ",@" ",@" ",@" ",@"Food Details",@"Photos", nil]; 
        
        if([arr_Event_name containsObject:@"Regular"]){
            
            [Array_section replaceObjectAtIndex:0 withObject:@"Regular Event"];
            
        }
        
        
        
        if([arr_Event_name containsObject:@"One Off"]){
            
            //[Array_section insertObject:@"One off Event" atIndex:6];
            [Array_section replaceObjectAtIndex:6 withObject:@"One off Event"];
            
        }
        if([arr_Event_name containsObject:@"Theme Nights"]){
            
            //[Array_section insertObject:@"Theme Night" atIndex:7];
            [Array_section replaceObjectAtIndex:7 withObject:@"Theme Night"];
            
        }
        
        
        if([arr_Event_name containsObject:@"Sport on Tv"]){
            
            [Array_section replaceObjectAtIndex:8 withObject:@"Sports Description"];
            [Array_section replaceObjectAtIndex:9 withObject:@"Sports Event"];
            
            
        }
        // isGeneralExpanded=YES;
        
        [Array_section removeObjectIdenticalTo:@" "];
        
        NSLog(@"array section %@",Array_section);
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"General"])
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
        }
        
        
        
        
        
    }
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"])
    {
        
        
        
        arr=[[SaveTonightAnd7DaysInfo GetNext7DaysRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Regular"];
            [arr removeAllObjects];
            
        }
        
        
        
        arr=[[SaveTonightAnd7DaysInfo GetNext7daysSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Sport on Tv"];
            [arr removeAllObjects];
            
        }
        
        arr=[[SaveTonightAnd7DaysInfo GetNext7DaysOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"One Off"];
            [arr removeAllObjects];
            
        }
        
        arr=[[SaveTonightAnd7DaysInfo GetNext7DaysThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
        if ([arr count]!=0) {
            [arr_Event_name addObject:@"Theme Nights"];
            [arr removeAllObjects];
            
            
            
        }
        
        if ([Share_EventName isEqualToString: @"Regular"]) {
            isregularEvent=YES;
        }
        else if ([Share_EventName isEqualToString: @"One Off"]) {
            isoneoffEvent=YES;
        }
        else if ([Share_EventName isEqualToString: @"Theme Nights"]) {
            isthemenightEvent=YES;
        }
        else
            issportsEvent=YES;
        
        
        Array_section = [[NSMutableArray alloc]initWithObjects:@" ",@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@" ",@" ",@" ",@" ",@"Food Details",@"Photos", nil]; 
        
        if([arr_Event_name containsObject:@"Regular"]){
            // [Array_section insertObject:@"Regular Event" atIndex:0];
            [Array_section replaceObjectAtIndex:0 withObject:@"Regular Event"];
            
        }
        
        
        
        if([arr_Event_name containsObject:@"One Off"]){
            
            //[Array_section insertObject:@"One off Event" atIndex:6];
            [Array_section replaceObjectAtIndex:6 withObject:@"One off Event"];
            
        }
        if([arr_Event_name containsObject:@"Theme Nights"]){
            
            //[Array_section insertObject:@"Theme Night" atIndex:7];
            [Array_section replaceObjectAtIndex:7 withObject:@"Theme Night"];
            
        }
        
        
        if([arr_Event_name containsObject:@"Sport on Tv"]){
            
            [Array_section replaceObjectAtIndex:8 withObject:@"Sports Description"];
            [Array_section replaceObjectAtIndex:9 withObject:@"Sports Event"];
            
            // [Array_section insertObject:@"Sports Description" atIndex:8];
            //[Array_section insertObject:@"Sports Event" atIndex:9];
            
        }
        if ((isregularEvent!=YES)&& (isoneoffEvent!=YES)&&(isthemenightEvent!=YES)&&(issportsEvent!=YES)) {
            isGeneralExpanded=YES;
        }
        
        
        [Array_section removeObjectIdenticalTo:@" "];
        
        NSLog(@"array section %@",Array_section);
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        latitude=[[arr objectAtIndex:0]valueForKey:@"Latitude"];
        longitude=[[arr objectAtIndex:0]valueForKey:@"Longitude"];
        
        NSLog(@"%@ %@",latitude,longitude);
        
        
        NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl;
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"General"])
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
                
            }
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
        }
        
        
        
    }
    
    else if([categoryStr isEqualToString:@"One Off"])
    {
        
        isRegularEventExit=YES;
        isThemeNightExit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isoneoffEvent=YES;
        
        isoneoffEvent=YES;
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        imageURL = [[arr objectAtIndex:0]valueForKey:@"venuePhoto"];
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"One off Event",@"Food Details",@"Photos", nil];  
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"One off Event",@"Food Details",@"Photos", nil];                  
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        
        
        
        my_table.contentOffset=CGPointMake(10, 100);
        
    }
    
    else if([categoryStr isEqualToString:@"Theme Nights"])
    {
        
        
        isRegularEventExit=YES;
        isOneOffEventexit=YES;
        issportsEventExit=YES;
        isSportsDetailsExit=YES;
        isthemenightEvent=YES;
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
        
        imageURL = [[arr objectAtIndex:0]valueForKey:@"venuePhoto"];
        str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
        str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
        
        
        NSMutableArray *temp_array1=[arrMain copy];
        
        for (int i=0; i<[temp_array1 count]; i++) {
            if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            Array_section = [[NSMutableArray alloc]initWithObjects:@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Theme Night",@"Food Details",@"Photos", nil];                  
            
            
            
        }
        else{
            Array_section = [[NSMutableArray alloc]initWithObjects:@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"Theme Night",@"Food Details",@"Photos", nil];                  
            
            
        }
        
        
        if ([OpenHourArray count]==0) {
            
            if([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"])
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            else{
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
                
            }
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        
        if([arrMain count]==0){
            if([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:2 withObject:@" "];
            
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"])
                
                
                [Array_section replaceObjectAtIndex:1 withObject:@" "];
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
            
            
            
        }
        
        
        if ([bulletPointArray count]==0) {
            
            if([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"])
                
                
                [Array_section replaceObjectAtIndex:3 withObject:@" "];
            
            else if([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:2 withObject:@" "];  
                
            }
            else if([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]){
                [Array_section replaceObjectAtIndex:1 withObject:@" "];  
            }
            
            else
                [Array_section replaceObjectAtIndex:0 withObject:@" "];  
            
            [Array_section removeObjectIdenticalTo:@" "];
        }
        
        
        
        
        [self.my_table scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:NO];
        
        
    }
    
    
    [self CreateView];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)CreateView{
    
    my_table = [[UITableView alloc]initWithFrame:CGRectMake(10, 75, 300, 300)style:UITableViewStylePlain];
    my_table.delegate=self;
    my_table.dataSource=self;
    my_table.rowHeight = 44.0;
    my_table.backgroundColor =[UIColor whiteColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    my_table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    my_table.separatorColor = [UIColor lightGrayColor];
    
    heardervw = [[UIView alloc]init];
    heardervw.backgroundColor = [UIColor whiteColor];
    
    image = [[AsyncImageView_New alloc]init];
    //[[AsyncImageLoader sharedLoader] cancelLoadingURL:image.image];
    image.image = [UIImage imageNamed:@"icon.png"];
    image.imageURL = [NSURL URLWithString:imageURL];
    // [image loadImageFromURL:[NSURL URLWithString:imageURL]];
    
    image.userInteractionEnabled = YES;
    
    //    [[AsyncImageLoader sharedLoader] cancelLoadingURL:image.imageURL];
    //    image.image = [UIImage imageNamed:@"icon.png"];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAlerts)];
    tap.numberOfTapsRequired = 1;
    
    [image addGestureRecognizer:tap];
    
    name_lbl = [[UILabel alloc]init];
    
    // name_lbl.text = [headerDictionaryData objectForKey:@"PubName"];
    
    
    name_lbl.font = [UIFont systemFontOfSize:12];
    name_lbl.textColor = [UIColor darkGrayColor];
    name_lbl.backgroundColor = [UIColor clearColor];
    
    address_lbl = [[UILabel alloc]init];
    address_lbl.text = [NSString stringWithFormat:@"%@, %@, %@",[headerDictionaryData objectForKey:@"PubPostCode"],[headerDictionaryData objectForKey:@"PubDistrict"],[headerDictionaryData objectForKey:@"PubCity"]];//@"6 The Meadow Lane,Blackawon";
    address_lbl.textColor = [UIColor lightGrayColor];
    address_lbl.backgroundColor = [UIColor clearColor];
    address_lbl.font = [UIFont systemFontOfSize:9];
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    
    fabBtn = [[UIButton alloc]init];
    [fabBtn setImage:[UIImage imageNamed:@"RedHartDeselect.png"] forState:UIControlStateNormal];
    [fabBtn setImage:[UIImage imageNamed:@"RedHartSelect.png"] forState:UIControlStateHighlighted];
    fabBtn.backgroundColor = [UIColor clearColor];
    [fabBtn setTitleColor:[UIColor colorWithRed:202/255 green:225/255 blue:255/255 alpha:1] forState:UIControlStateNormal];
    [fabBtn addTarget:self action:@selector(AddToFavourite:) forControlEvents:UIControlEventTouchUpInside];
    // fabBtn.font = [UIFont systemFontOfSize:9];
    [fabBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
    
    managerBtn = [[UIButton alloc]init];
    [managerBtn setImage:[UIImage imageNamed:@"CallSelectButton.png"] forState:UIControlStateNormal];
    [managerBtn setImage:[UIImage imageNamed:@"CallDeselectButton.png"] forState:UIControlStateHighlighted];
    
    managerBtn.backgroundColor = [UIColor clearColor];
    [managerBtn addTarget:self action:@selector(CallDistributor:) forControlEvents:UIControlEventTouchUpInside];
    [managerBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
    
    
    emailBtn = [[UIButton alloc]init];
    [emailBtn setImage:[UIImage imageNamed:@"EmailSelect.png"]  forState:UIControlStateNormal];
    [emailBtn setImage:[UIImage imageNamed:@"EmailDeselect.png"]  forState:UIControlStateHighlighted];
    emailBtn.backgroundColor = [UIColor clearColor];
    [emailBtn addTarget:self action:@selector(ClickOnMailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [emailBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
    
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.text=[headerDictionaryData objectForKey:@"PubName"];//@"Pub Details";
    lbl_heading.font = [UIFont boldSystemFontOfSize:11];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
    
    if([categoryStr isEqualToString:@"Regular"]||[categoryStr isEqualToString:@"One Off"]||[categoryStr isEqualToString:@"Theme Nights"]){
        
        name_lbl.text = [headerDictionaryData objectForKey:@"PubName"];
    }
    else
    {
        name_lbl.text = [headerDictionaryData objectForKey:@"PubName"];
    }
    
    btn_map=[[UIButton alloc]init];
    [btn_map setImage:[UIImage imageNamed:@"MapIconSelect2.png"]  forState:UIControlStateNormal];
    [btn_map setImage:[UIImage imageNamed:@"MapIconDeselect2.png"]  forState:UIControlStateHighlighted];
    btn_map.backgroundColor = [UIColor clearColor];
    [btn_map addTarget:self action:@selector(ClickOnMap:) forControlEvents:UIControlEventTouchUpInside];
    lbl_heading.hidden=YES;
    address_lbl.hidden=YES;
    
    [self setViewFrame];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:my_table];
    [self.view addSubview:backButton];
    [self.view addSubview:heardervw];
    [heardervw addSubview:image];
    [heardervw addSubview:name_lbl];
    [heardervw addSubview:address_lbl];
    [heardervw addSubview:btn_map];
    [heardervw addSubview:emailBtn];
    [heardervw addSubview:managerBtn];
    [heardervw addSubview:fabBtn];
    
    [backButton release];
    [heardervw release];
    [image release];
    [name_lbl release];
    [address_lbl release];
    //[fablbl release];
    [fabBtn release];
    [managerBtn release];
    [emailBtn release];
    [btn_map release];
}
-(void)imageAlerts{
    
    ImagesList *objImagesList=[[ImagesList alloc]initWithNibName:[Constant GetNibName:@"ImagesList"] bundle:[NSBundle mainBundle]];
    
    objImagesList.arrImage=[[SavePubDetailsInfo GetPhotoGalaryInfo:[Pub_ID intValue]]retain];
    NSLog(@"%@",objImagesList.arrImage);
    
    arr=[[SavePubDetailsInfo GetFunctionRoomImagesInfo:[Pub_ID intValue]]retain];
    
    [objImagesList.arrImage addObjectsFromArray:arr];
    
    
    NSLog(@"%@",objImagesList.arrImage);
    
    arr=[[SavePubDetailsInfo GetFoodDrinkImagesInfo:[Pub_ID intValue]]retain];
    [objImagesList.arrImage addObjectsFromArray:arr];
    NSLog(@"%@",objImagesList.arrImage);
    
    if([objImagesList.arrImage count]>0){
        
        PictureShowsInFullScreen *picFull=[[PictureShowsInFullScreen alloc]initWithNibName:[Constant GetNibName:@"PictureShowsInFullScreen"] bundle:[NSBundle mainBundle]];
        
        //UIButton *btnTemp= (UIButton*)sender;	
        //picFull.CurrentPositionofImage =btnTemp.tag;
        picFull.objBigImageArray = objImagesList.arrImage;
        // picFull.headertitle = headerTitle;
        [self.navigationController pushViewController:picFull animated:YES];
        [picFull release];
        
        
    }
    //[self.navigationController pushViewController:objImagesList animated:YES];
    else
    {
        UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Sorry, licensee has not uploaded any images of their venue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [altview show];
        [altview release];
    }
    
    [objImagesList release];
    
}

-(IBAction)ClickBack:(id)sender{
    
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    //app.ismore=NO;
    isGeneralExpanded=NO;
    isFoodDetail=NO;
    isregularEvent=NO;
    isOpeningHr=NO;
    isOtherDetails=NO;
    isPubBulletsExpanded=NO;
    isDescriptionExpanded=NO;
    isoneoffEvent=NO;
    isthemenightEvent=NO;
    isSportsDetails=NO;
    issportsEvent=NO;
    isImagesExpanded=NO;
    
    isRegularEventExit = NO;
    isGeneralExpandedExit = NO;
    isPubOpeningHrsExpandedexit = NO;
    isOtherDetailsExit = NO;
    isPubBulletsExpandedExit = NO;
    isDescriptionExpandedExit = NO;
    isOneOffEventexit = NO;
    isThemeNightExit = NO;
    
    isSportsDetailsExit = NO;
    issportsEventExit = NO;
    isImagesExpandedExit = NO;
    
    
    [my_table reloadData];
    
    FoodDetails_Microsite *obj= [[FoodDetails_Microsite alloc]init];
    obj.IsServeTime=NO;
    obj.IsInformation=NO;
    obj.IsFood=NO;
    obj.IsSpecialOffers=NO;
    obj.IsChefDesc=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)CallDistributor:(id)sender
{
    if ([str_mobile length]>0)
    {
        if ([str_mobile isEqualToString:@"No Info"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub & Bar Network" message:@"Sorry no phone number available." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }else
        {
            NSString *PhoneNo=[str_mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSLog(@"%@",PhoneNo);
            
            NSString *telephno=[NSString stringWithFormat:@"tel://%@",PhoneNo];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephno]]; 
        }
        
    }  else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub & Bar Network" message:@"Sorry no phone number available." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
    }
    
}
-(IBAction)ClickOnMap:(id)sender{
    NSLog(@"data     %@",longitude );
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=%f,%f&dirflg=d&doflg=ptm",[latitude doubleValue],[longitude doubleValue],app.currentPoint.coordinate.latitude,app.currentPoint.coordinate.longitude]]];
    
}

-(IBAction)ClickOnMailBtn:(id)sender
{
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            if ([str_mail isEqualToString:@"No Info"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No mail Id exist......." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            else{
                [self displayEmailComposerSheetMailToPub];
            }
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
-(IBAction)AddToFavourite:(id)sender
{
    //AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSString *pubName;
    if (app.IsNonsubscribed) {
        
        pubName = [[bulletPointArray valueForKey:@"PubName"] retain];
    }
    else
        pubName = [[headerDictionaryData objectForKey:@"PubName"] retain];
    
    [[DBFunctionality sharedInstance] InsertPubId_IntoPreference_Favourites:[Pub_ID intValue]];
    UIAlertView *alert_insert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ successfully added to your favourites.",pubName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_insert show];
    [alert_insert release];
}
-(void)setViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            my_table.frame = CGRectMake(10, 184, 300, 235);
            backButton.frame = CGRectMake(8, 90, 50, 25);
            heardervw.frame = CGRectMake(10, 124, 300, 58);
            image.frame = CGRectMake(2, 3.5, 70, 51.5);
            name_lbl.frame = CGRectMake(76, 0, 223, 30);
            // name_lbl.backgroundColor=[UIColor yellowColor];
            address_lbl.frame = CGRectMake(76, 13, 190, 30);
            toolBar.frame = CGRectMake(0, 387, 320, 48);
            lbl_heading.frame = CGRectMake(75, 89, 170, 25);
            
            fabBtn.frame = CGRectMake(88, 28, 27, 28);
            managerBtn.frame = CGRectMake(143, 28, 28, 29);
            emailBtn.frame = CGRectMake(200, 31, 33, 26);
            btn_map.frame=CGRectMake(256, 28, 30, 32);
            if (app.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);     
            }
            if (app.IsNonsubscribed==YES) {
                my_table.frame = CGRectMake(10, 184, 300, 190);
                image.image = [UIImage imageNamed:@"icon.png"];
            }
            
            
            
        }
        
        else{
            
            backButton.frame = CGRectMake(20, 85, 50, 25);
            toolBar.frame = CGRectMake(0, 240, 480, 48);
            my_table.frame = CGRectMake(10, 175, 460, 84);
            heardervw.frame = CGRectMake(10, 116, 460, 58);
            image.frame = CGRectMake(5, 3.5, 80, 51.5);
            name_lbl.frame = CGRectMake(100, 0, 200, 30);
            address_lbl.frame = CGRectMake(100, 13, 190, 30);
            lbl_heading.frame = CGRectMake(150, 79, 155, 24); 
            fabBtn.frame = CGRectMake(130, 26, 27, 28);
            managerBtn.frame = CGRectMake(210, 26, 28, 29);
            emailBtn.frame = CGRectMake(290, 30, 33, 26);
            btn_map.frame=CGRectMake(370, 28, 30, 32);
            
            if (app.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            if (app.IsNonsubscribed==YES) {
                my_table.frame = CGRectMake(10, 175, 460, 84);
                image.image = [UIImage imageNamed:@"icon.png"];
            }
            
            
            
            
        }
    }
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    
    if([categoryStr isEqualToString:@"What's On Next 7 Days"]||[categoryStr isEqualToString:@"What's On Tonight..."])
    {
        for(int i=0;i<[arr_Event_name count];i++){
            
            if([[arr_Event_name objectAtIndex:i] isEqualToString:@"Regular"]){
                
                self.my_table.contentOffset=CGPointMake(10, 1);
                break;
            }
            
            
            else if([[arr_Event_name objectAtIndex:i] isEqualToString:@"One Off"])
                
            {
                self.my_table.contentOffset=CGPointMake(10, 140);
                break;
            }
            
            else if([[arr_Event_name objectAtIndex:i] isEqualToString:@"Theme Nights"])
            {
                self.my_table.contentOffset=CGPointMake(10, 140);
                break;
            }
            else if([[arr_Event_name objectAtIndex:i] isEqualToString:@"Sport on Tv"])
            {
                self.my_table.contentOffset=CGPointMake(10, 170);
                break;
            }
            
            
        }
    }
    else{
        
        if([categoryStr isEqualToString:@"Regular"]){
            
            self.my_table.contentOffset=CGPointMake(10, 1);
        }
        
        
        
        else if([categoryStr isEqualToString:@"Theme Nights"])
        {
            self.my_table.contentOffset=CGPointMake(10, 160);
        }
        
        else if([categoryStr isEqualToString:@"One Off"])
        {
            self.my_table.contentOffset=CGPointMake(10, 140);
        }
        else if([categoryStr isEqualToString:@"Sport on Tv"])
        {
            self.my_table.contentOffset=CGPointMake(10, 200);
        }
        
        else if([categoryStr isEqualToString:@"Style(s)"]||[categoryStr isEqualToString:@"Features"]||         [categoryStr isEqualToString:@"Facilities"]||[categoryStr isEqualToString:@"Near me now!"]||          [categoryStr isEqualToString:@"Text Search"]||[categoryStr isEqualToString:@"Real Ale"]||[categoryStr isEqualToString:@"Food & Offers"]){
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
            
            latitude=[[[arr objectAtIndex:0]valueForKey:@"Latitude"] retain];
            longitude=[[[arr objectAtIndex:0]valueForKey:@"Longitude"] retain];
            
            NSLog(@"%@ %@",latitude,longitude);
            
            
            NSString *tempurl=[NSString stringWithFormat:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]];
            tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            imageURL = tempurl;            
            str_mobile=[[[arr objectAtIndex:0]valueForKey:@"Mobile"]retain];
            str_mail=[[[arr objectAtIndex:0]valueForKey:@"PubEmail"]retain];
            
            
            
            
            
            isGeneralExpanded=YES;
            
        }
        
    }
    
    
    
    if(app.IsNonsubscribed==YES){
        Array_section = [[NSMutableArray alloc]initWithObjects:@"General", nil]; 
        
        name_lbl.text=[bulletPointArray valueForKey:@"PubName"];
        
        NSString *tempurl = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        imageURL = tempurl; 
        image.imageURL = [NSURL URLWithString:imageURL];
        //isGeneralExpanded=YES;
        
    }
    
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    app.Isvenue=NO;
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
    
    // [my_table reloadData];
    // app.ismore=NO;
    //    isGeneralExpanded=NO;
    //    isFoodDetail=NO;
    //    isregularEvent=NO;
    //    isOpeningHr=NO;
    //    isOtherDetails=NO;
    //    isPubBulletsExpanded=NO;
    //    isDescriptionExpanded=NO;
    //    isoneoffEvent=NO;
    //    isthemenightEvent=NO;
    //    isSportsDetails=NO;
    //    issportsEvent=NO;
    //    isImagesExpanded=NO;
    [my_table reloadData];
    
    IsSelect=NO;
    
    
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
    [self AddNotification];
    
}
#pragma  mark-
#pragma mark- AddNotification
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
    NSLog(@"%@",Share_EventName);
    
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/sports-pubs-tv_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        
        
        obj.textString=[NSString stringWithFormat: @"Watch %@ showing at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSLog(@"%@ %@ %@ %d",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        
        obj.textString=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        
        obj.textString=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[EventId intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/view_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        
        
        obj.textString=[NSString stringWithFormat: @"%@ at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
    }
    
    else if([categoryStr isEqualToString:@"Real Ale"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
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
        
        
        
        
        obj.textString=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],tempurl];
        
        NSLog(@"%@",obj.textString);        
        
    }
    
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    GooglePlusViewController *obj = [[GooglePlusViewController alloc] initWithNibName:@"GooglePlusViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [obj release];
}


- (void)ShareInMessage:(NSNotification *)notification {
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            if ([str_mail isEqualToString:@"No Info"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No mail Id exist......." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            else{
                [self displayEmailComposerSheet];
            }
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


-(void)displayEmailComposerSheetMailToPub
{
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    //[mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    if (app.IsNonsubscribed) {
        [mailController setToRecipients:[NSArray arrayWithObjects:@"info@pubandbar-network.co.uk", nil]];
        
    }
    else
        [mailController setToRecipients:[NSArray arrayWithObjects:str_mail, nil]];
    
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"Pub & bar Network"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

-(void)displayEmailComposerSheet
{
    
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    NSString *fb_str;
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/sports-pubs-tv_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Watch %@ showing at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSLog(@"%@ %@ %@ %d",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[EventId intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/view_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
    }
    
    else if([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        NSLog(@"%@",tempurl);
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        fb_str=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],tempurl];
        
        NSLog(@"%@",fb_str);        
        
        
        
        
    }
    
    
    [mailController setMessageBody:[NSString stringWithFormat:@"%@",fb_str] isHTML:NO];
    //[mailController setToRecipients:[NSArray arrayWithObjects:str_mail, nil]];
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
    
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/sports-pubs-tv_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"Watch %@ showing at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSLog(@"%@ %@ %@ %d",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        
        obj.shareText=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[EventId intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/view_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
    }
    
    else if([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        NSLog(@"%@",tempurl);
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        obj.shareText=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],tempurl];
        
        NSLog(@"%@",obj.shareText);        
        
        
        
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
    if ([categoryStr isEqualToString:@"Sports on TV"])
    {
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/sports-pubs-tv_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"Watch %@ showing at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSLog(@"%@ %@ %@ %d",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]);
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[EventId intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",Share_EventName,Day,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/view_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        fb_str=[NSString stringWithFormat: @"%@ at %@ %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubPostCode"],tempurl];
    }
    
    else if([categoryStr isEqualToString:@"Real Ale"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
        
        NSLog(@"%@",tempurl);
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        fb_str=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",Share_EventName,[headerDictionaryData valueForKey:@"PubName"],[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],tempurl];
        
        NSLog(@"%@",fb_str);        
        
        
        
        
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
        
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/sports-pubs-tv_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[EventId intValue],[Pub_ID intValue]];
    
    
    
    
    else if ([categoryStr isEqualToString:@"Food & Offers"]){
        
        
        NSLog(@"%@ %@ %@ %d",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]);
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
    }
    
    
    
    //fb_str=[NSString stringWithFormat: @"http://tinyurl.com/89u8erm = (media text) #Pubs and Bars showing %@ http://tinyurl.com/bncphw2",eventName];
    
    else if ([categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."]){
        
        
        fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/"];
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Theme Nights" ]){
        
        //fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t%5B%d%5D=on",eventID];
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[EventId intValue]];
        
        
    }
    
    
    else if ([categoryStr isEqualToString:@"One Off"]){
        
        // fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e%5B%d%5D=on",[eventID intValue]];
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
    }
    
    
    
    else if ([categoryStr isEqualToString:@"Regular"]){
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
    }
    
    else  if([categoryStr isEqualToString:@"Facilities"]){
        
        fb_str=[NSString stringWithFormat: @" http://www.pubandbar-network.co.uk/pubs/view_%@_%@_%@_%d_.html",[headerDictionaryData valueForKey:@"PubCity"],[headerDictionaryData valueForKey:@"PubDistrict"],[headerDictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
    }
    
    
    else
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v "];
    
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",fb_str,
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
#pragma  mark-



-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView %@",Array_section);
    return [Array_section count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if(((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"]))){
        
        return 0.1;
        
        
    }
    
    else
        
        return 0.8;
    // }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"]))){
        
        
        return 0.1;
    }
    
    else
        return 0.8; 
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    
    if((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Regular Event"])){
        if ( isregularEvent==YES)
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
                return [arr count]+1;
            }
            else{
                return [arrSubMain count]+1;
            }
        
            else
            {
                return 1;
            }
    }
    
    else if(((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"General"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"General"]))){
        
        
        if(app.IsNonsubscribed==NO){
            
            [arr removeAllObjects];
            [arrMain removeAllObjects];
            
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
            NSMutableArray *temp_array1=[arrMain copy];
            
            for (int i=0; i<[temp_array1 count]; i++) {
                if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                    [arrMain replaceObjectAtIndex:i withObject:@" "];
                }
            }
            
            [arrMain removeObjectIdenticalTo:@" "];
            
            
        }
        
        
        if(isGeneralExpanded ==YES)
            return [arrMain count]+1;
        
        else if(app.IsNonsubscribed==YES){
            return 4;
        }
        else
            return 1;
    }
    
    else if(((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Opening Hours"]))){
        
        
        
        if( isOpeningHr==YES)
        {
            NSLog(@"%d",( [OpenDayArray count]+1));
            return [OpenDayArray count]+1;
        }
        
        else
        {
            return 1;
        }
    }
    
    else if(((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Other Details"]))){
        
        [arrMain removeAllObjects];
        [arr removeAllObjects];
        
        
        arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
        
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
        [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
        NSLog(@"before Details %@",arrMain);
        
        NSMutableArray *temp_array=[arrMain copy];
        
        for (int i=0; i<5; i++) {
            if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                [arrMain replaceObjectAtIndex:i withObject:@" "];
            }
        }
        
        [arrMain removeObjectIdenticalTo:@" "];
        NSLog(@"other Details %@",arrMain);
        
        
        if(isOtherDetails==YES)
            return [arrMain count]+1;
        else
            return 1;
    }
    else if(((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Bullet Points"]))){
        
        
        if(isPubBulletsExpanded==YES)
        {
            NSLog(@"%d",( [bulletPointArray count]+1));
            return [bulletPointArray count]+1;
        }
        else
            return 1;
    }
    
    else if(((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Description"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Description"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Description"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Description"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Description"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Description"]))){
        if(isDescriptionExpanded==YES)
            return 2;
        else
            return 1;
        
    }
    else if(((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"One off Event"]))||((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"One off Event"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"One off Event"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"One off Event"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"One off Event"]))||((section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"One off Event"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"One off Event"]))){
        if(isoneoffEvent==YES)
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
                return [arr count]+1;
            }
            else
            {
                return [arrSubMain count]+1;
            }
            else
                return 1;
    }
    else if(((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Theme Night"]))||((section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Theme Night"]))||((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Theme Night"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Theme Night"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Theme Night"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Theme Night"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Theme Night"]))){
        
        if(isthemenightEvent==YES)
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
                return [arr count]+1;
            }
            else
            {
                return [arrSubMain count]+1;
            }
            else
                return 1;
    }
    
    else if(((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Description"]))||((section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Description"]))||((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Description"]))||((section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Description"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Description"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Description"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Description"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Sports Description"]))){
        
        if(isSportsDetails==YES){
            
            
            
            NSLog(@"%d",[arr count]+1);
            return 2;
        }
        else
            return 1;
    }
    
    else if(((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Event"]))||((section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Sports Event"]))||((section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Event"]))||((section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Event"]))||((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Event"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Event"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Event"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Event"]))){
        
        if(issportsEvent==YES){
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
                
                
                return [arr count]+1;
                
            }
            else{
                return ([arrSubMain count]+1);
            }
        }
        else
            return 1;
    }
    else if(((section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Food Details"]))||((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Food Details"]))||((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Food Details"]))||((section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Food Details"]))||((section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Food Details"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Food Details"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Food Details"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Food Details"]))||((section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Food Details"]))||((section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Food Details"]))){
        return 1;
    }
    else if(((section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Photos"]))||((section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Photos"]))||((section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Photos"]))||((section==11)&&([[Array_section objectAtIndex:11]isEqualToString:@"Photos"]))||((section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Photos"]))||((section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Photos"]))||((section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Photos"]))||((section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Photos"]))||((section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Photos"]))){ 
        
        if(isImagesExpanded==YES)
            return 4;
        else
            return 1;
    }
    else
        return 0;
    
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell ; 
    
	
    
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	NSLog(@"%d",indexPath.section);
    
    UIView *vw = [[[UIView alloc]init]autorelease];
    vw.frame =CGRectMake(0, 0, 380, 42);
    vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    
    vw.backgroundColor = [UIColor whiteColor];
    
    
    if(indexPath.section==10){
        vw.backgroundColor =[UIColor whiteColor];
    }
    else
    {
        if (indexPath.section==section_value) {
            
            
            if (indexPath.row==0) {
                if (IsSelect==YES) {
                    vw.backgroundColor =[UIColor clearColor];
                }
            }
            
            else
            {
                vw.backgroundColor =[UIColor whiteColor];//[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
                
            }
        }
    }
    
    [cell.contentView addSubview:vw];
    
    
    
    
    if((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Regular Event"]))
    {
		UILabel *lblRegularEvent = [Design LabelFormation:5 :7 :100 :20 :0];
        lblRegularEvent.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel *lblRegularEvent1 = [Design LabelFormation:110 :7 :190 :20 :0];
        lblRegularEvent1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
        UILabel *lbl=[Design LabelFormation:5 :55 :90 :20 :0];
        lbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UITextView *lblRegularEventDesc = [Design textViewFormation:100 :55 :230 :35 :0];
        lblRegularEventDesc.editable=NO;
        lblRegularEventDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel * lblEventDay = [Design LabelFormation:5 :31 :100 :20 :0];	
        lblEventDay.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel * lblEventDay1 = [Design LabelFormation:110 :31 :200 :20 :0];	
        lblEventDay1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
        //        UILabel *lblRegularEvent= [Design LabelFormation:10 :5 :250 :20 :0];
        //		UILabel *lblEventDay = [Design LabelFormation:10 :20 :290 :20 :0];
        //        UILabel *lbl=[];
        //        UITextView *lblRegularEventDesc = [Design textViewFormation:10 :35 :270 :35 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            
			if(isRegularEventExit==YES)
			    img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                
                if(isregularEvent == YES)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			imgMain.image =img;
            
			
			[vw addSubview:imgMain];
            
			
			[imgMain release];
			
			lblRegularEvent = [Design LabelFormation:35 :5 :150 :20 :0];
			lblRegularEvent.text = @"Regular Event";
			lblRegularEvent.font = [UIFont boldSystemFontOfSize:15];
			//lblRegularEvent.textColor =textcolorNew;//[UIColor whiteColor];
			[cell.contentView addSubview:lblRegularEvent];
		}
        else if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
            
            if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else{
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
                
            }
            
            if ( isregularEvent == YES){
                
                lblRegularEvent.text=[NSString stringWithFormat:@"Event Name:"];
                
                lblRegularEvent1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                str_date = [dateFormat2 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"EventDay"]];
                
                lbl.text=@"Description:";
                lblRegularEventDesc.text =[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Event_Description"];
                
                
                
                [cell.contentView addSubview:lblRegularEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblRegularEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblRegularEvent1];  
                [cell.contentView addSubview:lblEventDay1]; 
                
                cell.selectionStyle =UITableViewCellSelectionStyleNone;		
                
                [lblRegularEvent release];
                [lblEventDay release];
                [lblRegularEventDesc release];
                [lbl release];
                [lblRegularEvent1 release];
                [lblEventDay1 release];
                
                
            } 
        }
        else{
            
            if ( isregularEvent == YES) {
                
                
                lblRegularEvent.text=[NSString stringWithFormat:@"Event Name:"];
                
                lblRegularEvent1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                str_date = [dateFormat2 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Day"]];
                
                lbl.text=@"Description:";
                lblRegularEventDesc.text =[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Description"];
                
                
                
                [cell.contentView addSubview:lblRegularEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblRegularEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblRegularEvent1];
                [cell.contentView addSubview:lblEventDay1]; 
                
                
                cell.selectionStyle =UITableViewCellSelectionStyleNone;		
                
                [lblRegularEvent release];
                [lblEventDay release];
                [lblRegularEventDesc release];
                [lbl release];
                [lblRegularEvent1 release];
                [lblEventDay1 release];
                
                if(indexPath.row>0)
                {
                    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                }
                
                
            }
        }
    }
    
    
 	if(((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"General"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"General"])))
	{
        UILabel *lblPubGeneral = [Design LabelFormation:5 :8 :110 :25 :0];
        lblPubGeneral.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel  *lblPubGeneralDisp = [Design LabelFormation:115 :0 :202 :45 :0];
        lblPubGeneralDisp.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        lblPubGeneralDisp.numberOfLines=2;
        // lblPubGeneralDisp.backgroundColor=[UIColor redColor];
        
        UITextView *lblPubGeneralDispTextView = [Design textViewFormation:105 :1 :207 :28 :0];
        lblPubGeneralDispTextView.editable=NO;
        lblPubGeneralDispTextView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        //lblPubGeneral.backgroundColor = [UIColor redColor];
        //lblPubGeneralDisp.backgroundColor = [UIColor brownColor];
		
		NSLog(@"%d",indexPath.row);	
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			if(isGeneralExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isGeneralExpanded==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			
			imgMain.image = img;
			[vw addSubview:imgMain];
			[imgMain release];
			lblPubGeneral = [Design LabelFormation:35 :5 :100 :20 :0];
			lblPubGeneral.text = @"General";
			lblPubGeneral.font = [UIFont boldSystemFontOfSize:15];
			//lblPubGeneral.textColor =textcolorNew;//[UIColor whiteColor];
		}
		else if(app.IsNonsubscribed==YES){
            
            
            //[arr removeAllObjects];
            //[arrMain removeAllObjects];
            
            arr=[bulletPointArray copy];
            NSLog(@"array %@",arr);
            
            [arrMain addObject:[bulletPointArray valueForKey:@"PubName"]];
            if ([[bulletPointArray valueForKey:@"PhoneNumber"] isEqual:@" "]) 
                [arrMain addObject:@"Please forward phone number and we will add it."];
            else
                [arrMain addObject:[bulletPointArray valueForKey:@"PhoneNumber"]];
            
            [arrMain addObject:[bulletPointArray valueForKey:@"PubCity"]];
            
            if (indexPath.row==1){
                lblPubGeneral.text = @"Name:";
                //lblPubGeneralDisp.backgroundColor=[UIColor yellowColor];
                lblPubGeneralDisp.text =[arrMain objectAtIndex:0];
                [cell.contentView addSubview:lblPubGeneralDisp];
                
            }
            else if(indexPath.row==2) {
                lblPubGeneral.text = @"Phone No:";
                
                lblPubGeneralDisp.text = [arrMain objectAtIndex:1];
            }
            else if(indexPath.row==3) {
                
                
                UILabel *lblPubGeneral1 = [Design LabelFormation:5 :17 :110 :25 :0];
                lblPubGeneral1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
                
                lblPubGeneral1.text = @"Address: ";
                
                UILabel  *lblPubGeneralDisp1 = [Design LabelFormation:105 :0 :210 :75 :0];
                lblPubGeneralDisp1.numberOfLines=4;
                lblPubGeneralDisp1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;    
                
                lblPubGeneralDisp1.text = [NSString stringWithFormat:@"%@,%@,%@",[bulletPointArray valueForKey:@"PubCity"],[bulletPointArray valueForKey:@"PubDistrict"],[bulletPointArray valueForKey:@"PubPostCode"]];
                [cell.contentView addSubview:lblPubGeneralDisp1];
                [lblPubGeneralDisp1 release];
                [cell.contentView addSubview:lblPubGeneral1];
                [lblPubGeneral1 release];
                
                
            }
            
            if(indexPath.row!=3) {
                [cell.contentView addSubview:lblPubGeneralDisp];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
        }
        
        
        else if(isGeneralExpanded ==YES)        {
            
            array=[[NSMutableArray alloc]initWithObjects:@"Name:",@"District:",@"City:",@"Postcode:",@"Phone No:",@"Mobile:",@"WebSite:",@"Pub Company:",@"Address:", nil];  
            
            [arr removeAllObjects];
            [arrMain removeAllObjects];
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
            
            NSMutableArray *temp_array1=[arrMain copy];
            
            for (int i=0; i<[temp_array1 count]; i++) {
                if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                    [arrMain replaceObjectAtIndex:i withObject:@" "];
                    [array replaceObjectAtIndex:i withObject:@" "];
                    
                }
            }
            
            [arrMain removeObjectIdenticalTo:@" "];
            [array removeObjectIdenticalTo:@" "];
            
            if([[array objectAtIndex:indexPath.row-1]isEqualToString:@"Address:"]){
                
                UILabel *lblPubGeneral = [Design LabelFormation:5 :22 :110 :25 :0];
                lblPubGeneral.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
                
                
                
                UILabel  *lblPubGeneralDisp = [Design LabelFormation:115 :0 :202 :75 :0];
                lblPubGeneralDisp.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;    
                
                lblPubGeneralDisp.numberOfLines=4;
                
                lblPubGeneral.text = [array objectAtIndex:indexPath.row-1];
                lblPubGeneralDisp.text =[arrMain objectAtIndex:indexPath.row-1];
                [cell.contentView addSubview:lblPubGeneralDisp];
                [cell.contentView addSubview:lblPubGeneral];
                
                
            }
            else{
                
                lblPubGeneral.text = [array objectAtIndex:indexPath.row-1];
                lblPubGeneralDisp.text =[arrMain objectAtIndex:indexPath.row-1];
                [cell.contentView addSubview:lblPubGeneralDisp];
                [cell.contentView addSubview:lblPubGeneral];
                
            }
            
            
            
            /*  CGSize lblkgspounds_Size = [[arrMain objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:13.5]constrainedToSize:CGSizeMake(250, MAXFLOAT_Height+10) lineBreakMode:UILineBreakModeWordWrap];
             CGRect rect=lblPubGeneralDisp.frame;
             rect.size=lblkgspounds_Size;
             lblPubGeneralDisp.frame=rect;*/
            // lblPubGeneralDisp.backgroundColor=[UIColor redColor];
            //NSLog(@"Rect frame %@",rect);
            
            
            if(indexPath.row!=9) {
                
                [cell.contentView addSubview:lblPubGeneralDisp];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
        }
        [cell.contentView addSubview:lblPubGeneral];
        [lblPubGeneral release];
		[lblPubGeneralDisp release];
        
	}	
    
    if(((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Opening Hours"]))){
        
        UILabel *lblOpening = [Design LabelFormation:5 :11 :80 :20 :0];
        UITextView *lblOpeningDesc = [Design textViewFormation:90 :5 :230 :24 :0];
        lblOpeningDesc.editable=NO;
        lblOpeningDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        if (indexPath.row==0){				
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            if(isPubOpeningHrsExpandedexit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isOpeningHr==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
            imgMain.image = img;
            
            [vw addSubview:imgMain];
            [imgMain release];
            
            lblOpening = [Design LabelFormation:35 :5 :150 :20 :0];
            lblOpening.text = @"Opening Hours";
            lblOpening.font = [UIFont boldSystemFontOfSize:15];
            // lblOpening.textColor =textcolorNew;//[UIColor whiteColor];
            [cell.contentView addSubview:lblOpening];
        }
        else if( isOpeningHr==YES)
        {
            
            lblOpening.text = [OpenDayArray objectAtIndex:indexPath.row-1];
            lblOpeningDesc.text =[OpenHourArray objectAtIndex:indexPath.row-1];
            
            
            
            [cell.contentView addSubview:lblOpeningDesc];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:lblOpening];
            
        }
        
        [lblOpening release];
        [lblOpeningDesc release];
    }
    
  	if(((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Other Details"]))){
		
        UILabel *lblOpening = [Design LabelFormation:5 :11 :105 :20 :0];
		UITextView *lblOpeningDesc = [Design textViewFormation:110 :5 :210 :24 :0];
        lblOpeningDesc.editable=NO;
        lblOpeningDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
		if (indexPath.row==0){				
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            
            if ([Constant isiPad]) {
                ;
            }
            else{
                if ([Constant isPotrait:self]) {
                    if(isOtherDetailsExit==YES)
                        
                        img=[UIImage imageNamed:@"CrossButton.png"];
                    else{
                        if(isOtherDetails==NO)
                            img=[UIImage imageNamed:@"ArrowDeselect.png"];
                        else
                            img=[UIImage imageNamed:@"ArrowDeselect.png"];
                    }
                }
                else
                {
                    if(isOtherDetailsExit==YES)
                        
                        img=[UIImage imageNamed:@"CrossButton.png"];
                    else{
                        if(isOtherDetails==NO)
                            img=[UIImage imageNamed:@"ArrowDeselect.png"];
                        else
                            img=[UIImage imageNamed:@"ArrowDeselect.png"];
                    }
                    
                }
            }
			imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			
			lblOpening = [Design LabelFormation:35 :5 :150 :20 :0];
			lblOpening.text = @"Other Details";
			lblOpening.font = [UIFont boldSystemFontOfSize:15];
			
		}
        else if( isOtherDetails==YES)
        {
            
            
            [arrMain removeAllObjects];
            [arr removeAllObjects];
            
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
            NSLog(@"before Details %@",arrMain);
            
            NSMutableArray *temp_array=[arrMain copy];
            
            NSMutableArray *arr_otherdetails = [[NSMutableArray alloc]initWithObjects:@"VenueStyle",@"Venue Capacity:",@"Nearest Rail:",@"Nearest Tube",@"Local Buses:", nil]; 
            
            for (int i=0; i<5; i++) {
                if ([[temp_array objectAtIndex:i]isEqualToString:@"Not Available"]) {
                    [arrMain replaceObjectAtIndex:i withObject:@" "];
                    [arr_otherdetails replaceObjectAtIndex:i withObject:@" "];
                }
            }
            
            [arrMain removeObjectIdenticalTo:@" "];
            [arr_otherdetails removeObjectIdenticalTo:@" "];
            
            NSLog(@"integer value %d",[arrMain count]);
            
            NSLog(@"integer value %d",indexPath.row);
            
            
            lblOpening.text = [arr_otherdetails objectAtIndex:indexPath.row-1];
            lblOpeningDesc.text =[arrMain objectAtIndex:indexPath.row-1];
            
            
            [cell.contentView addSubview:lblOpeningDesc];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [arr_otherdetails release];
            
	    }	
        [cell.contentView addSubview:lblOpening];
        [lblOpening release];
		[lblOpeningDesc release];
        
	}
    
    if(((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Bullet Points"]))){
        
        UILabel *lblPubBullets = [Design LabelFormation:10 :5 :100 :20 :0];
        UITextView *lblPubBulletsDesc = [Design textViewFormation:5 :5 :310 :40 :0];
        lblPubBulletsDesc.editable=NO;
        lblPubBulletsDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            if(isPubBulletsExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isPubBulletsExpanded==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
            imgMain.image = img;
            
            [vw addSubview:imgMain];
            [imgMain release];
            
            lblPubBullets = [Design LabelFormation:35 :5 :150 :20 :0];
            lblPubBullets.text = @"Bullet Points";
            lblPubBullets.font = [UIFont boldSystemFontOfSize:15];
            
            [cell.contentView addSubview:lblPubBullets];
        }
        else if(isPubBulletsExpanded==YES){
            if ([[[bulletPointArray objectAtIndex:indexPath.row-1] valueForKey:@"bullet"] length] == 0) {
                lblPubBulletsDesc.text =@"No Info"; 
            }
            else{
                lblPubBulletsDesc.text =[[bulletPointArray objectAtIndex:indexPath.row-1] valueForKey:@"bullet"]; //valueForKey:@"pubBullet"] retain];
            }
            
            // Set up the cell...
            [cell.contentView addSubview:lblPubBulletsDesc];
        }
        [lblPubBullets release];
        [lblPubBulletsDesc release];
        
    }	
    
    if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Description"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Description"]))){
        
        
        
        
        UILabel *lblPubDesc= [Design LabelFormation:10 :5 :100 :20 :0];
        UITextView *lblPubDescDetails= [Design textViewFormation:5 :5 :310 :75 :1];
        lblPubDescDetails.editable=NO;
        
        lblPubDescDetails.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            
            if(isDescriptionExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isDescriptionExpanded==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
            imgMain.image = img;
            
            [vw addSubview:imgMain];
            [imgMain release];
            
            lblPubDesc = [Design LabelFormation:35 :5 :100 :20 :0];
            lblPubDesc.text = @"Description";
            lblPubDesc.font = [UIFont boldSystemFontOfSize:15];
            // lblPubDesc.textColor =textcolorNew;//[UIColor whiteColor];
            [cell.contentView addSubview:lblPubDesc];
        }
        else if(isDescriptionExpanded==YES){
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
            //[arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDescription"]];
            
            lblPubDescDetails.text =[[arr objectAtIndex:0]valueForKey:@"PubDescription"];
            NSLog(@"%@",[[arr objectAtIndex:0]valueForKey:@"PubDescription"]);
            [cell.contentView addSubview:lblPubDescDetails];
        }
        [lblPubDesc release];
        [lblPubDescDetails release];
    }
	
  	
	if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"One off Event"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"One off Event"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"One off Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"One off Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"One off Event"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"One off Event"]))){
        
        
        
        UILabel *lblOneoffEvent = [Design LabelFormation:5 :7 :100 :20 :0];
        UILabel *lblOneoffEvent1 = [Design LabelFormation:110 :7 :190 :20 :0];
        lblOneoffEvent1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
        
        UILabel *lbl=[Design LabelFormation:5 :55 :80 :20 :0];
        UITextView *lblOneoffEventDesc = [Design textViewFormation:100 :55 :233 :35 :0];
        lblOneoffEventDesc.editable=NO;
        lblOneoffEventDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel * lblEventDay = [Design LabelFormation:5 :31 :100 :20 :0];	
        UILabel * lblEventDay1 = [Design LabelFormation:110 :31 :200 :20 :0];	
        lblEventDay1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			
            if(isOneOffEventexit==YES)
				
                img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isoneoffEvent==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			imgMain.image = img;
			[vw addSubview:imgMain];
			[imgMain release];
			lblOneoffEvent = [Design LabelFormation:35 :5 :150 :20 :0];
			lblOneoffEvent.text = @"One Off Event";
			lblOneoffEvent.font = [UIFont boldSystemFontOfSize:15];
			//lblOneoffEvent.textColor =textcolorNew;//[UIColor whiteColor];
			[cell.contentView addSubview:lblOneoffEvent];
		}
		else  if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
            
            if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else{
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
                
            }
            
            if(isoneoffEvent==YES) {
                
                
                lblOneoffEvent.text=[NSString stringWithFormat:@"Event Name:"];
                lblOneoffEvent1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                //[dateFormat setLocale:[NSLocale currentLocale]];
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
                //[dateFormat release];
                
                
                
                NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
                [dateFormat3 setDateFormat:@"HH:mm:ss"];
                
                NSString *dateString1 = [dateFormat3 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                [dateFormat3 release];
                
                str_date=[NSString stringWithFormat:@"%@ At %@",dateString,dateString1];
                
                
                
                
                
                
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"EventDay"]];
                
                lbl.text=@"Description:";
                lblOneoffEventDesc.text =[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Event_Description"];
                
                
                [cell.contentView addSubview:lblOneoffEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblOneoffEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblOneoffEvent1];
                [cell.contentView addSubview:lblEventDay1];
                
                [lblEventDay release];	
                [lblOneoffEvent release];
                [lblOneoffEventDesc release];
                [lbl release];
                [lblOneoffEvent1 release];	
                [lblEventDay1 release];
                
                
            }
            
            
            
            
        }
        
        else{
            if(isoneoffEvent==YES) {	
                
                
                lblOneoffEvent.text=[NSString stringWithFormat:@"Event Name:"];
                
                lblOneoffEvent1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                //[dateFormat setLocale:[NSLocale currentLocale]];
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
                //[dateFormat release];
                
                
                
                NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
                [dateFormat3 setDateFormat:@"HH:mm:ss"];
                
                NSString *dateString1 = [dateFormat3 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                [dateFormat3 release];
                
                str_date=[NSString stringWithFormat:@"%@ At %@",dateString,dateString1];
                
                
                
                
                
                
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Day"]];  
                
                lbl.text=@"Description:";
                lblOneoffEventDesc.text =[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Description"];
                
                
                [cell.contentView addSubview:lblOneoffEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblOneoffEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblOneoffEvent1];
                [cell.contentView addSubview:lblEventDay1];
                
                
                
                [lblEventDay release];	
                [lblOneoffEvent release];
                [lblOneoffEventDesc release];
                [lbl release];
                [lblOneoffEvent1 release];	
                [lblEventDay1 release];
                
                if(indexPath.row>0)
                {
                    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                }
                
                
                //			if(indexPath.row>0)
                //				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
	}
    
    
    if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Theme Night"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Theme Night"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Theme Night"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Theme Night"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Theme Night"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Theme Night"]))){
        
        
        
        
        
        UILabel *lblThemenightEvent = [Design LabelFormation:5 :7 :90 :20 :0];
        
        UILabel *lblThemenightEvent1 = [Design LabelFormation:110 :7 :200 :20 :0];
        lblThemenightEvent1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
        UILabel *lbl=[Design LabelFormation:5 :55 :90 :20 :0];
        UITextView *lblOneoffEventDesc = [Design textViewFormation:100 :55 :233 :35 :0];
        lblOneoffEventDesc.editable=NO;
        lblOneoffEventDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        UILabel * lblEventDay = [Design LabelFormation:5 :31 :290 :20 :0];	
        UILabel * lblEventDay1 = [Design LabelFormation:110 :31 :200 :20 :0];	
        lblEventDay1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        
        
        if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			
            if(isThemeNightExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!isthemenightEvent)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			imgMain.image = img;
			
            [vw addSubview:imgMain];
			[imgMain release];
			
			lblThemenightEvent = [Design LabelFormation:35 :5 :150 :20 :0];
			lblThemenightEvent.text = @"Theme Night";
			lblThemenightEvent.font = [UIFont boldSystemFontOfSize:15];
			//lblThemenightEvent.textColor =textcolorNew;//[UIColor whiteColor];
			[cell.contentView addSubview:lblThemenightEvent];
		}
		
		else if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
            
            
            if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else{
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            
            if(isthemenightEvent==YES) {
                
                lblThemenightEvent.text=[NSString stringWithFormat:@"Event Name:"];
                
                lblThemenightEvent1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                str_date = [dateFormat2 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                
                
                
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"EventDay"]];
                
                lbl.text=@"Description:";
                lblOneoffEventDesc.text =[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Event_Description"];
                
                
                
                [cell.contentView addSubview:lblThemenightEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblOneoffEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblThemenightEvent1];
                [cell.contentView addSubview:lblEventDay1];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;		
                
                [lblThemenightEvent release];
                [lblEventDay release];
                [lblOneoffEventDesc release];
                [lbl release];
                [lblThemenightEvent1 release];	
                [lblEventDay1 release];
                
                
                
                
                
            }
            
            
        }
        
        
        
        else
        {
            
            
            
            
            if(isthemenightEvent==YES) {
                
                
                
                lblThemenightEvent.text=[NSString stringWithFormat:@"Event Name:"];
                
                lblThemenightEvent1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
                
                
                NSString *str_date;
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                str_date = [dateFormat2 stringFromDate:tempDate]; 
                [dateFormat release];
                [dateFormat2 release];
                
                
                
                
                
                lblEventDay.text=[NSString stringWithFormat:@"Event Date:"];
                
                lblEventDay1.text=[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Day"]];
                
                lbl.text=@"Description:";
                lblOneoffEventDesc.text =[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Description"];
                
                
                
                [cell.contentView addSubview:lblThemenightEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblOneoffEventDesc];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblThemenightEvent1];
                [cell.contentView addSubview:lblEventDay1];
                
                cell.selectionStyle =UITableViewCellSelectionStyleNone;		
                
                [lblThemenightEvent release];
                [lblEventDay release];
                [lblOneoffEventDesc release];
                [lbl release];
                [lblThemenightEvent1 release];
                [lblEventDay1 release];
                
                if(indexPath.row>0)
                {
                    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                }
                
                
                
            }
        }
        
    }
	
	if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Description"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Description"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Description"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Sports Description"]))){
        
		
        
        UILabel *lblSportsDes= [Design LabelFormation:10 :5 :100 :20 :0];
		UITextView *lblSportsDesCrip = [Design textViewFormation:10 :5 :305 :95 :0];
		lblSportsDesCrip.editable=NO;
        
        lblSportsDesCrip.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			if(isSportsDetailsExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!isSportsDetails)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			
			lblSportsDes = [Design LabelFormation:35 :5 :150 :20 :0];
			lblSportsDes.text = @"Sports Description";
			lblSportsDes.font = [UIFont boldSystemFontOfSize:15];
			//lblSportsDes.textColor =textcolorNew;//[UIColor whiteColor];
			[cell.contentView addSubview:lblSportsDes];
		}
		else if(isSportsDetails==YES){
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]){
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
                
                if ([arr count]!=0) {
                    lblSportsDesCrip.text = Sport_Evnt_id;
                }
                else
                {
                    lblSportsDesCrip.text =@"No info";
                }
                
                
                
            }
            else if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7daysSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
                
                if ([arr count]!=0) {
                    lblSportsDesCrip.text = Sport_Evnt_id;
                }
                else
                {
                    lblSportsDesCrip.text =@"No info";
                }
                
            }
            
            else{
                
                
                
                
                lblSportsDesCrip.text = Sport_Evnt_id;
            }
            
			[cell.contentView addSubview:lblSportsDesCrip];
		}
		[lblSportsDes release];
		[lblSportsDesCrip release];
	}	
	
	
	
	
	
	if(((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Event"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Sports Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Event"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Event"]))|((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Event"]))){
        
        
        UILabel *lblSportsEventName= [Design LabelFormation:10 :7 :310 :20 :0];
        lblSportsEventName.numberOfLines = 1;
        lblSportsEventName.lineBreakMode = UILineBreakModeWordWrap;	
        UILabel *lblSportsEventType= [Design LabelFormation:10 :22 :120 :30 :0];
        
        
        UITextView *lblSportsEventTypeName=[Design textViewFormation:120 :28 :173 :26 :0];
        lblSportsEventName.text=UITextAlignmentLeft;
        lblSportsEventTypeName.editable=NO;
        
        UILabel *lblSportsSound = [Design LabelFormation:10 :61 :310 :20 :0 ];
        UILabel *lblSportsEventScreen= [Design LabelFormation:10 :83 :310 :20 :0];
        UILabel *lblSportsEventHD= [Design LabelFormation:10 :105 :310 :20 :0];
        UILabel *lblSportsEventDate= [Design LabelFormation:10 :127 :310 :20 :0];
        UILabel *lblSportsEventChannel= [Design LabelFormation:10 :149 :310 :20 :0];
        UILabel *lblSportsEvent3D= [Design LabelFormation:10 :171 :310 :20 :0];
        
        
        
        
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			if(issportsEventExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!issportsEvent)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			}
			imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			
			lblSportsEventName = [Design LabelFormation:35 :5 :150 :20 :0];
			lblSportsEventName.text = @"Sports Event";
			lblSportsEventName.font = [UIFont boldSystemFontOfSize:15];
			//lblSportsEventName.textColor =textcolorNew; // [UIColor whiteColor];
			[cell.contentView addSubview:lblSportsEventName];
			
		}
        
        else if ([categoryStr isEqualToString:@"What's On Tonight..."]||([categoryStr isEqualToString:@"What's On Next 7 Days"])){
            
            if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7daysSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else{
                arr=[[SaveTonightAnd7DaysInfo GetTonightSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            if(issportsEvent==YES) {
                
                lblSportsEventName.text =[NSString stringWithFormat:@"Type:                       %@ ",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Type"]];
                
                lblSportsEventType.text =@"SportEvent Name:";
                
                lblSportsEventTypeName.text=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sport_EventName"];
                
                
                lblSportsEventScreen.text =[NSString stringWithFormat:@"Channel:                 %@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Channel"]];
                
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                //[dateFormat setLocale:[NSLocale currentLocale]];
                NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sport_Date"]]];
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eee dd MMMM"];
                
                NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
                //[dateFormat release];
                
                
                
                [dateFormat release];
                [dateFormat2 release];
                
                
                
                lblSportsSound.text =[NSString stringWithFormat:@"Date and Time:       %@ At %@",dateString,[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Time"]];
                
                lblSportsEventHD.text = [NSString stringWithFormat:@"Screen:                   %@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Screen"]];
                
                lblSportsEventDate.text = [NSString stringWithFormat:@"Sound:                    %@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sound"]];
                
                lblSportsEventChannel.text = [NSString stringWithFormat:@"HD:                         %@",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"HD"]];
                
                lblSportsEvent3D.text = [NSString stringWithFormat:@"3D:                          %@ ",[[arr objectAtIndex:indexPath.row-1]valueForKey:@"ThreeD"]];         
                
                
                
                
                [cell.contentView addSubview:lblSportsEventName];
                [cell.contentView addSubview:lblSportsEventType];
                [cell.contentView addSubview:lblSportsEventScreen];
                [cell.contentView addSubview:lblSportsSound];	
                [cell.contentView addSubview:lblSportsEventHD];
                [cell.contentView addSubview:lblSportsEventDate];
                [cell.contentView addSubview:lblSportsEventChannel];
                [cell.contentView addSubview:lblSportsEvent3D];
                [cell.contentView addSubview:lblSportsEventTypeName];
                // [cell.contentView addSubview:vw2];
                
                [lblSportsEventName release];
                [lblSportsEventType release];
                [lblSportsEventScreen release];
                [lblSportsEventHD release];
                [lblSportsEventDate release];
                [lblSportsEventChannel release];
                [lblSportsSound release];
                [lblSportsEvent3D release];
                
            }
            
            
            if (indexPath.row!=0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        
        
        
        
        
        
        
        
		else if(issportsEvent==YES) {
			//NSLog(@"%@",arr);
            
            lblSportsEventName.text =[NSString stringWithFormat:@"Type:                       %@ ",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Type"]];
            
            lblSportsEventType.text =@"SportEvent Name:";
            
            lblSportsEventTypeName.text=[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"eventName"];
            
            
            lblSportsEventScreen.text =[NSString stringWithFormat:@"Channel:                 %@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Channel"]];
            
            NSLog(@"DATEEEEEEEEEEEEEEEEEEEEEEEEEEE     %@",[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Date Show"]]);
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            //[dateFormat setLocale:[NSLocale currentLocale]];
            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Date Show"]]];
            
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"eee dd MMMM"];
            
            NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
            //[dateFormat release];
            
            
            
            [dateFormat release];
            [dateFormat2 release];
            
            
            
            lblSportsSound.text =[NSString stringWithFormat:@"Date and Time:       %@ At %@",dateString,[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Time Show"]];
            
            lblSportsEventHD.text = [NSString stringWithFormat:@"Screen:                   %@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Screen"]];
            
            lblSportsEventDate.text = [NSString stringWithFormat:@"Sound:                    %@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Sound"]];
            
            lblSportsEventChannel.text = [NSString stringWithFormat:@"HD:                         %@",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"HD"]];
            
            lblSportsEvent3D.text = [NSString stringWithFormat:@"3D:                          %@ ",[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"threeD"]];         
            
            
            
            
            [cell.contentView addSubview:lblSportsEventName];
            [cell.contentView addSubview:lblSportsEventType];
            [cell.contentView addSubview:lblSportsEventScreen];
            [cell.contentView addSubview:lblSportsSound];	
            [cell.contentView addSubview:lblSportsEventHD];
            [cell.contentView addSubview:lblSportsEventDate];
            [cell.contentView addSubview:lblSportsEventChannel];
            [cell.contentView addSubview:lblSportsEvent3D];
            [cell.contentView addSubview:lblSportsEventTypeName];
            // [cell.contentView addSubview:vw2];
            
            [lblSportsEventName release];
            [lblSportsEventType release];
            [lblSportsEventScreen release];
            [lblSportsEventHD release];
            [lblSportsEventDate release];
            [lblSportsEventChannel release];
            [lblSportsSound release];
            [lblSportsEvent3D release];
            
        }
        
        
        if (indexPath.row!=0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
    }
    
    
    
	
    
    if(((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Food Details"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Food Details"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Food Details"]))||((indexPath.section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Food Details"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Food Details"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Food Details"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Food Details"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Food Details"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Food Details"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Food Details"]))){
        
        
        
		UILabel *lblFoodName= [Design LabelFormation:35 :5 :250 :20 :0];
		if(indexPath.row==0) {	
            UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			if(!isImagesExpanded)
                img=[UIImage imageNamed:@"ArrowDeselect.png"];
            else
                img=[UIImage imageNamed:@"ArrowDeselect.png"];			
            imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
            
            
            lblFoodName.text = @"Food Details";
            lblFoodName.font = [UIFont boldSystemFontOfSize:15];
            // lblFoodName.textColor =textcolorNew;//[UIColor whiteColor];
		}
		
        // cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
		[cell.contentView addSubview:lblFoodName];
		[lblFoodName release];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
	}
    
    
	if(((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Photos"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Photos"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Photos"]))||((indexPath.section==11)&&([[Array_section objectAtIndex:11]isEqualToString:@"Photos"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Photos"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Photos"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Photos"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Photos"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Photos"]))||((indexPath.section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Photos"]))){ 
		
		
		UILabel *lblImage = [Design LabelFormation:10 :5 :200 :20 :0];
		
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			if(!isImagesExpanded)
                img=[UIImage imageNamed:@"ArrowDeselect.png"];
            else
                img=[UIImage imageNamed:@"ArrowDeselect.png"];			
            imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			UILabel *lblImage1 = [Design LabelFormation:35 :5 :100 :20 :0];
			lblImage1.text = @"Photos";
			lblImage1.font = [UIFont boldSystemFontOfSize:15];
			//lblImage.textColor =textcolorNew;//[UIColor whiteColor];
            [cell addSubview:lblImage1];  
        }
		else if(isImagesExpanded==YES) {
            
            if (indexPath.row==1){
                lblImage.text = @"General Images";
                
            }
            else if (indexPath.row==2){
                lblImage.text = @"Function Room Images";
                
            }
            else if (indexPath.row==3){
                lblImage.text = @"Food Drink Images";
                
            }
            
            [cell.contentView addSubview:lblImage];
            
            
            [lblImage release];
        }
        if(indexPath.row>0)
        {
            cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        }
	}
    cell.backgroundColor=[UIColor clearColor];
    //cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;	
    
   	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IsSelect=YES;  
    section_value=indexPath.section;
    if(indexPath.row==0 ){
        
        NSLog(@"%d",indexPath.section);
        if((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Regular Event"])){
            
            if(indexPath.row==0)
            {
                
                [tableView cellForRowAtIndexPath:indexPath].backgroundView.backgroundColor=[UIColor darkGrayColor];
                
                NSLog(@"%d %@",indexPath.row,[tableView cellForRowAtIndexPath:indexPath]);
                
                if (isRegularEventExit==NO) {
                    
                    [self PrepareArrayList:0];
                }
                
            }
        }
        else if(((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"General"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"General"])))
        {
            
            if(indexPath.row==0)
                [tableView cellForRowAtIndexPath:indexPath].backgroundView.backgroundColor=[UIColor darkGrayColor];
            NSLog(@"%d %@",indexPath.row,[tableView cellForRowAtIndexPath:indexPath]);
            
            if(app.IsNonsubscribed==NO){
                [self PrepareArrayList:1];
            }
            
        }
        else if(((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Opening Hours"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Opening Hours"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Opening Hours"]))){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:2];
            
            
        }
        else  if(((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Other Details"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Other Details"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Other Details"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Other Details"]))){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:3];
        }
        else  if(((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Bullet Points"]))){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isPubBulletsExpandedExit==NO){
                [self PrepareArrayList:4];
            }
        }
        else  if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Description"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Description"]))){
            
            
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:5];
            
        }
        else if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"One off Event"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"One off Event"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"One off Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"One off Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"One off Event"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"One off Event"]))){
            
            
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isOneOffEventexit==NO){
                [self PrepareArrayList:6];
            }
            
        }
        else if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Theme Night"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Theme Night"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Theme Night"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Theme Night"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Theme Night"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Theme Night"]))){
            
            
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isThemeNightExit==NO){
                [self PrepareArrayList:7];
            }
            
        }
        else if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Description"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Description"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Description"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Sports Description"]))){
            
            if(indexPath.row==0)
                
                NSLog(@"%d",indexPath.row);
            if(isSportsDetailsExit==NO){
                [self PrepareArrayList:8];
            }
            
        }
        else if(((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Event"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Sports Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Event"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Event"]))|((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Event"]))){
            
            
            
            if(indexPath.row==0)
                
                NSLog(@"%d",indexPath.row);
            if(issportsEventExit==NO){
                [self PrepareArrayList:9];
            }
            
        }
        else if(((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Food Details"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Food Details"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Food Details"]))||((indexPath.section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Food Details"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Food Details"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Food Details"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Food Details"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Food Details"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Food Details"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Food Details"]))){
            
            
            
            
            if(indexPath.row==0){
                
                
                NSLog(@"%d",indexPath.row);
                [self PrepareArrayList:10];
                NSMutableArray *tempArray = [[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pub_ID intValue]] retain];
                if ([tempArray count] != 0) {
                    
                    FoodDetails_Microsite *obj_FoodDetails_Microsite=[[FoodDetails_Microsite alloc]initWithNibName:[Constant GetNibName:@"FoodDetails_Microsite"] bundle:[NSBundle mainBundle]];
                    obj_FoodDetails_Microsite.category_Str=categoryStr;
                    obj_FoodDetails_Microsite.header_DictionaryData=headerDictionaryData;
                    obj_FoodDetails_Microsite.Pubid=Pub_ID;
                    //obj_FoodDetails_Microsite.btn_Venu.hidden=YES;
                    app.Isvenue=YES;
                    
                    [self.navigationController pushViewController:obj_FoodDetails_Microsite animated:YES];
                    [obj_FoodDetails_Microsite release];
                }
                else{
                    UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub & Bar Network" message:@"Food information not availbale." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [altview show];
                    [altview release];
                }                
                
            }
        }
        
        else if(((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Photos"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Photos"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Photos"]))||((indexPath.section==11)&&([[Array_section objectAtIndex:11]isEqualToString:@"Photos"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Photos"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Photos"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Photos"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Photos"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Photos"]))||((indexPath.section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Photos"]))){
            
            if(indexPath.row==0) {
                [self PrepareArrayList:11];
                
                my_table.contentOffset=CGPointMake(0, 410);
                
                
            }
            
            
        }  
        
        
    }
	else
    {
        if(((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Event"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Sports Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Event"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Event"]))|((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Event"]))){
            
            
            
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||[categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                Sport_Microsite *obj_Sport_Microsite=[[Sport_Microsite alloc]initWithNibName:[Constant GetNibName:@"Sport_Microsite"] bundle:[NSBundle mainBundle]];
                obj_Sport_Microsite.sporeid=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sport_EventID"];
                obj_Sport_Microsite.event_type=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sport_EventID"];//EventId;
                obj_Sport_Microsite.sport_ID=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Sport_ID"];
                
                obj_Sport_Microsite.Pub_ID=Pub_ID;
                obj_Sport_Microsite.category_Str=categoryStr;
                obj_Sport_Microsite.header_DictionaryData=headerDictionaryData;
                [self.navigationController pushViewController:obj_Sport_Microsite animated:YES];
                [obj_Sport_Microsite release];
                
            }
            else{
                
                
                Sport_Microsite *obj_Sport_Microsite=[[Sport_Microsite alloc]initWithNibName:[Constant GetNibName:@"Sport_Microsite"] bundle:[NSBundle mainBundle]];
                //obj_Sport_Microsite.event_type=[arr objectAtIndex:indexPath.row-1];
                
                
                NSMutableDictionary *tempDic;// = [[NSMutableDictionary alloc] init];
                tempDic = [[arrSubMain objectAtIndex:indexPath.row-1]retain];
                obj_Sport_Microsite.sportEventDic=tempDic;
                NSLog(@"%@",sportEventDic);
                obj_Sport_Microsite.category_Str=categoryStr;
                obj_Sport_Microsite.event_type=[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"event ID"];
                obj_Sport_Microsite.Pub_ID=Pub_ID;
                obj_Sport_Microsite.header_DictionaryData=headerDictionaryData;
                
                [self.navigationController pushViewController:obj_Sport_Microsite animated:YES];
                [obj_Sport_Microsite release];
            }
            
            
        }
        else if(((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Regular Event"]))|| ((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"One off Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Theme Night"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"One off Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"One off Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"One off Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"One off Event"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"One off Event"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Theme Night"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Theme Night"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Theme Night"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Theme Night"])))
            
        {
            
            
            
            
            Event_Microsite *obj_Event_Microsite = [[Event_Microsite alloc]initWithNibName:[Constant GetNibName:@"Event_Microsite"] bundle:[NSBundle mainBundle]];
            
            
            
            
            
            
            obj_Event_Microsite.header_DictionaryData=headerDictionaryData;
            
            obj_Event_Microsite.Pub_ID=Pub_ID;
            obj_Event_Microsite.event_type = EventId;
            obj_Event_Microsite.category_Str=categoryStr;
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]||[categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                obj_Event_Microsite._ID=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"ID"];
                obj_Event_Microsite.EventDay=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"EventDay"];
                obj_Event_Microsite.eventDesc=[[arr objectAtIndex:indexPath.row-1]valueForKey:@"Event_Description"];
                
            }
            else
            {
                obj_Event_Microsite._ID=[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"ID"];
                obj_Event_Microsite.EventDay=[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Day"];
                obj_Event_Microsite.eventDesc=[[arrSubMain objectAtIndex:indexPath.row-1]valueForKey:@"Event Description"];
            }
            
            
            obj_Event_Microsite.OpenDayArray=OpenDayArray;
            obj_Event_Microsite.OpenHourArray=OpenHourArray;
            obj_Event_Microsite.bulletPointArray=bulletPointArray;
            
            obj_Event_Microsite.arrMain=[[SavePubDetailsInfo GetEvent_DetailsInfo:[obj_Event_Microsite.Pub_ID intValue] event_ID:[obj_Event_Microsite._ID intValue]]retain];
            
            if ([obj_Event_Microsite.arrMain count]==0) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No data found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
            else{
                
                [self.navigationController pushViewController:obj_Event_Microsite animated:YES];
                [obj_Event_Microsite release];
            }   
        }
        
        else if(((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Photos"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Photos"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Photos"]))||((indexPath.section==11)&&([[Array_section objectAtIndex:11]isEqualToString:@"Photos"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Photos"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Photos"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Photos"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Photos"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Photos"]))||((indexPath.section==10)&&([[Array_section objectAtIndex:10]isEqualToString:@"Photos"]))){
            
            if(indexPath.row==1){
                ImagesList *objImagesList=[[ImagesList alloc]initWithNibName:[Constant GetNibName:@"ImagesList"] bundle:[NSBundle mainBundle]];
                
                objImagesList.arrImage=[[SavePubDetailsInfo GetPhotoGalaryInfo:[Pub_ID intValue]]retain];
                
                if([objImagesList.arrImage count]>0)	
                    [self.navigationController pushViewController:objImagesList animated:YES];
                else
                {
                    UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Sorry, licensee has not uploaded any images of their venue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [altview show];
                    [altview release];
                }
                
                [objImagesList release];
            }
            
            else if(indexPath.row==2){
                ImagesList *objImagesList=[[ImagesList alloc]initWithNibName:[Constant GetNibName:@"ImagesList"] bundle:[NSBundle mainBundle]];
                
                objImagesList.arrImage=[[SavePubDetailsInfo GetFunctionRoomImagesInfo:[Pub_ID intValue]]retain];
                
                if([objImagesList.arrImage count]>0)	
                    [self.navigationController pushViewController:objImagesList animated:YES];
                else
                {
                    UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Sorry, licensee has not uploaded any images of their venue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [altview show];
                    [altview release];
                }
                
                [objImagesList release];
            }
            
            else{
                ImagesList *objImagesList=[[ImagesList alloc]initWithNibName:[Constant GetNibName:@"ImagesList"] bundle:[NSBundle mainBundle]];
                
                objImagesList.arrImage=[[SavePubDetailsInfo GetFoodDrinkImagesInfo:[Pub_ID intValue]]retain];
                
                if([objImagesList.arrImage count]>0)	
                    [self.navigationController pushViewController:objImagesList animated:YES];
                else
                {
                    UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Sorry, licensee has not uploaded any images of their venue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [altview show];
                    [altview release];
                }
                
                [objImagesList release];
                
                
            }
            
            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
	
	if(indexPath.row==0)
		return 35;
	else{
        
		
        if(((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Bullet Points"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Bullet Points"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Bullet Points"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Bullet Points"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Bullet Points"]))){
            
			return 50;
        }
        
        else if(((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Regular Event"]))|| ((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"One off Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Theme Night"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"One off Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"One off Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"One off Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"One off Event"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"One off Event"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Theme Night"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Theme Night"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Theme Night"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Theme Night"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Theme Night"])))
            
            return 100;
        
		else if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Description"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Description"])))
            
            
			return 90;
		
        else if(((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Description"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Description"]))||((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Description"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Description"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Description"]))||((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Description"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Description"]))||((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"Sports Description"])))
			return 100;
        
		else if(((indexPath.section==6)&&([[Array_section objectAtIndex:6]isEqualToString:@"Sports Event"]))||((indexPath.section==9)&&([[Array_section objectAtIndex:9]isEqualToString:@"Sports Event"]))||((indexPath.section==7)&&([[Array_section objectAtIndex:7]isEqualToString:@"Sports Event"]))||((indexPath.section==8)&&([[Array_section objectAtIndex:8]isEqualToString:@"Sports Event"]))||((indexPath.section==5)&&([[Array_section objectAtIndex:5]isEqualToString:@"Sports Event"]))||((indexPath.section==4)&&([[Array_section objectAtIndex:4]isEqualToString:@"Sports Event"]))|((indexPath.section==3)&&([[Array_section objectAtIndex:3]isEqualToString:@"Sports Event"]))||((indexPath.section==2)&&([[Array_section objectAtIndex:2]isEqualToString:@"Sports Event"])))
            
            
            return 190;
        
        else if(((indexPath.section==1)&&([[Array_section objectAtIndex:1]isEqualToString:@"General"]))||((indexPath.section==0)&&([[Array_section objectAtIndex:0]isEqualToString:@"General"]))){
            
            
            if(app.IsNonsubscribed==NO){
                
                
                array=[[NSMutableArray alloc]initWithObjects:@"Name:",@"District:",@"City:",@"Postcode:",@"Phone No:",@"Mobile:",@"WebSite:",@"Pub Company:",@"Address:", nil];  
                
                [arr removeAllObjects];
                [arrMain removeAllObjects];
                
                arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
                
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
                [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
                
                NSMutableArray *temp_array1=[arrMain copy];
                
                for (int i=0; i<[temp_array1 count]; i++) {
                    if ([[temp_array1 objectAtIndex:i]isEqualToString:@"Not Available"]||[[temp_array1 objectAtIndex:i]isEqualToString:@"No Info"]|| [[temp_array1 objectAtIndex:i]isEqualToString:@""]) {
                        [arrMain replaceObjectAtIndex:i withObject:@" "];
                        [array replaceObjectAtIndex:i withObject:@" "];
                        
                    }
                }
                
                [arrMain removeObjectIdenticalTo:@" "];
                [array removeObjectIdenticalTo:@" "];
                
                
                if([[array objectAtIndex:indexPath.row-1]isEqualToString:@"Address:"]){
                    
                    
                    return 75;
                }
                else
                    return 45;
            }
            if(indexPath.row==3)
                return 75;
            
            
            
            
            else  if(app.IsNonsubscribed==YES){
                if(indexPath.row==3){
                    
                    return 75;
                }
                else
                    return 45;
            }
            else
            {
                return 45;
            }
        }
        
        else
			return 45;
        
        
        
    }
}

-(void)PrepareArrayList:(int)Selection
{
    // [arrMain removeAllObjects];
    switch (Selection) {
            //			
        case 0:
            // isregularEvent = YES;
            
            // arr=[[SavePubDetailsInfo GetEvent_DetailsInfo:[Pub_ID intValue] EventType:[event_type intValue]event_ID:[_ID intValue] ]retain];
            
            [arr removeAllObjects];
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]){
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysRegularEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            else
            {
                arr=[[SaveEventMicrositeInfo GetEvent_DetailsInfo:[Pub_ID intValue] EventType:[event_type intValue] ]retain];
            }
            
            if(isregularEvent==YES){
                isregularEvent=NO;
                
                
            }
            else{
                isregularEvent=YES;
            }
            
            
            /*  isFoodDetail=NO;
             isGeneralExpanded=NO;
             isOpeningHr=NO;
             isOtherDetails=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isImagesExpanded=NO;*/
            break;
            
        case 1:
            
            
            
            if(isGeneralExpanded==YES){
                isGeneralExpanded=NO;
                
                
            }
            else{
                isGeneralExpanded=YES;
            }
            
            [arrMain removeAllObjects];
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
            
            
            [arr removeAllObjects];
            
            /*    isFoodDetail=NO;
             isregularEvent=NO;
             isOpeningHr=NO;
             isOtherDetails=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isImagesExpanded=NO;*/
            break;
            
        case 2:
            // isOpeningHr =YES;
            
            if(isOpeningHr==YES){
                isOpeningHr=NO;
                
                
            }
            else{
                isOpeningHr=YES;
            }
            
            
            /*   [arrMain removeAllObjects];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];
             [arrMain addObject:@"TEST_Address"];  */
            
            
            /*    isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO;   */     
            break;
            
        case 3:
            // isOtherDetails=YES;
            
            if(isOtherDetails==YES){
                isOtherDetails=NO;
                
            }
            else{
                isOtherDetails=YES;
            }
            
            
            [arrMain removeAllObjects];
            
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
            
            /*   isregularEvent=NO;
             isGeneralExpanded=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO;  */ 
            break;
            
        case 4:
            //  isPubBulletsExpanded = YES;
            
            if(isPubBulletsExpanded==YES){
                isPubBulletsExpanded=NO;
                
            }
            else{
                isPubBulletsExpanded=YES;
            }
            
            /*    [arrMain removeAllObjects];
             [arrMain addObject:@"TEST_PhoneNumber"];
             [arrMain addObject:@"TEST_NameLastName"];
             [arrMain addObject:@"TEST_NameLastName"];*/
            
            /*   isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO;   */
            break;
            
        case 5:
            //isDescriptionExpanded= YES;
            
            if(isDescriptionExpanded==YES){
                isDescriptionExpanded=NO;
                
            }
            else{
                isDescriptionExpanded=YES;
            }
            
            [arrMain removeAllObjects];
            arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]]retain];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDescription"]];
            [arr removeAllObjects];
            
            /*     isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO;   */
            
            
            break;
            
        case 6:
            
            if(isoneoffEvent==YES){
                isoneoffEvent=NO;
                
            }
            else{
                isoneoffEvent=YES;
            }
            
            
            /* if (isOneOffEventexit==NO) {
             
             isoneoffEvent = YES;
             }*/
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]){
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysOneOffEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            else{
                
                arr=[[SaveEventMicrositeInfo GetEvent_DetailsInfo:[Pub_ID intValue] EventType:[event_type intValue] ]retain];
            }
            
            NSLog(@"%d",[arr count]);
            
            /*   isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO;
             //isoneoffEvent=YES;*/
            break;
            
            
        case 7:
            
            if(isthemenightEvent==YES){
                isthemenightEvent=NO;
                
            }
            else{
                isthemenightEvent=YES;
            }
            
            /*  if(isthemenightEvent==NO){
             isthemenightEvent = YES;
             }*/
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]){
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7DaysThemeNightEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            else{
                
                
                arr=[[SaveEventMicrositeInfo GetEvent_DetailsInfo:[Pub_ID intValue] EventType:[event_type intValue] ]retain];
            }
            
            
            /*  isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO; */
            break;
            
        case 8:
            // isSportsDetails = YES;
            
            if(isSportsDetails==YES){
                isSportsDetails=NO;
                
            }
            else{
                isSportsDetails=YES;
            }
            
            [arrMain removeAllObjects];
            //   arr=[[SaveSportDetailInfo GetSport_EventInfo_Details:[Pub_ID intValue]Sport_EventID:[sporeid intValue]_id:[Sport_Evnt_id intValue]]retain];
            
            /* if ([categoryStr isEqualToString:@"What's On Tonight..."]){
             
             arr=[[SaveTonightAnd7DaysInfo GetTonightSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
             }
             else{
             
             */
            
            
            //  arr=[[SaveSportMicrositeInfo GetSport_EventInfo_Details:[Pub_ID intValue] Sport_EventID:[sporeid intValue] currentDate:current_date]retain];
            
            
            //  }
            
            
            
            /*    isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             issportsEvent=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO; */
            
            break;
            
        case 9:
            
            
            //issportsEvent = YES;
            
            if(issportsEvent==YES){
                issportsEvent=NO;
                
            }
            else{
                issportsEvent=YES;
            }
            
            [arrMain removeAllObjects];
            // arr=[[SaveSportDetailInfo GetSport_EventInfo_Details:[Pub_ID intValue]Sport_EventID:[sporeid intValue]_id:[Sport_Evnt_id intValue]]retain];
            
            [arr removeAllObjects];
            
            
            if ([categoryStr isEqualToString:@"What's On Tonight..."]){
                
                arr=[[SaveTonightAnd7DaysInfo GetTonightSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            else if ([categoryStr isEqualToString:@"What's On Next 7 Days"]){
                
                arr=[[SaveTonightAnd7DaysInfo GetNext7daysSportEvent_DetailsInfo:[Pub_ID intValue]] retain];
            }
            
            
            //  else{
            
            
            // arr=[[SaveSportMicrositeInfo GetSport_EventInfo_Details:[Pub_ID intValue] Sport_EventID:[sporeid intValue] currentDate:current_date]retain];
            
            //  }
            
            /*   isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             isFoodDetail=NO;
             isImagesExpanded=NO; */
            
            
            break;
            
            
        case 10:
            isFoodDetail = NO;
            [arrMain removeAllObjects];
            
            /*   isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isImagesExpanded=NO; */
            
            break;
            
        case 11:
            //isImagesExpanded = YES;
            
            if(isImagesExpanded==YES){
                isImagesExpanded=NO;
                
            }
            else{
                isImagesExpanded=YES;
            }
            
            
            
            
            /*  isregularEvent=NO;
             isGeneralExpanded=NO;
             isOtherDetails=NO;
             isOpeningHr=NO;
             isPubBulletsExpanded=NO;
             isDescriptionExpanded=NO;
             isoneoffEvent=NO;
             isthemenightEvent=NO;
             isSportsDetails=NO;
             issportsEvent=NO;
             isFoodDetail=NO; */
            
            break;
            
            
        default:
            break;
    }
    [my_table reloadData];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //self.table = nil;
}

-(void)dealloc{
    [arrSubMain release];
    [arrMain release];
    [Array_section release];
    //[arr release];
    [my_table release];
    [Array release];
    [toolBar release];
    [headerDictionaryData release];
    [OpenDayArray release];
    [OpenHourArray release];
    [array release];
    //[str_mobile release];
    //[str_mail release];
    [super dealloc];
    
}
@end

