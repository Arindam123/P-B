//
//  DBFunctionality4Delete.h
//  PubAndBar
//
//  Created by MacMini10 on 15/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBFunctionality4Delete : NSObject


+ (DBFunctionality4Delete *)sharedInstance;
-(void) deleteEvents:(int)_pubID andEventID :(int)_eventID;
-(void) deleteThemenightEvents:(NSMutableArray *) _eventsArray;
-(void) deleteOneOffEvents:(NSMutableArray *) _eventsArray;
-(void) deleteRegularEvents:(NSMutableArray *) _eventsArray;
-(void) deleteExpiredEvents;


-(void) deleteRealAle:(NSMutableArray *) _aleArray;
-(void) deleteRealAle:(int)_pubID andEventID :(int)_eventID;

-(void) deleteSports:(int)_pubID andEventID :(int)_eventID;
-(void) deleteSports:(NSMutableArray *) _sportsArray;
-(void) deleteExpiredSportsEvent;

-(void) deleteFoods:(int)_pubID andEventID :(int)_eventID;
-(void) deleteFoods:(NSMutableArray *) _foodsArray;

-(void) deleteFacilities:(int)_pubID andEventID :(int)_eventID facilityID :(int) _facilityID;
-(void) deleteFacilities:(NSMutableArray *) _facilitiesArray;

@end
