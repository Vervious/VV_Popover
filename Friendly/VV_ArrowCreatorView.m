//
//  VV_ArrowCreatorView.m
//  Friendly
//
//  Created by Vervious on 7/25/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import "VV_ArrowCreatorView.h"

@implementation VV_ArrowCreatorView

@synthesize delegate = _delegate;

- (id)initWithWindow:(NSWindow <VV_ArrowedWindow> *)window
{
    NSRect initRect = NSZeroRect;
    if (window) {
        initRect = [window rectOfTransparentArea];
    }
    self = [super initWithFrame:initRect];
    if (self) {
        // Initialization code here.
        _delegate = window;
        [self setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *drawPath = [self.delegate transparentArea];
    [drawPath addClip];
    [[NSColor clearColor] set];
    NSRectFillUsingOperation(dirtyRect, NSCompositeCopy);
}

@end
