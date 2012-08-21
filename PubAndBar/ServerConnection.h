//
//  ServerConnection.h
//  FinancialDashboard
//
//  Created by Ria Chandra on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol ServerConnectionDelegate;

@protocol ServerConnectionDelegate <NSObject>
@required
-(void)afterSuccessfulConnection:(id)msg;
-(void)afterFailourConnection:(id)msg;
@end


@interface ServerConnection : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate> {

	NSURLConnection *allServerconn;
	
	NSURLConnection *conn;
	
	NSMutableData *d2;
	
	id fromClass;
	SEL afterSuccessfulConnectionMethod;
	SEL afterFailourConnectionMethod;
	int forConnectionType;
    id <ServerConnectionDelegate> serverDelegate;

}

@property (nonatomic,assign) id <ServerConnectionDelegate> serverDelegate;


- (void)passInformationFromTheClass:(id)fromClass_
		  afterSuccessfulConnection:(SEL)afterSuccessfulConnectionMethod_
			 afterFailourConnection:(SEL)afterFailourConnectionMethod_;


-(void)getFoodandOffersData:(NSString *) withReference;
-(void)getRealAleData:(NSString *) withReference;

//------------------mb*--25/05/12/5-45---------------------------//
-(void)getEventsData:(NSString*) withreference;
-(void)getThmeNightData:(NSString*) withreference;

-(void)getSportsData:(NSString *) withReference;

-(void) getPubDetails:(NSString *) pubID;
-(void)geteventsData:(NSString*) withreference;



//Delete Events

-(void) deleteEventsData:(NSString*) withreference;
-(void) deleteThemeNightData:(NSString*) withreference;
-(void) deleteOneOffData:(NSString*) withreference;


-(void) deleteSportsData:(NSString*) withreference;
-(void) deleteRealAleData:(NSString*) withreference;
-(void) deleteFoodData:(NSString*) withreference;
-(void) deleteFacilityData:(NSString*) withreference;


//Non Sub Pubs


-(void) getNonSubPubs:(int) _value withDate:(NSString *) _date;
-(void) getNewAddedSubPubs:(NSString*) withreference;




@end
