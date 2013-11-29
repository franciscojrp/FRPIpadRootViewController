//
//  FRPIpadRootViewController.h
//
//  Created by Francisco José Rodríguez Pérez on 06/06/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FRPIpadRootViewControllerNavigationManager <NSObject>

- (void)showDefaultState;

@end

@interface FRPIpadRootViewController : UIViewController

@property (strong, nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UIViewController *leftViewController;
@property (strong, nonatomic) UIViewController *rightViewController;
@property (strong, nonatomic) UIViewController *completeViewController;

@property (strong, nonatomic) id<FRPIpadRootViewControllerNavigationManager> navigationManager;

@end
