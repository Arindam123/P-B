//
//  SFCustomNavigationBar.m
//  CustomNavigationBar
//
//  Created by Krzysztof Zabłocki on 2/21/12.
//  Copyright (c) 2012 Krzysztof Zabłocki. All rights reserved.
//

#import "SFCustomNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation SFCustomNavigationBar
+ (UINavigationController*)navigationControllerWithRootViewController:(UIViewController*)aRootViewController
{
    //! load nib named the same as our custom class
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    //! get navigation controller from our xib and pass it the root view controller
    UINavigationController *navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    [navigationController setViewControllers:[NSArray arrayWithObject:aRootViewController] animated:NO];
    return navigationController;
}

- (void)drawRect:(CGRect)rect
{
    static UIImage *backgroundImage = nil;
    if (!backgroundImage) {
        backgroundImage = [UIImage imageNamed:@"TopBar_iPhone.png"];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    [backgroundImage drawInRect:rect];
}
@end
