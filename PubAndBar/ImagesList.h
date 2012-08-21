//
//  ImagesList.h
//  UrBanChat
//
//  Created by Kislay on 20/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ImagesList :UITableViewController  {

	
	NSString *image;
	NSInteger currentImage;
	UIButton *backButton;
	
		
	NSMutableArray *arrImagesList; //Main array
	NSMutableArray *arrTemp_Counter; // Sub array
	NSMutableArray *arrTempImages; //Image array
	NSMutableArray *arrCounter; //counter array
	
	NSMutableArray *arrImage;
	UIView *Loading;
	NSString *headerTitle;
    UITapGestureRecognizer *tap;
        
	
}
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)NSMutableArray *arrImagesList;
@property(nonatomic,retain)NSMutableArray *arrTempImages;
@property(nonatomic,retain)NSMutableArray *arrTemp_Counter;
@property(nonatomic,retain)NSMutableArray *arrCounter;
//
//@property(nonatomic,retain)UIView *Loading;
@property(nonatomic,retain)NSString *image;
@property(nonatomic)NSInteger currentImage;
@property(nonatomic,retain)NSMutableArray *arrImage;
@property(nonatomic,retain)NSString *headerTitle;

-(UIView*)CreateImageList:(NSMutableArray*)imgList;
-(UIView*)CreateImageList_Landscape:(NSMutableArray*)imgList;
-(void)CreateImageArray;
-(void)CreateImageArray_Landscape;
-(void)LoadDesign:(UIInterfaceOrientation)interfaceOrientation;
@end
