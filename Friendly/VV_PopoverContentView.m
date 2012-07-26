//
//  VV_PopoverContentView.m
//  Friendly
//
//  Created by Vervious on 7/25/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import "VV_PopoverContentView.h"

@implementation VV_PopoverContentView

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
    [[NSColor whiteColor] set];
    NSRectFill(dirtyRect);
}

@end
