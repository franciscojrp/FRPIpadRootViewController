FRPIpadRootViewController
=========================

Root view controller designed to allow an easy reutilization of the existing iPhone screens in an iPad version of the app

## Description

The idea behind this root view controller is to ease the reutilization of the existing iPhone code in an iPad version.
In a typical iPhone app with a master-detail view you use a UINavigationController to push the detail view in screen; instead of doing that, this root view controller is designed to allow you to show that master view on the left part of the screen and the detail on the right.

The `FRPIpadRootViewController` class is the root view controller of the app and the class `FRPIpadNavigationManager` is designed to be the delegate of the existing screens and the point where the logic that decides what to do when the user makes an action would be.

So, now instead of, for example, performing a segue in the iPhone, you just call the delegate (the `FRPIpadNavigationManager` instance) for it to perfom the needed action:

	if ([self.delegate respondsToSelector:@selector(conversationsViewController:didSelectConversation:)]) {
        [self.delegate conversationsViewController:self didSelectConversation:nil];
    } else {
        [self performSegueWithIdentifier:@"showConversation" sender:nil];
    }

## Usage

 * Add the files to your existing project
 * Implement in `FRPIpadNavigationManager` the protocols you define for each of your existing view controllers
		
		- (void)masterViewController:(FRPMasterViewController *)masterVC didSelectElement:(id)element
		{
			FRPDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
			vc.element = element;
			self.rootViewController.rightViewController = vc;
		}

	and set the `FRPIpadNavigationManager` instance as delegate of the view controllers if running on an iPad
 * And finally install an instance of `FRPIpadRootViewController` as the iPad rootViewController:

		UIViewController *rootVC = [[FRPIpadRootViewController alloc] init];
		self.window.rootViewController = rootVC;
	
