//
//  OverlayAnimationController.m
//  CustomModalTransitionOCDemo
//
//  Created by chao on 2017/10/31.
//

#import "OverlayAnimationController.h"

@implementation OverlayAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 从转场环境transitionContext中获取容器视图
    UIView *containerView = transitionContext.containerView;
    
    // 获取fromVC和toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (!fromVC || !toVC) {
        return;
    }

    // 获取fromView和toView
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    // 获取转场时间
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 不像容器VC转场里需要额外的变量来标记操作类型，UIViewController自身就有方法跟踪Modal状态。
    // 处理Presentation转场：
    if (toVC.isBeingPresented) {
        // 1、将toView添加到容器视图上
        [containerView addSubview:toView];
        
        // 设置toView的初始位置
        CGFloat toViewWidth = containerView.frame.size.width * 2 / 3;
        CGFloat toViewHeight = containerView.frame.size.height * 2 / 3;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0.0, 0.0, 1.0, toViewHeight);
        
        if (@available(iOS 8.0, *)) {
            // 动画toView
            [UIView animateWithDuration:duration animations:^{
                toView.bounds = CGRectMake(0.0, 0.0, toViewWidth, toViewHeight);
            } completion:^(BOOL finished) {
                // 2、动画完成需要通知转场环境
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        } else {
            //在 presentedView后面添加暗背景视图dimmingView，注意两者在containerView中的位置
            UIView *dimmingView = [[UIView alloc] init];
            [containerView insertSubview:dimmingView belowSubview:toView];
            // 设置dimmingView的初始颜色和位置
            dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            dimmingView.center = containerView.center;
            dimmingView.bounds = CGRectMake(0.0, 0.0, toViewWidth, toViewHeight);
            
            // 动画toView和dimmingView的bounds
            [UIView animateWithDuration:duration animations:^{
                dimmingView.bounds = containerView.bounds;
                toView.bounds = CGRectMake(0.0, 0.0, toViewWidth, toViewHeight);
            } completion:^(BOOL finished) {
                // 2、动画完成需要通知转场环境
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
    }
    
    // 处理Dismissal转场，按照上一小节的结论，Custom模式下不要将toView添加到containerView，省去了上面标记1处的操作。
    if (fromVC.isBeingDismissed) {
        CGFloat fromViewHeight = fromView.frame.size.height;
        [UIView animateWithDuration:duration animations:^{
            fromView.bounds = CGRectMake(0.0, 0.0, 1.0, fromViewHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
