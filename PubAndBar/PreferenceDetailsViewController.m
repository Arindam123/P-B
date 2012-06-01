//
//  PreferenceDetailsViewController.m
//  PubAndBar
//
//  Created by MacMini Lion-1 on 21/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "PreferenceDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SavePreferenceInfo.h"
#import "Global.h"
#import "AsyncImageView.h"

@interface PreferenceDetailsViewController ()

@end

@implementation PreferenceDetailsViewController
@synthesize array;
@synthesize RecentArray;
@synthesize FavouritesArray;
@synthesize hometable;
@synthesize btnSignUp;
//@synthesize line_vw;
@synthesize name;
@synthesize value;
@synthesize i;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    i=0;
   // self.view.frame = CGRectMake(0, 0, 320, 395);
    toolBar = [[Toolbar alloc] init];
    toolBar.layer.borderWidth = 1.0f;
    toolBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:toolBar];
        //self.navigationController.navigationBarHidden=NO;
    [self CreateHomeView];
    //-----------------------------mb-28-05-12------------------------//
    FavouritesArray =[[SavePreferenceInfo GetFavourites_DetailsInfo]retain];
    RecentArray=[[SavePreferenceInfo GetRecentSearch_DetailsInfo] retain];
    //-----------------------------------------------------//
    array=[[NSMutableArray alloc]initWithArray:FavouritesArray];
   // selectionArray = [[SaveHomeInfo GetMain_CatagoryInfo]retain];
    
    
}

-(void)CreateHomeView{
    hometable = [[UITableView alloc]init];
    hometable.delegate = self;
    hometable.dataSource = self;
    hometable.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    hometable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    btnSignUp = [[UIButton alloc]init];
    
    [btnSignUp addTarget:self action:@selector(ClickSignUp:) forControlEvents:UIControlEventTouchUpInside];
    [btnSignUp setTitle:@"visitors - sign up for pub & bar alerts FREE" forState:UIControlStateNormal];
    btnSignUp.titleLabel.font = [UIFont systemFontOfSize:10];
    
//    line_vw = [[UIView alloc]init];
//    line_vw.backgroundColor=[UIColor whiteColor];
    
    [self setHomeViewFrame];
    
    [self.view addSubview:btnSignUp];
    [self.view addSubview:hometable];
   // [self.view addSubview:line_vw];
}

-(void)setHomeViewFrame{
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            hometable.frame = CGRectMake(0, 30, 320, 358);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(65, 363, 280, 30);
           // line_vw.frame = CGRectMake(150, 383, 148, 1);
            [RecentHistory_Btn setFrame:CGRectMake(10, 0, 70, 27)];
            [Favourites_Btn setFrame:CGRectMake(80, 0, 70, 27)];
            [RecentSearch_Btn setFrame:CGRectMake(150, 0, 70, 27)];
            [EditOrDelet_Btn setFrame:CGRectMake(240, 0, 70, 27)];
            
        }
        else{
            hometable.frame = CGRectMake(0, 40, 480, 178);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(130, 195, 420, 30);
            //line_vw.frame = CGRectMake(285, 218, 148, 1);
            
            
            [RecentHistory_Btn setFrame:CGRectMake(15, 10, 105, 27)];
            [Favourites_Btn setFrame:CGRectMake(120, 10, 105, 27)];
            [RecentSearch_Btn setFrame:CGRectMake(225, 10, 105, 27)];
            [EditOrDelet_Btn setFrame:CGRectMake(360, 10, 105, 27)];
        }
    }
}

- (IBAction)TapOnRecentButton:(id)sender {
    [array removeAllObjects];
   [ array addObjectsFromArray:RecentArray];
    NSLog(@"RecentArray  %@",RecentArray);
     NSLog(@"Array  %@",array);
    FavouritesButtonClicked=YES;
    
    [Favourites_Btn setBackgroundColor:[UIColor lightGrayColor]];
    [RecentHistory_Btn setBackgroundColor:[UIColor blueColor]];
    [RecentSearch_Btn setBackgroundColor:[UIColor lightGrayColor]];
    
    [hometable reloadData];
    NSLog(@"FavouritesArray  %@",FavouritesArray);
}

- (IBAction)TapOnFavouritesButton:(id)sender {
    [array removeAllObjects];
    [array addObjectsFromArray:FavouritesArray];
    NSLog(@"FavouritesArray  %@",FavouritesArray);
    
    [Favourites_Btn setBackgroundColor:[UIColor blueColor]];
    [RecentHistory_Btn setBackgroundColor:[UIColor lightGrayColor]];
    [RecentSearch_Btn setBackgroundColor:[UIColor lightGrayColor]];
    
    NSLog(@"Array  %@",array);
    FavouritesButtonClicked=NO;

    [hometable reloadData];
}

- (IBAction)TapOnRecentSearchButton:(id)sender {
    [array removeAllObjects];
     FavouritesButtonClicked=YES;
   [ array addObjectsFromArray:RecentArray];
    
    [Favourites_Btn setBackgroundColor:[UIColor lightGrayColor]];
    [RecentHistory_Btn setBackgroundColor:[UIColor lightGrayColor]];
    [RecentSearch_Btn setBackgroundColor:[UIColor blueColor]];
    
    [hometable reloadData];
}

- (IBAction)TapOnEditOrDeletButton:(id)sender {
    if (!EditOrDeletBtnClicked) {
        
        EditOrDeletBtnClicked=YES;
        hometable.editing=YES;
        [EditOrDelet_Btn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else {
        EditOrDeletBtnClicked=NO;
        hometable.editing=NO;

        [EditOrDelet_Btn setTitle:@"Edit" forState:UIControlStateNormal];
    }
    [hometable reloadData];
}

-(IBAction)DeletPub:(id)sender
{
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    
}

- (void)viewDidUnload
{
    [RecentHistory_Btn release];
    RecentHistory_Btn = nil;
    [Favourites_Btn release];
    Favourites_Btn = nil;
    [RecentSearch_Btn release];
    RecentSearch_Btn = nil;
    [EditOrDelet_Btn release];
    EditOrDelet_Btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.hometable = nil;
    self.btnSignUp = nil;
   // self.selectionArray = nil;
   // self.line_vw = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        toolBar.frame = CGRectMake(0, 387, 320, 48);
    }
    else{
        toolBar.frame = CGRectMake(0, 239, 480, 48);
    }
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)ClickSignUp:(id)sender{
    NSLog(@"ClickSignUp");
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    [hometable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"ArrayCount   %d",[array count]);
    NSLog(@"Array  %@",array);
    return [array count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger ICON_IMG_TAG = 1002;
    const NSInteger DISTANCE_LABLE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
	UILabel *topLabel;
    AsyncImageView *iconImg;
    UIView *vw;
	UILabel *distanceLbl;
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
		vw = [[UIView alloc]init];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
        
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        
		topLabel =
		[[[UILabel alloc]initWithFrame:
          CGRectMake(100,0,170,37)]autorelease]
        ;
        
		[vw addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:16];
		
        distanceLbl=[[[UILabel alloc]initWithFrame:CGRectMake(260, 7, 55, 37)]autorelease];
        [vw addSubview:distanceLbl];
		
		distanceLbl.tag = DISTANCE_LABLE_TAG;
		distanceLbl.backgroundColor = [UIColor clearColor];
		distanceLbl.textColor = [UIColor whiteColor];
		distanceLbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		distanceLbl.font = [UIFont boldSystemFontOfSize:16];
        
      
        
        iconImg = [[[AsyncImageView alloc]initWithFrame:CGRectMake(13, 7, 22, 22)]autorelease];
        iconImg.tag = ICON_IMG_TAG;
        iconImg.backgroundColor=[UIColor redColor];
        iconImg.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        
        [vw addSubview:iconImg];
        

        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		iconImg = (AsyncImageView *)[cell viewWithTag:ICON_IMG_TAG];
       // pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        distanceLbl=(UILabel *)[cell viewWithTag:DISTANCE_LABLE_TAG];
	}
    @try {
        NSLog(@"indexpathRow  %d",indexPath.row);
        topLabel.text = [array objectAtIndex:indexPath.row];
        //-----------------------------------------mb-28-05-12--------//
        if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
            distanceLbl.text= [NSString stringWithFormat: @"%@ Km",[[array objectAtIndex:indexPath.row] valueForKey:@"PubDistance"]];
        else
            distanceLbl.text=[NSString stringWithFormat:@"%f",[[[array objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192];
         NSURL *url = [[NSURL alloc] initWithString:[[array objectAtIndex:indexPath.row] valueForKey:@"PubImages"]];
        [iconImg loadImageFromURL:url];
       // iconImg.image=[UIImage imageNamed:[[array objectAtIndex:indexPath.row] valueForKey:@"PubImages"]];
        //---------------------------------------------//
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    if (!EditOrDeletBtnClicked) {

        distanceLbl.hidden=NO;
    }
    else {
       
    
        distanceLbl.hidden=YES;
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
   // cell.selectionStyle=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        [array removeObjectAtIndex:indexPath.row];
        [hometable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        //----------------------mb-28-05-12-----------------------//
        if( !FavouritesButtonClicked)
        {
            [FavouritesArray removeObjectAtIndex:indexPath.row];
            [SavePreferenceInfo RemoveData_Preference_Favourites:[[[array objectAtIndex:indexPath.row]valueForKey:@"PubID"]intValue]]; 
        }
        else {
            [RecentArray removeObjectAtIndex:indexPath.row];
            [SavePreferenceInfo RemoveData_Preference_RecentHistory:[[[array objectAtIndex:indexPath.row]valueForKey:@"PubID"]intValue]];         }
    }
    //-------------------------------------------------------//    }
        
}


-(void)dealloc{
    [RecentHistory_Btn release];
    [Favourites_Btn release];
    [RecentSearch_Btn release];
    [EditOrDelet_Btn release];
    [hometable release];
    [btnSignUp release];
    //[selectionArray release];
    //[line_vw release];
    [array release];
    [FavouritesArray release];
    [RecentArray release];
    [toolBar release];
    [super dealloc];

}
@end
