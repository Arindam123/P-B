//
//  RealAle_Microsite.m
//  PubAndBar
//
//  Created by Apple on 22/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "RealAle_Microsite.h"
#import "Design.h"
#import "PubDetail.h"
#import "SaveRealAleDetailsInfo.h"
#import <QuartzCore/QuartzCore.h>


@implementation RealAle_Microsite
@synthesize table;
@synthesize backButton;
@synthesize datelbl;
@synthesize lbl_heading;
@synthesize Name;
@synthesize arrSubMain;
@synthesize arrMain;
@synthesize category_Str;
@synthesize Pubid;
@synthesize arrRealAlyInfo;
@synthesize arrBeerInfo;
@synthesize arrMode;
@synthesize header_DictionaryData;
@synthesize btn_Venu;
@synthesize img_1stLbl;
/*
BOOL IsBroadside;
BOOL IsBitterAdnams;
BOOL IsGunhillAdnams;
BOOL IsBestBitter;
BOOL IsAbbot;
BOOL IsWandle;*/



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
    arrRealAlyInfo=[[NSMutableArray alloc]init];
    arrSubMain=[[NSMutableArray alloc]init];
    arrMain=[[NSMutableArray alloc]init];
    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];

        
    arrRealAlyInfo =[[SaveRealAleDetailsInfo GetRealAleTypeInfo:[Pubid intValue]]retain];
	arrBeerInfo=[[SaveRealAleDetailsInfo GetAleBeerDetailsInfo:[Pubid intValue]]retain];
    
	for (int i=0; i<[arrRealAlyInfo count]; i++) {
		[arrMode addObject:[NSString stringWithFormat:@"0"]];
	}
	
	
	[self PrepareArrayList:0:[[arrMode objectAtIndex:0]boolValue]];

    [self CreateView];

}

-(void)CreateView{
    table = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 300)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    table.separatorColor = [UIColor blackColor];
    
    btn_Venu=[[UIButton alloc]initWithFrame:CGRectMake(100, 380, 135, 40)];
    [btn_Venu addTarget:self action:@selector(ClickShowDetails:) forControlEvents:UIControlEventTouchUpInside];
    //[btn_Venu setTitle:@"Venue Information" forState:UIControlStateNormal];
    [btn_Venu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_Venu.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_Venu.backgroundColor=[UIColor clearColor];
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VenueButton.png"]];

    
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
    
      
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table];
    [self.view addSubview:btn_Venu];
    [btn_Venu addSubview:img_1stLbl];
    //[lbl_heading release];
    [backButton release];
    //[datelbl release];
    [btn_Venu release];
}

-(IBAction)ClickBack:(id)sender{
   
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
            btn_Venu.frame=CGRectMake(100, 335, 135, 40);
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
            
        }
        
        else{
            table.frame=CGRectMake(0, 45, 480, 150);
            lbl_heading.frame = CGRectMake(200, 14, 125, 27); 
            backButton.frame = CGRectMake(20, 15, 50, 20);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
            btn_Venu.frame=CGRectMake(180, 190, 135, 40);
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
            
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
    return [arrMain count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%d",[[arrMain objectAtIndex:section] count]);
	return [[arrMain objectAtIndex:section]count]+1;
	
	
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//	if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	//	  }
	
	//NSMutableArray *arr = [arrMain objectAtIndex:indexPath.section];
	SaveRealAleDetailsInfo *objSaveRealAleDetailsInfo;
	objSaveRealAleDetailsInfo =[[SaveRealAleDetailsInfo alloc]init];
	objSaveRealAleDetailsInfo =[arrBeerInfo objectAtIndex:indexPath.section];
	UILabel *lblFoodInfo = [Design LabelFormation:10 :5 :100 :20 :0];
	UITextView *lblFoodInfoDetials = [Design textViewFormation:90 :0 :200 :125 :0];//125
	lblFoodInfoDetials.editable=NO;
    
	if(indexPath.row ==0)
	{
		//UILabel *lblFoodInfo = [Design LabelFormation:10 :5 :100 :20 :0];
		//UITextView *lblFoodInfoDetials = [Design textViewFormation:90 :3 :290 :125 :0];
		
		
		//objRealAleInfoProperties =[[RealAleInfoProperties alloc]init];
		//objRealAleInfoProperties =[arrRealAlyInfo objectAtIndex:indexPath.section];
		lblFoodInfo = [Design LabelFormation:35 :7 :300 :20 :0];
		
        lblFoodInfo.text = [NSString stringWithFormat:@"%@ %@",[[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Name"],[[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Catagory"]];
		
        lblFoodInfo.font = [UIFont boldSystemFontOfSize:12];
		//lblFoodInfo.textColor =textcolor;//[UIColor whiteColor];
		[cell.contentView addSubview:lblFoodInfo];
		
		
		UIImage *img;
		UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 25,25)];
		if([[arrMode objectAtIndex:indexPath.section] boolValue])
			img=[UIImage imageNamed:@"PlusButton.png"];
		else
			img=[UIImage imageNamed:@"MinusButton.png"];
		
		imgMain.image = img;
		
		[cell.contentView addSubview:imgMain];
	}
	else
	{
		if(indexPath.row ==1)
		{
            lblFoodInfo.text = @"Beer Title :";
            lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Name"];
            [cell.contentView addSubview:lblFoodInfo];
            [cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==2) {
			lblFoodInfo.text = @"Brewery :";
			lblFoodInfoDetials.text =[[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Catagory"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==3) {
			lblFoodInfo.text = @"ABV % :";
			lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer ABV"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==4) {
			lblFoodInfo.text = @"See :";
			lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Color"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==5) {
			lblFoodInfo.text = @"Smell :";
			lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Smell"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==6) {
			lblFoodInfo.text = @"Taste :";
			lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Taste"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==7) {
			lblFoodInfo.text = @"Brewery Name :";
			lblFoodInfoDetials.text = [[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"Beer_Name"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==8) {
			lblFoodInfo.text = @"Website URL :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_Website"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==9) {
			lblFoodInfo.text = @"address :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_Address"];
			//lblFoodInfoDetials.frame = CGRectMake(90,-10,200,50);
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==10) {
			lblFoodInfo.text = @"Postcode :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_Postcode"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==11) {
			lblFoodInfo.text = @"Contact Name :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_ContactName"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==12) {
			lblFoodInfo.text = @"Phone Number :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_PhoneNumber"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
			
           			
		}
		else if(indexPath.row==13) {
			lblFoodInfo.text = @"Email :";
			lblFoodInfoDetials.text = [[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_MailID"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==14) {
			lblFoodInfo.text = @"District :";
			lblFoodInfoDetials.text =[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_District"];
			[cell.contentView addSubview:lblFoodInfo];
			[cell.contentView addSubview:lblFoodInfoDetials];
		}
		else if(indexPath.row==15) {
			
			UITextView *txtvwRealAleDesc = [Design textViewFormation:100 :0 :200 :37 :0];
			
			txtvwRealAleDesc.backgroundColor =[UIColor clearColor];
			txtvwRealAleDesc.editable =NO;
			txtvwRealAleDesc.text =[[arrBeerInfo objectAtIndex:indexPath.section]valueForKey:@"License_Note"];
			txtvwRealAleDesc.textColor =[UIColor blackColor];
			lblFoodInfo.text = @"Licensee Notes:";
			//lblFoodInfoDetials.text = objRealAleInfoProperties.licenseenotes;
			[cell.contentView addSubview:lblFoodInfo];
			//[cell.contentView addSubview:lblFoodInfoDetials];
			[cell.contentView addSubview:txtvwRealAleDesc];
		}
		
		
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 	//valuofarrindex =indexPath.row;
	if(indexPath.row==0)
		[self PrepareArrayList:indexPath.section :[[arrMode objectAtIndex:indexPath.section]boolValue]];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
		return 35;
	else
        return 25;
    
    }
-(void)PrepareArrayList:(int)Selection:(BOOL)Mode{
	
	//RealAleInfoProperties *objRealAleInfoProperties =[[RealAleInfoProperties alloc]init];
	
	[arrMain removeAllObjects];
	for (int i=0; i<[arrRealAlyInfo count]; i++) {
		if(Selection ==i)
		{
			if(!Mode)
			{
				arrSubMain = [[NSMutableArray alloc]init];
		/*		objRealAleInfoProperties =[arrRealAlyInfo objectAtIndex:i];
				[arrSubMain addObject:objRealAleInfoProperties.abv];
				[arrSubMain addObject:objRealAleInfoProperties.address];
				[arrSubMain addObject:objRealAleInfoProperties.beertitle];
				[arrSubMain addObject:objRealAleInfoProperties.brewery];
				[arrSubMain addObject:objRealAleInfoProperties.breweryname];
				[arrSubMain addObject:objRealAleInfoProperties.distric];
				[arrSubMain addObject:objRealAleInfoProperties.email];
				[arrSubMain addObject:objRealAleInfoProperties.licenseenotes];
				
				Phoneno =objRealAleInfoProperties.phonenumber;
				[arrSubMain addObject:objRealAleInfoProperties.phonenumber];
				
				[arrSubMain addObject:objRealAleInfoProperties.contactname];
				[arrSubMain addObject:objRealAleInfoProperties.postcode];
				[arrSubMain addObject:objRealAleInfoProperties.see];
				[arrSubMain addObject:objRealAleInfoProperties.smell];
				[arrSubMain addObject:objRealAleInfoProperties.taste];
				[arrSubMain addObject:objRealAleInfoProperties.websiteurl];
				[arrMain addObject:arrSubMain];*/
                
                [arrSubMain addObject:@"TEST_PhoneNumber"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_PhoneNumber"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_PhoneNumber"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                [arrSubMain addObject:@"TEST_NameLastName"];
                
                [arrMain addObject:arrSubMain];

                

				
				[arrMode replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"1"]];
			}
			else
			{
				arrSubMain = [[NSMutableArray alloc]init];
				[arrMain addObject:arrSubMain];
				
				
				[arrMode replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
			}
		}
		else
		{
			arrSubMain = [[NSMutableArray alloc]init];
			[arrMain addObject:arrSubMain];
			[arrMode replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
		}
	}
	
	[table reloadData];
}


-(IBAction)ClickShowDetails:(id)sender
{
    PubDetail *obj_PubDetail=[[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
    
    obj_PubDetail.categoryStr=category_Str;
    obj_PubDetail.Pub_ID=Pubid;
    obj_PubDetail.headerDictionaryData=header_DictionaryData;
    
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
    [datelbl release];
    [lbl_heading release];
    [arrSubMain release];
    [arrRealAlyInfo release];
    [arrBeerInfo release];
    [toolBar release];
    [super dealloc];

    
}


@end
