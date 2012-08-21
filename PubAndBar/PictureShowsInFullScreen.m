//
//  PictureShowsInFullScreen.m
//  PubAndBarNetwork
//
//  Created by VICTOR RAY on 22/09/10.
//  Copyright 2010 CF. All rights reserved.
//

#import "PictureShowsInFullScreen.h"
#import "AsyncImageView.h"
#import "ImagesList.h"
#import "Constant.h"
#import "AsyncImageView_New.h"

@implementation PictureShowsInFullScreen (private)
int totalPhoto ;
UIImageView *SmallImageView;
AsyncImageView *asyncImage;
BOOL IsFirstLoad;
CGFloat TouchStartX,TouchEndX;
CGFloat TouchStartY,TouchEndY;
BOOL TouchTopToBottom;
UIInterfaceOrientation imageFullOrientation;

@end



@implementation PictureShowsInFullScreen

@synthesize CurrentPositionofImage,btnNext,btnPrevious,btnSwitch1,btnSwitch2;
@synthesize Loading,pictureView,arrViewedImage,myTimer,objBigImageArray;
@synthesize headertitle;
@synthesize backButton;

//int totalPhoto ;
//int a;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		UIImage *img=[UIImage imageNamed:@"top-bar.png"];
		self.tabBarItem.image=img;		
		[img release];				
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = headertitle;
	IsFirstLoad=YES;
	self.navigationItem.hidesBackButton=YES;
	arrViewedImage = [[NSMutableArray alloc]init];
	//app = (PubAndBarNetworkAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	totalPhoto = [objBigImageArray count]-1;
	self.navigationItem.hidesBackButton=YES;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"midbg.png"]];
	
	self.navigationController.navigationBarHidden=NO;
	self.navigationController.toolbarHidden=NO;
	//[self.navigationController.toolbar setTranslucent:YES];
	
	

	//self.navigationController.toolbar.tintColor = [UIColor clearColor];
	self.navigationController.toolbar.translucent=YES;
	self.navigationController.toolbar.alpha=10;
	//self.tabBarItem.image=[UIImage imageNamed:@"top-bar.png"];
	
	btnNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextImage)];
	btnPrevious = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previousImage)];
	UIBarButtonItem *btnPlay = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(awakeFromNib)];
	UIBarButtonItem *btnflex =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] ;
	
	NSArray *barArray = [NSArray arrayWithObjects:btnflex,btnPrevious, btnflex,btnPlay,btnflex, btnNext, btnflex,nil];
	
	[self setToolbarItems:barArray animated:YES];
	
	
	//self.navigationItem.titleView =[Constants GetNavigationTitleimage_withbackbutton:app.imgName :@"General Images":self];
	if(CurrentPositionofImage==0)
		btnPrevious.enabled=NO;
	else if(CurrentPositionofImage==totalPhoto)
		btnNext.enabled=NO;
	
	[btnNext release];
	
	[btnPrevious release];
	
	[btnSwitch1 release];
	
	[btnSwitch2 release];
	
	[btnPlay release];
	[self LoadImage:CurrentPositionofImage];
	
	imageFullOrientation =0;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButtonTwo.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    backButton.frame = CGRectMake(10, 15, 50, 25);
	
	self.navigationItem.hidesBackButton = NO;
    
}
-(void)LoadImage:(long)Position{
	if(!IsFirstLoad)
	{
			for (UIView *vwTemp in self.view.subviews) {
			[vwTemp removeFromSuperview];
		}
	}
	
	
	//objTempImage = [[ImageGroup alloc]init];
	
	
	if(self.navigationController.navigationBarHidden==NO){
		SmallImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		asyncImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,320,480)]autorelease];
    //  NSString *ImgImage = [objBigImageArray objectAtIndex:CurrentPositionofImage];
   // NSURL *url=[[NSURL alloc]initWithString:ImgImage];
    //[asyncImage loadImageFromURL:url];

	}
	else
	{
		SmallImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		asyncImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,320,480)]autorelease];
	}
	 //SmallImageView.image = [UIImage imageWithData:objTempImage.imgSmallInBytes];
    NSString *stringurl = [objBigImageArray objectAtIndex:CurrentPositionofImage];
    stringurl = [stringurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url1=[[NSURL alloc]initWithString:stringurl];
    [asyncImage loadImageFromURL:url1];
    
  
	
		
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.25];
	//[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	if (!TouchTopToBottom)
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	else
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	/*
	
	if ([objTempImage.imgLargeInBytes length]>0) {
		SmallImageView.image = [UIImage imageWithData:objTempImage.imgLargeInBytes];
		[self.view insertSubview:SmallImageView atIndex:0];
	}
	else {
		asyncImage.objRefImage =objTempImage;
		asyncImage.isLargeImage=YES;
		[asyncImage loadImageFromURL:url1];
		[self.view insertSubview:SmallImageView atIndex:0];
		[self.view addSubview:asyncImage];
	}
	*/
    
    [self.view addSubview:asyncImage];
	[UIView commitAnimations];
	IsFirstLoad=NO;
}

-(void)LoadImage_Landscape:(long)Position{
	if(!IsFirstLoad)
	{
		//if(SmallImageView.superview!=nil)
		//			[SmallImageView removeFromSuperview];
		//		if(Load.superview!=nil)
		//			[Load removeFromSuperview];
		//		if(asyncImage.superview!=nil)
		//			[asyncImage removeFromSuperview];
		for (UIView *vwTemp in self.view.subviews) {
			[vwTemp removeFromSuperview];
		}
	}
	
	
	//objTempImage = [[ImageGroup alloc]init];
	//objTempImage = [objBigImageArray objectAtIndex:Position];
	
	if(self.navigationController.navigationBarHidden==NO){
		SmallImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
		asyncImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,480,320)]autorelease];
	}
	else
	{
		SmallImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
		asyncImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,480,320)]autorelease];
	}
		//SmallImageView.image = [UIImage imageWithData:objTempImage.imgSmallInBytes];
	
    NSString *stringurl = [objBigImageArray objectAtIndex:CurrentPositionofImage];
    stringurl = [stringurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url1=[[NSURL alloc]initWithString:stringurl];
    [asyncImage loadImageFromURL:url1];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.25];
	//[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	if (!TouchTopToBottom)
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	else
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	
	
	
	/*
	if ([objTempImage.imgLargeInBytes length]>0) {
		SmallImageView.image = [UIImage imageWithData:objTempImage.imgLargeInBytes];
		[self.view insertSubview:SmallImageView atIndex:0];
	}
	else {
		asyncImage.objRefImage =objTempImage;
		asyncImage.isLargeImage=YES;
		[asyncImage loadImageFromURL:url1:Load];
		[self.view insertSubview:SmallImageView atIndex:0];
		[self.view addSubview:Load];
		[self.view addSubview:asyncImage];
	}
	*/
       [self.view addSubview:asyncImage];
	[UIView commitAnimations];
	IsFirstLoad=NO;
}


-(void) GoBack:(id)sender {
	
	self.navigationController.navigationBarHidden = YES;
	[self.navigationController popViewControllerAnimated:YES];
    //self.navigationController.toolbarHidden = YES;
//	[myTimer invalidate];
}	

-(void)previousImage{
	@try{
		CurrentPositionofImage--;
		if(CurrentPositionofImage==0)
			btnPrevious.enabled=NO;
		else
			btnNext.enabled=YES;
		//CurrentPositionofImage=totalPhoto;
		TouchTopToBottom=YES;
		if(imageFullOrientation == UIDeviceOrientationPortrait || imageFullOrientation == UIDeviceOrientationPortraitUpsideDown) {
			[self LoadImage:CurrentPositionofImage];
		}
		else if(imageFullOrientation==UIDeviceOrientationLandscapeRight || imageFullOrientation==UIDeviceOrientationLandscapeLeft) {
			[self LoadImage_Landscape:CurrentPositionofImage];
		}	
		
		
	}
	@catch (NSException *e) {
		NSLog(@" %@",e);
	}
}

-(void)nextImage{
	@try{
		CurrentPositionofImage++;
		if(CurrentPositionofImage==totalPhoto)
			btnNext.enabled=NO;
		else
			btnPrevious.enabled=YES;
		//CurrentPositionofImage=0;
		
		TouchTopToBottom=NO;
		if(imageFullOrientation == UIDeviceOrientationPortrait || imageFullOrientation == UIDeviceOrientationPortraitUpsideDown) {
		          [self LoadImage:CurrentPositionofImage];
		}
		else if(imageFullOrientation==UIDeviceOrientationLandscapeRight || imageFullOrientation==UIDeviceOrientationLandscapeLeft) {
			[self LoadImage_Landscape:CurrentPositionofImage];
		}	
		
	}
	@catch (NSException *e) {
		NSLog(@" %@",e);
	}
	
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *theTouch = [touches anyObject];	
	CGPoint touchLocation = [theTouch locationInView:self.view];
	
	TouchStartX = touchLocation.x;
	TouchStartY = touchLocation.y;
	NSLog(@"%f,%f",TouchStartX,TouchStartY);
	
	
	
	if(CurrentPositionofImage==0)
		btnPrevious.enabled=NO;
	else if(CurrentPositionofImage==totalPhoto)
		btnNext.enabled=NO;
	
	CATransition *transition = [CATransition animation];
	transition.duration = 1.00;
	transition.type = kCATransitionFade;
	transition.subtype = kCATransitionFromLeft;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	
	self.navigationController.navigationBarHidden=NO;
	self.navigationController.toolbarHidden = NO;
	
    if([myTimer isValid])
    {
    [myTimer invalidate];
    }
}
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *theTouch = [touches anyObject];	
//	CGPoint touchLocation = [theTouch locationInView:self.view];
//	
//	TouchStartX = touchLocation.x;
//	TouchStartY = touchLocation.y;
//	NSLog(@"%f,%f",TouchStartX,TouchStartY);
//}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//[myTimer invalidate];
	
	UITouch *theTouch = [touches anyObject];	
	CGPoint endPoint = [theTouch locationInView:self.view];
	TouchEndX = endPoint.x;
	TouchEndY = endPoint.y;
	NSLog(@"%f,%f",TouchEndX,TouchEndY);
	if(CurrentPositionofImage>=totalPhoto)
		return;
	else if(CurrentPositionofImage<=0)
		return;
	if(TouchEndX<TouchStartX)
	{
		TouchTopToBottom=NO;
		CurrentPositionofImage++;
		if(CurrentPositionofImage==totalPhoto)
			btnNext.enabled=NO;
		else
			btnPrevious.enabled=YES;
		[self LoadImage:CurrentPositionofImage];
	}
	else if(TouchEndX>TouchStartX)
	{
		TouchTopToBottom=YES;
		CurrentPositionofImage--;
		if(CurrentPositionofImage==0)
			btnPrevious.enabled=NO;
		else
			btnNext.enabled=YES;
		if(imageFullOrientation == UIDeviceOrientationPortrait || imageFullOrientation == UIDeviceOrientationPortraitUpsideDown) {
			[self LoadImage:CurrentPositionofImage];
		}
		else if(imageFullOrientation==UIDeviceOrientationLandscapeRight || imageFullOrientation==UIDeviceOrientationLandscapeLeft) {
			[self LoadImage_Landscape:CurrentPositionofImage];
		}	
		
	}
	
}
- (void) touchesCancled:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)awakeFromNib {
	CATransition *transition = [CATransition animation];
	transition.duration = 1.00;
	transition.type = kCATransitionFade;
	transition.subtype = kCATransitionFromLeft;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	self.navigationController.navigationBarHidden=YES;
	self.navigationController.toolbarHidden = YES;
	TouchTopToBottom=NO;
	myTimer=[[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(updatePhoto) userInfo:nil repeats:YES] retain];
    
}

-(void)updatePhoto{
	if(CurrentPositionofImage<totalPhoto)
	{
		CurrentPositionofImage++;
	}
	else	{
		CurrentPositionofImage=0;
	}
	//[self LoadImage:CurrentPositionofImage];
	if(imageFullOrientation == UIDeviceOrientationPortrait || imageFullOrientation == UIDeviceOrientationPortraitUpsideDown) {
		[self LoadImage:CurrentPositionofImage];
	}
	else if(imageFullOrientation==UIDeviceOrientationLandscapeRight || imageFullOrientation==UIDeviceOrientationLandscapeLeft) {
		[self LoadImage_Landscape:CurrentPositionofImage];
	}	
	
}



- (void)viewWillAppear:(BOOL)animated {
	[self LoadDesign:self.interfaceOrientation];
	[super viewWillAppear:animated];
	CATransition *transition = [CATransition animation];
	transition.duration = 1.50;
	//transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	transition.type = kCATransitionFade;
	transition.subtype = kCATransitionFromLeft;
	self.navigationController.toolbarHidden=NO;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	
	
}

-(void)LoadDesign:(UIInterfaceOrientation)interfaceOrientation
{
	if(imageFullOrientation==0)
	{
		if(interfaceOrientation==UIDeviceOrientationPortrait)
		{   
			
			[self LoadImage:CurrentPositionofImage];
			//[barTool DesignToolBar:self];			
		}
		else
		{
		//self.navigationItem.titleView =[Constants GetNavigationTitleimage_withbackbutton_landScape:app.imgName :@"General Images":self];	
			[self LoadImage_Landscape:CurrentPositionofImage];
			//[barTool DesignToolBar_Landscape:self];
			
		}
		
	}
	else
	{
		if(interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
		{
			if(imageFullOrientation!=interfaceOrientation)
			{
		//self.navigationItem.titleView =[Constants GetNavigationTitleimage_withbackbutton:app.imgName :@"General Images":self];		
				[self LoadImage:CurrentPositionofImage];
				
				//[barTool DesignToolBar:self];
			}
			
			
			
		}
		else
		{
			if(imageFullOrientation!=interfaceOrientation)
			{
			//	self.navigationItem.titleView =[Constants GetNavigationTitleimage_withbackbutton_landScape:app.imgName :@"General Images":self];
			
				[self LoadImage_Landscape:CurrentPositionofImage];
				//[barTool DesignToolBar_Landscape:self];
			}
			
			
			
		}
	}
	//[self.tableView reloadData];
	imageFullOrientation=interfaceOrientation;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	[self LoadDesign:interfaceOrientation];
	imageFullOrientation=interfaceOrientation;
}





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [backButton release];
    [super dealloc];
}


@end
