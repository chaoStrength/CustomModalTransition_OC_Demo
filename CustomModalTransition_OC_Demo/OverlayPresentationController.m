//
//  OverlayPresentationController.m
//  CustomModalTransitionOCDemo
//
//  Created by chao on 2017/10/31.
//

#import "OverlayPresentationController.h"

@interface OverlayPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation OverlayPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        _dimmingView = [[UIView alloc] init];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    [self.containerView addSubview:self.dimmingView];
    CGFloat dimmingViewInitailWidth = self.containerView.frame.size.width * 2 / 3;
    CGFloat dimmingViewInitailHeight = self.containerView.frame.size.height * 2 / 3;
    
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = CGRectMake(0.0, 0.0, dimmingViewInitailWidth, dimmingViewInitailHeight);
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.bounds = self.containerView.bounds;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
    
    CGFloat width = self.containerView.frame.size.width * 2 / 3;
    CGFloat height = self.containerView.frame.size.height * 2 / 3;
    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = CGRectMake(0.0, 0.0, width, height);
}

@end
