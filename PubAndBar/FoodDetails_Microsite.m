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
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];

    // Do any additional setup after loading the view from its nib.
   Array_section=[[NSMutableArray alloc]init];
    arr=[[NSMutableArray alloc]init];
    arr_FoodDetails=[[NSMutableArray alloc]init];
    arrMain=[[NSMutableArray alloc]init];
    Array_section = [[NSMutableArray alloc]initWithObjects:@"Information",@"Food Serving Times",@"Chef Description",@"Special Offers",@"Foods",nil]; 
    
    [self CreateView];
    
    
}

-(void)CreateView{
    table = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 300)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    table.separatorColor = [UIColor blackColor];
    
 /*   UIButton *btn_Venu=[[UIButton alloc]initWithFrame:CGRectMake(100, 380, 120, 30)];
    [btn_Venu addTarget:self action:@selector(ClickShowDetails:) forControlEvents:UIControlEventTouchUpInside];
    [btn_Venu setTitle:@"Venue Information" forState:UIControlStateNormal];
    [btn_Venu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_Venu.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_Venu.backgroundColor=[UIColor whiteColor];*/

    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
   [backButton setImage:[UIImage imageNamed:@"BackWhiteButtonTwo.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    datelbl = [[UILabel alloc]init];
    datelbl.textColor = [UIColor whiteColor];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.font = [UIFont boldSystemFontOfSize:9];
    
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:10];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.hidden=YES;
   
 /*   if([category_Str isEqualToString: @"Sports on TV" ]){
        lbl_heading.text = @"Choose a Sport";
        lbl_heading.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
    }
    else if([category_Str isEqualToString:@"Food & Offers" ]){
        lbl_heading.text = @"Choose a Food";
        lbl_heading.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];    
       
        arr_FoodDetails=[[SavePubDetailsSubCatagoryInfo GetFoodDetailsInfo:[Pubid intValue]]retain];
        arr=[[SavePubDetailsSubCatagoryInfo GetFoodTypeInfo:[Pubid intValue]]retain];
       
        Array_section = [[NSMutableArray alloc]initWithObjects:@"Information",@"Food Serving Times",@"Chef Description",@"Special Offers",@"Foods",nil]; 
        
    }
    else if(category_Str==@"Facilities"){
        lbl_heading.text = @"Amenities";
        lbl_heading.backgroundColor = [UIColor clearColor];
    }
       
       
    else if([category_Str isEqualToString:@"Real Ale" ]){
        lbl_heading.text = @"Choose a Theme Night";
        lbl_heading.backgroundColor = [UIColor clearColor];
         Array_section = [[NSMutableArray alloc]initWithObjects:@"Broadside Adnams",@"Bitter Adnams",@"Gunhill Adnams",@"Best Bitter Black Sheep",@"Abbot Ale Greene King",@"Wandle Sambrooks Brewery Ltd",nil]; 
        
    }*/
           
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table];
    //[self.view addSubview:btn_Venu];
    //[lbl_heading release];
    [backButton release];
    //[datelbl release];
    //[btn_Venu release];
}

-(IBAction)ClickBack:(id)sender{
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
            
            table.frame=CGRectMake(0, 44, 320, 272);
            lbl_heading.frame = CGRectMake(100, 10, 125, 27);
            backButton.frame = CGRectMake(10, 15, 50, 20);
            datelbl.frame = CGRectMake(230, 10, 125, 27);
        }
        
        else{
            table.frame=CGRectMake(0, 45, 480, 150);
            lbl_heading.frame = CGRectMake(200, 14, 125, 27); 
            backButton.frame = CGRectMake(20, 15, 50, 20);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
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



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell ; 
	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	
	NSLog(@"%d",indexPath.section);
    
    if(indexPath.section==0)
    {
		UILabel *lblRegularEvent= [Design LabelFormation:10 :5 :250 :20 :0];
		UILabel *lblEventDay = [Design LabelFormation:10 :20 :290 :20 :0];
        UILabel *lblRegularEventDesc = [Design LabelFormation:10 :20 :140 :20 :0];
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15,15)];
           
                
                if(IsInformation == YES)
                    img=[UIImage imageNamed:@"MinusButton.png"];
                
                else
                    img=[UIImage imageNamed:@"PlusButton.png"];
			
			imgMain.image =img;
            //imgMain.image = img;
			
			[cell.contentView addSubview:imgMain];
			
			[imgMain release];
			
			lblRegularEvent = [Design LabelFormation:35 :7 :190 :20 :0];
			lblRegularEvent.text = [Array_section objectAtIndex:indexPath.section];
			lblRegularEvent.font = [UIFont boldSystemFontOfSize:16];
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
        UILabel  *lblPubGeneralDisp = [Design LabelFormation:95 :-5 :210 :40 :0];
		
		NSLog(@"%d",indexPath.row);	
		if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15,15)];
			
            if(IsServeTime==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
					
			imgMain.image = img;
			[cell.contentView addSubview:imgMain];
			[imgMain release];
			lblPubGeneral = [Design LabelFormation:35 :7 :190 :20 :0];
			lblPubGeneral.text =[Array_section objectAtIndex:indexPath.section];
			lblPubGeneral.font = [UIFont boldSystemFontOfSize:16];
			//lblPubGeneral.textColor =textcolorNew;//[UIColor whiteColor];
		}
		else if (IsServeTime == YES){
                
                 lblPubGeneralDisp.text =[[arr_FoodDetails objectAtIndex:0]valueForKey:@"Food_ServingTime" ];


              
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
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15,15)];
           
            if(IsChefDesc==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			
            imgMain.image = img;
            
            [cell.contentView addSubview:imgMain];
            [imgMain release];
            
            lblOpening = [Design LabelFormation:35 :7 :190 :20 :0];
            lblOpening.text =[Array_section objectAtIndex:indexPath.section];
            lblOpening.font = [UIFont boldSystemFontOfSize:16];
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
		UILabel *lblOpeningDesc = [Design LabelFormation:105 :5 :190 :20 :0];
		if (indexPath.row==0){				
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15,15)];
			
                if(IsSpecialOffers==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			
			imgMain.image = img;
			
			[cell.contentView addSubview:imgMain];
			[imgMain release];
			
			lblOpening = [Design LabelFormation:35 :7 :200 :20 :0];
			lblOpening.text = [Array_section objectAtIndex:indexPath.section];
			lblOpening.font = [UIFont boldSystemFontOfSize:16];
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
        UITextView *lblPubBulletsDesc = [Design textViewFormation:10 :5 :290 :40 :0];
        lblPubBulletsDesc.editable=NO;
        if (indexPath.row==0){
            UIImage *img;
            UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 15,15)];
            
            if(IsFood==NO)
                    img=[UIImage imageNamed:@"PlusButton.png"];
                else
                    img=[UIImage imageNamed:@"MinusButton.png"];
			
            imgMain.image = img;
            
            [cell.contentView addSubview:imgMain];
            [imgMain release];
            
            lblPubBullets = [Design LabelFormation:35 :7 :200 :20 :0];
            lblPubBullets.text = [Array_section objectAtIndex:indexPath.section];
            lblPubBullets.font = [UIFont boldSystemFontOfSize:16];
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
       
    
	if(indexPath.row==0 )
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
		
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	
	
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
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
        return 40;
    else
        return 60;
		
}


-(IBAction)ClickShowDetails:(id)sender
{
    PubDetail *obj_PubDetail=[[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetailsSubCatagory"] bundle:[NSBundle mainBundle]];
    
    obj_PubDetail.categoryStr=category_Str;
        
    [self.navigationController pushViewController:obj_PubDetail animated:YES];
    [obj_PubDetail release];

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    [arrMain release];
    [Array_section release];
    [arr release];
    [arr_FoodDetails release];
    [datelbl release];
    [lbl_heading release];
     [toolBar release];
    [super dealloc];
   
    
}

@end
