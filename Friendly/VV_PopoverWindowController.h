//
//  VV_PopoverWindowController.h
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VV_PopoverWindowController : NSWindowController <NSWindowDelegate>

// the point the popover is positioned at (relative)
@property (nonatomic, assign) NSPoint relativePoint;
// the property that controls whether the popover should be displayed or hidden
@property (nonatomic, assign) BOOL hasActiveInterface;

#pragma mark positioning
- (void)reposition; // reposition the window to the right place (under the bar)

@end
