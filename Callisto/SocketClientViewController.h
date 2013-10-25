//
//  SocketClientViewController.h
//  Callisto
//
//  Created by Saurabh Sharma on 25/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SocketClientViewController : NSViewController<NSStreamDelegate>

@property (nonatomic, retain) IBOutlet NSTextField *server;
@property (nonatomic, retain) IBOutlet NSTextField *port;
@property (nonatomic, retain) IBOutlet NSTextField *dataToSend;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

@end
