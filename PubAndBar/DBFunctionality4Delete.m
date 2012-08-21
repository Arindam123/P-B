//
//  DBFunctionality4Delete.m
//  PubAndBar
//
//  Created by MacMini10 on 15/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "DBFunctionality4Delete.h"
#import "AppDelegate.h"

@implementation DBFunctionality4Delete


+ (DBFunctionality4Delete *)sharedInstance
{
    static DBFunctionality4Delete *sharedInstance_ = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance_ = [[DBFunctionality4Delete alloc] init];
    });
    return sharedInstance_;
    
}



-(void) deleteEvents:(int)_pubID andEventID :(int)_eventID
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Qry4deletePubs4Events = [NSString stringWithFormat:@"delete from Event_Detail WHERE PubID=%d AND ID=%d",_pubID,_eventID];
    
    //NSLog(@"DELETE  %@",Qry4deletePubs4Events);

    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4deletePubs4Events];
    [appDelegate.PubandBar_DB commit];

}


-(void) deleteRealAle:(int)_pubID andEventID :(int)_eventID
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Qry4deleteAle = [NSString stringWithFormat:@"delete from Ale_BeerDetail WHERE PubID=%d AND Ale_ID=%d",_pubID,_eventID];
    NSString *Qry4deleteAle2 = [NSString stringWithFormat:@"delete from RealAle_Detail WHERE PubID=%d AND Ale_ID=%d",_pubID,_eventID];

    //NSLog(@"DELETE Qry4deleteAle  %@",Qry4deleteAle);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4deleteAle];
    [appDelegate.PubandBar_DB executeUpdate:Qry4deleteAle2];
    [appDelegate.PubandBar_DB commit];


}


-(void) deleteSports:(int)_pubID andEventID :(int)_eventID
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *Qry4Sports = [NSString stringWithFormat:@"delete from Sport_Event WHERE PubID=%d AND Sport_EventID=%d",_pubID,_eventID];
    
    //NSLog(@"DELETE Qry4Sports  %@",Qry4Sports);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4Sports];
    [appDelegate.PubandBar_DB commit];

    
}


-(void) deleteExpiredSportsEvent
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Only_date;
    NSString *currentdate = [Constant GetCurrentDateTime];
    NSArray *Arr_OnlyDate = [currentdate componentsSeparatedByString:@" "];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@" " withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@":" withString:@""];
    Only_date = [Arr_OnlyDate objectAtIndex:0];
    Only_date = [Only_date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *Str_qry2DeleteEvents = [NSString stringWithFormat:@"delete from Sport_Event where Sport_Date <= date('now', '-1 days')"];
    //NSString *Str_qry2DeleteEvents = [NSString stringWithFormat:@"delete from (select  abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,*  from Sport_Event) Sport_Event where datet < %@",Only_date];
    //NSLog(@"Str_qry2DeleteEvents   %@   %@",Str_qry2DeleteEvents,Only_date);
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Str_qry2DeleteEvents];
    [appDelegate.PubandBar_DB commit];

    
    [self deleteSports:nil];
}


-(void) deleteExpiredEvents
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Str_qry2DeleteEvents = [NSString stringWithFormat:@"delete from Event_Detail where ExpiryDate <= date('now', '-1 days')"];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Str_qry2DeleteEvents];
    [appDelegate.PubandBar_DB commit];

}



-(void) deleteFoods:(int)_pubID andEventID :(int)_eventID
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Qry4Foods = [NSString stringWithFormat:@"delete from Food_Detail WHERE PubID=%d AND Food_ID=%d",_pubID,_eventID];
    
    //NSLog(@"DELETE Qry4Foods  %@",Qry4Foods);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4Foods];
    [appDelegate.PubandBar_DB commit];

}

-(void) deleteFacilities:(int)_pubID andEventID :(int)_eventID facilityID:(int) _facilityID
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *Qry4Facilities = [NSString stringWithFormat:@"delete from Ammenity_Detail WHERE PubID=%d AND Ammenity_TypeID=%d",_pubID,_eventID,_facilityID];
    
    NSLog(@"DELETE Qry4Facilities  %@",Qry4Facilities);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4Facilities];
    [appDelegate.PubandBar_DB commit];

}


#pragma mark - Theme Night Events Deletion


-(void) deleteThemenightEvents:(NSMutableArray *) _eventsArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];

    for (int i =0; i<[_eventsArray count]; i++) {
        
        [array4ID addObject:[[_eventsArray objectAtIndex:i] valueForKey:@"ID"]];
    }
    
        
    NSString *Qry4themeNightEventsDelete = [NSString stringWithFormat:@"delete from Event_Detail WHERE Event_Type=3 AND ID NOT IN %@",array4ID];
    
    //NSLog(@"DELETE Qry4themeNightEventsDelete  %@",Qry4themeNightEventsDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4themeNightEventsDelete];
    [appDelegate.PubandBar_DB commit];

    [array4ID release];

    
}


#pragma mark - One Off Events Deletion


-(void) deleteOneOffEvents:(NSMutableArray *) _eventsArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    for (int i =0; i<[_eventsArray count]; i++) {
        
        [array4ID addObject:[[_eventsArray objectAtIndex:i] valueForKey:@"ID"]];
    }
    
    
    NSString *Qry4oneOffEventsDelete = [NSString stringWithFormat:@"delete from Event_Detail WHERE Event_Type=2 AND ID IN %@",array4ID];
    
    //NSLog(@"DELETE Qry4themeNightEventsDelete  %@",Qry4oneOffEventsDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4oneOffEventsDelete];
    [appDelegate.PubandBar_DB commit];

    [array4ID release];
    
    
}


#pragma mark - Regular Events Deletion


-(void) deleteRegularEvents:(NSMutableArray *) _eventsArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    for (int i =0; i<[_eventsArray count]; i++) {
        
        [array4ID addObject:[[_eventsArray objectAtIndex:i] valueForKey:@"ID"]];
    }
    
    
    NSString *Qry4regularEventsDelete = [NSString stringWithFormat:@"delete from Event_Detail WHERE Event_Type=1 AND ID IN %@",array4ID];
    
    //NSLog(@"DELETE Qry4regularEventsDelete  %@",Qry4regularEventsDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4regularEventsDelete];
    [appDelegate.PubandBar_DB commit];

    [array4ID release];
    
    
}




#pragma mark - Real Ale Deletion

-(void) deleteRealAle:(NSMutableArray *) _aleArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    for (int i =0; i<[_aleArray count]; i++) {
        
        [array4ID addObject:[[_aleArray objectAtIndex:i] valueForKey:@"ID"]];
    }
    
    
    NSString *Qry4RealAleDelete = [NSString stringWithFormat:@"delete from Ale_BeerDetail WHERE  Ale_ID IN %@",array4ID];
    NSString *Qry4RealAleDelete2 = [NSString stringWithFormat:@"delete from RealAle_Detail WHERE  Ale_ID IN %@",array4ID];

    
    NSLog(@"DELETE Qry4RealAleDelete  %@",Qry4RealAleDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4RealAleDelete];
    [appDelegate.PubandBar_DB executeUpdate:Qry4RealAleDelete2];
    [appDelegate.PubandBar_DB commit];


    [array4ID release];
}

#pragma mark - Sports Deletion

-(void) deleteSports:(NSMutableArray *) _sportsArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    ResultSet *rs;
    
    /*NSString *Qry4SportsID = [NSString stringWithFormat:@"select Sport_ID from Sport_Event group by Sport_ID"];
    
    rs = [appDelegate.PubandBar_DB executeQuery:Qry4SportsID];

    while ([rs next]) {
        
       // NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                               //[rs stringForColumn:@"Sport_ID"],@"Sport_ID",
                                               //nil];
        
        [array4ID addObject:[rs stringForColumn:@"Sport_ID"]];
        //[tempDictionary release];
    }*/
    
    NSString *Only_date;
    NSString *currentdate = [Constant GetCurrentDateTime];
    NSArray *Arr_OnlyDate = [currentdate componentsSeparatedByString:@" "];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@" " withString:@""];
    currentdate = [currentdate stringByReplacingOccurrencesOfString:@":" withString:@""];
    Only_date = [Arr_OnlyDate objectAtIndex:0];
    Only_date = [Only_date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *Str_qry1 = [NSString stringWithFormat:@"select  Sport_ID from (select  abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,*  from Sport_Event) where datet>=%@ group by Sport_ID",Only_date];
    //NSString *Qry4SportsID2 = [NSString stringWithFormat:@"select Sport_ID from Sport_Event group by Sport_ID"];
    [appDelegate.PubandBar_DB beginTransaction];

    rs = [appDelegate.PubandBar_DB executeQuery:Str_qry1];
    
    while ([rs next]) {
        
        // NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
        //[rs stringForColumn:@"Sport_ID"],@"Sport_ID",
        //nil];
        
        [array4ID addObject:[rs stringForColumn:@"Sport_ID"]];
        //[tempDictionary release];
    }
    
    
    NSArray *copy = [array4ID copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([array4ID indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [array4ID removeObjectAtIndex:index];
        }
        index--;
    }
    [copy release];
    
    
    NSString *Qry4sportsDelete = [NSString stringWithFormat:@"delete from Sport_CatagoryName WHERE Sport_ID NOT IN %@",array4ID];
    
    //NSLog(@"DELETE Qry4sportsDelete  %@",Qry4sportsDelete);
    
    [appDelegate.PubandBar_DB executeUpdate:Qry4sportsDelete];
    [array4ID release];
    
    
    NSString *Str_qry2DeleteEvents = [NSString stringWithFormat:@"delete from (select  abs(substr(Sport_Date,1,4)||substr(Sport_Date,6,2)||substr(Sport_Date,9,2)) as datet,*  from Sport_Event) where datet<%@",Only_date];
    
    [appDelegate.PubandBar_DB executeUpdate:Str_qry2DeleteEvents];
    [appDelegate.PubandBar_DB commit];

    
}


#pragma mark - Foods Deletion

-(void) deleteFoods:(NSMutableArray *) _foodsArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    for (int i =0; i<[_foodsArray count]; i++) {
        
        [array4ID addObject:[[_foodsArray objectAtIndex:i] valueForKey:@"FoodID"]];
    }
    
    
    NSString *Qry4foodsDelete = [NSString stringWithFormat:@"delete from Food_Type WHERE Food_ID IN %@",array4ID];
    
    NSLog(@"DELETE Qry4foodsDelete  %@",Qry4foodsDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4foodsDelete];
    [appDelegate.PubandBar_DB commit];

    [array4ID release];
}

#pragma mark - Facilities Deletion

-(void) deleteFacilities:(NSMutableArray *) _facilitiesArray
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *array4ID = [[NSMutableArray alloc] init];
    
    for (int i =0; i<[_facilitiesArray count]; i++) {
        
        [array4ID addObject:[[_facilitiesArray objectAtIndex:i] valueForKey:@"FoodID"]];
    }
    
    
    NSString *Qry4facilitiesDelete = [NSString stringWithFormat:@"delete from Food_Type WHERE Food_ID IN %@",array4ID];
    
    NSLog(@"DELETE Qry4facilitiesDelete  %@",Qry4facilitiesDelete);
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry4facilitiesDelete];
    [appDelegate.PubandBar_DB commit];

    [array4ID release];
}



@end
