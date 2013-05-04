//
//  AppboyBinding.m
//  Unity-iPhone
//
//  Created by Peter McKee on 4/30/13.
//
//

#import "AppboyUnityManager.h"

// Converts C style string to NSString
#define GetStringParam( _x_ ) ( _x_ != NULL ) ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""]

void _showStreamView()
{
    [AppboyUnityManager showStreamView];
}

void _showFeedbackForm()
{
    [AppboyUnityManager showFeedbackForm];
}