//
//  AppDelegate.m
//  BluetoothNXT
//
//  Created by Rafael Munhoz on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

IOBluetoothRFCOMMChannel *nxtChannel;
WiiRemoteDiscovery *wiiDiscovery;


@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSLog(@"Application ready");
    nxtChannel = [[IOBluetoothRFCOMMChannel alloc] init];
}

-(IBAction)removeWiiRemote:(id)sender
{
    NSLog(@"Remove Wii Remote");
    [wiiDiscovery stop];
}

-(IBAction)connectWiiRemote:(id)sender
{
    NSLog(@"Connect Wii Remote");
    
    wiiDiscovery = [WiiRemoteDiscovery discoveryWithDelegate:self];
    [wiiDiscovery start];
}

-(void)stopSteringMotor
{
    NSLog(@"Stop Stering Motor");
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80; // no response required
    dataBuffer[3] = 0x04; // motor device
    dataBuffer[4] = 0x00; // motor attached at port A
    dataBuffer[5] = 0x80; // Power to motor
    dataBuffer[6] = 0x02; // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x00; // REGULATION_MODE_IDLE  0x00
    // REGULATION_MODE_MOTOR_SPEED 0x01
    // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x40; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
    // MOTOR_RUN_STATE_RAMPUP = 0x10
    // MOTOR_RUN_STATE_RUNNING = 0x20
    // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    dataBuffer[11] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);
    
    
    
}

-(IBAction)stopMotor:(id)sender
{
    NSLog(@"Stop Motor");
    
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00; //just a comment
    dataBuffer[2] = 0x80; // no response required
    dataBuffer[3] = 0x04; // motor device
    dataBuffer[4] = 0x00; // motor attached at port A
    dataBuffer[5] = 0x80; // Power to motor
    dataBuffer[6] = 0x02; // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x00; // REGULATION_MODE_IDLE  0x00
    // REGULATION_MODE_MOTOR_SPEED 0x01
    // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x40; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
    // MOTOR_RUN_STATE_RAMPUP = 0x10
    // MOTOR_RUN_STATE_RUNNING = 0x20
    // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    dataBuffer[11] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);
    
}

-(IBAction)resetMotor:(id)sender
{
    NSLog(@"Reset Motor");
    
    char dataBuffer[6];
    
    dataBuffer[0] = 0x04;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80;
    dataBuffer[3] = 0x0A;
    dataBuffer[4] = 0x00;
    dataBuffer[5] = 0x01;
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:6];
    NSLog(@"Write result ... %d ", writeResult);
    
}

-(void)powerSteringMotor:(int)controlPower
{
    //NSSlider *test = (NSSlider *)sender;
    
    int power = 0x10 + controlPower;
    
    if (power >127 ) {
        power = 127;
    }
    
    NSLog(@"Slider test %d", power);
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80; // no response required
    dataBuffer[3] = 0x04; // motor device
    dataBuffer[4] = 0x00; // motor attached at port A
    dataBuffer[5] = power; // Power to motor
    dataBuffer[6] = 0x01; // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x00; // REGULATION_MODE_IDLE  0x00
    // REGULATION_MODE_MOTOR_SPEED 0x01
    // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x20; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
    // MOTOR_RUN_STATE_RAMPUP = 0x10
    // MOTOR_RUN_STATE_RUNNING = 0x20
    // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    dataBuffer[11] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);
    
}

-(void)powerMotorA:(int)controlPower
{
    //NSSlider *test = (NSSlider *)sender;
    
    int power = 0x10 + controlPower*2;
    
    if (power >127 ) {
        power = 127;
    }
    
    NSLog(@"Slider test %d", power);
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80; // no response required
    dataBuffer[3] = 0x04; // motor device
    dataBuffer[4] = 0x00; // motor attached at port A
    dataBuffer[5] = power; // Power to motor
    dataBuffer[6] = 0x01; // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x00; // REGULATION_MODE_IDLE  0x00
    // REGULATION_MODE_MOTOR_SPEED 0x01
    // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x20; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
    // MOTOR_RUN_STATE_RAMPUP = 0x10
    // MOTOR_RUN_STATE_RUNNING = 0x20
    // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    dataBuffer[11] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);
    
}

-(IBAction)sliderAccel:(id)sender
{
   
    //NSSlider *test = (NSSlider *)sender;

    //int power = 0x10 + [sender intValue]*2;
    
    //if (power >80 ) {
    //    power = 80;
    //}
    
    char power = 0x40;
    
    NSLog(@"Slider test %d", power);
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80; // no response required
    dataBuffer[3] = 0x04; // motor device
    dataBuffer[4] = 0x00; // motor attached at port A
    dataBuffer[5] = power; // Power to motor
    dataBuffer[6] = 0x04; // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x01; // REGULATION_MODE_IDLE  0x00
    // REGULATION_MODE_MOTOR_SPEED 0x01
    // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x10; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
    // MOTOR_RUN_STATE_RAMPUP = 0x10
    // MOTOR_RUN_STATE_RUNNING = 0x20
    // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x08; // tachlimit (ULONG, 0 run forever) 08
    
    dataBuffer[11] = 0x16; // tachlimit (ULONG, 0 run forever) 16
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);

    
    
    
}

-(IBAction)runMotor:(id)sender
{
    //NSSlider *test = (NSSlider *)sender;
    
    //int power = 0x10 + [sender intValue]*2;
    
    //if (power >80 ) {
    //    power = 80;
    //}
    
    char power = -0xB5;
    
    NSLog(@"runMotor test");
    
    char dataBuffer[14];
    
    dataBuffer[0] = 0x0C;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80;  // no response required
    dataBuffer[3] = 0x04;  // motor device
    dataBuffer[4] = 0x00;  // motor attached at port A
    dataBuffer[5] = power; // Power to motor
    dataBuffer[6] = 0x01;  // Mode Byte {MOTOR ON 0x01 , BRAKE 0x02, REGULATED 0x04 (ensure constant speed for load)}
    
    dataBuffer[7] = 0x00; // REGULATION_MODE_IDLE  0x00
                          // REGULATION_MODE_MOTOR_SPEED 0x01
                          // REGULATION_MODE_MOTOR_SYNC 0x02
    
    
    dataBuffer[8] = 0x00; // Turn Ratio (SBYTE -100 to 100) maybe it is related to reguation mode
    dataBuffer[9] = 0x20; // Run State {MOTOR_RUN_STATE_IDLE = 0x00
                          // MOTOR_RUN_STATE_RAMPUP = 0x10
                          // MOTOR_RUN_STATE_RUNNING = 0x20
                          // MOTOR_RUN_STATE_RAMPDOWN = 0x40
    
    
    
    
    dataBuffer[10] = 0x00; // tachlimit (ULONG, 0 run forever) 68
    
    dataBuffer[11] = 0x00; // tachlimit (ULONG, 0 run forever) 01
    dataBuffer[12] = 0x00; // tachlimit (ULONG, 0 run forever)
    dataBuffer[13] = 0x00; // tachlimit (ULONG, 0 run forever)
    
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:14];
    NSLog(@"Write result ... %d ", writeResult);

    
}


-(IBAction)playSoundTest:(id)sender
{
    NSLog(@"Play sound");
    char dataBuffer[8];
    
    dataBuffer[0] = 0x06;
    dataBuffer[1] = 0x00;
    dataBuffer[2] = 0x80;
    dataBuffer[3] = 0x03;
    dataBuffer[4] = 0x20;
    dataBuffer[5] = 0x20;
    dataBuffer[6] = 0x01;
    dataBuffer[7] = 0x01;
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:8];
    NSLog(@"Write result ... %d ", writeResult);

    
}

-(IBAction)getOutputState:(id)sender
{
    NSLog(@"Get output state");
    //little ending
    char dataBuffer[5];
    
    dataBuffer[0] = 0x03; // 0x03 Most sig byte
    dataBuffer[1] = 0x00; // 0x00
    dataBuffer[2] = 0x00; // 0x00
    dataBuffer[3] = 0x06; // 0x06 Less sig byte
    dataBuffer[4] = 0x00; // 0x00
    
    int writeResult = [nxtChannel writeSync:dataBuffer length:5];
       
    
    NSLog(@"Write result ... %d ", writeResult);

    
}

-(IBAction)checkBlueToothDevice:(id)sender
{
    NSLog(@"Blue tooth button clicked");    
    IOBluetoothDevice *myNXT = [IOBluetoothDevice deviceWithAddressString:@"00-16-53-14-06-76"];
    if ([myNXT isPaired]){
        NSLog(@"Paired");
        NSLog(@"Device name %@",[myNXT name]);
        [myNXT openRFCOMMChannelSync:&nxtChannel withChannelID:1 delegate:self];
        
    }else {
        NSLog(@"Not Paired");
    }
}

-(void)WiiRemoteDiscovered:(WiiRemote*)wiimote
{
    NSLog(@"Wii remote discovered %@", [wiimote address]);
    [wiimote setDelegate:self];
    //[wiimote setExpansionPortEnabled:YES];
}

-(void)WiiRemoteDiscoveryError:(int)code
{
    NSLog(@"Wii remote error");
}

- (void) irPointMovedX:(float)px Y:(float)py wiiRemote:(WiiRemote*)wiiRemote
{
    NSLog(@"Irpoint");

}

- (void) rawIRData: (IRData[4])irData wiiRemote:(WiiRemote*)wiiRemote
{
    NSLog(@"rawIrData");
}

- (void) buttonChanged:(WiiButtonType)type isPressed:(BOOL)isPressed wiiRemote:(WiiRemote*)wiiRemote
{
    NSLog(@"buttonChanged");
}

- (void) accelerationChanged:(WiiAccelerationSensorType)type accX:(unsigned char)accX accY:(unsigned char)accY accZ:(unsigned char)accZ wiiRemote:(WiiRemote*)wiiRemote
{
    
}

- (void) joyStickChanged:(WiiJoyStickType)type tiltX:(unsigned char)tiltX tiltY:(unsigned char)tiltY wiiRemote:(WiiRemote*)wiiRemote
{
    NSLog(@"joyStickChanged X %d",tiltX);
    NSLog(@"joyStickChanged Y %d",tiltY);
    [self powerMotorA:tiltY-128];
}

- (void) analogButtonChanged:(WiiButtonType)type amount:(unsigned)press wiiRemote:(WiiRemote*)wiiRemote
{
    //NSLog(@"analogButtonChanged");
}

- (void) wiiRemoteDisconnected:(IOBluetoothDevice*)device
{
    NSLog(@"wiiRemoteDisconnected");
}

// Bluetooth delegate protocol

- (void)rfcommChannelData:(IOBluetoothRFCOMMChannel*)rfcommChannel data:(void *)dataPointer length:(size_t)dataLength
{
    
    //unsigned char* dp = (unsigned char*)dataPointer;
    
    
    unsigned char* dp = (unsigned char*)dataPointer;
    
    
    int data;
    
    for (int i=0;i<dataLength;i++){
        data = dp[i];
        NSLog(@"Byte %d data %d",i-2,data);
    }
    

    
    //little ending conversion Tacho count
    long tachoLimit = 0;
    tachoLimit |= dp[14] & 0xFF; // Most sig byte
    tachoLimit <<= 8;
    tachoLimit |= dp[13] & 0xFF;
    tachoLimit <<= 8;
    tachoLimit |= dp[12] & 0xFF;
    tachoLimit <<= 8;
    tachoLimit |= dp[11] & 0xFF; // Less Sig Byte

    
    //little ending conversion Tacho count
    long tachoCount = 0;
    tachoCount |= dp[18] & 0xFF; // Most sig byte
    tachoCount <<= 8;
    tachoCount |= dp[17] & 0xFF;
    tachoCount <<= 8;
    tachoCount |= dp[16] & 0xFF;
    tachoCount <<= 8;
    tachoCount |= dp[15] & 0xFF; // Less Sig Byte
    
    //little ending conversion Rotation Count
    long rotationCount = 0;
    rotationCount |= dp[26] & 0xFF; // Most sig byte
    rotationCount <<= 8;
    rotationCount |= dp[25] & 0xFF;
    rotationCount <<= 8;
    rotationCount |= dp[24] & 0xFF;
    rotationCount <<= 8;
    rotationCount |= dp[23] & 0xFF; // Less Sig Byte
    
    //little ending conversion Rotation Count
    long blockTachoCount = 0;
    blockTachoCount |= dp[22] & 0xFF; // Most sig byte
    blockTachoCount <<= 8;
    blockTachoCount |= dp[21] & 0xFF;
    blockTachoCount <<= 8;
    blockTachoCount |= dp[20] & 0xFF;
    blockTachoCount <<= 8;
    blockTachoCount |= dp[19] & 0xFF; // Less Sig Byte

    
    
    
    NSLog(@"Tacho limit %ld", tachoLimit);
    NSLog(@"Tacho count %ld",tachoCount);
    NSLog(@"Block tacho count %ld",blockTachoCount);
    NSLog(@"Rotation Count %ld",rotationCount);
    
    //NSLog(@"Raw outputdata %s",dp);
    
    
    
    

}

- (void)rfcommChannelOpenComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel status:(IOReturn)error
{
    NSLog(@"rfcommChannelOpenComplete");
}

- (void)rfcommChannelClosed:(IOBluetoothRFCOMMChannel*)rfcommChannel
{
    NSLog(@"rfcommChannelClosed");
}

- (void)rfcommChannelControlSignalsChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel
{
    NSLog(@"rfcommChannelControlSignalsChanged");
}
- (void)rfcommChannelFlowControlChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel
{
    NSLog(@"rfcommChannelFlowControlChanged");
}
- (void)rfcommChannelWriteComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel refcon:(void*)refcon status:(IOReturn)error
{
    NSLog(@"rfcommChannelWriteComplete");
}


- (void)rfcommChannelQueueSpaceAvailable:(IOBluetoothRFCOMMChannel*)rfcommChannel
{
    NSLog(@"rfcommChannelQueueSpaceAvailable");
}


@end
