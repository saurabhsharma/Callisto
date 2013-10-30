//
//  SocketClientViewController.m
//  Callisto
//
//  Created by Saurabh Sharma on 25/10/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "SocketClientViewController.h"
#import "NewWindowController.h"

@interface SocketClientViewController ()

@end

@implementation SocketClientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

 


-(IBAction)connectWithServer:(id)sender {
	
    if ([self.connectBtn.title isEqualToString:@"Disconnect"]){
        
        [self.inputStream close];
        [self.outputStream close];
        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.inputStream = nil;
        self.outputStream = nil;
        [self.statusMsg setStringValue:@"Disconnected"];
        [self.connectBtn setTitle:@"Connect"];
        
        return;
        
    }
    
    CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
    
	CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[self.server stringValue], [self.port intValue], &readStream, &writeStream);
    
    self.inputStream = (__bridge_transfer NSInputStream *)readStream;
    self.outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    
    
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.inputStream open];
    [self.outputStream open];
    
    self.conversation = @"";
    [self.statusMsg setStringValue:@"Disconnected"];
    [self.connectBtn setTitle:@"Disconnect"];
    
}


-(IBAction)sendDataOnStream:(id)sender{
    
    NSString *dataToSendOnStream  = [self.dataToSend stringValue];
	NSData *data = [[NSData alloc] initWithData:[dataToSendOnStream dataUsingEncoding:NSASCIIStringEncoding]];
	[self.outputStream write:[data bytes] maxLength:[data length]];

    [self updateConversationWith:@"client" with:[self.dataToSend stringValue]];
   
    //self.dataToSend.stringValue = "";
    
}


-(void) updateConversationWith:(NSString *) eventType with:(NSString *) dataString{
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [outputFormatter stringFromDate:[NSDate date]];
    
    
    if ([eventType isEqualToString:@"client"]){
        
        self.conversation = [NSString stringWithFormat:@"%@%@Callisto (%@) -\n%@\n----------------------------------------------",self.conversation,((self.conversation.length>0)?@"\n":@""),dateString,dataString];
        
    }
    else if ([eventType isEqualToString:@"server"]) {
        
         self.conversation = [NSString stringWithFormat:@"%@\n%@:%d (%@) -\n%@\n---------------------------------------------- ",self.conversation,[self.server stringValue],[self.port intValue],dateString,dataString];
    }
    
    self.conversationTxtView.string = self.conversation;
    [self.conversationTxtView scrollRangeToVisible:NSMakeRange([[self.conversationTxtView string] length], 0)];
    
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	NSLog(@"stream event %lu", streamEvent);
	
	switch (streamEvent) {
			
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
            [self.statusMsg setStringValue:[NSString stringWithFormat:@"Connected to %@:%d",[self.server stringValue], [self.port intValue]]];
            [self.connectBtn setTitle:@"Disconnect"];
			break;
		case NSStreamEventHasBytesAvailable:
            
			if (theStream == self.inputStream) {
				
				uint8_t buffer[1024];
				int len;
				
				while ([self.inputStream hasBytesAvailable]) {
					len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						
						if (nil != output) {
                            
							NSLog(@"server said: %@", output);
                            [self updateConversationWith:@"server" with:output];
							
						}
					}
				}
			}
			break;
            
			
		case NSStreamEventErrorOccurred:
			
			NSLog(@"Can not connect to the host!");
			break;
			
		case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            [self.statusMsg setStringValue:@"Disconnected"];
            [self.connectBtn setTitle:@"Connect"];
			break;
		default:
			NSLog(@"Unknown event");
	}
    
}

@end
