//
//  Tweet.m
//  iCodeOauth
//
//  Created by Collin Ruffenach on 9/14/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "Tweet.h"


//NSString * const NOTIF_DataComplete = @"DataComplete";


/*@interface Tweet (private)
- (void) dataDownloadComplete:(NSNotification *)notif;
@end*/


@implementation Tweet

-(id)initWithTweetDictionary:(NSDictionary*)_contents {
	
	/*[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(downloadDataComplete:) 
												 name:NOTIF_DataComplete object:nil]; */
	
	
	
	if(self = [super init]) {
		
		contents = _contents;
		[contents retain];
	}
	
	return self;
}

- (void)downloadDataComplete:(NSNotification *)notif 
{
	NSLog(@"Received Notification - Data has been downloaded");
}



-(NSString*)tweet {
	
	return [contents objectForKey:@"text"];
}

-(NSString*)author {
	
	return [[contents objectForKey:@"user"] objectForKey:@"screen_name"];
}

-(NSString*)fullName
{
    return [[contents objectForKey:@"user"] objectForKey:@"name"];
	
}


-(void) dealloc{
	
	//[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}


@end
