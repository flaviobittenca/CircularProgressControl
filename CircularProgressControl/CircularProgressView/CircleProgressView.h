//
//  CircleProgressView.h
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIControl

@property (nonatomic) NSTimeInterval elapsedTime;
@property (nonatomic) NSTimeInterval timeLimit;
@property (nonatomic, retain) NSString *status;
@property (assign, nonatomic, readonly) double percent;
//@property (nonatomic)
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *alphaPauseView;
@end
