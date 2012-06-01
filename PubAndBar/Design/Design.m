//
//  TextFieldDesign.m
//  BarCode
//
//  Created by Tamal on 17/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#define textcolor [[UIColor alloc]initWithRed:56.0f/255 green:52.0f/255 blue:53.0f/255 alpha:1.0]


#import "Design.h"


@implementation Design
+(UITextField *)textFieldFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag{
	//Design text fied. Set text field comon properties
	UITextField *textFieldNormal ;
	CGRect frame = CGRectMake(x, y, Width, Height);
	textFieldNormal = [[UITextField alloc] initWithFrame:frame];
	textFieldNormal.borderStyle = UITextBorderStyleRoundedRect;
	textFieldNormal.textColor = [UIColor blackColor];
	textFieldNormal.font = [UIFont systemFontOfSize:12.0];
	textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	
	textFieldNormal.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	textFieldNormal.returnKeyType = UIReturnKeyDone;
	textFieldNormal.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
	textFieldNormal.clearButtonMode =UITextFieldViewModeWhileEditing;  // has a clear 'x' button to the right
	textFieldNormal.backgroundColor = [UIColor clearColor];
	textFieldNormal.tag =tag;		// tag this control so we can remove it later for recycled cells
	
	return textFieldNormal;
	[textFieldNormal release];
}

+(UILabel *)LabelFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag{
	
	UILabel *lblTemp;
	CGRect frame = CGRectMake(x, y, Width, Height);
	lblTemp = [[UILabel alloc]initWithFrame:frame];
	lblTemp.backgroundColor = [UIColor clearColor];
	lblTemp.textColor = textcolor;
	lblTemp.font = [UIFont systemFontOfSize:12.0];
	lblTemp.tag = tag;
	return lblTemp;
	[lblTemp release];
}

+(UITextView *)textViewFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag{
	UITextView *txtViewTemp;
	CGRect frame = CGRectMake(x, y, Width, Height);
	txtViewTemp = [[UITextView alloc]initWithFrame:frame];
	txtViewTemp.textColor = textcolor;//[UIColor whiteColor];
	txtViewTemp.backgroundColor = [UIColor clearColor];
	txtViewTemp.font = [UIFont systemFontOfSize:12.0];
	txtViewTemp.autocorrectionType = UITextAutocorrectionTypeNo;
	txtViewTemp.keyboardType=UIKeyboardTypeDefault;
	txtViewTemp.returnKeyType=UIReturnKeyDone;
	txtViewTemp.tag = tag;
	//txtViewTemp.scrollEnabled = YES;
	return txtViewTemp;
	[txtViewTemp release];
}
@end
