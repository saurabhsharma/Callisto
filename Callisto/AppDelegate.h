//
//  AppDelegate.h
//  Callisto
//
//  Created by Saurabh Sharma on 25/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SocketClientViewController.h"
#import "NewWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet SocketClientViewController *socketClientViewController;
@property (strong) NSMutableArray *windowArr;

-(IBAction)createNewWindow:(id)sender;

@end
