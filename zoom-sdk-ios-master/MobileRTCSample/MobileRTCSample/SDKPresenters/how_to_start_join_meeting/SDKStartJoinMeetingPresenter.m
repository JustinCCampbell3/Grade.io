//
//  SDKStartJoinMeetingPresenter.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/15.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//E

#import "SDKStartJoinMeetingPresenter.h"
#import "SDKStartJoinMeetingPresenter+LoginUser.h"
#import "SDKStartJoinMeetingPresenter+RestApiWithoutLoginUser.h"
#import "SDKStartJoinMeetingPresenter+JoinMeetingOnly.h"
#import "SDKStartJoinMeetingPresenter+MeetingServiceDelegate.h"
#import "MeetingSettingsViewController.h"

@interface SDKStartJoinMeetingPresenter()

@end

@implementation SDKStartJoinMeetingPresenter

- (void)startMeeting:(BOOL)appShare rootVC:(UIViewController *)rootVC;
{
    self.rootVC = rootVC;
    
    [self initDelegate];
    
    [self checkMeetingSettingSendRawdataEnable];
    
    if ([[[MobileRTC sharedRTC] getAuthService] isLoggedIn])
    {
        [self startMeeting_emailLoginUser:appShare];
    }
    else
    {
        [self startMeeting_RestApiWithoutLoginUser:appShare];
    }
}


- (void)joinMeeting:(NSString*)meetingNo withPassword:(NSString*)pwd rootVC:(UIViewController *)rootVC
{
    self.rootVC = rootVC;
    
    [self initDelegate];
    
    [self checkMeetingSettingSendRawdataEnable];
    
    [self joinMeeting:meetingNo withPassword:pwd];
}

- (void)initDelegate
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        ms.delegate = self;
    }
    
    //optional for custom-ui meeting
    if ([[[MobileRTC sharedRTC] getMeetingSettings] enableCustomMeeting]) {
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        if (ms)
        {
            ms.customizedUImeetingDelegate = self;
        }
    }
}

- (void)checkMeetingSettingSendRawdataEnable {
    BOOL enableRawdataSend = [[NSUserDefaults standardUserDefaults] boolForKey:Raw_Data_Send_Enable];
    if (enableRawdataSend) {
        MeetingSettingsViewController *meetingSetting = [[MeetingSettingsViewController alloc] init];
        [meetingSetting enableSendRawdata:YES];
        [meetingSetting release];
    }
}

- (void)dealloc
{
    self.rootVC = nil;
    self.customMeetingVC = nil;
    
    [[MobileRTC sharedRTC] getMeetingService].customizedUImeetingDelegate = nil;
    [super dealloc];
}

@end
