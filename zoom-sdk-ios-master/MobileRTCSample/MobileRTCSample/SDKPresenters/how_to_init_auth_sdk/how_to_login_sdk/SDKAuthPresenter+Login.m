//
//  SDKAuthPresenter+Login.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/12/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter+Login.h"

@implementation SDKAuthPresenter (Login)

- (void)loginWithEmail:(NSString *)email password:(NSString *)password rememberMe:(BOOL)rememberMe
{
    [[[MobileRTC sharedRTC] getAuthService] loginWithEmail:email password:password rememberMe:YES];
}

- (void)loginWithSSOToken:(NSString *)ssoToken rememberMe:(BOOL)rememberMe
{
    [[[MobileRTC sharedRTC] getAuthService] loginWithSSOToken:ssoToken rememberMe:YES];
}

@end
