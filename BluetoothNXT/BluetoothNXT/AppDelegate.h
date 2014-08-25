//
//  AppDelegate.h
//  BluetoothNXT
//
//  Created by Rafael Munhoz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOBluetooth/IOBluetooth.h>
#import "WiiRemoteDiscovery.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

-(IBAction)checkBlueToothDevice:(id)sender;
-(IBAction)playSoundTest:(id)sender;
-(IBAction)runMotor:(id)sender;
-(IBAction)sliderAccel:(id)sender;
-(IBAction)resetMotor:(id)sender;
-(IBAction)stopMotor:(id)sender;
-(IBAction)connectWiiRemote:(id)sender;
-(IBAction)getOutputState:(id)sender;

-(void)WiiRemoteDiscovered:(WiiRemote*)wiimote;
-(void)WiiRemoteDiscoveryError:(int)code;

- (void) irPointMovedX:(float)px Y:(float)py wiiRemote:(WiiRemote*)wiiRemote;
- (void) rawIRData: (IRData[4])irData wiiRemote:(WiiRemote*)wiiRemote;
- (void) buttonChanged:(WiiButtonType)type isPressed:(BOOL)isPressed wiiRemote:(WiiRemote*)wiiRemote;
- (void) accelerationChanged:(WiiAccelerationSensorType)type accX:(unsigned char)accX accY:(unsigned char)accY accZ:(unsigned char)accZ wiiRemote:(WiiRemote*)wiiRemote;
- (void) joyStickChanged:(WiiJoyStickType)type tiltX:(unsigned char)tiltX tiltY:(unsigned char)tiltY wiiRemote:(WiiRemote*)wiiRemote;
- (void) analogButtonChanged:(WiiButtonType)type amount:(unsigned)press wiiRemote:(WiiRemote*)wiiRemote;
- (void) wiiRemoteDisconnected:(IOBluetoothDevice*)device;

@end
