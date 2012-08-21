//
//  PictureShowsInFullScreen.h
//  PubAndBarNetwork
//
//  Created by VICTOR RAY on 22/09/10.
//  Copyright 2010 CF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>


@interface PictureShowsInFullScreen : UIViewController {
	int CurrentPositionofImage;
	//NSString* str;
	//int Counter ;
	NSMutableArray *arrViewedImage;
	UIBarButtonItem *btnNext;
	UIBarButtonItem *btnPrevious;
	UIBarButtonItem *btnSwitch1;
	UIBarButtonItem *btnSwitch2;
	UIView *Loading;
	UIImageView *pictureView;
	
	NSInteger count;
	//BOOL translucent;
	NSTimer *myTimer;
	
	NSMutableArray *objBigImageArray;
	NSString *headertitle;
    UIButton *backButton;

	

}

@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,readwrite)int CurrentPositionofImage;
//@property(nonatomic,retain)NSString* str;
@property(nonatomic,retain)NSMutableArray *arrViewedImage;
@property(nonatomic,retain)UIBarButtonItem *btnNext;
@property(nonatomic,retain)UIBarButtonItem *btnPrevious;
@property(nonatomic,retain)UIBarButtonItem *btnSwitch1;
@property(nonatomic,retain)UIBarButtonItem *btnSwitch2;
@property(nonatomic,retain)UIView *Loading;
@property(nonatomic,retain)UIImageView *pictureView;
@property(nonatomic,retain)NSTimer *myTimer;
@property(nonatomic,retain)NSMutableArray *objBigImageArray;
@property(nonatomic,retain)NSString *headertitle;



//-(void)BackView;
//-(void)CommonFlipFunction;
- (void)awakeFromNib;
//-(void)updateImage;
//-(void)BackClick;
-(void)LoadImage:(long)Position;
-(void)LoadImage_Landscape:(long)Position;
-(void)LoadDesign:(UIInterfaceOrientation)interfaceOrientation;



@end
