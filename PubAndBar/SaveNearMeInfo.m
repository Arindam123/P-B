//
//  SaveNearMeInfo.m
//  PubAndBar
//
//  Created by ARINDAM GHOSH on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SaveNearMeInfo.h"
#import "PubDetail.h"



@implementation SaveNearMeInfo

/*+(NSMutableArray *)GetNearMePubsInfo{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *_arr = [[NSMutableArray alloc]init];
    ResultSet *rs;
    
    rs =[appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Longitude Not Null and Latitude  Not Null  ORDER BY PubDistance ASC"]];
    
    
    NSLog(@"%@  ",rs);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               
                                               [rs stringForColumn:@"PubName"],@"PubName",                                
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                               [rs stringForColumn:@"Longitude"],@"Longitude",
                                               [rs stringForColumn:@"Latitude"],@"Latitude",
                                               [rs stringForColumn:@"venuePhoto"],@"venuePhoto",
                                               nil];                                               
        
        
        [_arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    return [_arr autorelease];
}*/

//*********************************** amit-04/06/2012 ******************************//

+(NSMutableArray *)GetNearMePubsInfo:(NSString *)pubDistance{
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *_arr = [[NSMutableArray alloc] init];
    ResultSet *rs;
    [appDelegate.PubandBar_DB beginTransaction];

    rs =[appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where Longitude Not Null and Latitude  Not Null ORDER BY PubDistance ASC"]];
    
    
    NSLog(@"%@  ",rs);
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [rs stringForColumn:@"venuePhoto"],@"venuePhoto",
                                               [rs stringForColumn:@"PubName"],@"PubName",
                                               [rs stringForColumn:@"PubDistance"],@"PubDistance",
                                               [rs stringForColumn:@"Longitude"],@"Longitude",
                                               [rs stringForColumn:@"Latitude"],@"Latitude",
                                               [rs stringForColumn:@"PubID"],@"PubID",
                                               [rs stringForColumn:@"PubPostCode"],@"PubPostCode", 
                                               [rs stringForColumn:@"PubCity"],@"PubCity",
                                               [rs stringForColumn:@"PubDistrict"],@"PubDistrict",
                                               [rs stringForColumn:@"PhoneNumber"],@"PhoneNumber",
                                               nil];                                               
        
        
        [_arr addObject:tempDictionary];
        [tempDictionary release];
        
        
    }
    
    [appDelegate.PubandBar_DB commit];

    return [_arr autorelease];
}




+(NSMutableArray *)GetNearMeNonSubPubsInfo:(NSString *)pubDistance withLimitValue:(int) _limitVal hitCount:(int)_count
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *_arr = [[NSMutableArray alloc] init];
    ResultSet *rs;
    
    int startLimit;
    int endLimit;
    
    if (_count == 1) {
        
        startLimit = 1;
        endLimit = _limitVal;
    }
    else{
        endLimit = _limitVal*_count;
        startLimit = (_limitVal*_count) - _limitVal+1;

    }
    
    NSLog(@"hitCount   %d  startLimit  %d  endLimit  %d",_count,startLimit,endLimit);


    NSString *StrQuary=[NSString stringWithFormat:@"select a.* from (SELECT *, round(abs(distance(Lat, Long, '%0.2f', '%0.2f'))) as dist FROM NonSubPubs) a where a.Long Not Null and a.Lat Not Null ORDER BY dist ASC LIMIT %d,%d",appDelegate.currentPoint.coordinate.latitude,appDelegate.currentPoint.coordinate.longitude,startLimit,endLimit];
    NSLog(@"QUERY %@",StrQuary);
    [appDelegate.PubandBar_DB beginTransaction];

    rs =[appDelegate.PubandBar_DB executeQuery:StrQuary];
    
    NSLog(@"QUERY %@",rs.query);
    while ([rs next]) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [rs stringForColumn:@"Pub_Name"],@"PubName",
                                               [rs stringForColumn:@"dist"],@"PubDistance",
                                               [rs stringForColumn:@"Long"],@"Longitude",
                                               [rs stringForColumn:@"Lat"],@"Latitude",
                                               [rs stringForColumn:@"Pub_ID"],@"PubID",
                                               [rs stringForColumn:@"Post_Code"],@"PubPostCode", 
                                               [rs stringForColumn:@"Pub_City"],@"PubCity",
                                               [rs stringForColumn:@"Pub_District"],@"PubDistrict",
                                               [rs stringForColumn:@"Phone"],@"PhoneNumber",
                                               nil];                                               
        /*double distance = ([self calculateDistance:[[rs stringForColumn:@"Lat"] doubleValue] andLongitude:[[rs stringForColumn:@"Long"] doubleValue]])/1000;
        
        NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update NonSubPubs SET Distance='%0.2f'  WHERE Pub_ID=%d",distance,[[rs stringForColumn:@"Pub_ID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdatePubDetails];*/
        
        [_arr addObject:tempDictionary];
        [tempDictionary release];
        
    } 
    //    }
    [appDelegate.PubandBar_DB commit];
    
    

    return [_arr autorelease];
}

#pragma mark -
#pragma mark - calculateDistance

+(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude
{
    //NSString *latitude = @"51.5001524";
    //NSString *longitude = @"-0.1262362";
    //delegate.currentPoint.coordinate.latitude
    //delegate.currentPoint.coordinate.longitude
    AppDelegate *delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:delegate.currentPoint.coordinate.latitude longitude:delegate.currentPoint.coordinate.longitude];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
    
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    
    return distance;
}






@end
