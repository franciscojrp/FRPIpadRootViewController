//
//  FRPIpadNavigationManager.h
//
//  Created by Francisco José Rodríguez Pérez on 06/06/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRPIpadRootViewController.h"

@interface FRPIpadNavigationManager : NSObject <FRPIpadRootViewControllerNavigationManager>

@property (nonatomic, weak) FRPIpadRootViewController *rootViewController;

- (id)initWithRootViewController:(FRPIpadRootViewController *)rootViewController;

@end
