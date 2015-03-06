//
//  STCommentInputView.m
//  CoolOffice
//
//  Created by lxzhh on 14-4-24.
//  Copyright (c) 2014年 lxzhh. All rights reserved.
//

#import "CommentInputView.h"
#import "ViewUtils.h"
#define CommentGrayColor [UIColor colorWithRed:0.616 green:0.620 blue:0.633 alpha:1.000]
#define CreamColor [UIColor colorWithRed:0.926 green:0.905 blue:0.807 alpha:1.000]
#define CommentInputViewHeigh 48.0f
@interface CommentInputView ()
@property(nonatomic, strong)UIView *voiceInputView;
@property(nonatomic, strong)UIView *textInputView;
@property(nonatomic, strong)UIImageView *audioImage;
@property(nonatomic, assign)BOOL longPressTouchIsOutside;
@property(nonatomic, strong)UIButton *longPressTORecordButton;//长按录音的按钮
@property(nonatomic, strong)NSMutableString *formatCommentString;
@property(nonatomic, strong)NSMutableDictionary *atContactDictionary;

@end

@implementation CommentInputView



-(id)initWithSuperView:(UIView *)superView distanceToBottom:(CGFloat)distance{
    if (self = [super initWithFrame:CGRectMake(0, 0, superView.width, CommentInputViewHeigh)]) {
        [self configureVoiceView];
        self.bottom = superView.height - distance;
        self.backgroundColor = [UIColor colorWithWhite:0.970 alpha:1.000];

    }
    return self;
}

- (void)buttonTouchDown{
    NSLog(@"button touch down");
}

- (void)buttonTouchUpInside{
    NSLog(@"button touch up inside");
}


- (void)configureVoiceView{
    self.voiceInputView = [[UIView alloc] initWithFrame:self.bounds];
//    self.voiceInputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    if (!self.longPressTORecordButton) {
        UIButton *longPressButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200.0, 44.f)];
        longPressButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [longPressButton setTitle:@"touchToShow" forState:UIControlStateNormal];
        [longPressButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [longPressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [longPressButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
        [longPressButton addTarget:self action:@selector(buttonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        CGFloat scale = [UIScreen mainScreen].scale;

        longPressButton.backgroundColor = [UIColor whiteColor];
        longPressButton.layer.borderColor = [UIColor blueColor].CGColor;
        longPressButton.layer.cornerRadius = 4.0f;
        longPressButton.layer.borderWidth = 1.0f/scale;
        longPressButton.layer.masksToBounds = YES;
        longPressButton.contentMode = UIViewContentModeCenter;
        
        //        longPressButton.tintColor = LongPressButtonTintColor;
        self.longPressTORecordButton = longPressButton;
    }
    
    [self.voiceInputView addSubview:self.longPressTORecordButton];
    [self addSubview:self.voiceInputView];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



#pragma CustomDraw

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, CommentGrayColor.CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}



@end
