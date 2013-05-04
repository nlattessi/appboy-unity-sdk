//
//  AppboyUnityManager.mm
//  Unity-iPhone
//
//  Created by Peter McKee on 5/1/13.
//
//

#import "AppboyUnityManager.h"
#include "iPhone_View.h"
#import "Appboy.h"
#import "ABKFeedbackViewControllerModalContext.h"
#import "ABKStreamViewControllerModalContext.h"

@implementation AppboyUnityManager

+ (void) showFeedbackForm
{
    ABKFeedbackViewControllerModalContext *feedbackViewController = [[ABKFeedbackViewControllerModalContext alloc] init];
    [UnityGetGLViewController() presentModalViewController:feedbackViewController animated:YES];
    [feedbackViewController release];
}

+ (void) showStreamView
{
    ABKStreamViewControllerModalContext *streamViewController = [[ABKStreamViewControllerModalContext alloc] init];
    [UnityGetGLViewController() presentModalViewController:streamViewController animated:YES];
    [streamViewController release];
}

@end