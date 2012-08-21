//
//  UtilityClass.h
//  PubAndBar
//
//  Created by MacMini10 on 10/08/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityClass : NSObject
{
    
}

+ (void)runBlock:(void (^)())block;
+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block;

@end
