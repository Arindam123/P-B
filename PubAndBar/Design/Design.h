//
//  TextFieldDesign.h
//  BarCode
//
//  Created by Tamal on 17/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Design : NSObject {

}
+(UITextField *)textFieldFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag;
+(UILabel *)LabelFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag;
+(UITextView *)textViewFormation:(float)x:(float)y:(float)Width:(float)Height:(int)tag;
@end
