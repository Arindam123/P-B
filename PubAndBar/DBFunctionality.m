//
//  DBFunctionality.m
//  CCC
//
//  Created by Prosenjit on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBFunctionality.h"
#import "AppDelegate.h"


@interface DBFunctionality()

-(NSString *) lastUpdatedDate;

@end


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


-(NSString *) lastUpdatedDate
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"BST"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSLog(@"Date  %@",timeStamp);
    return timeStamp;
}




#pragma mark
#pragma Non-Sub-Pubs

-(void)InsertValue_NonSubPub_Info:(int)pubID
                         withName:(NSString *)pubName 
                         distance:(double)_distance
                         latitude:(NSString *)_latitude
                        longitude:(NSString *)_longitude
                         postCode:(NSString *)_postCode 
                         district:(NSString *)_district 
                             city:(NSString *)_city
                  lastUpdatedDate:(NSString *) _lastUpdatedDate
                          phoneNo:(NSString *) _phoneNo
{
    pubName = [pubName stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _district = [_district stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _city = [_city stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    
    
    NSString *qry4NonSubPubs = [NSString stringWithFormat:@"insert or replace into NonSubPubs (Long,Lat,Pub_ID,Pub_Name,Pub_City,Pub_District,Post_Code,Phone,Distance,LastUpdatedDate)values('%@','%@','%d','%@','%@','%@','%@','%@','%0.2f','%@')",_longitude,_latitude,pubID,pubName,_city,_district,_postCode,_phoneNo,_distance,[self lastUpdatedDate]];
    
    //NSLog(@"qry4NonSubPubs  %@",qry4NonSubPubs);
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:qry4NonSubPubs];
    [appDelegate.PubandBar_DB commit];

}


#pragma mark

-(void)InsertValue_Food_Type:(int)foodID withName:(NSString *)typeName;                                 
{
    //NSLog(@"%d  %@",foodID,typeName);
    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert or replace into Food_Type (Food_ID,Food_Name)values(%d,'%@')",foodID ,typeName];
     
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
    [appDelegate.PubandBar_DB commit];

    //[[DbController CCCDatabase] executeUpdate:Qry_Insert_DashBoard];
    
    
}

-(void)InsertValue_Food_Detail:(NSString *)_foodInfo 
             withFoodServeTime:(NSString *)_foodServeTime
               chefDescription:(NSString *) _chefDescription
                  specialOffer:(NSString *) _specialOffer
                     withPubID:(int)_pubID
                withFoodTypeID:(int)_withFoodTypeID
{
    _foodServeTime = [_foodServeTime stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _foodInfo = [_foodInfo stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _chefDescription = [_chefDescription stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _specialOffer = [_specialOffer stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    NSString *qry4FoodDetail = [NSString stringWithFormat:@"insert or replace into Food_Detail (Food_Information,Food_ServingTime,Food_ChefDescription,Food_SpecialOffer)values('%@','%@','%@','%@') where PubID=%d AND FoodTypeID=%d",_foodInfo,_foodServeTime,_chefDescription,_specialOffer,_pubID,_withFoodTypeID];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodDetail];
    [appDelegate.PubandBar_DB commit];

}


-(void)InsertValue_Food_Detail:(int)pubID withFoodID:(int)_foodID pubDistance:(double) _pubDistance                             
{
    //NSLog(@"%d  %@",foodID,typeName);
    
    NSString *qry4FoodDetail = [NSString stringWithFormat:@"insert or replace into Food_Detail (pubID,FoodTypeID,PubDistance)values(%d,%d,%0.2f)",pubID,_foodID,_pubDistance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodDetail];
    [appDelegate.PubandBar_DB commit];

    //[[DbController CCCDatabase] executeUpdate:Qry_Insert_DashBoard];
    
    
}


//--------------------------------mb-25/05/12/5-45--------------------------------//
-(void)InsertValue_Amenities_Type:(int)eventID
                         withName:(NSString *)typeName
{
    typeName = [typeName stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert or replace into Ammenities (Ammenity_ID,Ammenity_Type)values(%d,'%@')",eventID ,typeName];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
    [appDelegate.PubandBar_DB commit];

}
-(void)InsertValue_Amenities_Detail:(int)Ammenity_ID
                    ammenity_TypeID:(int)ammenity_TypeID
                      facility_Name:(NSString *)Facility_Name
                              PubID:(int )pubID
                    withPubDistance:(double)Pub_Distanc
{
    Facility_Name = [Facility_Name stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert or replace into Ammenity_Detail (Ammenity_ID,Ammenity_TypeID,Facility_Name,PubID,PubDistance)values(%d,%d,'%@',%d,%f)",Ammenity_ID,ammenity_TypeID ,Facility_Name,pubID,Pub_Distanc];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType]; 
    [appDelegate.PubandBar_DB commit];

}

//------------------------------------------------------------------//

-(void)InsertValue_Sports_Type:(int)_sportID withName:(NSString *)_sportName
{
    NSLog(@"ID  %d   NAME  %@",_sportID,_sportName);
    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert or replace into Sport_CatagoryName (Sport_ID,Sport_Name)values(%d,'%@')",_sportID ,_sportName];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];
    [appDelegate.PubandBar_DB commit];

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
    
    _event_Name = [_event_Name stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _event_Description = [_event_Description stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _event_Channel = [_event_Channel stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _event_Time = [_event_Time stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _event_Type = [_event_Type stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    
    NSString *qry4FoodType = [NSString stringWithFormat:@"insert or replace into Sport_Event (Sport_EventID,Sport_ID,Sport_EventName,Sport_Description,Sport_Date,Time,Type,Channel,Reservation,Sound,HD,ThreeD,Screen,PubID,PubDIstance)values(%d,%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,%f)",_event_ID,_sport_TypeID ,_event_Name,_event_Description,_event_Date,_event_Time,_event_Type,_event_Channel,_reservation,_sound,_hd,_threeD,_screen,_pubID,_Pub_Distance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4FoodType];   
    [appDelegate.PubandBar_DB commit];

}


#pragma mark Pub Photo
//Biswa
-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                        GeneralImages:(NSString*)_GeneralImages 
                       GeneralImageID:(NSString*)_GeneralImageID
{
    
    NSString *Qry_Insert_PubPhoto = [NSString stringWithFormat:@"Insert or replace Into GeneralImage (PubID,Image,ID) values(%d , '%@',%d)",[_pubId intValue],_GeneralImages,[_GeneralImageID intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_Insert_PubPhoto];
    [appDelegate.PubandBar_DB commit];

}

-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                   FunctionRoomImages:(NSString*)_FunctionRoomImages
                  FunctionRoomImageID:(NSString*)_FunctionRoomImageID

{ 
    
    NSString *Qry_Insert_PubPhoto = [NSString stringWithFormat:@"Insert or replace Into FunctionRoomImage (PubID,Image,ID) values(%d , '%@',%d)",[_pubId intValue],_FunctionRoomImages,[_FunctionRoomImageID intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_Insert_PubPhoto];
    [appDelegate.PubandBar_DB commit];

    
}

-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                      FoodDrinkImages:(NSString*)_FoodDrinkImages
                     FoodDrinkImageID:(NSString*)_FoodDrinkImageID
{
    
    NSString *Qry_Insert_PubPhoto = [NSString stringWithFormat:@"Insert or replace Into FoodDrinkImage (PubID,Image,ID) values(%d , '%@',%d)",[_pubId intValue],_FoodDrinkImages,[_FoodDrinkImageID intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_Insert_PubPhoto];
    [appDelegate.PubandBar_DB commit];

    
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
                   pubPhoto:(NSString *) _pubPhoto
{
    //NSLog(@"%d  %d  %@  %f  %@  %@  %@",pubID,_foodID,pubName,_distance,_postCode,_district,_city);
    NSString *qry4PubInfo;
    pubName = [pubName stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    
    
    if(_latitude.length == 0 || _longitude.length == 0)
    {
        qry4PubInfo = [NSString stringWithFormat:@"insert or replace into PubDetails (PubID,PubName,PubPostCode,PubDistrict,PubCity,LastUpdatedDate,venuePhoto)values(%d,'%@','%@','%@','%@','%@','%@')",pubID ,pubName,_postCode,_district,_city,[self lastUpdatedDate],_pubPhoto];
    }
    else{
        qry4PubInfo = [NSString stringWithFormat:@"insert or replace into PubDetails (PubID,PubName,PubDistance,PubPostCode,PubDistrict,PubCity,Latitude,Longitude,LastUpdatedDate,venuePhoto)values(%d,'%@',%0.2f,'%@','%@','%@','%@','%@','%@','%@')",pubID ,pubName,_distance,_postCode,_district,_city,_latitude,_longitude,[self lastUpdatedDate],_pubPhoto];
        
        
    }
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4PubInfo];
    [appDelegate.PubandBar_DB commit];

}




-(void)InsertIntoEventDetailsWithEventID:(int)_ID 
                                    Name:(NSString*)_Name
                             EventTypeID:(NSString*)_EventTypeID
                                   PubID:(int)_PubID 
                             PubDistance:(double)_PubDistance 
                            creationdate:(NSString*)_date
                                eventDay:(NSString*)_eventDay
                              expiryDate:(NSString*)_expiryDate
{
    @try {
        _Name = [_Name stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
        
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
        
        NSString *Qry_EventDetails = [NSString stringWithFormat:@"Insert or replace into Event_Detail (ID,Name,PubID,PubDistance,Event_Type,Date,ExpiryDate,EventDay) values(%d,'%@',%d,%f,'%@','%@','%@','%@')",_ID,_Name,_PubID,_PubDistance,_EventTypeID,_date,_expiryDate,_eventDay];
        
        [appDelegate.PubandBar_DB beginTransaction];

        [appDelegate.PubandBar_DB executeUpdate:Qry_EventDetails];
        [appDelegate.PubandBar_DB commit];

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
    
    NSString *Qry_Insert_PubPhoto = [NSString stringWithFormat:@"Insert or replace Into Pub_Photo (PubID,GeneralImages,FunctionRoomImages,FoodDrinkImages) values(%d , '%@' , '%@' , '%@')",[_pubId intValue],_GeneralImages,_FunctionRoomImages,_FoodDrinkImages];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_Insert_PubPhoto];
    [appDelegate.PubandBar_DB commit];

    
}

#pragma mark Ammenities Details Update
//Biswa
-(void)UpdateAmmenitiesDetailsbyPubId:(NSString*)_pubid 
                          AmmnitiesID:(NSString*)_amennitiesid 
                       FacilitiesInfo:(NSString*)_facilitiesinfo{
    
    _facilitiesinfo = [_facilitiesinfo stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    
    NSString *Qry_UpdateAmmenitiesDetails = [NSString stringWithFormat:@"Update Ammenity_Detail SET FacilitiesInformation='%@' where Ammenity_TypeID=%@ AND PubID=%@",_facilitiesinfo,_amennitiesid,_pubid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateAmmenitiesDetails];
    [appDelegate.PubandBar_DB commit];

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
    _eventdesc = [_eventdesc stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    NSString *Qry_UpdateEventDetail;
    if (!_isNoInfo) 
        Qry_UpdateEventDetail = [NSString stringWithFormat:@"Update Event_Detail set Event_Description='%@' where ID=%@ and Event_Type='%@' and pubid=%@",_eventdesc,_Event_ID ,_eventtypeid,_pubid];
    else
        Qry_UpdateEventDetail = [NSString stringWithFormat:@"Update Event_Detail set Event_Description='%@' where ID=%@ and Event_Type='%@' and pubid=%@",_eventdesc,_Event_ID ,_eventtypeid,_pubid];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateEventDetail];
    [appDelegate.PubandBar_DB commit];

    
}

#pragma mark Food & Offers
//Biswa
-(void)UpdateFoodDetailsByFoodTypeId:(NSString*)_foodtypeid 
                             byPubID:(NSString*)_pubid 
                           FoodInfor:(NSString*)_foodinfo 
                     FoodServingTime:(NSString*)_foodservingtime 
                           Chiefdesc:(NSString*)_chiefdesc 
                       SpeicalOffers:(NSString*)_speicaloffers{
    _foodinfo = [_foodinfo stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _foodservingtime = [_foodservingtime stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _chiefdesc = [_chiefdesc stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _speicaloffers = [_speicaloffers stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    
    
    NSString *Str_UpdateFooddetails = [NSString stringWithFormat:@"Update Food_Detail set Food_Information='%@' , Food_ServingTime='%@' , Food_ChefDescription='%@' , Food_SpecialOffer='%@' where FoodTypeID=%d and PubID=%d",_foodinfo,_foodservingtime,_chiefdesc,_speicaloffers,[_foodtypeid intValue],[_pubid intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:Str_UpdateFooddetails];
    [appDelegate.PubandBar_DB commit];

    
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
    _pubdescription = [_pubdescription stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _venueStyle = [_venueStyle stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _venueCapacity = [_venueCapacity stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _nearestRail = [_nearestRail stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _nearestTube = [_nearestTube stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _localBuses = [_localBuses stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _pubCompany = [_pubCompany stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _pubadd = [_pubadd stringByReplacingOccurrencesOfString:@"'" withString:@"`"];



    
    NSString *qry4PubDetails = [NSString stringWithFormat:@"Update PubDetails SET PubEmail='%@' , Mobile='%@' , PubWebsite='%@' , PubDescription='%@' , venuePhoto='%@' , VenueStyle='%@' , VenueCapacity='%@' , NearestRail='%@' , NearestTube='%@' , LocalBuses='%@' , pubcompany='%@' , pubaddress='%@' ,phoneNumber='%@' where pubid=%@",_pubEmail ,_pubMobile,_pubWebsite,_pubdescription,_pubImage,_venueStyle,_venueCapacity,_nearestRail,_nearestTube,_localBuses,_pubCompany,_pubadd,_pubPhoneNo,_pubid];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4PubDetails];
    [appDelegate.PubandBar_DB commit];

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
                           SportID:(NSString*)_sportid
{
    
    _Type = [_Type stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _sportsDescription = [_sportsDescription stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _eventName = [_eventName stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _time = [_time stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    Channel = [Channel stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
        
    
    NSString *Qry_UpdateSportEvent = [NSString stringWithFormat:@"Update Sport_Event SET ThreeD='%@' , HD='%@' , Sound='%@' , Screen='%@' , Channel='%@' , Type='%@'  , Sport_EventName='%@' , Sport_Description='%@' , Time='%@' WHERE PubID=%@ AND Sport_EventID=%@ AND Sport_ID=%@",_threeD,_HD,_Sound,_Screen,Channel,_Type,_eventName,_sportsDescription,_time,_pubid,_sporteventid,_sportid];//, Sport_Date='%@'
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateSportEvent];
    [appDelegate.PubandBar_DB commit];

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
                         Ale_ID:(NSString*)_Ale_ID
{
    
    _Beer_Name = [_Beer_Name stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Catagory = [_Catagory stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Catagory = [_Catagory stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _BeerABV = [_BeerABV stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Beer_Color = [_Beer_Color stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Beer_Smell = [_Beer_Smell stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _License_Note = [_License_Note stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Beer_Taste = [_Beer_Taste stringByReplacingOccurrencesOfString:@"'" withString:@"`"];


    
    NSString *Qry_UpdateBeerDetails = [NSString stringWithFormat:@"Update Ale_BeerDetail SET Beer_Name='%@' , Catagory='%@' , Beer_ABV='%@' , Beer_Color='%@' , Beer_Smell='%@' , Beer_Taste='%@' , License_Note='%@' WHERE Beer_ID=%d AND Ale_ID=%d AND PubID=%d ",_Beer_Name,_Catagory,_BeerABV,_Beer_Color,_Beer_Smell,_Beer_Taste,_License_Note,[_beerid intValue],[_Ale_ID intValue],[_pubid intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateBeerDetails];
    [appDelegate.PubandBar_DB commit];

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
                      Ale_District:(NSString*)_Ale_District
{
    
    _Ale_Name = [_Ale_Name stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Ale_Address = [_Ale_Address stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _Ale_District = [_Ale_District stringByReplacingOccurrencesOfString:@"'" withString:@"`"];


    
    NSString *Qry_UpdateRealAleDetails = [NSString stringWithFormat:@"Update RealAle_Detail SET Ale_Name='%@' , Ale_MailID='%@' , Ale_Website='%@' , Ale_Address='%@' , Ale_Postcode='%@' , Ale_ContactName='%@' , Ale_PhoneNumber='%@' , Ale_District='%@' WHERE PubID=%d AND Ale_ID=%d",_Ale_Name,_Ale_MailID,_Ale_Website,_Ale_Address,_Ale_Postcode,_Ale_ContactName,_Ale_PhoneNumber,_Ale_District,[_pubid intValue],[_Ale_ID intValue]];
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:Qry_UpdateRealAleDetails];
    [appDelegate.PubandBar_DB commit];

}



/******************************************* Real Ale *********************************************/



-(void)InsertValue_RealAle_Type:(int)_breweryID 
                       withName:(NSString *)_breweryName
                      withPubID:(int)_pubID 
                    pubDistance:(double) _pubDistance
{
    _breweryName = [_breweryName stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    NSString *qry4AleType = [NSString stringWithFormat:@"insert or replace into RealAle_Detail (Ale_ID,Ale_Name,PubID,PubDistance)values(%d,'%@',%d,%0.2f)",_breweryID ,_breweryName,_pubID,_pubDistance];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:qry4AleType];
    [appDelegate.PubandBar_DB commit];

}


-(void)InsertValue_Beer_Detail:(int)beerID 
                 withBreweryID:(int)_breweryID 
                 withPubID:(int)_pubID 
                  withBeerName:(NSString *)_beername 
              withBeerCategory:(NSString *)_category 
                   pubDistance:(double) _pubDistance
{
    _beername = [_beername stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    _category = [_category stringByReplacingOccurrencesOfString:@"'" withString:@"`"];

    
    
    NSString *qry4BeerDetail = [NSString stringWithFormat:@"insert or replace into Ale_BeerDetail (Beer_ID,Ale_ID,PubID,Beer_Name,Catagory,PubDistance)values(%d,%d,%d,'%@','%@',%0.2f)",beerID ,_breweryID,_pubID,_beername,_category,_pubDistance];
    
    
    //NSLog(@"Query  %@",qry4BeerDetail);
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];
    [appDelegate.PubandBar_DB executeUpdate:qry4BeerDetail];
    [appDelegate.PubandBar_DB commit];

}


//Biswa
-(NSString*)GetlastupdateddatefromPubDetails{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString *Qry_lastupdateddate = [NSString stringWithFormat:@"select substr(lastupdateddate,1,10) as date from pubdetails LIMIT 1"];
    ResultSet *rs = [app.PubandBar_DB executeQuery:Qry_lastupdateddate];
    if ([rs next]) {
        NSLog(@"Date : %@" , [rs stringForColumn:@"date"]);
        return [rs stringForColumn:@"date"];
    }
    else
        return nil;
}


-(NSString*)GetlastupdatedDateandTimefromPubDetails{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString *Qry_lastupdateddate = [NSString stringWithFormat:@"select substr(lastupdateddate,1,16) as date from pubdetails LIMIT 1"];
    ResultSet *rs = [app.PubandBar_DB executeQuery:Qry_lastupdateddate];
    if ([rs next]) {
        NSLog(@"Date : %@" , [rs stringForColumn:@"date"]);
        return [rs stringForColumn:@"date"];//@"2012-07-09 18:20";
    }
    else
        return nil;
}
 

-(void)UpdatelastUadeField_PubDetails{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
   // NSString *Qry_latupdatedate = [NSString stringWithFormat:@"Select lastupdateddate from pubdetails LIMIT 1"];
    //ResultSet *rs = [app.PubandBar_DB executeQuery:Qry_latupdatedate];
    
    NSDate* sourceDate = [NSDate date];
    	 
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
     
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
     
    NSDate* destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] autorelease];
    
    NSLog(@"TIME  %@",destinationDate);

    
    NSString *Qry_Update_lastUpdate = [NSString stringWithFormat:@"Update PubDetails SET LastUpdatedDate='%@'",[self lastUpdatedDate]];
    [app.PubandBar_DB beginTransaction];

    [app.PubandBar_DB executeUpdate:Qry_Update_lastUpdate];
    [app.PubandBar_DB commit];

}


-(void)InsertPubId_IntoPreference_Favourites:(int) pubId
{
    NSString *qry4AleType = [NSString stringWithFormat:@"insert or replace into Preference_Favourites (Favourites)values(%d)",pubId];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4AleType];
    [appDelegate.PubandBar_DB commit];

    
}


-(void)InsertPubId_IntoPreference_RecentHistory:(int) pubId
{
    NSString *qry4AleType = [NSString stringWithFormat:@"insert or replace into Preference_RecentHistory (RecentHistory)values(%d)",pubId];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.PubandBar_DB beginTransaction];

    [appDelegate.PubandBar_DB executeUpdate:qry4AleType];
    [appDelegate.PubandBar_DB commit];

}


-(void)InsertPubId_IntoPreference_RecentSearch:(int) pubId
{
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    int count = 0;
    NSString *qry4Count = [NSString stringWithFormat:@"SELECT count(*) FROM Preference_RecentSearch"];

    [appDelegate.PubandBar_DB beginTransaction];
    
    ResultSet *rs =  [appDelegate.PubandBar_DB executeQuery:qry4Count];
    
    while ([rs next]) {
        
        count = [rs intForColumn:@"count(*)"];
    }
    
    if (count < 5) {
        
        NSString *qry4AleType = [NSString stringWithFormat:@"insert or replace into Preference_RecentSearch (RecentSearch)values(%d)",pubId];
        
        
        [appDelegate.PubandBar_DB executeUpdate:qry4AleType];
    }
    
    
    [appDelegate.PubandBar_DB commit];
    
}


@end
