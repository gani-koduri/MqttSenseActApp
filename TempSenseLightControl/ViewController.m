//
//  ViewController.m
//  TempSenseLightControl
//
//  Created by Gani Koduri on 15/12/17.
//  Copyright © 2017 Gani. All rights reserved.
//

#import "ViewController.h"
#include <PubNub/PubNub.h>

//<PNObjectEventListener>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *TempLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempValue;
@property (weak, nonatomic) IBOutlet UIButton *OffButton;
@property (weak, nonatomic) IBOutlet UIButton *OnButton;

// Stores reference on PubNub client to make sure what it won't be released.
@property (nonatomic, strong) PubNub *client;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize and configure PubNub client instance
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:@"pub-c-029290f5-5c71-4d7d-ab91-ed1a0e6a1e91" subscribeKey:@"sub-c-3d302b16-e05f-11e7-ad36-deb77ae39928"];
    self.client = [PubNub clientWithConfiguration:configuration];
    [self.client addListener:self];
    
    // Subscribe to demo channel with presence observation
    [self.client subscribeToChannels: @[@"/FarmEasy/TempSenseLightControl"] withPresence:NO];

}

// Handle new message from one of channels on which client has been subscribed.
- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message

    if (![message.data.channel isEqualToString:message.data.subscription]) {
        
        
        // Message has been received on channel group stored in message.data.subscription.

    }
    else {
        self.TempValue.text = [message.data.message valueForKey:@"Temperature"];
        // Message has been received on channel stored in message.data.channel.
    }
    
    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
          message.data.channel, message.data.timetoken);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
