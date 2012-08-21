//
//  ImagesList.m
//  UrBanChat
//
//  Created by Kislay on 20/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImagesList.h"
#import "AsyncImageView.h"
#import "PictureShowsInFullScreen.h"
#import "Constant.h"
#import "AsyncImageView_New.h"


@implementation ImagesList
@synthesize arrTempImages,arrCounter,arrTemp_Counter,arrImagesList;
@synthesize image,currentImage;
@synthesize arrImage;
@synthesize headerTitle;
@synthesize backButton;
long arrPossision=0;
int xWidth;

int j=0;
int l=0;
UIInterfaceOrientation imageOrientation;

- (id)init
{
	self = [super init];
	if (self != nil) {
		
	}
	return self;
}


-(UIView*)CreateImageList:(NSMutableArray*)imgList{
	
    
	NSMutableArray *arrLocalCnt =[[NSMutableArray alloc]init];
	[arrLocalCnt addObjectsFromArray:(NSMutableArray *)[imgList objectAtIndex:0]];
	
	NSLog(@"arrLocalCnt array is %@",arrLocalCnt);
	
	
	NSMutableArray *arrLocalImg = [[NSMutableArray alloc]init];
	
	arrLocalImg=[imgList objectAtIndex:1];
	
	NSLog(@"arrLocalImg array is %@",arrLocalImg);
	
	NSNumber *Tem_cnt = [arrLocalCnt objectAtIndex:0];
	int cnt = [Tem_cnt integerValue];
	
	NSLog(@"cnt is %d",cnt);
	
	float v_Width = (320-10)/4;
	float v_Height = v_Width-2.0;
	
	float inc_width=(float)310/4;
	float x = 0.0;
	float y = 2.0;
	
	NSLog(@"%d",[imgList count]);
	
    
	UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, v_Height)];
	
	UIButton *btnimg1 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg1 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	
	UIButton *btnimg2 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg2 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btnimg3 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg3 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btnimg4 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg4 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	NSArray *btnarray = [[NSArray alloc] initWithObjects:btnimg1,btnimg2,btnimg3,btnimg4, nil];
	[btnimg1 release];
	[btnimg2 release];	
	[btnimg3 release];
	[btnimg4 release];
	
	for (int i=0;i<[arrLocalImg count];i++)
	{
		NSLog(@"p2:%@",arrLocalImg);
		
        AsyncImageView_New* asyncImage = [[AsyncImageView_New alloc] initWithFrame:CGRectMake(0, 0,v_Width, v_Height)];
		NSString *ImgImage = [arrLocalImg objectAtIndex:i];
        ImgImage = [ImgImage stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *url=[[NSURL alloc]initWithString:ImgImage];
		NSLog(@"%@",url);
		
	    asyncImage.imageURL = url;
		
		
		UIView *imgTempview = [[[UIView alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)]autorelease];
		
        
		UIButton *btn = (UIButton*)[btnarray objectAtIndex:i];
		btn.tag = cnt;
		
		[imgTempview addSubview:asyncImage];
		[imgTempview addSubview:btn];
		[imgView addSubview:imgTempview];
				
		x+=inc_width;
		cnt++;
		NSLog(@"%f",x);
	}
	return imgView;
	[imgView release];
	[btnarray release];
}


-(UIView*)CreateImageList_Landscape:(NSMutableArray*)imgList {
	
	NSMutableArray *arrLocalCnt =[[NSMutableArray alloc]init];
	[arrLocalCnt addObjectsFromArray:(NSMutableArray *)[imgList objectAtIndex:0]];
	
	NSLog(@"arrLocalCnt array is %@",arrLocalCnt);
	
	NSMutableArray *arrLocalImg = [[NSMutableArray alloc]init];
	
	arrLocalImg=[imgList objectAtIndex:1];
	
	NSLog(@"arrLocalImg array is %@",arrLocalImg);
	
	NSNumber *Tem_cnt = [arrLocalCnt objectAtIndex:0];
	int cnt = [Tem_cnt integerValue];
	
	NSLog(@"cnt is %d",cnt);
	
	float v_Width = (470-10)/5;
	float v_Height = 75;
	
	float inc_width=(float)480/5;
	float x = 2.0;
	float y = 2.0;
	
	NSLog(@"%d",[imgList count]);
	
	
	
	UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, v_Height)];
	
	UIButton *btnimg1 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg1 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	
	UIButton *btnimg2 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg2 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btnimg3 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg3 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btnimg4 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg4 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btnimg5 = [[UIButton alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)];
	[btnimg5 addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	NSArray *btnarray = [[NSArray alloc] initWithObjects:btnimg1,btnimg2,btnimg3,btnimg4,btnimg5,nil];
	[btnimg1 release];
	[btnimg2 release];	
	[btnimg3 release];
	[btnimg4 release];
	[btnimg5 release];
		
	for (int i=0;i<[arrLocalImg count];i++)
	{
		
		AsyncImageView_New* asyncImage = [[AsyncImageView_New alloc] initWithFrame:CGRectMake(0, 0,v_Width, v_Height)];
		NSString *ImgImage = [arrLocalImg objectAtIndex:i];
        ImgImage = [ImgImage stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		NSURL *url=[[NSURL alloc]initWithString:ImgImage];
		asyncImage.imageURL = url;
		
		
		UIView *imgTempview = [[[UIView alloc]initWithFrame:CGRectMake(x,y,v_Width,v_Height)]autorelease];
		
		UIButton *btn = (UIButton*)[btnarray objectAtIndex:i];
		btn.tag = cnt;
		
		[imgTempview addSubview:asyncImage];
		[imgTempview addSubview:btn];
		[imgView addSubview:imgTempview];
		
		x+=inc_width;
		cnt++;
		NSLog(@"%f",x);
	}
	return imgView;
	[imgView release];
	[btnarray release];
	
    
}

-(IBAction)ButtonClick:(id)sender{
	
	PictureShowsInFullScreen *picFull=[[PictureShowsInFullScreen alloc]initWithNibName:[Constant GetNibName:@"PictureShowsInFullScreen"] bundle:[NSBundle mainBundle]];
	
	UIButton *btnTemp= (UIButton*)sender;	
	picFull.CurrentPositionofImage =btnTemp.tag;
	picFull.objBigImageArray = arrImage;
	picFull.headertitle = headerTitle;
	[self.navigationController pushViewController:picFull animated:YES];
	
	
	
	
}


/////////////////////////////////////JHUMA*****////////////////////////////////////////
/*
-(void)ButtonClick:(UITapGestureRecognizer *)sender{
    
	PictureShowsInFullScreen *picFull=[[PictureShowsInFullScreen alloc]initWithNibName:[Constant GetNibName:@"PictureShowsInFullScreen"] bundle:[NSBundle mainBundle]];
    
	picFull.CurrentPositionofImage =sender.view.tag;
    NSLog(@"tag  %d",sender.view.tag);
	picFull.objBigImageArray = arrImage;
	picFull.headertitle = headerTitle;
	[self.navigationController pushViewController:picFull animated:YES];
	
	}*/

-(void)CreateImageArray{
	
    [arrImagesList removeAllObjects];
	long nCount = 3;
	NSInteger Cnt=0;
	arrPossision=0;
	arrTempImages= [[NSMutableArray alloc]init];
	arrCounter = [[NSMutableArray alloc]init];
	arrTemp_Counter = [[NSMutableArray alloc]init];
	for(int i=0; i<[arrImage count];i++)
	{
		
		[arrTempImages addObject:[arrImage objectAtIndex:i]];
		if((i==nCount) || (i==[arrImage count]-1))
		{ 
			[arrCounter addObject:[NSNumber numberWithInt:Cnt]];
			[arrTemp_Counter addObject:arrCounter];
			[arrTemp_Counter addObject:arrTempImages];
			
			[arrImagesList addObject:arrTemp_Counter];
			
			arrTempImages = [[NSMutableArray alloc]init];
			arrCounter = [[NSMutableArray alloc]init];			
			
			arrTemp_Counter = [[NSMutableArray alloc]init];
			nCount+=4;
			Cnt+=4;
		}
	}
  
}


-(void)CreateImageArray_Landscape;{
	[arrImagesList removeAllObjects];
	
	long nCount = 4;
	NSInteger Cnt=0;
	arrPossision=0;
	arrTempImages= [[NSMutableArray alloc]init];
	arrCounter = [[NSMutableArray alloc]init];
	arrTemp_Counter = [[NSMutableArray alloc]init];
	for(int i=0; i<[arrImage count];i++)
	{
		
		[arrTempImages addObject:[arrImage objectAtIndex:i]];
		if((i==nCount) || (i==[arrImage count]-1))
		{ 
			[arrCounter addObject:[NSNumber numberWithInt:Cnt]];
			[arrTemp_Counter addObject:arrCounter];
			[arrTemp_Counter addObject:arrTempImages];
			
			[arrImagesList addObject:arrTemp_Counter];
			
			arrTempImages = [[NSMutableArray alloc]init];
			arrCounter = [[NSMutableArray alloc]init];			
			
			arrTemp_Counter = [[NSMutableArray alloc]init];
			nCount+=5;
			Cnt+=5;
		}
	}
	[self.tableView reloadData];
	[Loading removeFromSuperview];
}




- (void)viewDidLoad {
    [super viewDidLoad];
	
   
	
	self.title = headerTitle;
    self.tableView.separatorStyle=NO;
			
	self.view.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
	
	
	arrImagesList = [[NSMutableArray alloc]init];
	
	self.tableView.rowHeight = (320-10)/4;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor redColor];
    //self.view.frame=CGRectMake(-10, 5, 310, 100);
   // self.tableView.backgroundColor=[UIColor yellowColor];
	self.navigationController.toolbarHidden=YES;
	imageOrientation = 0;
	[Loading removeFromSuperview];
	
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
     backButton.frame = CGRectMake(10, 15, 50, 25);
	
	self.navigationItem.hidesBackButton = NO;

	
}
-(void) GoBack:(id)sender {
	
	[self.navigationController popViewControllerAnimated:YES];
}	
- (void)viewWillAppear:(BOOL)animated {
	
	[self LoadDesign:self.interfaceOrientation];
    //[super viewWillAppear:animated];
    [self.tableView reloadData];
    
	self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.toolbarHidden = YES;
}
-(void)LoadDesign:(UIInterfaceOrientation)interfaceOrientation
{
	if(imageOrientation==0)
	{
		if(interfaceOrientation==UIDeviceOrientationPortrait)
		{   
			
			[self CreateImageArray];
				
		}
		else
		{
			//self.navigationItem.titleView =[Constant GetNavigationTitleimage_withbackbutton_landScape:app.imgName :@"General Images":self];
			[self CreateImageArray_Landscape];
			
			
		}
		
	}
	else
	{
		if(interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
		{
			if(imageOrientation!=interfaceOrientation)
			{
				//self.navigationItem.titleView =[Constant GetNavigationTitleimage_withbackbutton:@"General Images":self];			
				[self CreateImageArray];
                
				
			}
			
			
			
		}
		else
		{
			if(imageOrientation!=interfaceOrientation)
			{
				//self.navigationItem.titleView =[Constants GetNavigationTitleimage_withbackbutton_landScape:app.imgName :@"General Images":self];
				[self CreateImageArray_Landscape];
				
			}
		
			
		}
	}
	[self.tableView reloadData];
	imageOrientation=interfaceOrientation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	[self LoadDesign:interfaceOrientation];
	imageOrientation=interfaceOrientation;
}

 


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%@",arrImage);
    return [arrImage count]; 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	if(indexPath.row < [arrImagesList count]){
		if(imageOrientation == UIDeviceOrientationPortrait || imageOrientation == UIDeviceOrientationPortraitUpsideDown)
		    [cell.contentView addSubview:[self CreateImageList:[arrImagesList objectAtIndex:indexPath.row]]];
		else if(imageOrientation==UIDeviceOrientationLandscapeLeft || imageOrientation==UIDeviceOrientationLandscapeRight)
            [cell.contentView addSubview:[self CreateImageList_Landscape:[arrImagesList objectAtIndex:indexPath.row]]];
	}
    
	NSLog(@"indexPath.row : %d",indexPath.row);
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;		

	
    return cell;
}


//////////////////////////////////////////////JHUMA****//////////////////////////////////

/*
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"count %d",[arrImage count]);
    int m=0;
    m=[arrImage count]/4;
    
    if ([arrImage count]%4==0) {
        return m;
    }
    else
    {
    return m+1;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //const int IMGVIEW_TAG=100;
    
    AsyncImageView* asyncImage;
    
    
     int value=70;
    int w=6;
      int k=[arrImage count]%4;
    
    UIView *vw = [[[UIView alloc]init]autorelease];
    vw.frame =CGRectMake(0, 1, 380, 42);
    vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    
    vw.backgroundColor = [UIColor clearColor];
   
       
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
        [cell addSubview:vw];
    if(indexPath.row < ([arrImage count]/4)){
		
      
        
    for (int i=0; i<4; i++) {
                NSLog(@"j value %d",j);
                  
                      
            asyncImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(w, 8, 60, 60)];
       
            asyncImage.tag=j;
                NSString *ImgImage = [arrImage objectAtIndex:j];
                NSURL *url=[[NSURL alloc]initWithString:ImgImage];
                j++;
                  w=w+value;
                
                tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ButtonClick:)];
        [asyncImage addGestureRecognizer:tap];
        [tap release];
                
                [asyncImage loadImageFromURL:url];
                [vw addSubview:asyncImage];
        
        
        

            
            }  
              
	}
    else
    {
        for (int i=0; i<k; i++) {
            NSLog(@"j value %d",j);
            
            AsyncImageView* asyncImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(w, 0, 60, 60)];
            asyncImage.tag=j;

            NSString *ImgImage = [arrImage objectAtIndex:j];
            NSURL *url=[[NSURL alloc]initWithString:ImgImage];
            j++;
            w=w+value;
        
            
            [asyncImage loadImageFromURL:url];
            [vw addSubview:asyncImage];
            
            tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ButtonClick:)];
            [asyncImage addGestureRecognizer:tap];
            [tap release];

            
            
        }  
        j=0;

    }
    }
		NSLog(@"indexPath.row : %d",indexPath.row);
    
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView=[[[UIView alloc]initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;		
    return cell;
}

*/
- (void)dealloc {
    [super dealloc];
}


@end

