//
//  DBFunctionality.h
//  CCC
//
//  Created by Prosenjit on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Contact.h"
//#import "DashBoard_Objects.h"
@interface DBFunctionality : NSObject

+ (DBFunctionality *)sharedInstance;


//***************** Non-Subscribing Pubs *******************

-(void)InsertValue_NonSubPub_Info:(int)pubID
                   withName:(NSString *)pubName 
                   distance:(double)_distance
                   latitude:(NSString *)_latitude
                  longitude:(NSString *)_longitude
                   postCode:(NSString *)_postCode 
                   district:(NSString *)_district 
                       city:(NSString *)_city
            lastUpdatedDate:(NSString *) _lastUpdatedDate
                    phoneNo:(NSString *) _phoneNo;



//***************** PubDetails *******************


-(void)InsertValue_Pub_Info:(int)pubID
                   withName:(NSString *)pubName 
                   distance:(double)_distance
                   latitude:(NSString *)_latitude
                  longitude:(NSString *)_longitude
                   postCode:(NSString *)_postCode 
                   district:(NSString *)_district 
                       city:(NSString *)_city
            lastUpdatedDate:(NSString *) _lastUpdatedDate
                   pubPhoto:(NSString *) _pubPhoto;

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
                    PubPhoneNo:(NSString*)_pubPhoneNo;


//***************** Food *******************


-(void)InsertValue_Food_Detail:(int)pubID withFoodID:(int)_foodID pubDistance:(double) _pubDistance;
-(void)InsertValue_Food_Detail:(NSString *)_foodInfo 
             withFoodServeTime:(NSString *)_foodServeTime
               chefDescription:(NSString *) _chefDescription
                  specialOffer:(NSString *) _specialOffer
                     withPubID:(int)_pubID
                withFoodTypeID:(int)_withFoodTypeID;


-(void)InsertValue_Food_Type:(int)foodID withName:(NSString *)typeName;


//***************** Real Ale *******************


-(void)InsertValue_RealAle_Type:(int)_breweryID 
                       withName:(NSString *)_breweryName
                      withPubID:(int)_pubID 
                    pubDistance:(double) _pubDistance;

-(void)InsertValue_Beer_Detail:(int)beerID 
                 withBreweryID:(int)_breweryID 
                     withPubID:(int)_pubID 
                  withBeerName:(NSString *)_beername 
              withBeerCategory:(NSString *)_category 
                   pubDistance:(double) _pubDistance;

//***************** Amenities *******************

//-----------------------mb-25/05/12/05-45-------------------------//
-(void)InsertValue_Amenities_Type:(int)eventID withName:(NSString *)typeName;
-(void)InsertValue_Amenities_Detail:(int)Ammenity_ID  ammenity_TypeID:(int)ammenity_TypeID facility_Name:(NSString *)Facility_Name PubID:(int )pubID withPubDistance:(double)Pub_Distanc;
-(void)UpdateAmmenitiesDetailsbyPubId:(NSString*)_pubid 
                          AmmnitiesID:(NSString*)_amennitiesid 
                       FacilitiesInfo:(NSString*)_facilitiesinfo;


// ****************   Sports ********************
-(void)InsertValue_Sports_Type:(int)_sportID withName:(NSString *)_sportName;

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
                           PubID:(int )_pubID 
                 withPubDistance:(double)_Pub_Distance
                      event_Time:(NSString *)_event_Time
                      event_Type:(NSString *)_event_Type;


//********************* Events *******************

-(void)InsertIntoEventDetailsWithEventID:(int)_ID 
                                    Name:(NSString*)_Name 
                             EventTypeID:(NSString*)_EventTypeID 
                                   PubID:(int)_PubID 
                             PubDistance:(double)_PubDistance 
                            creationdate:(NSString*)_date 
                                eventDay:(NSString*)_eventDay
                              expiryDate:(NSString*)_expiryDate;

-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                        GeneralImages:(NSString*)_GeneralImages 
                   FunctionRoomImages:(NSString*)_FunctionRoomImages 
                      FoodDrinkImages:(NSString*)_FoodDrinkImages;//Biswa


-(void)UpdateEvent_DetailByID:(NSString*)_Event_ID 
                  eventtypeid:(NSString*)_eventtypeid
                         date:(NSString*)_date 
                    eventdesc:(NSString*)_eventdesc 
                        PUBID:(NSString*)_pubid 
                     isNoInfo:(BOOL)_isNoInfo;

//Biswa
-(void)UpdateFoodDetailsByFoodTypeId:(NSString*)_foodtypeid 
                             byPubID:(NSString*)_pubid 
                           FoodInfor:(NSString*)_foodinfo 
                     FoodServingTime:(NSString*)_foodservingtime 
                           Chiefdesc:(NSString*)_chiefdesc 
                       SpeicalOffers:(NSString*)_speicaloffers;

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
                           SportID:(NSString*)_sportid;


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
                         Ale_ID:(NSString*)_Ale_ID;

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
                      Ale_District:(NSString*)_Ale_District;


//Biswa
-(NSString*)GetlastupdateddatefromPubDetails;
-(NSString*)GetlastupdatedDateandTimefromPubDetails;
-(void)UpdatelastUadeField_PubDetails;


-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                        GeneralImages:(NSString*)_GeneralImages 
                       GeneralImageID:(NSString*)_GeneralImageID;

-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                   FunctionRoomImages:(NSString*)_FunctionRoomImages
                  FunctionRoomImageID:(NSString*)_FunctionRoomImageID;

-(void)InsertValue_Pub_PhotoWithPubID:(NSString*)_pubId 
                      FoodDrinkImages:(NSString*)_FoodDrinkImages
                     FoodDrinkImageID:(NSString*)_FoodDrinkImageID;


-(void)InsertPubId_IntoPreference_Favourites:(int) pubId;
-(void)InsertPubId_IntoPreference_RecentHistory:(int) pubId;
-(void)InsertPubId_IntoPreference_RecentSearch:(int) pubId;

@end
