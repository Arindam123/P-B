//
//  UtilityClass.m
//  PubAndBar
//
//  Created by MacMini10 on 10/08/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "UtilityClass.h"

@implementation UtilityClass


+ (void)runBlock:(void (^)())block
{
    block();
}
+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block 
{
    void (^block_)() = [[block copy] autorelease];
    [self performSelector:@selector(runBlock:) withObject:block_ afterDelay:delay];
}

@end
