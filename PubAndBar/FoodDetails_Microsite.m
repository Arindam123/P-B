//
//  PubDetailsSubCatagory.m
//  PubAndBar
//
//  Created by Apple on 21/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "FoodDetails_Microsite.h"
#import "Design.h"
#import "PubDetail.h"
#import "SavePubDetailsSubCatagoryInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "ASIHTTPRequest.h"

@implementation FoodDetails_Microsite
@synthesize table;
@synthesize backButton;
@synthesize datelbl;
@synthesize lbl_heading;
@synthesize Name;
@synthesize Array_section;
@synthesize arr;
@synthesize arr_FoodDetails;
@synthesize arrMain;
@synthesize category_Str;
@synthesize Pubid;
@synthesize IsFood,IsChefDesc,IsServeTime,IsInformation,IsSpecialOffers;
@synthesize dic;
@synthesize hud = _hud;
@synthesize oAuthLoginView;
@synthesize btn_Venu;
@synthesize img_1stLbl;
@synthesize header_DictionaryData;
@synthesize OpenDayArray,OpenHourArray;
@synthesize bulletPointArray;
@synthesize FoodID;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    toolBar = [[Toolbar alloc]init];
   // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];

    // Do any additional setup after loading the view from its nib.
   Array_section=[[NSMutableArray alloc]init];
    arr=[[NSMutableArray alloc]init];
    arr_FoodDetails=[[NSMutableArray alloc]init];
    arrMain=[[NSMutableArray alloc]init];
    Array_section = [[NSMutableArray alloc]initWithObjects:@"Information",@"Food Serving Times",@"Chef Description",@"Special Offers",@"Food Types Available",nil]; 
    
    [self CreateView];
    IsInformation=YES;
     arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
    
    
}

-(void)CreateView{
    table = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 300)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
   // table.separatorColor = [UIColor blackColor];
    
     
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
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.text=@"Food Details";
    lbl_heading.font = [UIFont boldSystemFontOfSize:12];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.backgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
   
            
    
    btn_Venu=[[UIButton alloc]initWithFrame:CGRectMake(100, 380, 135, 40)];
    [btn_Venu addTarget:self action:@selector(ClickShowDetails:) forControlEvents:UIControlEventTouchUpInside];
    //[btn_Venu setTitle:@"Venue Information" forState:UIControlStateNormal];
    [btn_Venu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_Venu.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_Venu.backgroundColor=[UIColor clearColor];
    
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VenueButton.png"]];
    
    
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table];
    [self.view addSubview:btn_Venu];
    [btn_Venu addSubview:img_1stLbl];
    //[self.view addSubview:btn_Venu];
   // [lbl_heading release];
    [backButton release];
    //[datelbl release];
    //[btn_Venu release];
}
-(IBAction)ClickShowDetails:(id)sender
{
    PubDetail *obj_PubDetail=[[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
    
    obj_PubDetail.categoryStr=category_Str;
    obj_PubDetail.Pub_ID=Pubid;
    obj_PubDetail.headerDictionaryData=header_DictionaryData;
    
    obj_PubDetail.bulletPointArray=[bulletPointArray copy];
    obj_PubDetail.OpenDayArray=[OpenDayArray copy];
    obj_PubDetail.OpenHourArray=[OpenHourArray copy];
    //btn_Venu.hidden=YES;
    
    [self.navigationController pushViewController:obj_PubDetail animated:YES];
    [obj_PubDetail release];
    
}

-(IBAction)ClickBack:(id)sender{
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];

    IsInformation=NO;
    IsServeTime=NO;
    IsChefDesc=NO;
    IsSpecialOffers=NO;
    IsFood=NO;

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    
    else{
        if ([Constant isPotrait:self]) {
            
            
            table.frame=CGRectMake(10, 120, 300, 253);
            lbl_heading.frame = CGRectMake(98, 90, 125, 25);
            backButton.frame =CGRectMake(8, 90, 50, 25);
            btn_Venu.frame=CGRectMake(90, 377, 140, 40);
            datelbl.frame = CGRectMake(230, 10, 125, 27);
           // btn_Venu.frame=CGRectMake(90, 330, 140, 40);
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
          
            if (delegate.Isvenue==YES) {
               
               table.frame=CGRectMake(10, 120, 300, 253);
            }
                          

            if (delegate.ismore==YES) {
               // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
           
        }
        
        else{
            table.frame=CGRectMake(10, 117, 460, 100);
            lbl_heading.frame = CGRectMake(177, 86, 135, 20);
            backButton.frame = CGRectMake(20, 85, 50, 25);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
            btn_Venu.frame=CGRectMake(170, 220, 140, 40);
            if (delegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            datelbl.frame = CGRectMake(365, 14, 125, 27);
         
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
            
            if (delegate.Isvenue==YES) {
                table.frame=CGRectMake(10, 117, 460, 100);          
            }

          
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   // delegate.ismore=NO;
     delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    
    if (delegate.Isvenue==YES) {
        btn_Venu.hidden=YES;
        self.eventTextLbl.text=[NSString stringWithFormat:@"Food"];
        if ([Constant isiPad]) {
            ;
        }
        
        else{
            if ([Constant isPotrait:self]) {
                
                 table.frame=CGRectMake(0, 69, 320, 303);
            }
            else
            {
                table.frame=CGRectMake(0, 61, 480, 160);
            }
        }
        
    }
    else
    {
         self.eventTextLbl.text=category_Str;
        btn_Venu.hidden=NO;
    }
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
     [self AddNotification];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [Array_section count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    
               
  
        if(section==0){
            if ( IsInformation==YES)
                return 2;
            else
                return 1;
            
        }
        
        else if(section==1)
        {
            if(IsServeTime==YES)
                return 2;
            else
                return 1;
            
        }  
        else if(section==2){
            if( IsChefDesc==YES)
                return 2;
            else
                return 1;
        }
        
        
        else if(section==3)
        {
            if(IsSpecialOffers==YES)
                return 2;
            else
                return 1;
        }
        
        else if(section==4){
            
            if(IsFood==YES)
                return [arr count];
            else
                return 1;
        }
                       
        else
            return 0;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1; 
}





// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell ; 
	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
    UIView *vw = [[[UIView alloc]init]autorelease];
    vw.frame =CGRectMake(-11, 2, 380, 42);
    vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    
    vw.backgroundColor = [UIColor whiteColor];
    
    
    if ( IsInformation==YES){
         vw.backgroundColor =[UIColor clearColor];
    }
    
    
    
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
         else
            {
              vw.backgroundColor =[UIColor whiteColor];
            }
    
    [cell.contentView addSubview:vw];

	
	NSLog(@"%d",indexPath.section);
    
    if(indexPath.section==0)
    {
		UILabel *lblRegularEvent= [Design LabelFormation:10 :5 :250 :20 :0];
		UILabel *lblEventDay = [Design LabelFormation:10 :20 :290 :20 :0];
        UITextView *lblRegularEventDesc = [Design textViewFormation:5 :7 :320 :60 :0];
        lblRegularEventDesc.editable=NO;
        lblRegularEventDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
           
                
                if(IsInformation == YES)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			
			imgMain.image =img;
            //imgMain.image = img;
			
			[cell.contentView addSubview:imgMain];
			
			[imgMain release];
			
			lblRegularEvent = [Design LabelFormation:35 :7 :190 :20 :0];
			lblRegularEvent.text = [Array_section objectAtIndex:indexPath.section];
			lblRegularEvent.font = [UIFont boldSystemFontOfSize:15];
			//lblRegularEvent.textColor =textcolorNew;//[UIColor whiteColor];
			[cell.contentView addSubview:lblRegularEvent];
		}
        else if (IsInformation == YES){
                    
                lblRegularEventDesc.text =[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_Information" ];
             [cell.contentView addSubview:lblRegularEventDesc];
           
        }

                [lblRegularEvent release];
                [lblEventDay release];
                [lblRegularEventDesc release];
                
    }      
	
	if(indexPath.section==1)
	{
        UILabel *lblPubGeneral = [Design LabelFormation:10 :5 :100 :20 :0];
        
        
        UITextView  *lblPubGeneralDisp = [Design textViewFormation:5 :7 :320 :60 :0];
        lblPubGeneralDisp.editable=NO;
        lblPubGeneralDisp.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
       // lblPubGeneralDisp.backgroundColor=[UIColor redColor];
		
		NSLog(@"%d",indexPath.row);	
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			
            if(IsServeTime==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
					
			imgMain.image = img;
			[cell.contentView addSubview:imgMain];
			[imgMain release];
			lblPubGeneral = [Design LabelFormation:35 :7 :190 :20 :0];
			lblPubGeneral.text =[Array_section objectAtIndex:indexPath.section];
			lblPubGeneral.font = [UIFont boldSystemFontOfSize:15];
			//lblPubGeneral.textColor =textcolorNew;//[UIColor whiteColor];
		}
		else if (IsServeTime == YES){
                
                 lblPubGeneralDisp.text =[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_ServingTime" ];

        // cell.textLabel.text=[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_ServingTime" ];
              
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
        UITextView *lblOpeningDesc = [Design textViewFormation:5 :8 :320 :70 :0];
         lblOpeningDesc.editable=NO;
        lblOpeningDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
              
        if (indexPath.row==0){				
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
           
            if(IsChefDesc==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			
            imgMain.image = img;
            
            [cell.contentView addSubview:imgMain];
            [imgMain release];
            
            lblOpening = [Design LabelFormation:35 :7 :170 :20 :0];
            lblOpening.text =[Array_section objectAtIndex:indexPath.section];
            lblOpening.font = [UIFont boldSystemFontOfSize:15];
            // lblOpening.textColor =textcolorNew;//[UIColor whiteColor];
        }
        else if ( IsChefDesc == YES){
                
                lblOpeningDesc.text =[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_ChefDescription" ];


        
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
		UITextView *lblOpeningDesc = [Design textViewFormation:5 :20 :320 :40 :0];
        lblOpeningDesc.editable=NO;
        lblOpeningDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        

		if (indexPath.row==0){				
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
			
                if(IsSpecialOffers==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			
			imgMain.image = img;
			
			[cell.contentView addSubview:imgMain];
			[imgMain release];
			
			lblOpening = [Design LabelFormation:35 :7 :200 :20 :0];
			lblOpening.text = [Array_section objectAtIndex:indexPath.section];
			lblOpening.font = [UIFont boldSystemFontOfSize:15];
			//lblOpening.textColor =textcolorNew;//[UIColor whiteColor];
		}
        
        else if ( IsSpecialOffers == YES){
                
                lblOpeningDesc.text =[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_SpecialOffer" ];


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
        UITextView *lblPubBulletsDesc = [Design textViewFormation:10 :0 :290 :33 :0];
        lblPubBulletsDesc.editable=NO;
        lblPubBulletsDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
        
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 14,7)];
            
            if(IsFood==NO)
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                else
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
			
            imgMain.image = img;
            
            [cell.contentView addSubview:imgMain];
            [imgMain release];
            
            lblPubBullets = [Design LabelFormation:35 :7 :200 :20 :0];
            lblPubBullets.text = [Array_section objectAtIndex:indexPath.section];
            lblPubBullets.font = [UIFont boldSystemFontOfSize:15];
            // lblPubBullets.textColor =textcolorNew;//[UIColor whiteColor];
            [cell.contentView addSubview:lblPubBullets];
        }
       
        else if ( IsFood == YES){
                for (int i=0; i<[arr count]; i++) {
                    if (indexPath.row==i+1)
                    
                    
                    lblPubBulletsDesc.text =[arr objectAtIndex:i];
    
        
   
            // Set up the cell...
            [cell.contentView addSubview:lblPubBulletsDesc];
          }
        }
        [lblPubBullets release];
        [lblPubBulletsDesc release];
        
    }
       
    
/*	if(indexPath.row==0 )
        cell.backgroundColor=[[UIColor alloc]initWithRed:186.0f/255 green:180.0f/255 blue:137.0f/255 alpha:1.0]; 
	else 
	{
        if(indexPath.row%2==0)
        {
            cell.backgroundColor =[[UIColor alloc]initWithRed:243.0f/255 green:242.0f/255 blue:224.0f/255 alpha:1.0];
        }
		else
		{
            cell.backgroundColor =[[UIColor alloc]initWithRed:237.0f/255 green:229.0f/255 blue:190.0f/255 alpha:1.0];
		}
		
	}*/
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	

	
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    IsSelect=YES;
     section_value=indexPath.section;
    
    if(indexPath.row==0 ){
        NSLog(@"%d",indexPath.section);
        if(indexPath.section==0){
            
            if(indexPath.row==0)
            {
                NSLog(@"%d",indexPath.row);
                IsInformation=YES;
                arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
            
                IsServeTime=NO;
                IsChefDesc=NO;
                IsSpecialOffers=NO;
                IsFood=NO;
                //[self PrepareArrayList:0];
            }
        }
        else if(indexPath.section==1){
            //if(!isPubOpeningHrsExpandedexit)
            //	return;
            //  app.tabselection  = 1;
            if(indexPath.row==0)
             NSLog(@"%d",indexPath.row);
            IsServeTime=YES;
            arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
            IsInformation=NO;
            IsChefDesc=NO;
            IsSpecialOffers=NO;
            IsFood=NO;
            //[self PrepareArrayList:1];
            
        }
        else if(indexPath.section==2){
            // app.tabselection = 2;
            if(indexPath.row==0)
                //  [self PrepareArrayList:2 :isOtherDetails];
                NSLog(@"%d",indexPath.row);
            IsChefDesc=YES;
             arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
            IsInformation=NO;
            IsServeTime=NO;
            IsSpecialOffers=NO;
            IsFood=NO;
        }
        else if(indexPath.section==3){
            
            // app.tabselection = 3;
            if(indexPath.row==0)
                //  [self PrepareArrayList:3 :isPubBulletsExpanded];
                NSLog(@"%d",indexPath.row);
            IsSpecialOffers=YES;
           // [self PrepareArrayList:3];
             arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
            IsInformation=NO;
            IsServeTime=NO;
            IsChefDesc=NO;
            IsFood=NO;
        }
        else if(indexPath.section==4){
            
              if(indexPath.row==0)
                // [self PrepareArrayList:4 :isDescriptionExpanded];
                NSLog(@"%d",indexPath.row);
            IsFood=YES;
            arr=[[SavePubDetailsSubCatagoryInfo GetFoodTypeInfo:[Pubid intValue]]retain];
            IsInformation=NO;
            IsServeTime=NO;
            IsChefDesc=NO;
            IsSpecialOffers=NO;
            
        }
                       
    }
    
[table reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
		return 35;
	
    else if(indexPath.row==4)
        return 28;
    else if(indexPath.section==4)
    {
        if(indexPath.row!=0)
        {
            return 32;
        }
        else
            return 26;
    }
    else if(indexPath.section==2)
    {
        if(indexPath.row!=0)
        {
            return 80;
        }
        else
            return 26;
    }
    
    else if(indexPath.section==1){
        
        if(indexPath.row!=0)
        {
            return 75;
        }
        else
            return 26;
//        CGSize textSize = [[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_ServingTime" ] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(self.table.frame.size.width - 10.0 * 3, 1000.0f)];
//        
//        return textSize.height + 10.0 * 5;
    }

    
    else
        return 70;
		
}


//-(IBAction)ClickShowDetails:(id)sender
//{
//    PubDetail *obj_PubDetail=[[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetailsSubCatagory"] bundle:[NSBundle mainBundle]];
//    
//    obj_PubDetail.categoryStr=category_Str;
//        
//    [self.navigationController pushViewController:obj_PubDetail animated:YES];
//    [obj_PubDetail release];
//
//}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    [arrMain release];
    [Array_section release];
    [arr release];
    [arr_FoodDetails release];
    [datelbl release];
    [lbl_heading release];
     [toolBar release];
    [OpenHourArray release];
    [OpenDayArray release];
    [bulletPointArray release];
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pubid intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }
    

    
     obj.textString=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
    
     
    
   
    
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
//            if ([str_mail isEqualToString:@"No Info"])
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No mail Id exist......." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//                [alert release];
//                
//            }
//            else{
                [self displayEmailComposerSheet];
            //}
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pubid intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }

    
     NSString *fbText=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
    
       
    
     [mailController setMessageBody:[NSString stringWithFormat:@"%@",fbText] isHTML:NO];
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pubid intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }
    
    
   obj.shareText=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
    
    
   
    
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/food_%@_%@_%@_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pubid intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }
    
    
    NSString *fbText=[NSString stringWithFormat:@"Pubs and Bars available Foods info at %@ %@ %@ %@ %@",[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
    
    

    

    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = [NSString stringWithFormat:@"%@",fbText];
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
    NSString *fbText=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/FoodResult.php?f%5B%d%5D=on",[FoodID intValue]];
    
    
    
      NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     fbText,@"message",
     //@"Want to share through Greetings", @"description",
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
