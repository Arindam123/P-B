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
#import "ServerConnection.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "PubDetail.h"      
#import "InternetValidation.h"
#import "ASYImage.h"
#import "AsyncImageView_New.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"

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
@synthesize hud = _hud;
@synthesize oAuthLoginView;

//@synthesize i;
UIInterfaceOrientation orientation;
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
    
   // self.view.frame = CGRectMake(0, 0, 320, 395);
   
    FavouritesButtonClicked=YES;
    toolBar = [[Toolbar alloc] init];
   // toolBar.layer.borderWidth = 1.0f;
   // toolBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:toolBar];
        //self.navigationController.navigationBarHidden=NO;
    [self CreateHomeView];
    //-----------------------------mb-28-05-12------------------------//
    FavouritesArray =[[SavePreferenceInfo GetFavourites_DetailsInfo]retain];
    RecentArray=[[SavePreferenceInfo GetRecentHistory_DetailsInfo] retain];
    RecentSearchArray=[[SavePreferenceInfo GetRecentSearch_DetailsInfo] retain];

    //-----------------------------------------------------//
    array=[[NSMutableArray alloc]initWithArray:FavouritesArray];
   // selectionArray = [[SaveHomeInfo GetMain_CatagoryInfo]retain];
    
    
}




-(void)CreateHomeView{
    hometable = [[UITableView alloc]init];
    hometable.delegate = self;
    hometable.dataSource = self;
    //hometable.backgroundColor = [UIColor clearColor];
    hometable.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    hometable.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    hometable.separatorColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
   // hometable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    btnSignUp = [[UIButton alloc]init];
    
    [btnSignUp addTarget:self action:@selector(ClickSignUp:) forControlEvents:UIControlEventTouchUpInside];
   // [btnSignUp setTitle:@"visitors - sign up for pub & bar alerts FREE" forState:UIControlStateNormal];
    btnSignUp.titleLabel.font = [UIFont systemFontOfSize:10];
    
//    line_vw = [[UIView alloc]init];
//    line_vw.backgroundColor=[UIColor whiteColor];
    
    //[self setHomeViewFrame];
    
   // [self.view addSubview:btnSignUp];
    [self.view addSubview:hometable];
   // [self.view addSubview:line_vw];
}

-(void) addTableView
{
    hometable = [[UITableView alloc]init];
    hometable.delegate = self;
    hometable.dataSource = self;
    hometable.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    hometable.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    hometable.separatorColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    //hometable.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
       [self.view addSubview:hometable];
}

-(void)setHomeViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            hometable.frame = CGRectMake(10, 166, 300, 250);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(65, 363, 280, 30);
            // line_vw.frame = CGRectMake(150, 383, 148, 1);
            [RecentHistory_Btn setFrame:CGRectMake(10, 115, 92, 28)];
            [Favourites_Btn setFrame:CGRectMake(102, 115, 70, 28)];
            [RecentSearch_Btn setFrame:CGRectMake(172, 115, 92, 28)];
            [EditOrDelet_Btn setFrame:CGRectMake(268, 115, 42, 27)];
            backbutton.frame=CGRectMake(8, 90, 50, 25);
            if (app.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
                                   
            if(FavouritesButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelect.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselect.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselect.png"] forState: UIControlStateNormal];
                
                
            }
            else if(RecentHistryButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselect.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistorySelect.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselect.png"] forState: UIControlStateNormal];
            }
            else if(RecentSearchButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselect.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselect.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchSelect.png"] forState: UIControlStateNormal];
                
                
            }
            else{
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelect.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselect.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselect.png"] forState: UIControlStateNormal];
                
            }
            if(EditOrDeletBtnClicked==YES){
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"DoneSelect.png"] forState: UIControlStateNormal];
                
            }
            else{
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"EditDeselect.png"] forState: UIControlStateNormal];
                
            }
            
        }
        else{
            
         
            hometable.frame = CGRectMake(10, 180, 460, 110);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(130, 195, 420, 30);
            //line_vw.frame = CGRectMake(285, 218, 148, 1);
            
            
            [RecentHistory_Btn setFrame:CGRectMake(10, 125, 140, 35)];
            [Favourites_Btn setFrame:CGRectMake(150, 125, 123, 35)];
            [RecentSearch_Btn setFrame:CGRectMake(273, 125, 143, 35)];
            [EditOrDelet_Btn setFrame:CGRectMake(417, 125, 59, 35)];
            
            if (app.ismore==YES) {
                // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            

            
            if(FavouritesButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelectL.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselectL.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselectL.png"] forState: UIControlStateNormal];
                
                
            }
            else if(RecentHistryButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselectL.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistorySelectL.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselectL.png"] forState: UIControlStateNormal];
                
            }
            else if(RecentSearchButtonClicked==YES){
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselectL.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselectL.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchSelectL.png"] forState: UIControlStateNormal];
                
                
            }
            else{
                
                [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelectL.png"] forState: UIControlStateNormal];
                [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselectL.png"] forState: UIControlStateNormal];
                [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselectL.png"] forState: UIControlStateNormal];
                
                
            }
            
            if(EditOrDeletBtnClicked==YES){
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"DoneSelectButtonL.png"] forState: UIControlStateNormal];
                
            }
            else{
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"EditDeselectButtonL.png"] forState: UIControlStateNormal];
                
                
            }
            
        }
    }
}

- (IBAction)TapOnRecentButton:(id)sender {
    [array removeAllObjects];
    [array addObjectsFromArray:RecentArray];
    NSLog(@"RecentArray  %@",RecentArray);
    NSLog(@"Array  %@",array);
    
    RecentHistryButtonClicked=YES;
    FavouritesButtonClicked=NO;
    RecentSearchButtonClicked=NO;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselect.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistorySelect.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselect.png"] forState: UIControlStateNormal];
            
        }
        else{
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselectL.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistorySelectL.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselectL.png"] forState: UIControlStateNormal];
            
            
        }
    }
    if (hometable) {
        [hometable removeFromSuperview];
        [hometable release];
    }
    [self performSelector:@selector(addTableView)];
    [self setHomeViewFrame];
    [hometable reloadData];
    
}

- (IBAction)TapOnFavouritesButton:(id)sender {
    [array removeAllObjects];
    [array addObjectsFromArray:FavouritesArray];
    NSLog(@"FavouritesArray  %@",FavouritesArray);
    
    
    FavouritesButtonClicked=YES;
    RecentHistryButtonClicked=NO;
    RecentSearchButtonClicked=NO;
    
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelect.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselect.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselect.png"] forState: UIControlStateNormal];
        }
        else{
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesSelectL.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselectL.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchDeselectL.png"] forState: UIControlStateNormal];
            
        }
    }
    
    if (hometable) {
        [hometable removeFromSuperview];
        [hometable release];
    }
    [self performSelector:@selector(addTableView)];
    [self setHomeViewFrame];
    [hometable reloadData];
    
}

- (IBAction)TapOnRecentSearchButton:(id)sender {
    [array removeAllObjects];
    [ array addObjectsFromArray:RecentSearchArray];
    //  FavouritesButtonClicked=YES;
    // [ array addObjectsFromArray:RecentArray];
    RecentSearchButtonClicked=YES;
    FavouritesButtonClicked=NO;
    RecentHistryButtonClicked=NO;
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselect.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselect.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchSelect.png"] forState: UIControlStateNormal];
        }
        else{
            
            [Favourites_Btn setImage:[UIImage imageNamed:@"FavoritesDeselectL.png"] forState: UIControlStateNormal];
            [RecentHistory_Btn setImage:[UIImage imageNamed:@"ResentHistoryDeselectL.png"] forState: UIControlStateNormal];
            [RecentSearch_Btn setImage:[UIImage imageNamed:@"RecentSearchSelectL.png"] forState: UIControlStateNormal];
            
        }
    }
    
    if (hometable) {
        [hometable removeFromSuperview];
        [hometable release];
    }
    [self performSelector:@selector(addTableView)];
    [self setHomeViewFrame];
}

- (IBAction)TapOnEditOrDeletButton:(id)sender {
    if (!EditOrDeletBtnClicked) {
        
        EditOrDeletBtnClicked=YES;
      //  hometable.editing=YES;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"DoneSelect.png"] forState: UIControlStateNormal];
            }
            else{
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"DoneSelectButtonL.png"] forState: UIControlStateNormal];
                
            }
        }
    }
    else {
        EditOrDeletBtnClicked=NO;
       // hometable.editing=NO;
        
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"EditDeselect.png"] forState: UIControlStateNormal];
                
            }
            else{
                
                [EditOrDelet_Btn setImage:[UIImage imageNamed:@"EditDeselectL.png"] forState: UIControlStateNormal];
                
            }
        }
        
    }
   // [hometable reloadInputViews];

    [hometable reloadData];
}


-(IBAction)DeletPub:(id)sender
{
    
}
-(IBAction)ClickBack:(id)sender{
    
    
    // delegate.ismore=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [backbutton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backbutton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];

    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
//    [self SetCustomNavBarFrame];
//    [self setHomeViewFrame];
    
    [self AddNotification];
    
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

-(IBAction)ClickSignUp:(id)sender{
    NSLog(@"ClickSignUp");
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
   // [hometable reloadData];
    
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
	return 50;	
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger ICON_IMG_TAG = 1002;
    //   const NSInteger DISTANCE_LABLE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    
    const NSInteger DELETE_BUTTON_TAG = 1005;
    //const NSInteger MIDDLE_LABEL_TAG=1005;
	UILabel *topLabel;
   // UILabel *middleLbl;
    AsyncImageView_New *iconImg;
    UIView *vw;
    
    UIButton *deleteBtn;
	//UILabel *distanceLbl;
    
    UIActivityIndicatorView *spinnerCell = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinnerCell setCenter:CGPointMake(25, 55)];

	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 7, 320, 36);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
        
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        
		topLabel =[[[UILabel alloc]initWithFrame:CGRectMake(75,10,180,37)]autorelease];
        topLabel.tag = TOP_LABEL_TAG;
        
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:14.0];
		[cell.contentView addSubview:topLabel];

             
        iconImg = [[[AsyncImageView_New alloc]initWithFrame:CGRectMake(0, 10, 36, 32)]autorelease];
        iconImg.tag = ICON_IMG_TAG;
        iconImg.layer.cornerRadius = 5.0;
        iconImg.layer.borderWidth = 1.0;
        iconImg.layer.borderColor = [[UIColor whiteColor] CGColor];
        iconImg.backgroundColor=[UIColor clearColor];
        iconImg.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        [cell.contentView addSubview:iconImg];
        

        deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame=CGRectMake(278, 15, 42, 22);
        deleteBtn.layer.cornerRadius=5.0;
        deleteBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
        deleteBtn.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        deleteBtn.tag=DELETE_BUTTON_TAG;
         deleteBtn.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
        [deleteBtn addTarget:self action:@selector(DeleteRow:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:deleteBtn];
       
        
    }
	else
	{
		topLabel = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
		iconImg = (AsyncImageView_New *)[cell.contentView viewWithTag:ICON_IMG_TAG];
        deleteBtn=(UIButton *)[cell.contentView viewWithTag:DELETE_BUTTON_TAG];//DELETE_BUTTON_TAG
       // pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        //distanceLbl=(UILabel *)[cell viewWithTag:DISTANCE_LABLE_TAG];
        
        
	}
    @try {
        NSLog(@"indexpathRow  %d",indexPath.row);
        topLabel.text = [[array objectAtIndex:indexPath.row] valueForKey:@"PubName"];
        
        [[AsyncImageLoader sharedLoader] cancelLoadingURL:iconImg.imageURL];
        iconImg.image = [UIImage imageNamed:@"icon.png"];
        if ([[[array objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"] length] != 0) {
            
            NSString *tempurl=[NSString stringWithFormat:[[array objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]];
            tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSURL *url = [[NSURL alloc] initWithString:tempurl];
            iconImg.imageURL = url;
        }
        else{
            
        }
        
        if (!EditOrDeletBtnClicked) {
            
            deleteBtn.hidden=YES;
            deleteBtn.userInteractionEnabled=NO;
        }
        else {
            
            
            deleteBtn.hidden=NO;
            deleteBtn.userInteractionEnabled=YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[app sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubID"]]])
    {
        [self afterSuccessfulConnection:[[app sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubID"]]]];
    }
    else
    {
        [self performSelector:@selector(addMBHud)];
        [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
    }
    
}


-(IBAction)DeleteRow:(id)sender
{
    // Delete the managed object for the given index path
    //UIButton *btn = (UIButton *)sender;
    
//     UITableViewCell *cell=[self.hometable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
//    NSLog(@"%d",[NSIndexPath indexPathForRow:btn.tag inSection:0].row);
    
    NSIndexPath *indexPath = [hometable indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSLog(@"Selected row is: %d",indexPath.row);

    
    //[hometable deleteRowsAtIndexPaths:btn.tag withRowAnimation:YES];
    //----------------------mb-28-05-12-----------------------//
    if(FavouritesButtonClicked)
    {
        
        [SavePreferenceInfo RemoveData_Preference_Favourites:[[[array objectAtIndex:indexPath.row]valueForKey:@"PubID"]intValue]]; 
        [FavouritesArray removeObjectAtIndex:indexPath.row];
    }
    if (RecentSearchButtonClicked)
    {
        [SavePreferenceInfo RemoveData_Preference_RecentSearch:[[[array objectAtIndex:indexPath.row]valueForKey:@"PubID"]intValue]]; 
        [RecentSearchArray removeObjectAtIndex:indexPath.row];
    }
    if(RecentHistryButtonClicked)
    {        
        [SavePreferenceInfo RemoveData_Preference_RecentHistory:[[[array objectAtIndex:indexPath.row]valueForKey:@"PubID"]intValue]];  
        [RecentArray removeObjectAtIndex:indexPath.row];
    }
    
    [array removeObjectAtIndex:indexPath.row];
    [hometable reloadData];
}

-(void) callingServer
{    // && [InternetValidation hasConnectivity]
    if([InternetValidation  checkNetworkStatus])
    {
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        NSLog(@"%@",[[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubID"]);
        [conn1 getPubDetails:[[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubID"]];
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

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
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
        
}*/

#pragma mark ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
    NSMutableArray *pubDetailsArray = [[[json valueForKey:@"pubDetails"] valueForKey:@"details"] retain];
    //[[delegate sharedDefaults] removeObjectForKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
    
    
    if ([pubDetailsArray count] != 0) {
        
        
        //[[delegate sharedDefaults] setObject:data_Response forKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
        //[[delegate sharedDefaults] synchronize];
        
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
        
        
        
        NSMutableArray *bulletPointArray=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubBullet"] retain];
        
        NSLog(@"%@",bulletPointArray);
        
        
        //NSMutableArray *array_sportEvent=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Event Details"] retain];
        
       /* if([categoryStr isEqualToString:@"Regular"]){
            
            
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:0] valueForKey:@"Event Details"] retain];
        }
        else if([categoryStr isEqualToString:@"One Off"]){
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:1] valueForKey:@"Event Details"] retain];
        }
        else if([categoryStr isEqualToString:@"Theme Nights"]){
            
            array_EventDetails=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"] objectAtIndex:2] valueForKey:@"Event Details"] retain];
        }*/
        
        
        NSMutableArray *array_realAle=[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"Real Ale"] objectAtIndex:0] valueForKey:@"Real Ale Details"] retain];
        
        
        NSLog(@"Event Array %@",array_realAle);
        
        //NSMutableArray *arry_pubinformation=[pubDetailsArray objectAtIndex:0];
        
        NSString *str_sportDesc=[NSString stringWithFormat:@"%@",[[[[[pubDetailsArray objectAtIndex:0] valueForKey:@"SportsEvent"] objectAtIndex:0] valueForKey:@"Sports Description"]retain]];
        
        NSLog(@"%@",str_sportDesc);
        
        NSMutableDictionary *OpenHoursDictionary=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubOpenHours"] retain];
        //    NSMutableArray *arr;
        //    [arr addObject:OpenHoursDictionary];
        NSMutableArray *openingHours4Day = (NSMutableArray *)[[[OpenHoursDictionary keyEnumerator] allObjects] retain];
        NSMutableArray *openingHours4Hours = [[NSMutableArray alloc] init];
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
       // }
        
        //****************************** Food and offers *******************************************
        
        
        //***************************** Facilities *************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Facilities"]) {
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
       // if ([delegate.sharedDefaults objectForKey:@"Real Ale"]) {
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
        
              
        
        //else
        {
            NSLog(@"ARRAy   %@",array);
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                               [[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                               [[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                               [[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                               nil];
            obj_detail.Pub_ID= [[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"PubID"];
            obj_detail.sporeid=[[array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
            obj_detail.Sport_Evnt_id =[ [array objectAtIndex:[hometable indexPathForSelectedRow].row] valueForKey:@"Sport_EventID"];
            //        obj_detail.EventId = eventID;
            //        obj_detail.categoryStr=categoryStr;
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

-(void)afterFailourConnection:(id)msg
{
	
    [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
    
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
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
     [hometable release];
    self.hometable = nil;
    self.btnSignUp = nil;
     [super viewDidUnload];
   
    // self.selectionArray = nil;
    // self.line_vw = nil;
}



-(void)dealloc{
    [RecentHistory_Btn release];
    [Favourites_Btn release];
    [RecentSearch_Btn release];
    [EditOrDelet_Btn release];
    [hometable release];
    //[selectionArray release];
    //[line_vw release];
    [array release];
    [FavouritesArray release];
    [RecentArray release];
    [toolBar release];
    [super dealloc];

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
    
   // [mailController setToRecipients:[NSArray arrayWithObjects:str_mail, nil]];
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
#pragma  mark-

@end
