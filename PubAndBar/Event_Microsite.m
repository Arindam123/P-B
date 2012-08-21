//
//  Event_Microsite.m
//  PubAndBar
//
//  Created by Apple on 08/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Event_Microsite.h"
#import "Design.h"
#import "PubDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "SaveEventMicrositeInfo.h"
#import "SavePubDetailsInfo.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "ASIHTTPRequest.h"

@implementation Event_Microsite
@synthesize table;
@synthesize backButton;
@synthesize datelbl;
@synthesize lbl_heading;
@synthesize Name;
@synthesize arrSubMain;
@synthesize arrMain;
@synthesize category_Str;
@synthesize Pub_ID;
@synthesize hud = _hud;
@synthesize oAuthLoginView;
@synthesize dic;
@synthesize event_type;
@synthesize header_DictionaryData;
@synthesize OpenDayArray,OpenHourArray;
@synthesize bulletPointArray;
@synthesize _ID;
@synthesize EventDay;
@synthesize eventDesc;

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
    
    self.eventTextLbl.text=category_Str;
    toolBar = [[Toolbar alloc]init];
 
    [self.view addSubview:toolBar];
    
    // Do any additional setup after loading the view from its nib.
    arrSubMain=[[NSMutableArray alloc]init];
    arrMain=[[NSMutableArray alloc]init];
   
    
    
    arrMain=[[SavePubDetailsInfo GetEvent_DetailsInfo:[Pub_ID intValue] event_ID:[_ID intValue]]retain];
    
    [self CreateView];
    

}

-(void)CreateView{
    table = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 300)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
       
    
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
    lbl_heading.text=@"Event Details";
    lbl_heading.font = [UIFont boldSystemFontOfSize:12];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
    
    
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table];
    [backButton release];
   
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
            
            table.frame=CGRectMake(10, 130, 300, 150);
            lbl_heading.frame = CGRectMake(100, 89, 125, 27);
            backButton.frame = CGRectMake(10, 90, 50, 25);
            datelbl.frame = CGRectMake(230, 10, 125, 27);
            if (delegate.ismore==YES) {
              
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
               
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
            
        }
        
        else{
            table.frame=CGRectMake(10, 120, 460, 138.4);
            lbl_heading.frame = CGRectMake(175, 83, 130, 27); 
            backButton.frame = CGRectMake(20, 85, 50, 25);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
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
    IsSelect=YES;
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];

    self.navigationController.navigationBarHidden=YES;
  
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    if (IsSelect==YES) {
         return 2; 
    }
    else
        return 1;
    
    
   
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return 0.3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1; 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell ; 
	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
    UIView *vw = [[[UIView alloc]init]autorelease];
    vw.frame =CGRectMake(-11, 4, 380, 42);
    vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    
    vw.backgroundColor = [UIColor whiteColor];
    
    vw1 =[[[UIView alloc]init]autorelease];
    vw1.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    vw2 =[[[UIView alloc]init]autorelease];
    vw2.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
  
       
    vw1.frame =CGRectMake(-11,29,483,1);
    vw2.frame =CGRectMake(-11,53,483,1);
   
    
              
    if (indexPath.row==0) {
        if (IsSelect==YES) 
            vw.backgroundColor =[UIColor clearColor];
        else
     
            vw.backgroundColor =[UIColor whiteColor];
    }
    else
       vw.backgroundColor =[UIColor whiteColor];

      
    [cell.contentView addSubview:vw];
    
	    
   	UILabel *lblEventDay = [Design LabelFormation:10 :7 :290 :20 :0];
    UILabel *lbl=[Design LabelFormation:10 :55 :75 :20 :0];
    UITextView *lblRegularEventDesc = [Design textViewFormation:90 :55 :200 :60 :0];
    lblRegularEventDesc.editable=NO;
	     UILabel * lblRegularEventDate = [Design LabelFormation:10 :31 :290 :20 :0];	
     
      if (indexPath.row==0){
			UIImage *img;
			UIImageView *imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 14,7)];
            
            
            if(IsSelect == YES)
                img=[UIImage imageNamed:@"ArrowDeselect.png"];
            
            else
                img=[UIImage imageNamed:@"ArrowDeselect.png"];
			
			imgMain.image =img;
    		
			[cell.contentView addSubview:imgMain];
			
			[imgMain release];
			
			UILabel * lblRegularEvent = [Design LabelFormation:35 :4 :190 :20 :0];
          lblRegularEvent.text = category_Str;
			lblRegularEvent.font = [UIFont boldSystemFontOfSize:15];
		
			[cell.contentView addSubview:lblRegularEvent];
           [lblRegularEvent release];
		}
        else if (IsSelect == YES){
            
               
            lblEventDay.text=[NSString stringWithFormat:@"Event Name :   %@",[[arrMain objectAtIndex:indexPath.row-1]valueForKey:@"Name"]];
           
            NSString *str_date;
           
            if([category_Str isEqualToString:@"One Off"]){
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                 NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[arrMain objectAtIndex:indexPath.row-1]valueForKey:@"Date"]]];
               
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
                NSString *dateString = [dateFormat2 stringFromDate:tempDate]; 
                
                [dateFormat release];
                [dateFormat2 release];
                              
                str_date=[NSString stringWithFormat:@"%@",dateString];
                

                
            }
            else
            {
                            
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                             
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"eeee"];
                
             
                [dateFormat release];
                [dateFormat2 release];
                
           
            }
            
                       
            
            lblRegularEventDate.text=[NSString stringWithFormat:@"Event Date :     %@",EventDay];//[NSString stringWithFormat:@"Event Date :     %@",[[arrMain objectAtIndex:indexPath.row-1]valueForKey:@"EventDay"]];
           
            lbl.text=@"Description:";
           // lblRegularEventDesc.backgroundColor=[UIColor redColor];
            lblRegularEventDesc.text =eventDesc;//[[arrMain objectAtIndex:indexPath.row-1]valueForKey:@"Event_Description"];
            
            
             [cell.contentView addSubview:lblEventDay];
             [cell.contentView addSubview:lblRegularEventDate];
             [cell.contentView addSubview:lblRegularEventDesc];
             [cell.contentView addSubview:lbl];
           
        }
        
       
        [lblEventDay release];
        [lblRegularEventDate release];
        [lblRegularEventDesc release];
        
  
	    
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	
    
	
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if(indexPath.row==0 ){
       
      
       
        if(IsSelect==YES){
            IsSelect=NO;
        [table reloadData];   
        }
        else{
            IsSelect=YES;
            [table reloadData]; 
        }
      }
   
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
		return 26;
	    
    else
        return 120;
    
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
-(void)dealloc{
   
    [arrSubMain release];
    [arrMain release];
    [datelbl release];
    [lbl_heading release];
    [toolBar release];
    [table release];
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
    
    if ([category_Str isEqualToString:@"What's On Next 7 Days"] || [category_Str isEqualToString:@"What's On Tonight..."]){
        
        
       obj.textString=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([category_Str isEqualToString:@"Theme Nights" ]){
        
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[event_type intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        

        
        
        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([category_Str isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        

        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([category_Str isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            tempurl = response;
        }
        

        
        obj.textString=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
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
    
    if ([category_Str isEqualToString:@"What's On Next 7 Days"] || [category_Str isEqualToString:@"What's On Tonight..."]){
        
        
        fbText=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([category_Str isEqualToString:@"Theme Nights" ]){
        
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[event_type intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
                
        
        fbText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([category_Str isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
                
        
        fbText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([category_Str isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
                
        
        fbText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
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
    
   
    
    if ([category_Str isEqualToString:@"What's On Next 7 Days"] || [category_Str isEqualToString:@"What's On Tonight..."]){
        
        
        obj.shareText=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([category_Str isEqualToString:@"Theme Nights" ]){
        
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[event_type intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([category_Str isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([category_Str isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        obj.shareText=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
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
    
    if ([category_Str isEqualToString:@"What's On Next 7 Days"] || [category_Str isEqualToString:@"What's On Tonight..."]){
        
        
        fb_str=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"];
    }
    
    
    
    else if ([category_Str isEqualToString:@"Theme Nights" ]){
        
        
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[event_type intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
        
    }
    
    
    else if ([category_Str isEqualToString:@"One Off"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
    }
    
    
    
    else if ([category_Str isEqualToString:@"Regular"]){
        
        NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
        tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
        
        
        
        fb_str=[NSString stringWithFormat: @"%@ %@ at %@ %@ %@ %@ %@",[[arrMain objectAtIndex:0]valueForKey:@"Name"],EventDay,[header_DictionaryData valueForKey:@"PubName"],[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubPostCode"],tempurl];
        
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
    NSString *fbText;
    
    if ([category_Str isEqualToString:@"What's On Next 7 Days"] || [category_Str isEqualToString:@"What's On Tonight..."]){
        
        
        fbText=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/"];
    }
    
    
    
    else if ([category_Str isEqualToString:@"Theme Nights" ]){
        
        //fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/themeNightResult.php?t%5B%d%5D=on",eventID];
        
        fbText=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/theme_%@_%@_%@_%d_%d.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue],[event_type intValue]];
        
        
    }
    
    
    else if ([category_Str isEqualToString:@"One Off"]){
        
        // fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/eventResult.php?data=&actionn=ONEOFF&e%5B%d%5D=on",[eventID intValue]];
        
        fbText=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_ONEOFF.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
    }
    
    
    
    else if ([category_Str isEqualToString:@"Regular"]){
        
        fbText=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/pubs/nightlife_%@_%@_%@_%d_.html",[header_DictionaryData valueForKey:@"PubCity"],[header_DictionaryData valueForKey:@"PubDistrict"],[header_DictionaryData valueForKey:@"PubName"],[Pub_ID intValue]];
        
    }
    
    //[mailController setMessageBody:[NSString stringWithFormat:@"%@",fb_str] isHTML:NO];
    /* if ([categoryStr isEqualToString:@"Sports on TV"])
     
     fbText=[NSString stringWithFormat: @"Watch %@ showing at the %@,%@,%@, %@, http://tinyurl.com/89u8erm",[[arr objectAtIndex:0]valueForKey:@"Sport_EventName"],[headerDictionaryData objectForKey:@"PubName"],[headerDictionaryData objectForKey:@"PubCity"],[headerDictionaryData objectForKey:@"PubDistrict"],[headerDictionaryData objectForKey:@"PubPostCode"]];
     else if ([categoryStr isEqualToString:@"Regular"] || [categoryStr isEqualToString:@"One Off" ] || [categoryStr isEqualToString:@"Theme Nights" ] || [categoryStr isEqualToString:@"What's On Next 7 Days"] || [categoryStr isEqualToString:@"What's On Tonight..."])
     
     fbText=[NSString stringWithFormat: @"%@ %@ at %@'s, %@, %@, %@, http://tinyurl.com/72nbd7f",[[arr objectAtIndex:0]valueForKey:@"Name"],[headerDictionaryData objectForKey:@"PubName"],[[arr objectAtIndex:0]valueForKey:@"Date"],[headerDictionaryData objectForKey:@"PubCity"],[headerDictionaryData objectForKey:@"PubDistrict"],[headerDictionaryData objectForKey:@"PubPostCode"]];
     else if ([categoryStr isEqualToString:@"Food & Offers"])
     {
     
     fbText=[NSString stringWithFormat: @"food, menu and wine info at %@, %@, %@, %@ http://tinyurl.com/72nbd7f",[headerDictionaryData objectForKey:@"PubName"],[headerDictionaryData objectForKey:@"PubCity"],[headerDictionaryData objectForKey:@"PubDistrict"],[headerDictionaryData objectForKey:@"PubPostCode"]];
     }
     else if ([categoryStr isEqualToString:@"Near me now!"])
     {
     fbText=[NSString stringWithFormat:@"Check out %@ on this great FREE app and search facility for finding pubs and bars,http://tinyurl.com/dxzhhto",[headerDictionaryData objectForKey:@"PubName"]];
     }
     else if([categoryStr isEqualToString:@"Facilities"])
     
     fbText=[NSString stringWithFormat:@"%@ with updated %@ info",[headerDictionaryData objectForKey:@"PubName"]];
     
     */
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
