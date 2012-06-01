//
//  Tweet.h
//  iCodeOauth
//
//  Created by Collin Ruffenach on 9/14/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tweet : NSObject {

	NSDictionary *contents;
}

-(NSString*)tweet;
-(NSString*)author;
-(NSString*)fullName;

-(id)initWithTweetDictionary:(NSDictionary*)_contents;

//extern NSString * const NOTIF_DataComplete;

@end
