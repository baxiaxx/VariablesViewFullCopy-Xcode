//
//  DVTUserNotificationCenter+VariablesViewFullCopy.m
//  VariablesViewFullCopy
//
//  Created by Fabio on 18/09/2015.
//  Copyright © 2015 orange in a day. All rights reserved.
//

#import "DVTUserNotificationCenter+VariablesViewFullCopy.h"
#import "VariablesViewFullCopy.h"

@implementation DVTUserNotificationCenter (VariablesViewFullCopy)

+ (void)load
{
    NSError *error = nil;
    [self jr_swizzleMethod:@selector(userNotificationCenter:shouldPresentNotification:) withMethod:@selector(vvfc_userNotificationCenter:shouldPresentNotification:) error:&error];
    [self jr_swizzleMethod:@selector(userNotificationCenter:didActivateNotification:) withMethod:@selector(vvfc_userNotificationCenter:didActivateNotification:) error:&error];
}

- (BOOL)vvfc_userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    if ([notification.userInfo[VariablesViewFullCopyNewVersionNotification] boolValue]) {
        return YES;
    }
    return [self vvfc_userNotificationCenter:center shouldPresentNotification:notification];
}

- (void)vvfc_userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    if ([notification.userInfo[VariablesViewFullCopyNewVersionNotification] boolValue]) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/Sephiroth87/VariablesViewFullCopy-Xcode#release-notes"]];
    }
    [self vvfc_userNotificationCenter:center didActivateNotification:notification];
}

@end
