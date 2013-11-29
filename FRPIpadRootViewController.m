//
//  FRPIpadRootViewController.m
//
//  Created by Francisco José Rodríguez Pérez on 06/06/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "FRPIpadRootViewController.h"
#import "FRPIpadNavigationManager.h"

#define kLeftPanelWidthPortrait 400
#define kLeftPanelWidthLandscape 500

@interface FRPIpadRootViewController ()

@property (nonatomic, weak) UIImageView *panelsSeparator;

- (BOOL)isDeviceInLandscapeMode;
- (void)adjustSubviewsSizeForInterfaceOrientation;

@end

@implementation FRPIpadRootViewController

- (id)init
{
    self = [super init];
    if (self) {
        _navigationManager = [[FRPIpadNavigationManager alloc] initWithRootViewController:self];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _navigationManager = [[FRPIpadNavigationManager alloc] initWithRootViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationManager showDefaultState];
        
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [self adjustSubviewsSizeForInterfaceOrientation];
}

- (void)setTopViewController:(UIViewController *)topViewController
{
    if ([_topViewController isEqual:topViewController]) {
        return;
    }
    
    [_topViewController willMoveToParentViewController:nil];
    [_topViewController.view removeFromSuperview];
    [_topViewController removeFromParentViewController];
    
    if (topViewController) {
        _topViewController = topViewController;
        [self addChildViewController:_topViewController];
        [self.view addSubview:_topViewController.view];
        [_topViewController didMoveToParentViewController:self];
        [self adjustSubviewsSizeForInterfaceOrientation];
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{   
    [_leftViewController willMoveToParentViewController:nil];
    [_leftViewController.view removeFromSuperview];
    [_leftViewController removeFromParentViewController];
    
    if (leftViewController) {
        _leftViewController = leftViewController;
        [self addChildViewController:_leftViewController];
        [self.view addSubview:_leftViewController.view];
        [_leftViewController didMoveToParentViewController:self];
        [self adjustSubviewsSizeForInterfaceOrientation];
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    [_rightViewController willMoveToParentViewController:nil];
    [_rightViewController.view removeFromSuperview];
    [_rightViewController removeFromParentViewController];
	
    if (rightViewController) {
        _rightViewController = rightViewController;
        [self addChildViewController:_rightViewController];
        [self.view insertSubview:_rightViewController.view atIndex:0];
        [_rightViewController didMoveToParentViewController:self];
        [self adjustSubviewsSizeForInterfaceOrientation];
    }
}

- (void)setCompleteViewController:(UIViewController *)completeViewController
{
    if (completeViewController) {
        if ([_completeViewController isEqual:completeViewController]) {
            return;
        }
        UIViewController *oldCompleteViewController = _completeViewController;
        _completeViewController = completeViewController;
        [self.view addSubview:_completeViewController.view];
        [self addChildViewController:_completeViewController];
        [_completeViewController didMoveToParentViewController:self];
        _completeViewController.view.alpha = .0;
        [self adjustSubviewsSizeForInterfaceOrientation];

        [UIView animateWithDuration:0.5f animations:^{
            oldCompleteViewController.view.alpha = 0.0;
            _completeViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [oldCompleteViewController willMoveToParentViewController:nil];
            [oldCompleteViewController.view removeFromSuperview];
            [oldCompleteViewController removeFromParentViewController];        
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            _completeViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [_completeViewController willMoveToParentViewController:nil];
            [_completeViewController.view removeFromSuperview];
            [_completeViewController removeFromParentViewController];
            _completeViewController = nil;
        }];
    }
}

#pragma mark - Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - Private methods

- (BOOL)isDeviceInLandscapeMode
{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

- (void)adjustSubviewsSizeForInterfaceOrientation
{
    if ([self isDeviceInLandscapeMode]) {
        CGRect frame = CGRectZero;
        
        frame.origin.x = 0;
        frame.size.width = kLeftPanelWidthLandscape;
        frame.origin.y = 0;
        frame.size.height = self.view.bounds.size.height;
        if (!CGRectEqualToRect(self.leftViewController.view.frame, frame)) {
            self.leftViewController.view.frame = frame;
        }
        
        frame.origin.x = self.leftViewController.view.frame.origin.x + self.leftViewController.view.frame.size.width;
        frame.origin.y = 0;
        frame.size.height = self.view.bounds.size.height;
        frame.size.width = self.panelsSeparator.image.size.width;
        if (!CGRectEqualToRect(self.panelsSeparator.frame, frame)) {
            self.panelsSeparator.frame = frame;
        }
        
        frame.size.width = self.view.bounds.size.width - self.leftViewController.view.frame.size.width;
        if (!CGRectEqualToRect(self.rightViewController.view.frame, frame)) {
            self.rightViewController.view.frame = frame;
        }
        
        if (self.topViewController) {
            frame = CGRectZero;
            frame.origin.x = 50;
            frame.origin.y = 0;
            frame.size.width = self.leftViewController.view.frame.size.width - 60;
            frame.size.height = 44;
            if (!CGRectEqualToRect(self.topViewController.view.frame, frame)) {
                self.topViewController.view.frame = frame;
            }
            [self.topViewController.view setClipsToBounds:YES];
            
        }
                
        if (self.completeViewController) {
            frame = CGRectZero;
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.width = self.view.bounds.size.width;
            frame.size.height = self.view.bounds.size.height;
            if (!CGRectEqualToRect(self.completeViewController.view.frame, frame)) {
                self.completeViewController.view.frame = frame;
            }
        }
    } else {
        CGRect frame = CGRectZero;
        
        frame.size.width = kLeftPanelWidthPortrait;
        frame.origin.y = 0;
        frame.size.height = self.view.bounds.size.height;
        if (!CGRectEqualToRect(self.leftViewController.view.frame, frame)) {
            self.leftViewController.view.frame = frame;
        }
        
        frame = CGRectZero;
        frame.origin.x = self.leftViewController.view.frame.origin.x + self.leftViewController.view.frame.size.width;
        frame.origin.y = 0;
        frame.size.height = self.view.bounds.size.height;
        frame.size.width = self.panelsSeparator.image.size.width;
        if (!CGRectEqualToRect(self.panelsSeparator.frame, frame)) {
            self.panelsSeparator.frame = frame;
        }
        
        frame.size.width = self.view.bounds.size.width - self.leftViewController.view.frame.size.width;
        if (!CGRectEqualToRect(self.rightViewController.view.frame, frame)) {
            self.rightViewController.view.frame = frame;
        }
        
        if (self.topViewController) {
            frame = CGRectZero;
            frame.origin.x = 50;
            frame.origin.y = 0;
            frame.size.width = self.leftViewController.view.frame.size.width - 60;
            frame.size.height = 44;
            if (!CGRectEqualToRect(self.topViewController.view.frame, frame)) {
                self.topViewController.view.frame = frame;
            }
            [self.topViewController.view setClipsToBounds:YES];
        }
        
        if (self.completeViewController) {
            frame = CGRectZero;
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.width = self.view.bounds.size.width;
            frame.size.height = self.view.bounds.size.height;
            if (!CGRectEqualToRect(self.completeViewController.view.frame, frame)) {
                self.completeViewController.view.frame = frame;
            }
        }
    }
}

@end
