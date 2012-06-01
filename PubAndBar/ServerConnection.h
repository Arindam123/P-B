//
//  ServerConnection.h
//  FinancialDashboard
//
//  Created by Ria Chandra on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerConnection : NSObject {

	NSURLConnection *allServerconn;
	
	NSURLConnection *conn;
	
	NSMutableData *d2;
	
	id fromClass;
	SEL afterSuccessfulConnectionMethod;
	SEL afterFailourConnectionMethod;
	int forConnectionType;
    
}

- (void)passInformationFromTheClass:(id)fromClass_
		  afterSuccessfulConnection:(SEL)afterSuccessfulConnectionMethod_
			 afterFailourConnection:(SEL)afterFailourConnectionMethod_;


-(void)getFoodandOffersData:(NSString *) withReference;
-(void)getRealAleData:(NSString *) withReference;

//------------------mb*--25/05/12/5-45---------------------------//
-(void)getEventsData:(NSString*) withreference;

-(void)getSportsData:(NSString *) withReference;

-(void) getPubDetails:(NSString *) pubID;
-(void)geteventsData:(NSString*) withreference;







@end
