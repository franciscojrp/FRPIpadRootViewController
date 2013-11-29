//
//  FRPIpadNavigationManager.m
//
//  Created by Francisco José Rodríguez Pérez on 06/06/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "FRPIpadNavigationManager.h"

@interface FRPIpadNavigationManager ()

@end

@implementation FRPIpadNavigationManager

- (id)initWithRootViewController:(FRPIpadRootViewController *)rootViewController
{
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)showDefaultState
{
    // UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"defaultViewController"];
    // self.rootViewController.leftViewController = vc;
}

#pragma mark - ViewControllerDelegate delegate

@end
