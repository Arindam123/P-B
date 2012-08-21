//
//  DBFunctionality4Update.m
//  PubAndBar
//
//  Created by MacMini10 on 11/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "DBFunctionality4Update.h"


@implementation DBFunctionality4Update
static DBFunctionality4Update *sharedInstance_;

/*+ (void)initialize
{
    static BOOL initialized = NO;
    //static DBFunctionality4Update *sharedInstance_;
    if(!initialized)
    {
        initialized = YES;
        sharedInstance_ = [[DBFunctionality4Update alloc] init];
    }
}*/

+ (DBFunctionality4Update *)sharedInstance
{
    
        static dispatch_once_t pred;
        
        dispatch_once(&pred, ^{
            sharedInstance_ = [[DBFunctionality4Update alloc] init];
        });
        
       
    {
        return sharedInstance_;    
    }
    
}

#pragma mark -
#pragma mark - UpdatePubDistance

-(void) UpdatePubDistance
{
    /*@synchronized(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"PubandBar_DB.sqlite"];
        
        // Check to see if the database file already exists
        bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
        
        if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK)
        {
            // Create the query statement to get all persons
            NSString *queryStatement = [NSString stringWithFormat:@"select * from PubDetails where latitude not null and longitude not null"];
            
            // Prepare the query for execution
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(databaseHandle, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                // Iterate over all returned rows
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    
                    
                    //NSLog(@"STMT   %@   %@   %@",[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)],[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)],[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]);
                    
                    
                    NSString *latitude = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                    NSString *longitude = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                    NSString *pubID = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                    
                    double distance = ([self calculateDistance:[latitude doubleValue] andLongitude:[longitude doubleValue]])/1000;
                    
                    NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update PubDetails SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[pubID intValue]];
                    //NSLog(@"QUERY   %@",Qry_UpdatePubDetails);
                    
                    //sqlite3_stmt *statement2;
                    sqlite3_exec(databaseHandle, "BEGIN", 0, 0, 0);
                    char *error;        
                    if (sqlite3_exec(databaseHandle, [Qry_UpdatePubDetails UTF8String], NULL, NULL, &error) == SQLITE_OK)
                    {
                        NSLog(@"updated");
                    }
                    else
                    {
                        NSLog(@"Error: %s", error);
                    }
                    
                    
                }
                sqlite3_exec(databaseHandle, "COMMIT", 0, 0, 0);
                sqlite3_finalize(statement);
            }
        }
        NSLog(@"Done");

    }
    */
    
        
   
    @synchronized(self)
    {
        AppDelegate *appDelegate;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        // NSMutableArray *arr=[[NSMutableArray alloc]init];
        ResultSet *rs;
        [appDelegate.PubandBar_DB beginTransaction];
        rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails where latitude not null and longitude not null"]];
        while ([rs next]) {
            
            
            NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                    [rs stringForColumn:@"PubID"],@"PubID",
                                                    [rs stringForColumn:@"Latitude"],@"Latitude",
                                                    [rs stringForColumn:@"Longitude"],@"Longitude",
                                                    nil];
            
            
            
            double distance = ([self calculateDistance:[[rs stringForColumn:@"Latitude"] doubleValue] andLongitude:[[rs stringForColumn:@"Longitude"] doubleValue]])/1000;
            
            NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update PubDetails SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[rs stringForColumn:@"PubID"] intValue]];
            
            //NSLog(@"QUERY   %@",Qry_UpdatePubDetails);
            
            [appDelegate.PubandBar_DB executeUpdate:Qry_UpdatePubDetails];
            
            
            //[arr addObject:tempDictionary2];
            [tempDictionary2 release];
            
        }
        [appDelegate.PubandBar_DB commit];

        NSLog(@"Done");

    }
   
    
    
    /*for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update PubDetails SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdatePubDetails];
        //NSLog(@"DISTANCE   %d",(int)floor(distance));
        
       // NSLog(@"Query   %@",Qry_UpdatePubDetails);

    }*/
   

}


-(void) UpdatePubDistance4NonSubPubs
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    [appDelegate.PubandBar_DB beginTransaction];

    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from NonSubPubs"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"Pub_ID"],@"PubID",
                                                [rs stringForColumn:@"Lat"],@"Latitude",
                                                [rs stringForColumn:@"Long"],@"Longitude",
                                                nil];
        
        double distance = ([self calculateDistance:[[rs stringForColumn:@"Lat"] doubleValue] andLongitude:[[rs stringForColumn:@"Long"] doubleValue]])/1000;
        
        NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update NonSubPubs SET Distance='%0.2f'  WHERE Pub_ID=%d",distance,[[rs stringForColumn:@"Pub_ID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdatePubDetails];
        [tempDictionary2 release];
    }
    
    
    /*for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        NSString *Qry_UpdatePubDetails = [NSString stringWithFormat:@"Update NonSubPubs SET Distance='%0.2f'  WHERE Pub_ID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdatePubDetails];
       // NSLog(@"Qry_UpdatePubDetails  %@",Qry_UpdatePubDetails);
        
    }*/
    
    [appDelegate.PubandBar_DB commit];

    
    [arr release];
}




-(void)UpdatePubDistance4Events
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        
        NSString *Qry_UpdateEvent_Detail = [NSString stringWithFormat:@"Update Event_Detail SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateEvent_Detail];
                
    }
    [arr release];
}


-(void)UpdatePubDistance4Sports
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        NSString *Qry_UpdateSport_Event = [NSString stringWithFormat:@"Update Sport_Event SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateSport_Event];
        
    }
    
    [arr release];
}


-(void)UpdatePubDistance4RealAle
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        NSString *Qry_UpdateRealAle_Detail = [NSString stringWithFormat:@"Update RealAle_Detail SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateRealAle_Detail];
        
        NSString *Qry_UpdateAle_BeerDetail = [NSString stringWithFormat:@"Update Ale_BeerDetail SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateAle_BeerDetail];
        
     
    }
    
    [arr release];
}

-(void)UpdatePubDistance4Foods
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        
        NSString *Qry_UpdateFood_Detail = [NSString stringWithFormat:@"Update Food_Detail SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateFood_Detail];
        
               
        
    }
    
    [arr release];
}

-(void)UpdatePubDistance4Facilities
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    ResultSet *rs;
    rs = [appDelegate.PubandBar_DB executeQuery:[NSString stringWithFormat:@"select * from PubDetails"]];
    while ([rs next]) {
        
        
        NSMutableDictionary *tempDictionary2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                
                                                [rs stringForColumn:@"PubID"],@"PubID",
                                                [rs stringForColumn:@"Latitude"],@"Latitude",
                                                [rs stringForColumn:@"Longitude"],@"Longitude",
                                                nil];
        
        [arr addObject:tempDictionary2];
        [tempDictionary2 release];
    }
    
    for (int i=0; i<[arr count]; i++) {
        
        double distance = ([self calculateDistance:[[[arr objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[arr objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]])/1000;
        
        
        NSString *Qry_UpdateAmmenity_Detail = [NSString stringWithFormat:@"Update Ammenity_Detail SET PubDistance='%0.2f'  WHERE PubID=%d",distance,[[[arr objectAtIndex:i] valueForKey:@"PubID"] intValue]];
        [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateAmmenity_Detail];
        
      
        
        
        
    }
    
    [arr release];
}



#pragma mark -
#pragma mark - calculateDistance
-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude
{
    //NSString *latitude = @"51.5001524";
    //NSString *longitude = @"-0.1262362";
    //delegate.currentPoint.coordinate.latitude
    //delegate.currentPoint.coordinate.longitude
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:delegate.currentPoint.coordinate.latitude longitude:delegate.currentPoint.coordinate.longitude];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
    
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    
    return distance;
}
@end
