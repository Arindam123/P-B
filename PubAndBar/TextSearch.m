//
//  TextSearch.m
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "TextSearch.h"
#import "SaveTextSearchInfo.h"
#import "AsyncImageView.h"
#import "Global.h"
#import "PubDetail.h"
#import "ServerConnection.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "InternetValidation.h"

#import "SportDetail.h"
#import "Catagory.h"
#import "PubList.h"
#import "AmenitiesDetails.h"
#import "RealAleDetail.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"

@implementation TextSearch
@synthesize backButton;
@synthesize lblheading;
@synthesize searchbar;
@synthesize txtvw;
@synthesize vw;
@synthesize vw_textfield;
@synthesize resultvw;
@synthesize scrvw;
@synthesize oAuthLoginView;

@synthesize hud = _hud;

BOOL _IsSelect;
int j;

UIInterfaceOrientation orientation;
NSString *category_str;

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
    self.eventTextLbl.text=[NSString stringWithFormat:@"Search"];
    
    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    array=[[NSMutableArray  alloc]init];
    
    [self CreateView];
    
    
}

-(IBAction)List_btnClick:(id)sender{
    
    segmentedControl.hidden=NO;
    searchbar.hidden=NO;
    searchTable.hidden = NO;
    vw_textfield.hidden=NO;
    obj_nearbymap.hidden = YES;
    _IsSelect=NO;
    lblheading.hidden=NO;
    
    /*   if([pub_list count] == [PubArray count]){
     venu_btn.hidden=YES;
     } 
     else
     venu_btn.hidden=NO;
     */
    
    if ([Constant isiPad]) {
        ;
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
            map_btn.frame=CGRectMake(427, 80, 47, 26);        }
    }
    
}


-(IBAction)Map_btnClick:(id)sender{
    searchbar.hidden=YES;
    searchTable.hidden = YES;
    vw_textfield.hidden=YES;
    obj_nearbymap.hidden = NO;
    segmentedControl.hidden=YES;
    lblheading.hidden=YES;
    
    // venu_btn.hidden=NO;
    _IsSelect=YES;
    [self callingMapview];
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
            [obj_nearbymap setFrameOfView:CGRectMake(10, 115, 460, 142)];
            
        }
    } 
}
-(void)callingMapview{
    
    
    if (obj_nearbymap) {
        
        [obj_nearbymap removeFromSuperview];
        [obj_nearbymap release];
    }
    
    mapArray = [[NSMutableArray alloc] init];
    [mapArray removeAllObjects];
    
    for (id result in array) {
        
        [mapArray addObject:result];
    }
    
    
    
    obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(10, 124, 300, 292) withArray:mapArray withController:self];
    [self.view addSubview:obj_nearbymap];
    if (_IsSelect==NO)
    {
        obj_nearbymap.hidden=YES;
    }
    else
        obj_nearbymap.hidden=NO;
    
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
    
}
-(void)viewWillAppear:(BOOL)animated{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    obj_nearbymap = [[NearByMap alloc] initWithFrame:CGRectMake(10, 75, 300, 280) withArray:mapArray];
    //    [self.view addSubview:obj_nearbymap];
    [super viewWillAppear:animated];
    [self AddNotification];
    
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        //seg_control.selectedSegmentIndex =0;
        _IsSelect=NO;
        segmentedControl.hidden=NO;
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
        
        searchTable.hidden=NO;
        searchbar.hidden=NO;
        vw_textfield.hidden=NO;
        lblheading.hidden=NO;
        obj_nearbymap.hidden=YES;
    }
    else
    {
        //seg_control.selectedSegmentIndex =1;
        _IsSelect=YES;
        segmentedControl.hidden=YES;
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
        
        searchTable.hidden=YES;
        searchbar.hidden=YES;
        vw_textfield.hidden=YES;
        lblheading.hidden=YES;
        
        obj_nearbymap.hidden=NO;
        //venu_btn.hidden=YES;
    }
    
    [self setViewFrame];
    
}


#pragma mark- 
#pragma mark- CreateView
-(void)CreateView{
    
    
    obj_nearbymap = [[NearByMap alloc] initWithFrame:CGRectMake(10, 75, 300, 283) withArray:mapArray withController:self];
    [self.view addSubview:obj_nearbymap];
    
    
    scrvw = [[UIScrollView alloc]init];
    [scrvw setShowsVerticalScrollIndicator:NO];
    scrvw.contentSize = CGSizeMake(320, 280);
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    lblheading = [[UILabel alloc]init];
    lblheading.text = @"SEARCH";
    lblheading.backgroundColor = [UIColor clearColor];
    lblheading.textColor = [UIColor whiteColor];
    lblheading.font = [UIFont systemFontOfSize:13];
    
    vw_textfield = [[UIView alloc]init];
    vw_textfield.backgroundColor = [UIColor whiteColor];
    vw_textfield.layer.cornerRadius = 6.0f;
    
    searchbar = [[UITextField alloc]init];
    //  searchbar.frame = CGRectMake(73, 7, 180, 18);
    //searchbar.placeholder = @"Search By Venue,City,Postcode";
    searchbar.font = [UIFont systemFontOfSize:14];
    searchbar.delegate = self;
    searchbar.returnKeyType = UIReturnKeyGo;
    searchbar.backgroundColor=[UIColor yellowColor];
    
    resultvw = [[UITextView alloc]init];
    resultvw.backgroundColor = [UIColor clearColor];
    resultvw.text = @"RESULTS SHOULD APPEAR HERE";
    
    resultvw.delegate = self;
    resultvw.textColor = [UIColor whiteColor];
    resultvw.layer.borderWidth = 1.0f;
    resultvw.font = [UIFont systemFontOfSize:8];
    resultvw.layer.borderColor = [[UIColor colorWithRed:30.2/255.0 green:56.5/255.0 blue:99.6/255.0 alpha:1]CGColor];
    
    vw = [[UIView alloc]init];
    vw.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    
    searchTable = [[UITableView alloc]init];
    searchTable.delegate=self;
    searchTable.dataSource=self;
    searchTable.scrollEnabled=YES;
    searchTable.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    searchTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    searchTable.layer.cornerRadius = 5.0;
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Venue", @"City",@"Postcode",nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex =0;
    searchbar.placeholder=@"Venue";
    [segmentedControl setWidth:73 forSegmentAtIndex:0];
    [segmentedControl setWidth:73 forSegmentAtIndex:1];
    [segmentedControl setWidth:73 forSegmentAtIndex:2];
    
    
    [segmentedControl addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    
    
    array4NonSubPubs = [[NSMutableArray alloc] init];
    list_btn=[[UIButton alloc]init];
    [list_btn addTarget:self action:@selector(List_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    map_btn=[[UIButton alloc]init];
    [map_btn addTarget:self action:@selector(Map_btnClick:) forControlEvents:UIControlEventTouchUpInside]; 
    
    
    [self.view addSubview:list_btn];
    [self.view addSubview:map_btn];
    //[btn_view release];
    [list_btn release];
    [map_btn release];
    
    
    [self setViewFrame];
    
    [self.view addSubview:backButton];
    [self.view addSubview:lblheading];
    [self.view addSubview:vw];
    [self.view addSubview:vw_textfield];
    [vw_textfield addSubview:searchbar];
    
    [self.view addSubview:searchTable];
    //  [self.view addSubview:lbl_venueName];
    //  [self.view addSubview:lbl_distance];
    
    [self.view addSubview:segmentedControl];
    [segmentedControl release]; 
    [lblheading release];
    [vw release];
    [searchbar release];
    [resultvw release];
    [vw_textfield release];
    [scrvw release];
    
    [searchTable release];
    [lbl_distance release];
    [lbl_venueName release];
}
- (IBAction)segmentSwitch:(id)sender 
{
    segmentedControl = (UISegmentedControl *) sender;
    
    if(segmentedControl.selectedSegmentIndex ==0)
    {
        j=0;
        [array removeAllObjects];
        [searchTable reloadData];
        searchbar.text=Nil;
        
        searchbar.placeholder=@"Venue";
    }
    else if(segmentedControl.selectedSegmentIndex == 1)
    {
        j=1;
        [array removeAllObjects];
        [searchTable reloadData];
        searchbar.text=Nil;
        searchbar.placeholder=@"City";
    }
    else
    {
        j=2;
        [array removeAllObjects];
        [searchTable reloadData];
        searchbar.text=Nil;
        
        searchbar.placeholder=@"Postcode"; 
    }
}


#pragma mark- 
#pragma mark- tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"%d",[array count]);
    return [array count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger DISTANCE_LABEL_TAG = 1002;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    const NSInteger NEXT_IMG_TAG = 1005;
    
	UILabel *topLabel;
    UILabel *distanceLabel;
    UIView *backVw;
    UIImageView *nextImg;
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
		backVw = [[[UIView alloc]init]autorelease];
        backVw.frame =CGRectMake(4, 4, 314, 40);
        backVw.tag = MAINVIEW_VIEW_TAG;
        backVw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        backVw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:backVw];
        
		topLabel=[[[UILabel alloc]initWithFrame:CGRectMake(8,0,170,37)]autorelease];
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:12];
        topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        [backVw addSubview:topLabel];
        
        distanceLabel=[[[UILabel alloc]initWithFrame:CGRectMake(205,0,90,37)]autorelease];
		distanceLabel.tag = DISTANCE_LABEL_TAG;
		distanceLabel.backgroundColor = [UIColor clearColor];
		distanceLabel.textColor = [UIColor whiteColor];
		distanceLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		distanceLabel.font = [UIFont boldSystemFontOfSize:10];
        distanceLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        [backVw addSubview:distanceLabel];
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(296, 14, 11, 11)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.contentMode = UIViewContentModeScaleAspectFit;
        nextImg.image=[UIImage imageNamed:@"HistoryArrow.png"];
        [backVw addSubview:nextImg];
        
        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        distanceLabel = (UILabel *)[cell viewWithTag:DISTANCE_LABEL_TAG];
        backVw=(UIView*)[cell viewWithTag:MAINVIEW_VIEW_TAG];
        nextImg = (UIImageView *)[cell.contentView viewWithTag:NEXT_IMG_TAG];
        
	}
    @try {
        topLabel.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Name"];
        if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
            distanceLabel.text = [NSString stringWithFormat: @"%d KM",(int)floor([[[array objectAtIndex:indexPath.row] valueForKey:@"PubDistance"] doubleValue])];
        else
            // extremelbl.text=[NSString stringWithFormat:@"%d",(int)[[[[_pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192]];
            distanceLabel.text=[NSString stringWithFormat:@"%d Miles",(int)floor([[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
        
        //distanceLabel.text = [[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance"];
        
        
        //---------------------------------------------//
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([category_str isEqualToString:@"PubName"]) {
        if ([[appDelegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"ID"]]])
        {
            [self afterSuccessfulConnection:[[appDelegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"ID"]]]];
        }
        else
        {
            [self performSelector:@selector(addMBHud)];
            [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
        }
        
    }
    /* else if([category_str isEqualToString:@"Sports on TV"]){
     
     // vw.backgroundColor=[UIColor redColor];
     
     
     SportDetail *obj_sportdetail = [[SportDetail alloc]initWithNibName:[Constant GetNibName:@"SportDetail"] bundle:[NSBundle mainBundle]];  
     //   obj_sportdetail.searchRadius = searchRadius;
     obj_sportdetail.sportID = [[array objectAtIndex:indexPath.row]valueForKey:@"ID"];
     obj_sportdetail.sport_name=@"Sports on TV";
     obj_sportdetail.str_title=[[array objectAtIndex:indexPath.row] valueForKey:@"Name"];
     
     [self.navigationController pushViewController:obj_sportdetail animated:YES];
     [obj_sportdetail release];
     
     }
     else if([category_str isEqualToString:@"Events"])
     {
     
     Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
     obj_catagory.Name = [[array objectAtIndex:indexPath.row] valueForKey:@"Name"];
     obj_catagory.Event_page=@"Events";
     
     obj_catagory.eventID = [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     [self.navigationController pushViewController:obj_catagory animated:YES];
     [obj_catagory release];
     }
     else if ([category_str isEqualToString:@"Food & Offers"]) {
     
     PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:category_str];
     obj.catID = [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     //obj.searchRadius = searchRadius;
     obj.eventName=[[array objectAtIndex:indexPath.row]valueForKey:@"Name"];
     
     
     [self.navigationController pushViewController:obj animated:YES];
     [obj release];
     }
     
     else if([category_str isEqualToString:@"Facilities"])
     {
     NSLog(@"catagoryArray   %@",[[array objectAtIndex:indexPath.row]valueForKey:@"Name" ]);
     
     AmenitiesDetails  *obj_aminitiesDtls=[[AmenitiesDetails alloc]initWithNibName:[Constant GetNibName:@"AmenitiesDetails"] bundle:[NSBundle mainBundle] withString:[[array objectAtIndex:indexPath.row]valueForKey:@"Name" ]];
     
     obj_aminitiesDtls.Name=[[array objectAtIndex:indexPath.row]valueForKey:@"Name" ];
     //  obj_aminitiesDtls.searchRadius=searchRadius;
     //obj_aminitiesDtls.Name=Name;
     [self.navigationController pushViewController:obj_aminitiesDtls animated:YES];
     [obj_aminitiesDtls release];
     }
     else if([category_str isEqualToString:@"Real Ale"])
     {
     RealAleDetail *obj = [[RealAleDetail alloc]initWithNibName:[Constant GetNibName:@"RealAleDetail"] bundle:[NSBundle mainBundle]];
     obj.Realale_ID =    [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     obj.str_breweryName=[[array objectAtIndex:indexPath.row] valueForKey:@"Name"];
     obj.strPostcode=[[array objectAtIndex:indexPath.row] valueForKey:@"Ale_Postcode"];
     obj._Name = category_str;
     obj.str=[ NSMutableString stringWithFormat: @"ale"];
     [self.navigationController pushViewController:obj animated:YES];
     [obj release];
     }
     else if([category_str isEqualToString:@"FacilitiesDetails"])
     {
     NSString *Name;
     int Ammenity_ID=[[[array objectAtIndex:indexPath.row]valueForKey:@"Ammenity_ID"]intValue];
     if (Ammenity_ID==1) {
     Name=@"Facilities";
     }
     else if (Ammenity_ID==2) {
     Name=@"Style(s)";
     }
     else if (Ammenity_ID==3) {
     Name=@"Features";
     }
     
     NSMutableArray *arr_ID=[[NSMutableArray alloc]init];
     [arr_ID addObject:[[array objectAtIndex:indexPath.row]valueForKey:@"ID"]];
     PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
     // obj.searchRadius = searchRadius;
     obj.categoryArray=arr_ID;
     obj.eventName=Name;
     [arr_ID release];
     [self.navigationController pushViewController:obj animated:YES];
     [obj release];
     }
     
     else if([category_str isEqualToString:@"EventsDetails"])
     {
     NSString *Name;
     int Event_Type=[[[array objectAtIndex:indexPath.row]valueForKey:@"Event_Type"]intValue];
     if (Event_Type==1) {
     Name=@"Regular";
     }
     else if (Event_Type==2) {
     Name=@"One Off";
     }
     else if (Event_Type==3) {
     Name=@"Theme Nights";
     }
     else if (Event_Type==4) {
     Name=@"What's On Next 7 Days";
     }
     else if (Event_Type==5) {
     Name=@"What's On Tonight...";
     }
     PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
     obj.categoryStr=Name;
     obj._Eventpage=@"Events";
     obj.eventName=[[array objectAtIndex:indexPath.row]valueForKey:@"Name"];
     
     obj.catID = [NSString stringWithFormat:@"%d",Event_Type];//[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_ID"];
     obj.sport_eventID = [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     obj.eventID= [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     [self.navigationController pushViewController:obj animated:YES];
     [obj release];
     }
     else if([category_str isEqualToString:@"Real Ale Details"])
     {
     PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:@"Real Ale"];
     NSLog(@"BEER ID %@",[[array objectAtIndex:indexPath.row] valueForKey:@"ID"]);
     // obj.searchRadius = searchRadius;
     //obj.catID = [[detailsArray objectAtIndex:indexPath.row-1] valueForKey:@"Ale_ID"];
     obj.beerID = [[array objectAtIndex:indexPath.row] valueForKey:@"ID"];
     obj.eventName=[[array objectAtIndex:indexPath.row] valueForKey:@"Name"];
     //  obj.str_AlePostcode=strPostcode;
     [self.navigationController pushViewController:obj animated:YES];
     [obj release];
     }*/
    
    
    
}

#pragma mark- 
#pragma mark- callingServer

-(void) callingServer
{    // && [InternetValidation hasConnectivity]
    if([InternetValidation  checkNetworkStatus])
    {
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        NSLog(@"%@",[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"ID"]);
        [conn1 getPubDetails:[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"ID"]];
        [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        //[self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable. Do you want to retry?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
    
}

#pragma mark- 
#pragma mark- Alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 30) {
        [self performSelector:@selector(dismissHUD:)];
        
        if (buttonIndex == 0) {
            
            [self performSelector:@selector(addMBHud)];
            [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
        }
        else{
            [self performSelector:@selector(dismissHUD:)];
            
        }
    }
}



#pragma mark- 
#pragma mark- textfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    //Terminate editing
    [searchbar resignFirstResponder];
    //pubName
    
    
    if (j==0) {
        
        array=[[SaveTextSearchInfo GetSearchByVenue:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain];
    }
    else if(j==1){
        
        array=[[SaveTextSearchInfo GetSearchByCity:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain]; 
        
    }
    else
    {
        array=[[SaveTextSearchInfo GetSearchByPostcode:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain];
    }
    
    
    
    
    
    //array=[[SaveTextSearchInfo GetPubDetailsInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain];
    category_str=@"PubName";
    
    
    
    
    
    
    //BeerName
    /*if ([array count]==0) {
     category_str=@"Real Ale Details";
     array=[[SaveTextSearchInfo GetAle_beerdetailInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain];
     }
     //AleName
     if ([array count]==0) {
     category_str=@"Real Ale";
     array=[[SaveTextSearchInfo GetRealAle_DetailInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]]retain];
     }
     //Food
     if ([array count]==0) {
     category_str=@"Food & Offers";
     array=[[SaveTextSearchInfo GetFood_TypeInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }
     //Ammenities
     if ([array count]==0) {
     category_str=@"Facilities";
     array=[[SaveTextSearchInfo GetAmmenitiesInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }
     
     //AmmenitiesDetails
     if ([array count]==0) {
     category_str=@"FacilitiesDetails";
     array=[[SaveTextSearchInfo GetAmmenity_DetailInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }
     //Event Name
     if ([array count]==0) {
     category_str=@"Events";
     array=[[SaveTextSearchInfo GetEventInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }
     //event Details
     if ([array count]==0) {
     category_str=@"EventsDetails";
     array=[[SaveTextSearchInfo GetEvent_DetailInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }
     //Sport Name
     if ([array count]==0) {
     category_str=@"Sports on TV";
     array=[[SaveTextSearchInfo GetSport_CatagoryNameInfo:[[NSString stringWithFormat:@"%@",textField.text ] uppercaseString]] retain];
     }*/
    NSLog(@"array  %@",array); 
    if ([array  count]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No result found....." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [searchTable reloadData];
    [self callingMapview];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    CGRect viewFrame = self.view.frame;
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            viewFrame.origin.y -= 80;
        }
        else{
            
            viewFrame.origin.y -= 75; 
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
    }
    
    
    /*   if (textField==txt_VenueName)
     [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
     else if(textField==txt_recomndedBy)
     [scrll setContentOffset:CGPointMake(0, 140)animated:YES];*/
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text=nil;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y < 0.0) {
        
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                viewFrame.origin.y += 80;
            }
            else{
                
                viewFrame.origin.y += 75;  
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [self.view setFrame:viewFrame];
            [UIView commitAnimations];
            
        }
        
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark - ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    //AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
    NSMutableArray *pubDetailsArray = [[[json valueForKey:@"pubDetails"] valueForKey:@"details"] retain];
    
    if ([pubDetailsArray count] != 0) {
        
        //[[appDelegate sharedDefaults] setObject:data_Response forKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
        //[[appDelegate sharedDefaults] synchronize];
        
        PUBID = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"];
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
        
        
        /*array_sportEvent=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Event Details"] retain];
         
         if([categoryStr isEqualToString:@"Regular"]){
         
         
         array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:0] valueForKey:@"Event Details"] retain];
         }
         else if([categoryStr isEqualToString:@"One Off"]){
         array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:1] valueForKey:@"Event Details"] retain];
         }
         else if([categoryStr isEqualToString:@"Theme Nights"]){
         
         array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:2] valueForKey:@"Event Details"] retain];
         }
         
         NSLog(@"Event Array %@",array_EventDetails);
         
         arry_pubinformation=[pubDetailsArray objectAtIndex:0];
         
         str_sportDesc=[NSString stringWithFormat:@"%@",[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Description"]retain]];
         
         NSLog(@"%@",str_sportDesc);*/
        
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
        
        
        
        
        
        //******************************Pub_Photo***************************************************  
        
        
        
        //******************************* Event ****************************************************
        //if ([appDelegate.sharedDefaults objectForKey:@"Events"]) {
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
        //if ([appDelegate.sharedDefaults objectForKey:@"Food"]) {
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
        //if ([appDelegate.sharedDefaults objectForKey:@"Facilities"]) {
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
        //if ([appDelegate.sharedDefaults objectForKey:@"Real Ale"]) {
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
        //if ([appDelegate.sharedDefaults objectForKey:@"Sports on TV"]) {
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
        //}
        
        
        
        
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
        
        
        
        
        
        {
            NSLog(@"ARRAy   %@",array);
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            
            
            
            
            
            
            
            
            obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                               [[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                               [[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                               [[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                               nil];
            obj_detail.Pub_ID= PUBID;//[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"PubID"];
            // obj_detail.sporeid=[[array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
            //obj_detail.Sport_Evnt_id =[ [array objectAtIndex:[searchTable indexPathForSelectedRow].row] valueForKey:@"Sport_EventID"];
            //obj_detail.categoryStr=@"NearMeNow";
            // obj_detail.EventId = eventID;
            // obj_detail.categoryStr=categoryStr;
            obj_detail.categoryStr=@"Text Search";
            
            obj_detail.OpenDayArray=openingHours4Day;
            obj_detail.OpenHourArray=openingHours4Hours;
            obj_detail.bulletPointArray=bulletPointArray;
            
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
        }
        
        //shiftToNextPage = YES;
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
	
    [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
	
	
}

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            lblheading.frame = CGRectMake(125, 89, 150, 30);
            backButton.frame = CGRectMake(8, 90, 50, 25);
            vw_textfield.frame = CGRectMake(20, 180, 280, 29);
            searchTable.frame = CGRectMake(12, 220, 297, 185);
            
            
            searchbar.frame=CGRectMake(5, 5, 270, 19);
            [obj_nearbymap setFrameOfView:CGRectMake(10, 133, 300, 283)];
            list_btn.frame=CGRectMake(95, 90, 79, 32);
            map_btn.frame=CGRectMake(170, 90, 79, 32);
            
            if (appDelegate.ismore==YES) {
                // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            if (_IsSelect==NO) {
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
            segmentedControl.frame = CGRectMake(50,135,219,30);
            
        }
        
        else{
            
            backButton.frame = CGRectMake(20, 85, 50, 25);
            lblheading.frame = CGRectMake(210, 80, 150, 30);
            // vw.frame = CGRectMake(0, 85, 480, 8);
            vw_textfield.frame = CGRectMake(20, 155, 440, 29);
            // resultvw.frame = CGRectMake(27, 2, 438, 190);
            //  scrvw.frame = CGRectMake(0, 104, 480, 200);
            
            searchTable.frame = CGRectMake(20, 195, 440, 55);
            //            lbl_venueName.frame=CGRectMake(70, 104, 90, 20);
            //            lbl_distance.frame=CGRectMake(290, 104, 90, 20);
            
            searchbar.frame=CGRectMake(5, 5, 430, 19);
            [obj_nearbymap setFrameOfView:CGRectMake(10, 115, 460, 142)];
            list_btn.frame=CGRectMake(155, 83, 79, 32);
            map_btn.frame=CGRectMake(230, 83, 79, 32);
            segmentedControl.frame=CGRectMake(120, 110, 219, 30);
            
            if (appDelegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            if (_IsSelect==NO) {
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
                map_btn.frame=CGRectMake(238, 80, 79, 32);                }
            
            
            
            
        }
    }
    
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
     @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
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


#pragma mark -
#pragma mark - Memory Cleanup
-(void)dealloc{
    
    //[btn_bottom release];
    [toolBar release];
    [backButton release];
    [txtvw release];
    [openingHours4Day release];
    [openingHours4Hours release];
    [bulletPointArray release];
    [super dealloc];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark - addMBHud

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



@end
