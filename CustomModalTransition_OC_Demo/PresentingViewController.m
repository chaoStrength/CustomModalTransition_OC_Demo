//
//  PresentingViewController.m
//  CustomModalTransitionOCDemo
//
//  Created by chao on 2017/10/31.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "ModalTransitionDelegate.h"

@interface PresentingViewController ()

@property (nonatomic, strong) UIButton *presentButton;// present按钮
@property (nonatomic, strong) ModalTransitionDelegate *transitionDelegate;// 转场代理

@end

@implementation PresentingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"红色VC即将出现");
}

/**
 * 视图加载完毕执行该方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0
                                                green:83/255.0
                                                 blue:89/255.0
                                                alpha:1.0];
    
    // 创建presentButton
    self.presentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.presentButton setTitle:@"Present" forState:UIControlStateNormal];
    self.presentButton.titleLabel.font = [UIFont systemFontOfSize:24.0];
    [self.presentButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.presentButton addTarget:self
                           action:@selector(presentButtonDidClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.presentButton];
    self.presentButton.translatesAutoresizingMaskIntoConstraints = false;
    // 让presentButton水平居中对齐
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.presentButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    // 让presentButton竖直居中对齐
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.presentButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // 创建转场代理
    self.transitionDelegate = [[ModalTransitionDelegate alloc] init];
}

/**
 * Present按钮被点击
 * @param sender Present按钮
 */
- (void)presentButtonDidClicked:(id)sender {
    // UIModalPresentationFullScreen的时候，presentingView 的移除和添加由UIKit负责，在presentation转场结束后被移除，dismissal 转场结束时重新回到原来的位置
    // UIModalPresentationCustom的时候，presentingView依然由UIKit负责，但presentation转场结束后不会被移除
    
    // 创建presentedVC
    PresentedViewController *presentedVC = [[PresentedViewController alloc] init];
    // 设置presentedVC的转场代理为我们自己实现的转场代理，该代理遵守UIViewControllerTransitioningDelegate协议
    // 注意，这里的self.transitionDelegate对象由当前VC持有它的强引用，如果直接在这里创建一个代理对象赋值给presentedVC.transitioningDelegate的话，
    // 由于presentedVC.transitioningDelegate是weak的，所以会立马释放
    presentedVC.transitioningDelegate = self.transitionDelegate;
    // 设置模态转场的风格为UIModalPresentationCustom
    presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:presentedVC
                       animated:true
                     completion:nil];
}

@end
