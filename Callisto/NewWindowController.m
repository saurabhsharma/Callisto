//
//  NewWindowController.m
//  Callisto
//
//  Created by Saurabh Sharma on 28/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "NewWindowController.h"

@interface NewWindowController ()

@end

@implementation NewWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    self.socketClientViewController = [[SocketClientViewController alloc] initWithNibName:@"SocketClientViewController" bundle:nil];
    
    [self.window.contentView addSubview:self.socketClientViewController.view];
    self.socketClientViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
