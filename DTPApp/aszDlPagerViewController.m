//
//  aszDlViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlPagerViewController.h"
#import "aszDlViewController.h"


@interface aszDlPagerViewController ()

@end

@implementation aszDlPagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    UIViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
   
    NSArray *viewControllers = @[startingViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

}


- (aszDlViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    //TODO use cashe
    
    aszDlViewController *ret= [storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
    
    //TODO init ret
    
    return ret;
    
}

- (NSUInteger)indexOfViewController:(aszDlViewController *)viewController
{
    return 0;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
        int index = 0;
    
  
        return [self viewControllerAtIndex:(index-1) storyboard:self.storyboard];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    int index = 0;
    
    
    return [self viewControllerAtIndex:(index+1) storyboard:self.storyboard];
}


#pragma mark - UIPageViewController delegate methods

-(UIPageViewControllerSpineLocation) pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
    //    UIViewController *currentViewController = self.viewControllers[0];
    //    NSArray *viewControllers = @[currentViewController];
    //    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.doubleSided = NO;
    
    return UIPageViewControllerSpineLocationMin;
    
}


@end
