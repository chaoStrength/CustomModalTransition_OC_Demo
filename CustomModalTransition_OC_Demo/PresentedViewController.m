//
//  PresentedViewController.m
//  CustomModalTransitionOCDemo
//
//  Created by chao on 2017/10/31.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@property (nonatomic, strong) UIButton *dismissButton;// 关闭按钮
@property (nonatomic, strong) UITextField *inputTextField;// 输入框
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;// 输入框的宽度约束

@end

@implementation PresentedViewController

/**
 * 视图加载完毕执行该方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0 / 255.0
                                                green:122 / 255.0
                                                 blue:255 / 255.0
                                                alpha:1.0];
    
    // 创建dismissButton
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.dismissButton setTitle:@"×" forState:UIControlStateNormal];
    self.dismissButton.titleLabel.font = [UIFont systemFontOfSize:24.0];
    [self.dismissButton setTitleColor:[UIColor colorWithRed:255 / 255.0
                                                      green:83 / 255.0
                                                       blue:89 / 255.0
                                                      alpha:1.0]
                             forState:UIControlStateNormal];
    self.dismissButton.alpha = 0.0;
    [self.dismissButton addTarget:self
                           action:@selector(dismissButtonDidClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissButton];
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dismissButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dismissButton
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // 创建输入视图
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.backgroundColor = UIColor.whiteColor;
    self.inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTextField.placeholder = @"PresentedView";
    self.inputTextField.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:self.inputTextField];
    self.inputTextField.translatesAutoresizingMaskIntoConstraints = false;
    // 水平居中对齐
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputTextField
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    // 竖直居中对齐
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputTextField
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    // 宽度约束
    self.widthConstraint = [NSLayoutConstraint constraintWithItem:self.inputTextField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:0.0];
    [self.view addConstraint:self.widthConstraint];
}

/**
 * 视图已经出现时执行该方法
 * @param animated 是否动画
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 视图已经出现后，动画使输入框为当前视图宽度的2/3，并让关闭按钮的alpha值从0.0到1.0
    self.widthConstraint.constant = self.view.frame.size.width * 2 / 3;
    [UIView animateWithDuration:0.3 animations:^{
        self.dismissButton.alpha = 1.0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Action
/**
 * 关闭按钮被点击执行该方法
 * @param sender 关闭按钮
 */
- (void)dismissButtonDidClicked:(id)sender {
    // 让输入框的宽度约束为0
    self.widthConstraint.constant = 0.0;
    
    // 创建旋转3π并缩小到0.1倍的变换
    CGAffineTransform applyTransform = CGAffineTransformMakeRotation(3.0 * M_PI);
    applyTransform = CGAffineTransformScale(applyTransform, 0.1, 0.1);
    
    // 执行动画，让关闭按钮旋转3π并缩小到0.1倍
    [UIView animateWithDuration:0.4 animations:^{
        self.dismissButton.transform = applyTransform;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 动画结束后，dismiss当前VC
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

@end
