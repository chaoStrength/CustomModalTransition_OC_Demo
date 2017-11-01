//
//  ModalTransitionDelegate.m
//  CustomModalTransitionOCDemo
//
//  Created by chao on 2017/10/31.
//

#import "ModalTransitionDelegate.h"
#import "OverlayAnimationController.h"
#import "OverlayPresentationController.h"

@implementation ModalTransitionDelegate

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OverlayAnimationController alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[OverlayAnimationController alloc] init];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[OverlayPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
