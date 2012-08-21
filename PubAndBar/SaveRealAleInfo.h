//
//  SaveRealAleInfo.h
//  PubAndBar
//
//  Created by User7 on 15/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SaveRealAleInfo : NSObject{

}

+(NSMutableArray *)GetAleInfo;


+(NSMutableArray *)GetSearchAleInfo:(NSString *)_name;
+(NSMutableArray *)GetSearchBeerInfo:(NSString *)_name;
+(NSMutableArray *)GetSearchAleInfoFromBeer:(NSString *)_name;

@end
