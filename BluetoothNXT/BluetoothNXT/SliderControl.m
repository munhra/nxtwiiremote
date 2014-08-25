//
//  SliderControl.m
//  BluetoothNXT
//
//  Created by Rafael Munhoz on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SliderControl.h"

@implementation SliderControl

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

-(void)mouseDown:(NSEvent *)theEvent
{
    NSLog(@"Mouse down on slider !");
}

@end
