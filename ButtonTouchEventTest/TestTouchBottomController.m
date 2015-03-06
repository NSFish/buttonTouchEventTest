//
//  TestTouchViewController.m
//  ButtonTouchEventTest
//
//  Created by redhat' iMac on 15/1/15.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

#import "TestTouchBottomController.h"
#import "CommentInputView.h"
@implementation TestTouchBottomController

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //This line matters
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    
    [self.testTouchButton setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
//    CommentInputView *commentInputView =[[CommentInputView alloc] initWithSuperView:self.view distanceToBottom:100];
//    [self.view addSubview:commentInputView];
}

- (IBAction)buttonTouchDown:(id)sender {
    NSLog(@"buttonTouchDown");
}
@end
