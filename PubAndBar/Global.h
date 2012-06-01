//
//  Global.h
//  PubAndBar
//
//  Created by Mac on 19/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Global <NSObject>


#pragma mark -
#pragma mark UserDefaults

#define SAVE_AS_DEFAULT(_key,_value) [[NSUserDefaults standardUserDefaults]setObject:_value forKey:_key]

#define GET_DEFAUL_VALUE(_key) [[NSUserDefaults standardUserDefaults]objectForKey:_key]

#define REMOVE_DEFAULT_KEY(_key)  [[NSUserDefaults standardUserDefaults] removeObjectForKey:_key]
#pragma mark -

#pragma mark Preference name

// settings section
#define CurrentLocation       @"CurrentLocationValue"
#define ShowsResultIN         @"ShowsResultIN"
#define ShowNumberOfPubs      @"ShowNumberOfPubs"
#define SaveCacheToSeeHistory @"SaveCacheToSeeHistory"
#define PubsShowsIn           @"PubsShowsIn"
#pragma mark -


@end
