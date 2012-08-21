//
//  DBFunctionality4Update.h
//  PubAndBar
//
//  Created by MacMini10 on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface DBFunctionality4Update : NSObject{

    AppDelegate *delegate ;
    sqlite3 *databaseHandle;
 
}

+ (DBFunctionality4Update *)sharedInstance;

-(void) UpdatePubDistance;
-(void) UpdatePubDistance4NonSubPubs;
-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude;
-(void)UpdatePubDistance4Events;
-(void)UpdatePubDistance4Sports;
-(void)UpdatePubDistance4RealAle;
-(void)UpdatePubDistance4Foods;
-(void)UpdatePubDistance4Facilities;
@end
