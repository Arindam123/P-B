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

@implementation PubDetail
//@synthesize table;
@synthesize backButton;
@synthesize Array;
@synthesize heardervw;
@synthesize image;
@synthesize name_lbl;
@synthesize address_lbl;
@synthesize favorite;
@synthesize manager;
@synthesize email;
@synthesize show_map;
@synthesize fablbl;
@synthesize managerlbl;
@synthesize emaillbl;
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

UILabel *topLabel;
UIImageView *iconImg;

BOOL isGeneralExpanded;
BOOL isPubOpeningHrsExpanded;
BOOL isPubBulletsExpanded;
BOOL isDescriptionExpanded;
BOOL isregularEvent;
BOOL isoneoffEvent;
BOOL isthemenightEvent;
BOOL issportsEvent;
//BOOL issportsEvent;
BOOL isImagesExpanded;
BOOL isOtherDetails;
BOOL isSportsDetails;
BOOL isOpeningHr;
BOOL isFoodDetail;

BOOL isRegularEventExit;
BOOL isGeneralExpandedExit;
BOOL isPubOpeningHrsExpandedexit;
BOOL isOtherDetailsExit;
BOOL isPubBulletsExpandedExit;
BOOL isDescriptionExpandedExit;
BOOL isOneOffEventexit;
BOOL isThemeNightExit;

BOOL isSportsDetailsExit;
BOOL issportsEventExit;
BOOL isImagesExpandedExit;

BOOL IsSelect;
int section_value;


AppDelegate *app;
PubList *obj_PubList;


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
    
    self.eventTextLbl.text=[NSString stringWithFormat:@"Venue Info"];

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    
    //----------------------------mb-2-05-12------------------------------------------//
    //[[DBFunctionality sharedInstance] InsertValue_RecentSearch:[Pub_ID intValue]];
    //-------------------------------------------------------------------------------//
    
    arrMain=[[NSMutableArray alloc]init];
    arr=[[NSMutableArray alloc]init];
    
   /* if ([Pub_ID intValue]!=1429) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Pub Information" message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alrt show];
        [alrt release];
        // [self.navigationController popViewControllerAnimated:YES];
    }*/
    
    
   // if ([Pub_ID intValue]==1429) {
        
        Array_section = [[NSMutableArray alloc]initWithObjects:@"Regular Event",@"General",@"Opening Hours",@"Other Details",@"Bullet Points",@"Description",@"One off Event",@"Theme Night",@"Sports Description",@"Sports Event",@"Food Details",@"Photos", nil];    
        
        
        if ([categoryStr isEqualToString:@"Sports on TV"]) {
            isOneOffEventexit=YES;
            isThemeNightExit=YES;
            issportsEvent=YES;
            arr=[SaveSportDetailInfo GetSport_EventInfo_Details:[Pub_ID intValue]];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Type"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sport_EventName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Channel"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sport_Date"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Time"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Screen"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sound"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"HD"]];                                                                                  
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"ThreeD"]]; 
            [arr removeAllObjects];
        }
        else if([categoryStr isEqualToString:@"Food & Offers"])
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
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]]; 

            imageURL = [[arr objectAtIndex:0]valueForKey:@"venuePhoto"];
            
            [arr removeAllObjects];
            
        }
        else if([categoryStr isEqualToString:@"Real Ale"])
        {
            isRegularEventExit=YES;
            isOneOffEventexit=YES;
            isThemeNightExit=YES;
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
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]]; 

            imageURL = [[arr objectAtIndex:0]valueForKey:@"venuePhoto"];

            
            [arr removeAllObjects];
        }
        else if([categoryStr isEqualToString:@"Regular"])
        {
           
            isOneOffEventexit=YES;
            isThemeNightExit=YES;
            issportsEventExit=YES;
            isSportsDetailsExit=YES;
            
         /*   arr=[[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]] retain];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDistrict"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubPostCode"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PhoneNumber"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Mobile"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubWebsite"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubCompany"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubAddress"]]; 
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"venuePhoto"]]; 
            
            imageURL = [[arr objectAtIndex:0]valueForKey:@"venuePhoto"];
            
            [arr removeAllObjects];*/
            
        }

    
        [self CreateView];

        /*  else if([categoryStr isEqualToString:@"Real Ale"])
         {
         }*/
    //}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)CreateView{
    
    my_table = [[UITableView alloc]initWithFrame:CGRectMake(10, 75, 300, 300)style:UITableViewStyleGrouped];
    my_table.delegate=self;
    my_table.dataSource=self;
    my_table.backgroundColor =[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    my_table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    my_table.separatorColor = [UIColor blackColor];
    
    heardervw = [[UIView alloc]init];
    heardervw.backgroundColor = [UIColor whiteColor];
    
    image = [[AsyncImageView alloc]init];
    [image loadImageFromURL:[NSURL URLWithString:imageURL]];
    
    name_lbl = [[UILabel alloc]init];
    name_lbl.text = [headerDictionaryData objectForKey:@"PubName"];
    name_lbl.font = [UIFont systemFontOfSize:12];
    name_lbl.textColor = [UIColor lightGrayColor];
    name_lbl.backgroundColor = [UIColor clearColor];
    
    address_lbl = [[UILabel alloc]init];
    address_lbl.text = [NSString stringWithFormat:@"%@, %@, %@",[headerDictionaryData objectForKey:@"PubPostCode"],[headerDictionaryData objectForKey:@"PubDistrict"],[headerDictionaryData objectForKey:@"PubCity"]];//@"6 The Meadow Lane,Blackawon";
    address_lbl.textColor = [UIColor lightGrayColor];
    address_lbl.backgroundColor = [UIColor clearColor];
    address_lbl.font = [UIFont systemFontOfSize:9];
    
    favorite = [[UIImageView alloc]init];
    favorite.image = [UIImage imageNamed:@"BlueIcon.png"];
    
    fablbl = [[UILabel alloc]init];
    fablbl.text = @"add to favorite";
    fablbl.backgroundColor = [UIColor clearColor];
    fablbl.textColor = [UIColor colorWithRed:202/255 green:225/255 blue:255/255 alpha:1];
    fablbl.font = [UIFont systemFontOfSize:9];
    
    managerlbl = [[UILabel alloc]init];
    managerlbl.text = @"Call the manager";
    managerlbl.textColor = [UIColor lightGrayColor];
    managerlbl.backgroundColor = [UIColor clearColor];
    managerlbl.font = [UIFont systemFontOfSize:9];
    
    manager = [[UIImageView alloc]init];
    manager.image = [UIImage imageNamed:@"PhoneIcon.png"];
    
    emaillbl = [[UILabel alloc]init];
    emaillbl.text = @"Email";
    emaillbl.textColor = [UIColor lightGrayColor];
    emaillbl.backgroundColor = [UIColor clearColor];
    emaillbl.font = [UIFont systemFontOfSize:9];
    
    email = [[UIImageView alloc]init];
    email.image = [UIImage imageNamed:@"EmailIcon.png"];
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    


    [self setViewFrame];
    [self.view addSubview:my_table];
    [self.view addSubview:backButton];
    [self.view addSubview:heardervw];
    [heardervw addSubview:image];
    [heardervw addSubview:name_lbl];
    [heardervw addSubview:address_lbl];
    [heardervw addSubview:favorite];
    [heardervw addSubview:fablbl];
    [heardervw addSubview:managerlbl];
    [heardervw addSubview:manager];
    [heardervw addSubview:emaillbl];
    [heardervw addSubview:email];
    [backButton release];
    [heardervw release];
    [image release];
    [name_lbl release];
    [address_lbl release];
    [favorite release];
    [fablbl release];
    [managerlbl release];
    [manager release];
    [emaillbl release];
    [email release];
}

-(IBAction)ClickBack:(id)sender{
  
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
    app.issportsEvent=NO;
    isImagesExpanded=NO;
    [my_table reloadData];
    
    FoodDetails_Microsite *obj=[[FoodDetails_Microsite alloc]init];
    obj.IsServeTime=NO;
     obj.IsInformation=NO;
    obj.IsFood=NO;
    obj.IsSpecialOffers=NO;
    obj.IsChefDesc=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}


        


-(void)setViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            my_table.frame = CGRectMake(10, 83, 300, 300);
            backButton.frame = CGRectMake(10, 4, 50, 20);
            heardervw.frame = CGRectMake(10, 24, 300, 58);
            image.frame = CGRectMake(2, 3.5, 70, 51.5);
            name_lbl.frame = CGRectMake(76, 0, 200, 30);
            address_lbl.frame = CGRectMake(76, 13, 190, 30);
            favorite.frame = CGRectMake(74, 40, 16, 16);
            fablbl.frame = CGRectMake(91, 39, 70, 20);
            managerlbl.frame = CGRectMake(158, 39, 70, 20);
            manager.frame = CGRectMake(227, 42, 12, 12);
            emaillbl.frame = CGRectMake(250, 39, 30, 20);
            email.frame = CGRectMake(278, 45, 12, 8);
            toolBar.frame = CGRectMake(0, 387, 320, 48);
            
        }
        
        else{
            
            backButton.frame = CGRectMake(20, 15, 50, 20);
            toolBar.frame = CGRectMake(0, 240, 480, 48);
            my_table.frame = CGRectMake(10, 110, 460, 120);
            heardervw.frame = CGRectMake(10, 35, 460, 58);
            image.frame = CGRectMake(5, 3.5, 80, 51.5);
            name_lbl.frame = CGRectMake(100, 0, 200, 30);
            address_lbl.frame = CGRectMake(100, 13, 190, 30);
            favorite.frame = CGRectMake(100, 38, 16, 16);
            fablbl.frame = CGRectMake(120, 39, 70, 20);
            managerlbl.frame = CGRectMake(200, 39, 70, 20);
            manager.frame = CGRectMake(270, 42, 12, 12);
            emaillbl.frame = CGRectMake(310, 39, 30, 20);
            email.frame = CGRectMake(340, 42, 12, 11);
            
            
            
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // [my_table reloadData];
    
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
    app.issportsEvent=NO;
    isImagesExpanded=NO;
    //[my_table reloadData];
    
    IsSelect=NO;
    
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [Array_section count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section!=10){
          
    if (IsSelect==YES) {
        NSLog(@"%d",section_value);
        if (section==section_value) {
            
            return 6.0;
        }
        else
            return 0.1;
      }
    
        else
        {
            return 0.1;
        }
    }
    else
    {
        return 0.1;
    }
    
   }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1; 
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    
    if(section==0){
        if ( isregularEvent==YES)
		    return 2;
        
        else
        {
            return 1;
        }
    }
    
    else if(section==1)
        
        if(isGeneralExpanded ==YES)
            return 10;
    
        else
        {
            return 1;
        }
    
    
        else if(section==2)
            if( isOpeningHr==YES)
                return 8;
    
            else
            {
                return 1;
            }
    
    
            else if(section==3)
                if(isOtherDetails==YES)
                    return 6;
                else
                    return 1;
    
                else if(section==4)
                    if(isPubBulletsExpanded==YES)
                        return 2;
                    else
                        return 1;
    
                    else if(section==5)
                        if(isDescriptionExpanded==YES)
                            return 2;
                        else
                            return 1;
    
                        else if(section==6)
                            if(isoneoffEvent==YES)
                                return 2;
                            else
                                return 1;
                            else if(section==7)
                                if(isthemenightEvent==YES)
                                    return 2;
                                else
                                    return 1;
    
                                else if(section==8)
                                    if(isSportsDetails==YES)
                                        return 2;
                                    else
                                        return 1;
    
                                    else if(section==9)
                                        if(app.issportsEvent==YES)
                                            return 2;
                                        else
                                            return 1;
    
                                        else if(section==10)
                                            // if(isFoodDetail==YES)
                                            return 1;
    // else
    // return 1;
    
                                        else if(section==11)
                                            if(isImagesExpanded==YES)
                                                return 2;
                                            else
                                                return 1;
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
    vw.frame =CGRectMake(-11, 4, 380, 42);
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
    
    
    if(indexPath.section==0)
    {
		UILabel *lblRegularEvent= [Design LabelFormation:10 :5 :250 :20 :0];
		UILabel *lblEventDay = [Design LabelFormation:10 :20 :290 :20 :0];
        UILabel *lblRegularEventDesc = [Design LabelFormation:10 :35 :270 :20 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
            
			if(isRegularEventExit==YES)
			    img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                
                if(isregularEvent == YES)
                    img=[UIImage imageNamed:@"MinusButton.png"];
                
                else
                    img=[UIImage imageNamed:@"PlusButton.png"];
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
        else  { 
            if ( isregularEvent == YES) {
                
                lblRegularEvent.text =[arrMain objectAtIndex:0];
                lblEventDay.text =[arrMain objectAtIndex:1];
                lblRegularEventDesc.text =[arrMain objectAtIndex:2];
                
                [cell.contentView addSubview:lblRegularEvent];
                [cell.contentView addSubview:lblEventDay];
                [cell.contentView addSubview:lblRegularEventDesc];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;		
                
                [lblRegularEvent release];
                [lblEventDay release];
                [lblRegularEventDesc release];
                
                if(indexPath.row>0)
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                }	
            }
        }
    }
    
    
	
	if(indexPath.section==1)
	{
        UILabel *lblPubGeneral = [Design LabelFormation:10 :5 :100 :20 :0];
        UILabel  *lblPubGeneralDisp = [Design LabelFormation:95 :-5 :210 :40 :0];
		
		NSLog(@"%d",indexPath.row);	
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			if(isGeneralExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isGeneralExpanded==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			}
			
			imgMain.image = img;
			[vw addSubview:imgMain];
			[imgMain release];
			lblPubGeneral = [Design LabelFormation:35 :5 :100 :20 :0];
			lblPubGeneral.text = @"General";
			lblPubGeneral.font = [UIFont boldSystemFontOfSize:15];
			//lblPubGeneral.textColor =textcolorNew;//[UIColor whiteColor];
		}
		else if(isGeneralExpanded ==YES)        {
            
            
            if (indexPath.row==1){
                lblPubGeneral.text = @"Name :";
                lblPubGeneralDisp.text =[arrMain objectAtIndex:0];
                
            }
            else if (indexPath.row==2){
                lblPubGeneral.text = @"District :";
                lblPubGeneralDisp.text = [arrMain objectAtIndex:1];
            }
            else if (indexPath.row==3){
                lblPubGeneral.text = @"City :";
                lblPubGeneralDisp.text = [arrMain objectAtIndex:2];
            }
            else if (indexPath.row==4){
                lblPubGeneral.text = @"Postcode :";
                lblPubGeneralDisp.text =[arrMain objectAtIndex:3];
            }
            else if(indexPath.row==5) {
                lblPubGeneral.text = @"Phone No :";
                
                lblPubGeneralDisp.text = [arrMain objectAtIndex:4];
            }
            else if(indexPath.row==6) {
                lblPubGeneral.text =@"Mobile :"; 
                
                lblPubGeneralDisp.text = [arrMain objectAtIndex:5];
            }
            else if(indexPath.row==7) {
                lblPubGeneral.text = @"WebSite :";
                
                lblPubGeneralDisp.text = [arrMain objectAtIndex:6];
                lblPubGeneralDisp.numberOfLines = 2;
                lblPubGeneralDisp.lineBreakMode = UILineBreakModeWordWrap;
            }
            else if(indexPath.row==8) {
                lblPubGeneral.text = @"Pub Company : ";
                lblPubGeneralDisp.text =[arrMain objectAtIndex:7];
            }
            else if(indexPath.row==9) {
                lblPubGeneral.text = @"Address : ";
                lblPubGeneralDisp.text = [arrMain objectAtIndex:8];
                lblPubGeneralDisp.numberOfLines = 2;
                lblPubGeneralDisp.lineBreakMode = UILineBreakModeWordWrap;
            }
            
            
            
            
            // Set up the cell...
            
            [cell.contentView addSubview:lblPubGeneralDisp];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [cell.contentView addSubview:lblPubGeneral];
        [lblPubGeneral release];
		[lblPubGeneralDisp release];
	}	
	if(indexPath.section==2)
    {
        UILabel *lblOpening = [Design LabelFormation:10 :5 :100 :20 :0];
        UILabel *lblOpeningDesc = [Design LabelFormation:100 :5 :190 :20 :0];
        if (indexPath.row==0){				
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
            if(isPubOpeningHrsExpandedexit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isOpeningHr==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			}
            imgMain.image = img;
            
            [vw addSubview:imgMain];
            [imgMain release];
            
            lblOpening = [Design LabelFormation:35 :5 :150 :20 :0];
            lblOpening.text = @"Opening Hours";
            lblOpening.font = [UIFont boldSystemFontOfSize:15];
            // lblOpening.textColor =textcolorNew;//[UIColor whiteColor];
        }
        else if( isOpeningHr==YES)
        {
            if (indexPath.row==1){
                lblOpening.text = @"Sunday :";
                lblOpeningDesc.text =@"TEST";
            }
            else if (indexPath.row==2){
                lblOpening.text = @"Monday :";
                lblOpeningDesc.text =@"TEST";
                
            }
            else if (indexPath.row==3){
                lblOpening.text = @"Tuesday :";
                lblOpeningDesc.text=@"TEST";
            }
            else if (indexPath.row==4){
                lblOpening.text = @"Wednesday :";
                lblOpeningDesc.text =@"TEST";
                
            }
            else if (indexPath.row==5){
                lblOpening.text = @"Thusday :";
                lblOpeningDesc.text =@"TEST";
                
            }
            else if (indexPath.row==6){
                lblOpening.text = @"Friday :";
                lblOpeningDesc.text =@"TEST";
                
            }
            else if (indexPath.row==7){
                lblOpening.text = @"Saturday :";
                lblOpeningDesc.text =@"TEST";
                
            }
            // Set up the cell...
            
            [cell.contentView addSubview:lblOpeningDesc];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            
        }
        [cell.contentView addSubview:lblOpening];
        [lblOpening release];
        [lblOpeningDesc release];
    }	
	if(indexPath.section==3)
	{
		UILabel *lblOpening = [Design LabelFormation:10 :5 :100 :20 :0];
		UILabel *lblOpeningDesc = [Design LabelFormation:105 :5 :190 :20 :0];
		if (indexPath.row==0){				
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
            
            if ([Constant isiPad]) {
                ;
            }
            else{
                if ([Constant isPotrait:self]) {
                    if(isOtherDetailsExit==YES)
                        
                        img=[UIImage imageNamed:@"CrossButton.png"];
                    else{
                        if(isOtherDetails==NO)
                            img=[UIImage imageNamed:@"PlusButton.png"];
                        else
                            img=[UIImage imageNamed:@"MinusButton.png"];
                    }
                }
                else
                {
                    if(isOtherDetailsExit==YES)
                        
                        img=[UIImage imageNamed:@"CrossButton.png"];
                    else{
                        if(isOtherDetails==NO)
                            img=[UIImage imageNamed:@"PlusButton.png"];
                        else
                            img=[UIImage imageNamed:@"MinusButton.png"];
                    }
                    
                }
            }
			imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			
			lblOpening = [Design LabelFormation:35 :5 :150 :20 :0];
			lblOpening.text = @"Other Details";
			lblOpening.font = [UIFont boldSystemFontOfSize:15];
			//lblOpening.textColor =textcolorNew;//[UIColor whiteColor];
		}
        else if( isOtherDetails==YES)
        {
            
            
            if (indexPath.row==1){
                lblOpening.text = @"Venue Style :";
                lblOpeningDesc.text =[arrMain objectAtIndex:0];
            }
            else if (indexPath.row==2){
                lblOpening.text = @"Venue Capacity :";
                lblOpeningDesc.text =[arrMain objectAtIndex:1];
            }
            else if (indexPath.row==3){
                lblOpening.text = @"Nearest Rail :";
                lblOpeningDesc.text =[arrMain objectAtIndex:2];
            }
            else if (indexPath.row==4){
                lblOpening.text = @"Nearest Tube :";
                lblOpeningDesc.text =[arrMain objectAtIndex:3];
            }
            else if (indexPath.row==5){
                lblOpening.text = @"Local Buses :";
                lblOpeningDesc.text =[arrMain objectAtIndex:4];
            }
            // Set up the cell...
            
            [cell.contentView addSubview:lblOpeningDesc];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
	    }	
        [cell.contentView addSubview:lblOpening];
        [lblOpening release];
		[lblOpeningDesc release];
	}
    if(indexPath.section==4)
    {
        UILabel *lblPubBullets = [Design LabelFormation:10 :5 :100 :20 :0];
        UITextView *lblPubBulletsDesc = [Design textViewFormation:10 :5 :290 :40 :0];
        lblPubBulletsDesc.editable=NO;
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
            if(isPubBulletsExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isPubBulletsExpanded==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			}
            imgMain.image = img;
            
           [vw addSubview:imgMain];
            [imgMain release];
            
            lblPubBullets = [Design LabelFormation:35 :5 :150 :20 :0];
            lblPubBullets.text = @"Bullet Points";
            lblPubBullets.font = [UIFont boldSystemFontOfSize:15];
            // lblPubBullets.textColor =textcolorNew;//[UIColor whiteColor];
            [cell.contentView addSubview:lblPubBullets];
        }
        else if(isPubBulletsExpanded==YES){
            
            lblPubBulletsDesc.text =[arrMain objectAtIndex:0];
            
            // Set up the cell...
            [cell.contentView addSubview:lblPubBulletsDesc];
        }
        [lblPubBullets release];
        [lblPubBulletsDesc release];
        
    }	
    if(indexPath.section==5)
    {
        UILabel *lblPubDesc= [Design LabelFormation:10 :5 :100 :20 :0];
        UITextView *lblPubDescDetails= [Design textViewFormation:5 :5 :290 :50 :1];
        lblPubDescDetails.editable=NO;
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
            
            if(isDescriptionExpandedExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isDescriptionExpanded==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
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
            
            lblPubDescDetails.text =[arrMain objectAtIndex:0];
            NSLog(@"%@",lblPubDescDetails.text);
            [cell.contentView addSubview:lblPubDescDetails];
        }
        [lblPubDesc release];
        [lblPubDescDetails release];
    }
	
    
	
	if(indexPath.section==6)
	{
		UILabel *lblOneoffEvent= [Design LabelFormation:10 :5 :250 :20 :0];
		UILabel *lblEventDay = [Design LabelFormation:10 :20 :290 :20 :0];
		UILabel *lblOneoffEventDesc=[Design LabelFormation:10 :35 :270 :20 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			
            if(isOneOffEventexit==YES)
				
                img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(isoneoffEvent==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
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
		else if(isoneoffEvent==YES) {	
	        lblOneoffEvent.text = [arrMain objectAtIndex:0];
            lblEventDay.text = [arrMain objectAtIndex:1];
			lblOneoffEventDesc.text = [arrMain objectAtIndex:2];
			
            [cell.contentView addSubview:lblOneoffEvent];
            [cell.contentView addSubview:lblEventDay];
            [cell.contentView addSubview:lblOneoffEventDesc];
            
            [lblEventDay release];	
            [lblOneoffEvent release];
            [lblOneoffEventDesc release];
           	
//			if(indexPath.row>0)
//				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
	}
	if(indexPath.section==7)
	{
		UILabel *lblThemenightEvent= [Design LabelFormation:10 :5 :250 :20 :0];
		UILabel *lblEventDay = [Design LabelFormation:10 :20 :300 :20 :0];
		UILabel *lblOneoffEventDesc=[Design LabelFormation:10 :35 :270 :20 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			
            if(isThemeNightExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!isthemenightEvent)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
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
		
		else if(isthemenightEvent==YES) {
            
            
            lblThemenightEvent.text = [arrMain objectAtIndex:0];
            lblEventDay.text =[arrMain objectAtIndex:1];
			lblOneoffEventDesc.text = [arrMain objectAtIndex:2];            
			
		    [cell.contentView addSubview:lblThemenightEvent];
		    [cell.contentView addSubview:lblEventDay];
            [cell.contentView addSubview:lblOneoffEventDesc];
			[lblThemenightEvent release];
		    [lblOneoffEventDesc release];
			[lblEventDay release];
			
//			if(indexPath.row>0)
//				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
	}
	
	
	
	if(indexPath.section==8)
	{
		UILabel *lblSportsDes= [Design LabelFormation:10 :5 :100 :20 :0];
		UITextView *lblSportsDesCrip = [Design textViewFormation:10 :5 :285 :100 :0];
		lblSportsDesCrip.editable=NO;
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			if(isSportsDetailsExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!isSportsDetails)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
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
            
			lblSportsDesCrip.text = [arrMain objectAtIndex:0];
            
			[cell.contentView addSubview:lblSportsDesCrip];
		}
		[lblSportsDes release];
		[lblSportsDesCrip release];
	}	
	
	
	
	
	
	if(indexPath.section==9)
	{
		UILabel *lblSportsEventName= [Design LabelFormation:10 :1 :250 :20 :0];
		lblSportsEventName.numberOfLines = 2;
		lblSportsEventName.lineBreakMode = UILineBreakModeWordWrap;	
		UILabel *lblSportsEventType= [Design LabelFormation:10 :17 :200 :20 :0];
		UILabel *lblSportsSound = [Design LabelFormation:10 :33 :200 :20 :0 ];
		UILabel *lblSportsEventScreen= [Design LabelFormation:10 :48 :200 :20 :0];
		UILabel *lblSportsEventHD= [Design LabelFormation:10 :63 :200 :20 :0];
		UILabel *lblSportsEventDate= [Design LabelFormation:10 :77 :200 :20 :0];
		UILabel *lblSportsEventChannel= [Design LabelFormation:10 :91 :200 :20 :0];
		UILabel *lblSportsEvent3D= [Design LabelFormation:10 :105 :200 :20 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			if(issportsEventExit==YES)
				img=[UIImage imageNamed:@"CrossButton.png"];
			else{
                if(!app.issportsEvent)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
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
		else if(app.issportsEvent==YES) {
			
            lblSportsEventName.text = [arrMain objectAtIndex:0];
            lblSportsEventType.text = [arrMain objectAtIndex:1];
			lblSportsEventScreen.text = [arrMain objectAtIndex:2];
            lblSportsSound.text =[NSString stringWithFormat:@"%@ %@",[arrMain objectAtIndex:3],[arrMain objectAtIndex:4]];
            
            lblSportsEventHD.text = [arrMain objectAtIndex:5];
			lblSportsEventDate.text = [arrMain objectAtIndex:6];
            lblSportsEventChannel.text = [NSString stringWithFormat:@"%@ HD",[arrMain objectAtIndex:7]];
            lblSportsEvent3D.text = [NSString stringWithFormat:@"%@ 3D",[arrMain objectAtIndex:8]];
            
            [cell.contentView addSubview:lblSportsEventName];
            [cell.contentView addSubview:lblSportsEventType];
            [cell.contentView addSubview:lblSportsEventScreen];
            [cell.contentView addSubview:lblSportsSound];	
            [cell.contentView addSubview:lblSportsEventHD];
            [cell.contentView addSubview:lblSportsEventDate];
            [cell.contentView addSubview:lblSportsEventChannel];
            [cell.contentView addSubview:lblSportsEvent3D];
			
            [lblSportsEventName release];
            [lblSportsEventType release];
            [lblSportsEventScreen release];
            [lblSportsEventHD release];
            [lblSportsEventDate release];
            [lblSportsEventChannel release];
            [lblSportsSound release];
            [lblSportsEvent3D release];
            
//            if(indexPath.row>0)
//            {
//                cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
//            }
            
        }
        
	}	
    
	
    
	if(indexPath.section==10) {
        
		UILabel *lblFoodName= [Design LabelFormation:10 :5 :250 :20 :0];
		if(indexPath.row==0) {	
            
            
            lblFoodName.text = @"Food Details";
            lblFoodName.font = [UIFont boldSystemFontOfSize:15];
            // lblFoodName.textColor =textcolorNew;//[UIColor whiteColor];
		}
		
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
		[cell.contentView addSubview:lblFoodName];
		[lblFoodName release];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
	}
	if(indexPath.section==11) {
		
		
		UILabel *lblImage = [Design LabelFormation:10 :5 :200 :20 :0];
		
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 15,15)];
			if(!isImagesExpanded)
                img=[UIImage imageNamed:@"PlusButton.png"];
            else
                img=[UIImage imageNamed:@"MinusButton.png"];			imgMain.image = img;
			
			[vw addSubview:imgMain];
			[imgMain release];
			lblImage = [Design LabelFormation:35 :5 :100 :20 :0];
			lblImage.text = @"Photos";
			lblImage.font = [UIFont boldSystemFontOfSize:15];
			//lblImage.textColor =textcolorNew;//[UIColor whiteColor];
		}
		else if(isImagesExpanded==YES) {
			//ImageGroup *objImage1 = [[arrMain objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1];
            
			//lblImage.text = objImage1.Description;
            lblImage.text =@"TEST";
            
			
			
		}
        
		[cell.contentView addSubview:lblImage];
        
        
		[lblImage release];
        
	}
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IsSelect=YES;  
    section_value=indexPath.section;
    if(indexPath.row==0 ){
        
        NSLog(@"%d",indexPath.section);
        if(indexPath.section==0){
            
            if(indexPath.row==0)
            {
                
                [tableView cellForRowAtIndexPath:indexPath].backgroundView.backgroundColor=[UIColor darkGrayColor];
                
                NSLog(@"%d %@",indexPath.row,[tableView cellForRowAtIndexPath:indexPath]);
                if (isRegularEventExit==NO) {
                    
                    [self PrepareArrayList:0];
                }
                
            }
        }
        else if(indexPath.section==1){
            
            if(indexPath.row==0)
                [tableView cellForRowAtIndexPath:indexPath].backgroundView.backgroundColor=[UIColor darkGrayColor];
            NSLog(@"%d %@",indexPath.row,[tableView cellForRowAtIndexPath:indexPath]);
            [self PrepareArrayList:1];
            
        }
        else if(indexPath.section==2){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:2];
        }
        else if(indexPath.section==3){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:3];
        }
        else if(indexPath.section==4){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isPubBulletsExpandedExit==NO){
                [self PrepareArrayList:4];
            }
        }
        else if(indexPath.section==5){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            [self PrepareArrayList:5];
            
        }
        else if(indexPath.section==6){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isOneOffEventexit==NO){
                [self PrepareArrayList:6];
            }
            
        }
        else if(indexPath.section==7){
            
            if(indexPath.row==0)
                NSLog(@"%d",indexPath.row);
            if(isThemeNightExit==NO){
                [self PrepareArrayList:7];
            }
            
        }
        else if(indexPath.section==8){
            
            if(indexPath.row==0)
                
                NSLog(@"%d",indexPath.row);
            if(isSportsDetailsExit==NO){
                [self PrepareArrayList:8];
            }
            
        }
        else if(indexPath.section==9){
            
            if(indexPath.row==0)
                
                NSLog(@"%d",indexPath.row);
            if(issportsEventExit==NO){
                [self PrepareArrayList:9];
            }
            
        }
        else if(indexPath.section==10) {
            
            if(indexPath.row==0){
                
                NSLog(@"%d",indexPath.row);
                [self PrepareArrayList:10];
                FoodDetails_Microsite *obj_FoodDetails_Microsite=[[FoodDetails_Microsite alloc]initWithNibName:[Constant GetNibName:@"FoodDetails_Microsite"] bundle:[NSBundle mainBundle]];
                obj_FoodDetails_Microsite.category_Str=categoryStr;
                obj_FoodDetails_Microsite.Pubid=Pub_ID;
                [self.navigationController pushViewController:obj_FoodDetails_Microsite animated:YES];
                [obj_FoodDetails_Microsite release];
                
                
                
            }
        }
        
        else if(indexPath.section==11){
            
            
            if(indexPath.row==0) {
                
                //  [self PrepareArrayList:11];
                
                
                
            }  
            
            
        }	
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
		return 26;
	else{
		if(indexPath.section==3 )
			return 26;
		else if(indexPath.section==4) 
			return 80;
		else if(indexPath.section==5 || indexPath.section==6 || indexPath.section==7 )
			return 60;
		else if(indexPath.section==8)
			return 115;
		else if(indexPath.section==9 )//|| indexPath.section==10)
        {
            if(indexPath.row==1)
            {
                return 125;
            }
            else
            {
                return 26;
            }
            
        }
        else if(indexPath.section==0) 
        {
            if(indexPath.row==1)
            {
                return 65;
            }
            else
            {
                return 26;
            }
        }
        
        else
			return 26;
        
    }
}
-(void)PrepareArrayList:(int)Selection
{
    // [arrMain removeAllObjects];
    switch (Selection) {
            //			
        case 0:
            isregularEvent = YES;
            //app.isplus=NO;
             arr=[[SavePubDetailsInfo GetEvent_DetailsInfo:[Pub_ID intValue]]retain];
             
             [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Name"]];
             [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Date"]];
             [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Event_Description"]];
             [arr removeAllObjects];
            
            
         /* [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];  */
            
            
            
            
            isFoodDetail=NO;
            isGeneralExpanded=NO;
            isOpeningHr=NO;
            isOtherDetails=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isImagesExpanded=NO;
            break;
            
        case 1:
            
            
            isGeneralExpanded =YES;
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
            
            isFoodDetail=NO;
            isregularEvent=NO;
            isOpeningHr=NO;
            isOtherDetails=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isImagesExpanded=NO;
            break;
            
        case 2:
            isOpeningHr =YES;
            [arrMain removeAllObjects];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];
            [arrMain addObject:@"TEST_Address"];  
            
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO;        
            break;
            
        case 3:
            isOtherDetails=YES;
            [arrMain removeAllObjects];
            
            arr=[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueStyle"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"VenueCapacity"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestRail"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"NearestTube"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"LocalBuses"]];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO;   
            break;
            
        case 4:
            isPubBulletsExpanded = YES;
            [arrMain removeAllObjects];
            [arrMain addObject:@"TEST_PhoneNumber"];
            [arrMain addObject:@"TEST_NameLastName"];
            [arrMain addObject:@"TEST_NameLastName"];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO;   
            break;
            
        case 5:
            isDescriptionExpanded= YES;
            [arrMain removeAllObjects];
            arr=[SavePubDetailsInfo GetPubDetailsInfo:[Pub_ID intValue]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"PubDescription"]];
            [arr removeAllObjects];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO;   
            
            
            break;
            
        case 6:
            
            if (isOneOffEventexit==NO) {
                
                isoneoffEvent = YES;
            }
            [arrMain removeAllObjects];
            
            arr=[SavePubDetailsInfo GetEvent_DetailsInfo:[EventId intValue]];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Name"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Date"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Event_Description"]];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO;
            //isoneoffEvent=YES;
            break;
            
            
        case 7:
            if(isthemenightEvent==NO){
                isthemenightEvent = YES;
            }
            [arrMain removeAllObjects];
            arr=[SavePubDetailsInfo GetEvent_DetailsInfo:[EventId intValue]];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Name"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Date"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Event_Description"]];
            [arr removeAllObjects];  
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO; 
            break;
            
        case 8:
            isSportsDetails = YES;
            [arrMain removeAllObjects];
            arr=[SaveSportDetailInfo GetSport_EventInfo_Details:[Pub_ID intValue]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sport_Description"]];
            [arr removeAllObjects];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO; 
            
            break;
            
        case 9:
            
            
            app.issportsEvent = YES;
            [arrMain removeAllObjects];
            arr=[SaveSportDetailInfo GetSport_EventInfo_Details:[Pub_ID intValue]];
            
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Type"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sport_EventName"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Channel"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sport_Date"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Time"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Screen"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"Sound"]];
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"HD"]];                                                                                  
            [arrMain addObject:[[arr objectAtIndex:0]valueForKey:@"ThreeD"]]; 
            [arr removeAllObjects];
            
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            isFoodDetail=NO;
            isImagesExpanded=NO; 
            
            
            break;
            
            
        case 10:
            isFoodDetail = NO;
            [arrMain removeAllObjects];
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isImagesExpanded=NO; 
            
            break;
            
        case 11:
            isImagesExpanded = YES;
            [arrMain removeAllObjects];
            [arrMain addObject:@"TEST_PhoneNumber"];
            [arrMain addObject:@"TEST_NameLastName"];
            [arrMain addObject:@"TEST_NameLastName"];
            [arrMain addObject:@"TEST_NameLastName"];
            
            
            
            isregularEvent=NO;
            isGeneralExpanded=NO;
            isOtherDetails=NO;
            isOpeningHr=NO;
            isPubBulletsExpanded=NO;
            isDescriptionExpanded=NO;
            isoneoffEvent=NO;
            isthemenightEvent=NO;
            isSportsDetails=NO;
            app.issportsEvent=NO;
            isFoodDetail=NO; 
            
            break;
            
            
        default:
            break;
    }
    [my_table reloadData];
}





- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //self.table = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        toolBar.frame = CGRectMake(0, 387, 320, 48);
        
    }
    else{
        toolBar.frame = CGRectMake(0, 240, 480, 48);
        
    }
    return YES;
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
    [super dealloc];

}
@end

