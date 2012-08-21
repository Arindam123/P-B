//
//  NearMeNowCell.m
//  PubAndBar
//
//  Created by ARINDAM GHOSH on 09/08/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "NearMeNowCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NearMeNowCell

@synthesize pubImage,
label4Name,
label4Distance,
vw,
pushImg,
middleLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        vw = [[UIView alloc] init] ;
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
        
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [self.contentView addSubview:vw];
        
        
        
        /*UIView *vw1 =[[[UIView alloc]init] autorelease];//WithFrame:CGRectMake(10, 47, 300, 1)];
         vw1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         vw1.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
         
         if ([Constant isiPad]) {
         ;
         }
         
         else{
         if ([Constant isPotrait:self]) {
         
         
         vw1.frame =CGRectMake(10, 48, 300, 1);
         }
         else
         {
         vw1.frame =CGRectMake(10, 48, 460, 1);
         
         }
         }*/
        
        
        
        
        
        label4Name=[[UILabel alloc]initWithFrame:CGRectMake(50,3,200,20)];
        label4Name.backgroundColor = [UIColor clearColor];
        label4Name.textColor = [UIColor whiteColor];
        label4Name.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        label4Name.font = [UIFont boldSystemFontOfSize:11];
        label4Name.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label4Name];
        
        label4Distance=[[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 37)];
        label4Distance.backgroundColor = [UIColor clearColor];
        label4Distance.textColor = [UIColor whiteColor];
        label4Distance.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        label4Distance.font = [UIFont boldSystemFontOfSize:11];
        label4Distance.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label4Distance];
        
        
        middleLbl=[[UILabel alloc]initWithFrame:CGRectMake(50, 23, 160, 18)];
        middleLbl.backgroundColor = [UIColor clearColor];
        middleLbl.textColor = [UIColor whiteColor];
        middleLbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        middleLbl.font = [UIFont boldSystemFontOfSize:11];
        middleLbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:middleLbl];
        
        
        pubImage = [[AsyncImageView_New alloc] initWithFrame:CGRectMake(2,8,40,40)] ;
        //[asyncImage loadImageFromURL:[NSURL URLWithString: indicator:spinner];
        pubImage.backgroundColor=[UIColor clearColor];
        pubImage.layer.cornerRadius = 5.0;
        pubImage.layer.borderWidth = 1.0;
        pubImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        pubImage.layer.masksToBounds = YES;
        pubImage.userInteractionEnabled = YES;
        pubImage.crossfadeImages = NO;
        pubImage.layer.minificationFilter = kCAFilterNearest;
        //[pubImage addSubview:spinnerCell];
        [self.contentView addSubview:pubImage];
        
        
        
        pushImg = [[UIImageView alloc]initWithFrame:CGRectMake(310, 20, 10, 10)];
        pushImg.image=[UIImage imageNamed:@"right_iPhone"];
        pushImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ; 
        [self.contentView addSubview:pushImg];
        //[cell.contentView addSubview:vw1];
        
        
        
        self.layer.opaque = YES;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Memory management



- (void)dealloc {
	
	[pubImage release];
	[pushImg release];
    [vw release];
    [label4Name release];
    [label4Distance release];
    [middleLbl release];
	[super dealloc];
}

@end
