//
//  AppDelegate.h
//  Callisto
//
//  Created by Saurabh Sharma on 25/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SocketClientViewController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet SocketClientViewController *socketClientViewController;



@end
