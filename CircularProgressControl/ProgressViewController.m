//
//  ProgressViewController.m
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import "ProgressViewController.h"
#import "CircleProgressView.h"
#import "Session.h"

@interface ProgressViewController ()

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) Session *session;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //View Background
    self.view.backgroundColor = [UIColor colorWithRed:51/255.0 green:73/255.0 blue:93/255.0 alpha:1.0];
    
    self.session = [[Session alloc] init];
    self.session.state = kSessionStateStop;
    
    self.circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [self.view addSubview:self.circleProgressView];
    
    self.circleProgressView.status = NSLocalizedString(@"circle-progress-view.status-not-started", nil);
    self.circleProgressView.timeLimit = 60*8;
    self.circleProgressView.elapsedTime = 0;
    
    [self.actionButton setTintColor:[UIColor whiteColor]];
    
    [self startTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}


#pragma mark - Timer

- (void)startTimer {
    if ((!self.timer) || (![self.timer isValid])) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                      target:self
                                                    selector:@selector(poolTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)poolTimer
{
    if ((self.session) && (self.session.state == kSessionStateStart))
    {
        self.circleProgressView.elapsedTime = self.session.progressTime;
    }
}


#pragma mark - User Interaction

- (IBAction)actionButtonClick:(id)sender {
    
    if (self.session.state == kSessionStateStop) {
        
        self.session.startDate = [NSDate date];
        self.session.finishDate = nil;
        self.session.state = kSessionStateStart;
        
        UIColor *tintColor = [UIColor colorWithRed:231.7/255.0 green:119.5/255.0 blue:0.0/255.0 alpha:1.0];
        self.circleProgressView.status = NSLocalizedString(@"circle-progress-view.status-in-progress", nil);
        self.circleProgressView.tintColor = tintColor;
        self.circleProgressView.elapsedTime = self.session.progressTime;
        
        [self.actionButton setTitle:NSLocalizedString(@"progress-view-controller.action-button.title-stop", nil) forState:UIControlStateNormal];
        [self.actionButton setTintColor:tintColor];
    }
    else {
        self.session.finishDate = [NSDate date];
        self.session.state = kSessionStateStop;
        
        self.circleProgressView.status = NSLocalizedString(@"circle-progress-view.status-not-started", nil);
        self.circleProgressView.tintColor = [UIColor whiteColor];
        self.circleProgressView.elapsedTime = self.session.progressTime;
        
        [self.actionButton setTitle:NSLocalizedString(@"progress-view-controller.action-button.title-start", nil) forState:UIControlStateNormal];
        [self.actionButton setTintColor:[UIColor whiteColor]];
    }
}


@end
