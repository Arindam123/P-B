//
//  FacebookController.h
//  FBSSO
//
//  Created by ARINDAM GHOSH on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@protocol FacebookControllerDelegate;


@interface FacebookController : NSObject <FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>{
    
    NSArray *permissions;
    id <FacebookControllerDelegate> fbDelegate;
    Facebook *facebook;


}

@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic, assign) id <FacebookControllerDelegate> fbDelegate;
@property (nonatomic, retain) Facebook *facebook;


+ (FacebookController *)sharedInstance;
-(void) initialize;
-(void) postToFacebook :(NSMutableDictionary*)_params;
@end


@protocol FacebookControllerDelegate <NSObject>
@optional
- (void)FBLoginDone :(id) objectDictionay;
-(void)GetFBData:(id)data;
-(void) RequestError:(NSError *)err;
@end
