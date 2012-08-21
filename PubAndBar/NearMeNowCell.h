//
//  NearMeNowCell.h
//  PubAndBar
//
//  Created by ARINDAM GHOSH on 09/08/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView_New.h"

@interface NearMeNowCell : UITableViewCell
{
    AsyncImageView_New *pubImage;
    UILabel *label4Name;
    UILabel *label4Distance;
    UIView *vw;
    UIImageView *pushImg;
    UILabel *middleLbl;
}


@property (nonatomic,retain) AsyncImageView_New *pubImage;
@property (nonatomic,retain) UILabel *label4Name;
@property (nonatomic,retain) UILabel *label4Distance;
@property (nonatomic,retain) UIView *vw;
@property (nonatomic,retain) UIImageView *pushImg;
@property (nonatomic,retain) UILabel *middleLbl;


@end
