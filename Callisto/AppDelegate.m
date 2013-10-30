//
//  AppDelegate.m
//  Callisto
//
//  Created by Saurabh Sharma on 25/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "AppDelegate.h"
#import "NewWindowController.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.socketClientViewController = [[SocketClientViewController alloc] initWithNibName:@"SocketClientViewController" bundle:nil];
    
    [self.window.contentView addSubview:self.socketClientViewController.view];
    self.socketClientViewController.view.frame = ((NSView*)self.window.contentView).bounds;

    self.windowArr = [[NSMutableArray alloc] init];
    
}

-(IBAction)createNewWindow:(id)sender{

    NewWindowController *nwc = [[NewWindowController alloc] initWithWindowNibName:@"NewWindowController"];
    [self.windowArr addObject:nwc];
    [nwc showWindow:nil];
    
}



@end
