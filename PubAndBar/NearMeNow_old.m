//
//  PubList.m
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "NearMeNow.h"
#import "PubDetail.h"
#import "Toolbar.h"
#import "SavePubDetailsInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveNearMeInfo.h"

@implementation NearMeNow

@synthesize table_list;
@synthesize PubId;
@synthesize seg_control;
@synthesize PubArray;
@synthesize venu_btn;

UIImageView *pushImg;
UILabel *topLabel;
UILabel *middlelbl;
Toolbar *_Toolbar;
AppDelegate *app;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        categoryStr = categoryString;
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
    
    self.view.frame = CGRectMake(0, 0, 320, 395);

    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _Toolbar = [[[Toolbar alloc]init]autorelease];
    _Toolbar.layer.borderWidth = 1.0f;
    [self.view addSubview:_Toolbar];
    PubArray = [[[NSMutableArray alloc]init]autorelease];
    PubArray = [[SaveNearMeInfo GetNearMePubsInfo]retain];
    [self CreateHomeView];

    
}

-(void)CreateHomeView{
    
    NSLog(@"PubArray  %@",PubArray);
    obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(0, 32, 320, 335) withArray:PubArray];
    [self.view addSubview:obj_nearbymap];
    obj_nearbymap.hidden=YES;
    [obj_nearbymap release];
    
    venu_btn=[[UIButton alloc]initWithFrame:CGRectMake(120, 360, 80, 20)];
    venu_btn.titleLabel.font= [UIFont systemFontOfSize:12.0];
    venu_btn.layer.borderColor=[UIColor whiteColor].CGColor;
    venu_btn.layer.borderWidth=1.0;
    venu_btn.layer.cornerRadius=10.0;
    venu_btn.titleLabel.textColor=[UIColor whiteColor];
    [venu_btn setTitle:@"More" forState:UIControlStateNormal];
    venu_btn.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    [self.view addSubview:venu_btn];
    [venu_btn release];
    
    table_list = [[[UITableView alloc]init]autorelease];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    seg_control = [[UISegmentedControl alloc]init];
    NSArray *itemArray = [NSArray arrayWithObjects: @"List", @"Map", nil];
    seg_control = [[UISegmentedControl alloc] initWithItems:itemArray];
    seg_control.segmentedControlStyle = UISegmentedControlStyleBar;
    seg_control.backgroundColor=[UIColor clearColor];
    seg_control.tintColor=[UIColor lightGrayColor];
    seg_control.tintColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    seg_control.selectedSegmentIndex =0;
    [seg_control addTarget:self action:@selector(ClickSegCntrl:) forControlEvents:UIControlEventValueChanged];
    
    [self setHomeViewFrame];
    
    [self.view addSubview:table_list];
    [self.view addSubview:seg_control];
}
-(void)setHomeViewFrame{
    
    if ([Constant isiPad]){
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            table_list.frame = CGRectMake(0, 30, 320, 325);
            table_list.scrollEnabled = YES;
            seg_control.frame = CGRectMake(90, 4, 140, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(0, 32, 320, 325)];
            venu_btn.frame=CGRectMake(120, 360, 80, 20);
            
        }
        else{
            table_list.frame = CGRectMake(0, 40, 480, 165);
            table_list.scrollEnabled = YES;
            seg_control.frame = CGRectMake(140, 14, 200, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(0, 42, 480, 165)];
            venu_btn.frame=CGRectMake(190, 214, 100, 20);
        }
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [PubArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger PUSH_IMAGE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    const NSInteger MID_LABEL_TAG=1005;
    const NSInteger TOP_IMAGE_TAG=1002;
    
    UIImageView *pubImage;
	UILabel *topLabel;
    UILabel *middleLable;
    UIView *vw;
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
		vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
        
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        
		topLabel=[[[UILabel alloc]initWithFrame:CGRectMake(50,0,200,37)]autorelease];
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:12];
        [vw addSubview:topLabel];
        
        middleLable=[[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 60, 37)]autorelease];
        middleLable.tag = MID_LABEL_TAG;
        middleLable.backgroundColor = [UIColor clearColor];
		middleLable.textColor = [UIColor whiteColor];
		middleLable.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		middleLable.font = [UIFont boldSystemFontOfSize:12];
        [vw addSubview:middleLable];
        
        
        pubImage=[[[UIImageView alloc]initWithFrame:CGRectMake(2,4,30,30)]autorelease];
		pubImage.tag = TOP_IMAGE_TAG;
		pubImage.backgroundColor = [UIColor redColor];
        [vw addSubview:pubImage];


		
        pushImg = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 15, 10, 10)]autorelease];
        pushImg.tag = PUSH_IMAGE_TAG;
        pushImg.image=[UIImage imageNamed:@"right_iPhone"];
        pushImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        [vw addSubview:pushImg];
        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        vw=(UIView*)[cell viewWithTag:MAINVIEW_VIEW_TAG];
        middleLable = (UILabel *)[cell viewWithTag:MID_LABEL_TAG];
        pubImage = (UIImageView *)[cell viewWithTag:TOP_IMAGE_TAG];
        
	}
    @try {
        NSLog(@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]);
        topLabel.text = [[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubName"];
        //middleLable.text = [NSString stringWithFormat:@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]];
        middleLable.text=[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    PubDetail *obj_PubDetail=[[PubDetail alloc]initWithNibName:@"PubDetail" bundle:nil];
//    [self.navigationController pushViewController:obj_PubDetail animated:YES];
//    [obj_PubDetail release];
//    
//}

-(IBAction)ClickSegCntrl:(id)sender{
    
    if(seg_control.selectedSegmentIndex==0)
    {
        
        table_list.hidden = NO;
        obj_nearbymap.hidden = YES;
    }
    
    else {
        table_list.hidden = YES;
        obj_nearbymap.hidden = NO;
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    table_list = nil;
    seg_control=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        _Toolbar.frame = CGRectMake(0, 387, 320, 48);
    }
    else{
        _Toolbar.frame = CGRectMake(0, 240, 480, 48);
    }

    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [table_list release];
    [PubId release];
    [seg_control release];
    [obj_nearbymap release];
    [super dealloc];
}
@end
