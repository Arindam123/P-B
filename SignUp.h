//
//  SignUp.h
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface SignUp : UIViewController<UITextFieldDelegate>

{
    
   
    IBOutlet UIButton *btn_cancel;
    
    IBOutlet UIButton *Create_Profile;
    
    IBOutlet UITextField *txt_FirstName;
    
    IBOutlet UITextField *txt_LastName;
    
    IBOutlet UITextField *txt_Email;
    
    IBOutlet UITextField *txt_Password;
    
    IBOutlet UITextField *txt_Location;
    IBOutlet UIScrollView *scrll;
    AppDelegate *app;
    
}
@property (retain, nonatomic) IBOutlet UIButton *btn_cancel;
@property (retain, nonatomic) IBOutlet UIButton *Create_Profile;
@property (retain, nonatomic) IBOutlet UITextField *txt_FirstName;
@property (retain, nonatomic) IBOutlet UITextField *txt_LastName;
@property (retain, nonatomic) IBOutlet UITextField *txt_Email;
@property (retain, nonatomic) IBOutlet UITextField *txt_Password;
@property (retain, nonatomic) IBOutlet UITextField *txt_Location;

-(IBAction)ClickCancel:(id)sender;
-(IBAction)CreateProfile:(id)sender;
-(BOOL) validateEmail: (NSString *)Email; 




@end
