//
//  DBFunctionality.m
//  CCC
//
//  Created by Prosenjit on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBFunctionality.h"
#import "AppDelegate.h"

@implementation DBFunctionality
+ (DBFunctionality *)sharedInstance
{
       static DBFunctionality *sharedInstance_ = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance_ = [[DBFunctionality alloc] init];
    });
    return sharedInstance_;
    
}


-(void)InsertValue_Food_Type:(int)foodID withName:(NSString *)typeName;                                 
{
    //NSLog(@"%d  %@",foodID,typeName);
    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert into Food_Type (Food_ID,Food_Name)values(%d,'%@')",foodID ,typeName];
     
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
    
    //[[DbController CCCDatabase] executeUpdate:Qry_Insert_DashBoard];
    
    
}

-(void)InsertValue_Food_Detail:(NSString *)_foodInfo 
             withFoodServeTime:(NSString *)_foodServeTime
               chefDescription:(NSString *) _chefDescription
                  specialOffer:(NSString *) _specialOffer
                     withPubID:(int)_pubID
                withFoodTypeID:(int)_withFoodTypeID
{
    NSString *qry4FoodDetail = [NSString stringWithFormat:@"insert into Food_Detail (Food_Information,Food_ServingTime,Food_ChefDescription,Food_SpecialOffer)values('%@','%@','%@','%@') where PubID=%d AND FoodTypeID=%d",_foodInfo,_foodServeTime,_chefDescription,_specialOffer,_pubID,_withFoodTypeID];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodDetail];
}


-(void)InsertValue_Food_Detail:(int)pubID withFoodID:(int)_foodID pubDistance:(double) _pubDistance                             
{
    //NSLog(@"%d  %@",foodID,typeName);
    
    NSString *qry4FoodDetail = [NSString stringWithFormat:@"insert into Food_Detail (pubID,FoodTypeID,PubDistance)values(%d,%d,%0.2f)",pubID,_foodID,_pubDistance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodDetail];
    
    //[[DbController CCCDatabase] executeUpdate:Qry_Insert_DashBoard];
    
    
}


//--------------------------------mb-25/05/12/5-45--------------------------------//
-(void)InsertValue_Amenities_Type:(int)eventID withName:(NSString *)typeName
{
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert into Ammenities (Ammenity_ID,Ammenity_Type)values(%d,'%@')",eventID ,typeName];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
}
-(void)InsertValue_Amenities_Detail:(int)Ammenity_ID  ammenity_TypeID:(int)ammenity_TypeID facility_Name:(NSString *)Facility_Name PubID:(int )pubID withPubDistance:(double)Pub_Distanc
{
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert into Ammenity_Detail (Ammenity_ID,Ammenity_TypeID,Facility_Name,PubID,PubDistance)values(%d,%d,'%@',%d,%f)",Ammenity_ID,ammenity_TypeID ,Facility_Name,pubID,Pub_Distanc];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];   
}

//------------------------------------------------------------------//

-(void)InsertValue_Sports_Type:(int)_sportID withName:(NSString *)_sportName
{
    NSLog(@"ID  %d   NAME  %@",_sportID,_sportName);
    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert into Sport_CatagoryName (Sport_ID,Sport_Name)values(%d,'%@')",_sportID ,_sportName];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
}
-(void)InsertValue_Sports_Detail:(int)_event_ID
                    sport_TypeID:(int)_sport_TypeID
                      event_Name:(NSString *)_event_Name
               event_Description:(NSString *)_event_Description
                      event_Date:(NSString *)_event_Date
                   event_Channel:(NSString *)_event_Channel
                     reservation:(NSString *)_reservation
                           sound:(NSString *)_sound
                              hd:(NSString *)_hd
                          threeD:(NSString *)_threeD
                          screen:(NSString *)_screen
                           PubID:(int)_pubID 
                 withPubDistance:(double)_Pub_Distance
                      event_Time:(NSString *)_event_Time
                      event_Type:(NSString *)_event_Type
{
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert into Sport_Event (Sport_EventID,Sport_ID,Sport_EventName,Sport_Description,Sport_Date,Time,Type,Channel,Reservation,Sound,HD,ThreeD,Screen,PubID,PubDIstance)values(%d,%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,%f)",_event_ID,_sport_TypeID ,_event_Name,_event_Description,_event_Date,_event_Time,_event_Type,_event_Channel,_reservation,_sound,_hd,_threeD,_screen,_pubID,_Pub_Distance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];   
}


-(void)InsertValue_Pub_Info:(int)pubID
                   withName:(NSString *)pubName 
                   distance:(double)_distance
                   latitude:(NSString *)_latitude
                  longitude:(NSString *)_longitude
                   postCode:(NSString *)_postCode 
                   district:(NSString *)_district 
                       city:(NSString *)_city
            lastUpdatedDate:(NSString *) _lastUpdatedDate
{
    //NSLog(@"%d  %d  %@  %f  %@  %@  %@",pubID,_foodID,pubName,_distance,_postCode,_district,_city);
    NSString *qry4PubInfo;
    
    if(_latitude.length == 0 || _longitude.length == 0)
    {
        qry4PubInfo = [NSString stringWithFormat:@"insert into PubDetails (PubID,PubName,PubPostCode,PubDistrict,PubCity,LastUpdatedDate)values(%d,'%@','%@','%@','%@','%@')",pubID ,pubName,_postCode,_district,_city,_lastUpdatedDate];
    }
    else{
        qry4PubInfo = [NSString stringWithFormat:@"insert into PubDetails (PubID,PubName,PubDistance,PubPostCode,PubDistrict,PubCity,Latitude,Longitude,LastUpdatedDate)values(%d,'%@',%0.2f,'%@','%@','%@','%@','%@','%@')",pubID ,pubName,_distance,_postCode,_district,_city,_latitude,_longitude,_lastUpdatedDate];
        
        
    }
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4PubInfo];
}




-(void)InsertIntoEventDetailsWithEventID:(int)_ID Name:(NSString*)_Name EventTypeID:(NSString*)_EventTypeID PubID:(int)_PubID PubDistance:(double)_PubDistance creationdate:(NSString*)_date{
    @try {
        _Name = [_Name stringByReplacingOccurrencesOfString:@"'" withString:@""];
        
        if ([_Name isEqualToString:@"(null)"] || _Name == nil) 
            _Name = @"";
        if ([_EventTypeID isEqualToString:@"(null)"] || _EventTypeID == nil) 
            _EventTypeID = @"";
        if ([_date isEqualToString:@"(null)"] || _date == nil) 
            _date = @"";
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        /*NSString *Qry_UpdateEvent_InDistance;
         if ([appDelegate.SelectedRadius doubleValue] > _PubDistance) {
         //saying yes
         Qry_UpdateEvent_InDistance = [NSString stringWithFormat:@"update event set isindistance=1 where ID=%d",_EventTypeID];
         }
         else{
         //saying NO.
         Qry_UpdateEvent_InDistance = [NSString stringWithFormat:@"update event set isindistance=0 where ID=%d",_EventTypeID];
         }
         [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateEvent_InDistance];*/
        
        NSString *Qry_EventDetails = [NSString stringWithFormat:@"Insert into Event_Detail (ID,Name,PubID,PubDistance,Event_Type,Date) values(%d,'%@',%d,%f,'%@','%@')",_ID,_Name,_PubID,_PubDistance,_EventTypeID,_date];
        
        
        [appDelegate.PubandBar_DB executeUpdate:Qry_EventDetails];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

#pragma mark Pub Photo
//Biswa
-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                        GeneralImages:(NSString*)_GeneralImages 
                   FunctionRoomImages:(NSString*)_FunctionRoomImages 
                      FoodDrinkImages:(NSString*)_FoodDrinkImages{
    NSString *Qry_Insert_PubPhoto = [NSString stringWithFormat:@"Insert Into Pub_Photo (PubID,GeneralImages,FunctionRoomImages,FoodDrinkImages) values(%d , '%@' , '%@' , '%@')",[_pubId intValue],_GeneralImages,_FunctionRoomImages,_FoodDrinkImages];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_Insert_PubPhoto];
    
}

#pragma mark Ammenities Details Update
//Biswa
-(void)UpdateAmmenitiesDetailsbyPubId:(NSString*)_pubid 
                          AmmnitiesID:(NSString*)_amennitiesid 
                       FacilitiesInfo:(NSString*)_facilitiesinfo{
    
    _facilitiesinfo = [_facilitiesinfo stringByReplacingOccurrencesOfString:@"'" withString:@""];
    
    NSString *Qry_UpdateAmmenitiesDetails = [NSString stringWithFormat:@"Update Ammenity_Detail SET FacilitiesInformation='%@' where Ammenity_TypeID=%@ AND PubID=%@",_facilitiesinfo,_amennitiesid,_pubid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateAmmenitiesDetails];
}


//Biswa
#pragma mark Event Detail
//Biswa
-(void)UpdateEvent_DetailByID:(NSString*)_Event_ID 
                  eventtypeid:(NSString*)_eventtypeid
                         date:(NSString*)_date 
                    eventdesc:(NSString*)_eventdesc 
                        PUBID:(NSString*)_pubid 
                     isNoInfo:(BOOL)_isNoInfo{
    _eventdesc = [_eventdesc stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString *Qry_UpdateEventDetail;
    if (!_isNoInfo) 
        Qry_UpdateEventDetail = [NSString stringWithFormat:@"Update Event_Detail set Date='%@' , Event_Description='%@' where ID=%@ and Event_Type='%@' and pubid=%@",_date,_eventdesc,_Event_ID ,_eventtypeid,_pubid];
    else
        Qry_UpdateEventDetail = [NSString stringWithFormat:@"Update Event_Detail set Date='%@' , Event_Description='%@' where ID=%@ and Event_Type='%@' and pubid=%@",[Constant GetCurrentDateTime],_eventdesc,_Event_ID ,_eventtypeid,_pubid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateEventDetail];
    
}

#pragma mark Food & Offers
//Biswa
-(void)UpdateFoodDetailsByFoodTypeId:(NSString*)_foodtypeid 
                             byPubID:(NSString*)_pubid 
                           FoodInfor:(NSString*)_foodinfo 
                     FoodServingTime:(NSString*)_foodservingtime 
                           Chiefdesc:(NSString*)_chiefdesc 
                       SpeicalOffers:(NSString*)_speicaloffers{
    _foodinfo = [_foodinfo stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _foodservingtime = [_foodservingtime stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _chiefdesc = [_chiefdesc stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _speicaloffers = [_speicaloffers stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString *Str_UpdateFooddetails = [NSString stringWithFormat:@"Update Food_Detail set Food_Information='%@' , Food_ServingTime='%@' , Food_ChefDescription='%@' , Food_SpecialOffer='%@' where FoodTypeID=%d and PubID=%d",_foodinfo,_foodservingtime,_chiefdesc,_speicaloffers,[_foodtypeid intValue],[_pubid intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Str_UpdateFooddetails];
    
}

#pragma mark Pub details
//Biswa
-(void)InsertValue_Pub_details:(NSString *)_pubEmail
                     pubMobile:(NSString *)_pubMobile 
                    pubWebsite:(NSString *)_pubWebsite
                pubdescription:(NSString *)_pubdescription
                      pubImage:(NSString *)_pubImage
                    venueStyle:(NSString *)_venueStyle
                 venueCapacity:(NSString *)_venueCapacity
                   nearestRail:(NSString *)_nearestRail
                   nearestTube:(NSString *)_nearestTube
                    localBuses:(NSString *)_localBuses
                    pubCompany:(NSString *)_pubCompany 
                         PubID:(NSString*)_pubid 
                    PubAddress:(NSString*)_pubadd
                    PubPhoneNo:(NSString*)_pubPhoneNo

{
    //***********************There will be no insert method in this case***************************
    //NSString *qry4PubDetails = [NSString stringWithFormat:@"insert into PubDetails (PubEmail,Mobile,PubWebsite,PubDescription,Image,VenueStyle,VenueCapacity,NearestRail,NearestTube,LocalBuses)values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",_pubEmail ,_pubMobile,_pubWebsite,_pubdescription,_pubImage,_venueStyle,_venueCapacity,_nearestRail,_nearestTube,_localBuses,_pubCompany];
    _pubdescription = [_pubdescription stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _venueStyle = [_venueStyle stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _venueCapacity = [_venueCapacity stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _nearestRail = [_nearestRail stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _nearestTube = [_nearestTube stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _localBuses = [_localBuses stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _pubCompany = [_pubCompany stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _pubadd = [_pubadd stringByReplacingOccurrencesOfString:@"'" withString:@""];



    
    NSString *qry4PubDetails = [NSString stringWithFormat:@"Update PubDetails SET PubEmail='%@' , Mobile='%@' , PubWebsite='%@' , PubDescription='%@' , venuePhoto='%@' , VenueStyle='%@' , VenueCapacity='%@' , NearestRail='%@' , NearestTube='%@' , LocalBuses='%@' , pubcompany='%@' , pubaddress='%@' ,phoneNumber='%@' where pubid=%@",_pubEmail ,_pubMobile,_pubWebsite,_pubdescription,_pubImage,_venueStyle,_venueCapacity,_nearestRail,_nearestTube,_localBuses,_pubCompany,_pubadd,_pubPhoneNo,_pubid];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4PubDetails];
}


#pragma mark Sports & events
//Biswa
-(void)Update_Sport_DetailsbyPubId:(NSString*)_pubid 
                      SportEventID:(NSString*)_sporteventid 
                              Type:(NSString*)_Type 
                            ThreeD:(NSString*)_threeD 
                 SportsDescription:(NSString*)_sportsDescription 
                             Sound:(NSString*)_Sound 
                            Screen:(NSString*)_Screen 
                                HD:(NSString*)_HD 
                         eventName:(NSString*)_eventName 
                              Date:(NSString*)_Date 
                           Channel:(NSString*)Channel 
                              Time:(NSString*)_time 
                           SportID:(NSString*)_sportid{
    NSString *Qry_UpdateSportEvent = [NSString stringWithFormat:@"Update Sport_Event SET ThreeD='%@' , HD='%@' , Sound='%@' , Screen='%@' , Channel='%@' , Type='%@' , Sport_Date='%@' , Sport_EventName='%@' , Sport_Description='%@' , Time='%@' WHERE PubID=%@ AND Sport_EventID=%@ AND Sport_ID=%@",_threeD,_HD,_Sound,_Screen,Channel,_Type,_Date,_eventName,_sportsDescription,_time,_pubid,_sporteventid,_sportid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateSportEvent];
}


#pragma mark Beer details
//Biswa
-(void)UpdateBeerDetailsByPubId:(NSString*)_pubid 
                         BeerID:(NSString*)_beerid 
                      Beer_Name:(NSString*)_Beer_Name 
                       Catagory:(NSString*)_Catagory 
                       Beer_ABV:(NSString*)_BeerABV 
                     Beer_Color:(NSString*)_Beer_Color 
                     Beer_Smell:(NSString*)_Beer_Smell 
                     Beer_Taste:(NSString*)_Beer_Taste 
                   License_Note:(NSString*)_License_Note 
                         Ale_ID:(NSString*)_Ale_ID{
    NSString *Qry_UpdateBeerDetails = [NSString stringWithFormat:@"Update Ale_BeerDetail SET Beer_Name='%@' , Catagory='%@' , Beer ABV='%@' , Beer_Color='%@' , Beer_Smell='%@' , Beer_Taste='%@' , License_Note='%@' WHERE Beer_ID=%@ AND Ale_ID=%@ AND PubID=%@",_Beer_Name,_Catagory,_BeerABV,_Beer_Color,_Beer_Smell,_Beer_Taste,_Beer_Taste,_License_Note,_beerid,_Ale_ID,_pubid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateBeerDetails];
}



#pragma mark Real Ale details
//Biswa
-(void)UpdateRealAleDetailsByPubId:(NSString*)_pubid 
                            Ale_ID:(NSString*)_Ale_ID 
                          Ale_Name:(NSString*)_Ale_Name 
                        Ale_MailID:(NSString*)_Ale_MailID 
                       Ale_Website:(NSString*)_Ale_Website 
                       Ale_Address:(NSString*)_Ale_Address 
                      Ale_Postcode:(NSString*)_Ale_Postcode 
                   Ale_ContactName:(NSString*)_Ale_ContactName 
                   Ale_PhoneNumber:(NSString*)_Ale_PhoneNumber 
                      Ale_District:(NSString*)_Ale_District{
    NSString *Qry_UpdateRealAleDetails = [NSString stringWithFormat:@"Update RealAle_Detail SET Ale_Name='%@' , Ale_MailID='%@' , Ale_Website='%@' , Ale_Address='%@' , Ale_Postcode='%@' , Ale_ContactName='%@' , Ale_PhoneNumber='%@' , Ale_District='%@' WHERE PubID=%@ AND Ale_ID=%@",_Ale_Name,_Ale_MailID,_Ale_Website,_Ale_Address,_Ale_Postcode,_Ale_ContactName,_Ale_PhoneNumber,_Ale_District,_pubid,_Ale_ID];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateRealAleDetails];
}



/******************************************* Real Ale *********************************************/



-(void)InsertValue_RealAle_Type:(int)_breweryID 
                       withName:(NSString *)_breweryName
                      withPubID:(int)_pubID 
                    pubDistance:(double) _pubDistance
{
    NSString *qry4AleType = [NSString stringWithFormat:@"insert into RealAle_Detail (Ale_ID,Ale_Name,PubID,PubDistance)values(%d,'%@',%d,%0.2f)",_breweryID ,_breweryName,_pubID,_pubDistance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4AleType];
}


-(void)InsertValue_Beer_Detail:(int)beerID 
                 withBreweryID:(int)_breweryID 
                 withPubID:(int)_pubID 
                  withBeerName:(NSString *)_beername 
              withBeerCategory:(NSString *)_category 
                   pubDistance:(double) _pubDistance
{
    NSString *qry4BeerDetail = [NSString stringWithFormat:@"insert into Ale_BeerDetail (Beer_ID,Ale_ID,PubID,Beer_Name,Catagory,PubDistance)values(%d,%d,%d,'%@','%@',%0.2f)",beerID ,_breweryID,_pubID,_beername,_category,_pubDistance];
    
    
    NSLog(@"Query  %@",qry4BeerDetail);
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB executeUpdate:qry4BeerDetail];
}



 


@end
