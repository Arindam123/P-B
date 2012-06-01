//
//  SaveRealAleDetailsInfo.h
//  PubAndBar
//
//  Created by Apple on 22/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveRealAleDetailsInfo : NSObject

+(NSMutableArray *)GetRealAleTypeInfo:(int)ID;
+(NSMutableArray *)GetAleBeerDetailsInfo:(int)ID;

@end
