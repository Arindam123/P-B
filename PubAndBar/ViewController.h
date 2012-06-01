//
//  ViewController.h
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Home.h"
#import "AppDelegate.h"

@interface ViewController : ButtonAction<UINavigationControllerDelegate>{
    
    //////////////////JHUMA//////////////////////    
    
    IBOutlet UIView *vw;
    IBOutlet UILabel *lbl_version;
    
    
}
@property(nonatomic,retain)IBOutlet UILabel *lbl_version;
@property(nonatomic,retain)IBOutlet UIView *vw;

//////////////////////////////////////////////

-(IBAction)ClicksetMyPreference:(id)sender;
-(IBAction)ClickEnterWithoutPreference:(id)sender;
@end
