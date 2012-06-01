//
//  PreferenceDetailsViewController.h
//  PubAndBar
//
//  Created by MacMini Lion-1 on 21/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Constant.h"
#import "DistenceWheel.h"
#import "AppDelegate.h"
#import "Toolbar.h"
#import "SaveHomeInfo.h"

@interface PreferenceDetailsViewController : ButtonAction
<UITableViewDataSource,UITableViewDelegate>
{
    

    
    UITableView *hometable;
   // NSMutableArray *selectionArray;
    UIButton *btnSignUp;
    //UIView *line_vw;
    NSString *name;
    NSString *value;
    int i;
    Toolbar *toolBar;
    
    NSMutableArray *RecentArray;
    NSMutableArray *FavouritesArray;
    NSMutableArray  *array;
    
    IBOutlet UIButton *RecentHistory_Btn;
    IBOutlet UIButton *Favourites_Btn;
    IBOutlet UIButton *RecentSearch_Btn;
    IBOutlet UIButton *EditOrDelet_Btn;
    
    BOOL EditOrDeletBtnClicked;
    BOOL FavouritesButtonClicked;
    
}
@property(nonatomic,retain)UITableView *hometable;
//@property(nonatomic,retain)NSMutableArray *selectionArray;
@property(nonatomic,retain)UIButton *btnSignUp;
//@property(nonatomic,retain)UIView *line_vw;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *value;

@property(nonatomic,retain) NSMutableArray  *array;

@property(nonatomic,retain)NSMutableArray *RecentArray;
@property(nonatomic,retain)NSMutableArray *FavouritesArray;
@property(nonatomic,readwrite)int i;

-(void)CreateHomeView;
-(void)setHomeViewFrame;

- (IBAction)TapOnRecentButton:(id)sender;
- (IBAction)TapOnFavouritesButton:(id)sender;
- (IBAction)TapOnRecentSearchButton:(id)sender;
- (IBAction)TapOnEditOrDeletButton:(id)sender;


@end
