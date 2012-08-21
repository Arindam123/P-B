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
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "ASIHTTPRequest.h"

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
@synthesize OpenDayArray,OpenHourArray;
@synthesize bulletPointArray;
@synthesize aleID;
@synthesize hud = _hud;
@synthesize oAuthLoginView;
@synthesize dic;
@synthesize EventID;
@synthesize share_eventName;
@synthesize BeerID;
 int i=0;
UIInterfaceOrientation orientation;
AppDelegate *delegate ;

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
    self.eventTextLbl.text=category_Str;
     
    //arrRealAlyInfo=[[NSMutableArray alloc]init];
    arrSubMain=[[NSMutableArray alloc]init];
    arrMain=[[NSMutableArray alloc]init];
    
    toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];

        
   
	//[self PrepareArrayList:0:[[arrMode objectAtIndex:0]boolValue]];

    [self CreateView];
   // IsFirstTime=YES;

}

-(void)CreateView{
    table = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 300)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    
    btn_Venu=[[UIButton alloc]initWithFrame:CGRectMake(100, 380, 135, 40)];
    [btn_Venu addTarget:self action:@selector(ClickShowDetails:) forControlEvents:UIControlEventTouchUpInside];
    //[btn_Venu setTitle:@"Venue Information" forState:UIControlStateNormal];
    [btn_Venu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_Venu.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_Venu.backgroundColor=[UIColor clearColor];
    
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VenueButton.png"]];

    
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
    lbl_heading.font = [UIFont boldSystemFontOfSize:12];
    lbl_heading.text=@"Real Ale Detail";
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]; 
    
        
      
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
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];

 [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    
    else{
        if ([Constant isPotrait:self]) {
            
            table.frame=CGRectMake(10, 125, 300, 240);
            lbl_heading.frame = CGRectMake(98, 90, 125, 25);
            backButton.frame = CGRectMake(10, 90, 50, 25);
            datelbl.frame = CGRectMake(230, 10, 125, 27);
            btn_Venu.frame=CGRectMake(90, 373, 140, 40);
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
            
            
            vw1.frame =CGRectMake(-11,40,483,1);
            vw2.frame =CGRectMake(-11,82,483,1);
            vw3.frame =CGRectMake(-11,124,483,1);
            vw4.frame =CGRectMake(-11,166,483,1);
            vw5.frame =CGRectMake(-11,208,483,1);
            vw6.frame =CGRectMake(-11,250,483,1);
            vw7.frame =CGRectMake(-11,292,483,1);
            vw8.frame =CGRectMake(-11,334,483,1);
            vw9.frame =CGRectMake(-11,376,483,1);
            vw10.frame =CGRectMake(-11,418,483,1);
            vw11.frame =CGRectMake(-11,460,483,1);
            vw12.frame =CGRectMake(-11,502,483,1);
            vw13.frame =CGRectMake(-11,544,483,1);
            //vw14.frame =CGRectMake(-11,349,323,1);
            if (delegate.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
                

            
        }
        
        else{
            table.frame=CGRectMake(10, 117, 460, 100);
            lbl_heading.frame = CGRectMake(177, 86, 135, 20);
            backButton.frame = CGRectMake(20, 85, 50, 25);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
            btn_Venu.frame=CGRectMake(170, 220, 140, 40);
            img_1stLbl.frame=CGRectMake(0, 0, 134, 39);
            
            
            
            vw1.frame =CGRectMake(-11,40,483,1);
            vw2.frame =CGRectMake(-11,82,483,1);
            vw3.frame =CGRectMake(-11,124,483,1);
            vw4.frame =CGRectMake(-11,166,483,1);
            vw5.frame =CGRectMake(-11,208,483,1);
            vw6.frame =CGRectMake(-11,250,483,1);
            vw7.frame =CGRectMake(-11,292,483,1);
            vw8.frame =CGRectMake(-11,334,483,1);
            vw9.frame =CGRectMake(-11,376,483,1);
            vw10.frame =CGRectMake(-11,418,483,1);
            vw11.frame =CGRectMake(-11,460,483,1);
            vw12.frame =CGRectMake(-11,502,483,1);
            vw13.frame =CGRectMake(-11,544,483,1);

            //vw14.frame =CGRectMake(-11,349,483,1);
            if (delegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            

            
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
   // delegate.ismore=NO;
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    if(IsFirstTime==NO){
    IsFirstTime=YES;
        IsSelect=YES;
      //  [arrRealAlyInfo removeAllObjects];
        [arrBeerInfo removeAllObjects];
        
    }
   // arrRealAlyInfo =[[SaveRealAleDetailsInfo GetRealAleTypeInfo:[Pubid intValue]]retain];
   // arrBeerInfo=[[SaveRealAleDetailsInfo GetAleBeerDetailsInfo:[[[arrRealAlyInfo objectAtIndex:0]valueForKey:@"Ale_ID"]intValue] withPubID:[Pubid intValue]]retain];
    
	for (int i=0; i<[arrRealAlyInfo count]; i++) {
		[arrMode addObject:[NSString stringWithFormat:@"0"]];
	}
	section_value=0;
    [table reloadData];
    [self AddNotification];
	
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrRealAlyInfo count];
    //return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"%d",[[arrMain objectAtIndex:section] count]);
	//return [[arrMain objectAtIndex:section]count]+1;
    
   if(IsFirstTime==YES)
   {
       if (section==0){
            
            return 2;
       }
       else
           return 1;
   }
   else{
    
    if (IsSelect==YES) {
      if (section==section_value) {
        return 2;
        
         }
      else
        return 1;   
            
    }
    else
      return 1;
    }
 
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    if (IsSelect==YES) {
        NSLog(@"%d",section_value);
        if (section==section_value) {
            
            return 3.0;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 //  if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
    
    UIView *vw = [[[UIView alloc]init]autorelease];
    vw.frame =CGRectMake(-11, 4, 480, 42);
    vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    
    vw.backgroundColor = [UIColor whiteColor];
    
    if(IsFirstTime==YES)
    {
        if (indexPath.section==0) {
            
            
            if (indexPath.row==0) {
                IsSelect=YES;
                    vw.backgroundColor =[UIColor clearColor];
                            
              }
            else{
                 vw.backgroundColor =[UIColor whiteColor];
            }
                
                
               
           }
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
        {    IsSelect=YES;
            vw.backgroundColor =[UIColor whiteColor];
        }
     
    }
    else
    {
        vw.backgroundColor =[UIColor whiteColor];
    }
    }
    
    [cell.contentView addSubview:vw];
    
	
	UILabel *lblFoodInfo = [Design LabelFormation:10 :5 :100 :20 :0];
	UITextView *lblFoodInfoDetials = [Design textViewFormation:90 :0 :200 :125 :0];//125
	lblFoodInfoDetials.editable=NO;
    
    UILabel *lblSportsEventName= [Design LabelFormation:0 :11 :100 :20 :0];
    lblSportsEventName.numberOfLines = 2;
    lblSportsEventName.lineBreakMode = UILineBreakModeWordWrap;	
    
    UITextView *lblSportsEventName1 = [Design textViewFormation:115 :4 :217 :30 :0];
    lblSportsEventName1.editable=NO;
     lblSportsEventName1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
  
    
        
    UILabel *lblSportsEventType= [Design LabelFormation:0 :49 :100 :20 :0];
    
    UITextView *lblSportsEventType1 = [Design textViewFormation:115 :42 :217 :30 :0];
    lblSportsEventType1.editable=NO;
    lblSportsEventType1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

 
    
       
    UILabel *lblSportsSound = [Design LabelFormation:0 :93 :100 :20 :0 ];
    
    UITextView *lblSportsSound1 = [Design textViewFormation:115 :84 :217 :30 :0];
    lblSportsSound1.editable=NO;
    lblSportsSound1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

           
    UILabel *lblSportsEventScreen= [Design LabelFormation:0:133 :100 :20 :0];
    
    UITextView *lblSportsEventScreen1 = [Design textViewFormation:115 :126 :217 :30 :0];
    lblSportsEventScreen1.editable=NO;
    lblSportsEventScreen1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

    
      
    UILabel *lblSportsEventHD= [Design LabelFormation:0 :175 :100 :20 :0];
    
    UITextView *lblSportsEventHD1 = [Design textViewFormation:115 :168 :217 :30 :0];
    lblSportsEventHD1.editable=NO;
    lblSportsEventHD1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    
  
    
       
    UILabel *lblSportsEventDate= [Design LabelFormation:0 :217 :100 :20 :0];
    
    UITextView *lblSportsEventDate1 = [Design textViewFormation:115 :210 :217 :30 :0];
    lblSportsEventDate1.editable=NO;
    lblSportsEventDate1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

       
    UILabel *lblSportsEventChannel= [Design LabelFormation:0 :259 :100 :20 :0];
    
    UITextView *lblSportsEventChannel1 = [Design textViewFormation:115 :252 :217 :30 :0];
    lblSportsEventChannel1.editable=NO;
    lblSportsEventChannel1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    


    
      UILabel *lblSportsEvent3D= [Design LabelFormation:0 :301 :100 :20 :0];
    
    UITextView *lblSportsEvent3D1 = [Design textViewFormation:115 :294 :217 :30 :0];
    lblSportsEvent3D1.editable=NO;
    lblSportsEvent3D1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

    
    UILabel *lbl_addr=  [Design LabelFormation:0 :343 :100 :20 :0];
    
   
    
    
    UITextView *lblPub = [Design textViewFormation:115 :336 :217 :30 :0];
       lblPub.editable=NO;
    lblPub.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

     
     UILabel *lblPubPOstcode = [Design LabelFormation:0 :385 :100 :20 :0];
    
    UITextView *lblPubPOstcode1 = [Design textViewFormation:115 :378 :217 :30 :0];
    lblPubPOstcode1.editable=NO;
    lblPubPOstcode1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

     
     UILabel *lblPubNUmber = [Design LabelFormation:0 :427 :100 :20 :0];
    
    UITextView *lblPubNUmber1 = [Design textViewFormation:115 :420 :217 :30 :0];
    lblPubNUmber1.editable=NO;
    lblPubNUmber1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

    
      
     UILabel *lblPubEmail = [Design LabelFormation:0 :469 :100 :20 :0];
    
    UITextView *lblPubEmail1 = [Design textViewFormation:115 :462 :217 :30 :0];
    lblPubEmail1.editable=NO;
    lblPubEmail1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    


    
      UILabel *lblPubDistrict = [Design LabelFormation:0 :513 :100 :20 :0];
    
    UITextView *lblPubDistrict1 = [Design textViewFormation:115 :504 :217 :30 :0];
    lblPubDistrict1.editable=NO;
    lblPubDistrict1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    


    
     
     UILabel *lblPubContactName = [Design LabelFormation:0 :546 :100 :20 :0];
    
    
    UITextView *lblPubContactName1 = [Design textViewFormation:115 :546 :217 :30 :0];
    lblPubContactName1.editable=NO;
    
    lblPubContactName1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    


    
      
     UILabel *lblPubLicenceNote = [Design LabelFormation:0 :553 :100 :20 :0];
     UITextView *txtvwRealAleDesc = [Design textViewFormation:115 :546 :217 :35 :0];
    txtvwRealAleDesc.editable=NO;
    txtvwRealAleDesc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;
    

    
    
    
    vw1 = [[UIView alloc]init];
    vw1.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw2 = [[UIView alloc]init];
    vw2.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw3 = [[UIView alloc]init];
    vw3.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw4 = [[UIView alloc]init];
    vw4.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw5 = [[UIView alloc]init];
    vw5.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw6 = [[UIView alloc]init];
    vw6.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    vw7 = [[UIView alloc]init];
    vw7.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw8 = [[UIView alloc]init];
    vw8.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw9 = [[UIView alloc]init];
    vw9.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    vw10 = [[UIView alloc]init];
    vw10.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    vw11 = [[UIView alloc]init];
    vw11.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    vw12 = [[UIView alloc]init];
    vw12.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw13 = [[UIView alloc]init];
    vw13.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
   // vw14 = [[UIView alloc]init];
   // vw14.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    

            vw1.frame =CGRectMake(-11,40,483,1);
            vw2.frame =CGRectMake(-11,82,483,1);
            vw3.frame =CGRectMake(-11,124,483,1);
            vw4.frame =CGRectMake(-11,166,483,1);
            vw5.frame =CGRectMake(-11,208,483,1);
            vw6.frame =CGRectMake(-11,250,483,1);
            vw7.frame =CGRectMake(-11,292,483,1);
            vw8.frame =CGRectMake(-11,334,483,1);
            vw9.frame =CGRectMake(-11,376,483,1);
            vw10.frame =CGRectMake(-11,418,483,1);
            vw11.frame =CGRectMake(-11,460,483,1);
            vw12.frame =CGRectMake(-11,502,483,1);
            vw13.frame =CGRectMake(-11,544,483,1);
          //  vw14.frame =CGRectMake(-11,363,483,1);
    
    
	if(indexPath.row ==0)
	{
       // if(i<=[arrRealAlyInfo count]){
		lblFoodInfo = [Design LabelFormation:35 :8 :300 :25 :0];
		
        lblFoodInfo.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Brewery"]];
		
        lblFoodInfo.font = [UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:lblFoodInfo];
		
		
		UIImage *img;
		UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 14,7)];
		//if([[arrMode objectAtIndex:indexPath.section] boolValue])
            
           // if(indexPath.section){
                if (IsSelect==NO) {
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                }
                else{
                    if(indexPath.section==section_value){
                   
                    img=[UIImage imageNamed:@"ArrowDeselect.png"];
                    }
                    else
                    {
                         img=[UIImage imageNamed:@"ArrowDeselect.png"];
                    }
            }
            
            
			//i++;
		
		
		imgMain.image = img;
		
		[cell.contentView addSubview:imgMain];
	//}
    }
	else
        if (IsSelect==YES) {
            if(indexPath.section==section_value)
            {
              //  if(i<=[arrBeerInfo count]){   
                //NSLog(@"IndexPath %d",indexPath.row);
                
            lblSportsEventName.text = [NSString stringWithFormat:@"Beer Title :"];
                
                lblSportsEventName1.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"BeerTitle"]];
                
                lblSportsEventType.text = [NSString stringWithFormat:@"Brewery :"];
                
                lblSportsEventType1.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Brewery"]];
                
                lblSportsEventScreen.text = [NSString stringWithFormat:@"ABV :"];
                
                lblSportsEventScreen1.text = [NSString stringWithFormat:@"%@ ",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"ABV"]];
                
                lblSportsSound.text =[NSString stringWithFormat:@"See : "];
                
                 lblSportsSound1.text =[NSString stringWithFormat:@"%@ ",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"See"]];
                
                 
                lblSportsEventHD.text =[NSString stringWithFormat:@"Smell :"];
                
                 lblSportsEventHD1.text =[NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Smell"]];
                
                lblSportsEventDate.text = [NSString stringWithFormat:@"Taste :"];
                
                lblSportsEventDate1.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Taste"]];
                
                lblSportsEventChannel.text = [NSString stringWithFormat:@"Brewery Name :"];
                
                lblSportsEventChannel1.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Brewery"]];
                
                lblSportsEvent3D.text = [NSString stringWithFormat:@"Website URL :"];
                
                lblSportsEvent3D1.text = [NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"WebsiteURL"]];
              
                lbl_addr.text=@"Address :";
                
                lblPub.text=[NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Address"]];
                
                lblPubPOstcode.text=[NSString stringWithFormat:@"Postcode :"];
                
                 lblPubPOstcode1.text=[NSString stringWithFormat:@" %@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"postCode"]];
                
            lblPubNUmber.text=[NSString stringWithFormat:@"Contact Name :"];
                
                lblPubNUmber1.text=[NSString stringWithFormat:@"%@ ",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"ContactName"]];
                
                lblPubEmail.text=[NSString stringWithFormat:@"Phone Number :"];
                
                lblPubEmail1.text=[NSString stringWithFormat:@"%@ ",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"PhoneNumber"]];
                
                lblPubDistrict.text=[NSString stringWithFormat:@"Email : "];
                
                 lblPubDistrict1.text=[NSString stringWithFormat:@"%@",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Email"]];
                
               // lblPubContactName.text=[NSString stringWithFormat:@"District :             %@ ",[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"Ale_District"]];
                
                lblPubLicenceNote.text=[NSString stringWithFormat:@"Licensee Notes:"];
                
                
                
                txtvwRealAleDesc.backgroundColor =[UIColor clearColor];
                txtvwRealAleDesc.editable =NO;
                txtvwRealAleDesc.text =[[arrRealAlyInfo objectAtIndex:indexPath.section]valueForKey:@"LicenseeNotes"];
                txtvwRealAleDesc.textColor =[UIColor blackColor];
               
                
                [cell.contentView addSubview:lblSportsEventName];
                [cell.contentView addSubview:lblSportsEventType];
                [cell.contentView addSubview:lblSportsEventScreen];
                [cell.contentView addSubview:lblSportsSound];	
                [cell.contentView addSubview:lblSportsEventHD];
                [cell.contentView addSubview:lblSportsEventDate];
                [cell.contentView addSubview:lblSportsEventChannel];
                [cell.contentView addSubview:lblSportsEvent3D];
                
                [cell.contentView addSubview:lblPub];
                [cell.contentView addSubview:lblPubPOstcode];
                [cell.contentView addSubview:lblPubNUmber];
                [cell.contentView addSubview:lblPubEmail];
                 [cell.contentView addSubview:lbl_addr];
                [cell.contentView addSubview:lblPubDistrict];
                //[cell.contentView addSubview:lblPubContactName];
                [cell.contentView addSubview:lblPubLicenceNote];
                [cell.contentView addSubview:txtvwRealAleDesc];
                [cell.contentView addSubview:vw1];
                 [cell.contentView addSubview:vw2];
                 [cell.contentView addSubview:vw3];
                 [cell.contentView addSubview:vw4];
                 [cell.contentView addSubview:vw5];
                 [cell.contentView addSubview:vw6];
                 [cell.contentView addSubview:vw7];
                 [cell.contentView addSubview:vw8];
                 [cell.contentView addSubview:vw9];
                 [cell.contentView addSubview:vw10];
                 [cell.contentView addSubview:vw11];
                [cell.contentView addSubview:vw12];
                [cell.contentView addSubview:vw13];
                //[cell.contentView addSubview:vw14];
                
                [cell.contentView addSubview:lblSportsEventName1];
                [cell.contentView addSubview:lblSportsEventType1];
                [cell.contentView addSubview:lblSportsEventScreen1];
                [cell.contentView addSubview:lblSportsSound1];	
                [cell.contentView addSubview:lblSportsEventHD1];
                [cell.contentView addSubview:lblSportsEventDate1];
                [cell.contentView addSubview:lblSportsEventChannel1];
                [cell.contentView addSubview:lblSportsEvent3D1];
                [cell.contentView addSubview:lblPubPOstcode1];
                [cell.contentView addSubview:lblPubNUmber1];
                [cell.contentView addSubview:lblPubEmail1];
                [cell.contentView addSubview:lblPubDistrict1];
               // [cell.contentView addSubview:lblPubContactName1];


                  //  i++;
                
               
           // }
        }
        }
    
    [lblSportsEventName release];
    [lblSportsEventType release];
    [lblSportsEventScreen release];
    [lblSportsEventHD release];
    [lblSportsEventDate release];
    [lblSportsEventChannel release];
    [lblSportsSound release];
    [lblSportsEvent3D release];
    [lblPub release];
    [lblPubPOstcode release];
    [lblPubNUmber release];
    [lblPubEmail release];
    [lblPubDistrict release];
    [lblPubContactName release];
    [lblPubLicenceNote release];
    [txtvwRealAleDesc release];
    [lbl_addr release];
    
    [lblSportsEventName1 release];
    [lblSportsEventType1 release];
    [lblSportsEventScreen1 release];
    [lblSportsSound1 release];	
    [lblSportsEventHD1 release];
    [lblSportsEventDate1 release];
    [lblSportsEventChannel1 release];
    [lblSportsEvent3D1 release];
    [lblPubPOstcode1 release];
    [lblPubNUmber1 release];
    [lblPubEmail1 release];
    [lblPubDistrict1 release];
    [lblPubContactName1 release];

    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 	
    IsSelect=YES;
    section_value=indexPath.section;
    aleID=[[arrRealAlyInfo objectAtIndex:section_value]valueForKey:@"Ale_ID"];
    
    IsFirstTime=NO;
    
    
	if(indexPath.row==0)
		[self PrepareArrayList:indexPath.section :[[arrMode objectAtIndex:indexPath.section]boolValue]];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
		return 35;
	else
        return 586;
    
    }
-(void)PrepareArrayList:(int)Selection:(BOOL)Mode{
	
	//RealAleInfoProperties *objRealAleInfoProperties =[[RealAleInfoProperties alloc]init];
	
	[arrMain removeAllObjects];
    
    if (IsSelect==NO) {
    
    
	for (int i=0; i<[arrRealAlyInfo count]; i++) {
		if(Selection ==i)
		{
			if(!Mode)
			{
				arrSubMain = [[NSMutableArray alloc]init];
		                
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
    }
    else
    {
        arrBeerInfo=[[SaveRealAleDetailsInfo GetAleBeerDetailsInfo:[aleID intValue] withPubID:[Pubid intValue]] retain];
       // NSLog(@"VAL  %d",[[[arrRealAlyInfo objectAtIndex:0]valueForKey:@"Ale_ID"]intValue]);
    }
	
	[table reloadData];
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
    obj_PubDetail.Share_EventName=share_eventName;
    obj_PubDetail.EventId=BeerID;
       
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
    
    
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
    }
    return YES;
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
    
     
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[BeerID intValue],[Pubid intValue]];
    
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
    

    
    
    obj.textString=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",share_eventName,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],tempurl];
    
    NSLog(@"%@",obj.textString);
    
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
    NSString *fbText;
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[BeerID intValue],[Pubid intValue]];
    
    NSLog(@"%@",tempurl);
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    fbText=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",share_eventName,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],tempurl];
    
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
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[BeerID intValue],[Pubid intValue]];
    
    NSLog(@"%@",tempurl);
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    obj.shareText=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",share_eventName,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],tempurl];

    
    
    
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
    NSString *fbText;
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/ale_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[BeerID intValue],[Pubid intValue]];
    
    NSLog(@"%@",tempurl);
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    fbText=[NSString stringWithFormat: @"%@ provides Beers at %@ %@ %@ %@",share_eventName,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],tempurl];

    
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
    NSString *fbText;
    
    fbText=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=&e%5B%d%5D=on ",[EventID intValue]];
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





-(void)dealloc{
    [arrMain release];
    [datelbl release];
    [lbl_heading release];
    [arrSubMain release];
    [arrRealAlyInfo release];
    [arrBeerInfo release];
    [toolBar release];
    [OpenDayArray release];
    [OpenHourArray release];
    [bulletPointArray release];
    [arrMode release];
    [vw1 release];
    [vw2 release];
    [vw3 release];
    [vw4 release];
    [vw5 release];
    [vw6 release];
    [vw7 release];
    [vw8 release];
    [vw9 release];
    [vw10 release];
    [vw11 release];
    [vw12 release];
    [vw13 release];
   // [vw14 release];
    
    
    [super dealloc];

    
}


@end
