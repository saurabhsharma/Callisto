//
//  NewWindowController.h
//  Callisto
//
//  Created by Saurabh Sharma on 28/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SocketClientViewController.h"


@interface NewWindowController : NSWindowController

@property (strong) IBOutlet SocketClientViewController *socketClientViewController;

@end
