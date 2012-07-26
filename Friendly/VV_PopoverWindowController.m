//
//  VV_PopoverWindowController.m
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import "VV_PopoverWindowController.h"
#import "VV_TopLevelProtocols.h"

// basic definitions
#define WINDOW_CLOSE_DURATION .2
#define WINDOW_OPEN_DURATION .1
#define GAP_FROM_TOP 5

@interface VV_PopoverWindowController ()

@end

@implementation VV_PopoverWindowController

- (id)initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    /* Establish popover display settings */
    [NSApp activateIgnoringOtherApps:YES];
    
    // configure appearance of the window
    NSWindow *popover = (id)[self window];
    [popover setAcceptsMouseMovedEvents:YES];
    [popover setLevel:NSFloatingWindowLevel];
    [popover setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces|NSWindowCollectionBehaviorFullScreenAuxiliary];
}

#pragma mark - interface and window display and positioning
#pragma mark display

@synthesize relativePoint = _relativePoint;
@synthesize hasActiveInterface = _hasActiveInterface;

// we show/hide our popover through this setter
- (void)setHasActiveInterface:(BOOL)hasActiveInterface {
    if (_hasActiveInterface != hasActiveInterface) {
        _hasActiveInterface = hasActiveInterface;
        if ( _hasActiveInterface ) {
            [self showPopover];
        } else {
            [self hidePopover];
        }
    }
}

- (void)showPopover {
    [NSApp activateIgnoringOtherApps:YES];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:WINDOW_OPEN_DURATION];
    [[[self window] animator] setAlphaValue:1];
    [NSAnimationContext endGrouping];
    [NSObject cancelPreviousPerformRequestsWithTarget:[self window] selector:@selector(orderOut:) object:self];
    [[self window] makeKeyAndOrderFront:self];
    [[self window] performSelector:@selector(makeKeyAndOrderFront:) withObject:self afterDelay:WINDOW_OPEN_DURATION];
}

- (void)hidePopover {
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:WINDOW_CLOSE_DURATION];
    [[[self window] animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    [NSObject cancelPreviousPerformRequestsWithTarget:[self window] selector:@selector(makeKeyAndOrderFront:) object:self];
    [[self window] performSelector:@selector(orderOut:) withObject:self afterDelay:WINDOW_CLOSE_DURATION];
}

#pragma mark positioning

- (void)setRelativePoint:(NSPoint)relativePoint {
    if (!NSEqualPoints(relativePoint, _relativePoint)) {
        _relativePoint = relativePoint;
        [self repositionWithNewPoint:relativePoint];
    }
}

- (void)reposition {
    [self repositionWithNewPoint:self.relativePoint];
}

- (void)repositionWithNewPoint:(NSPoint)relativePoint {
    [self calculateAndSetInterfaceSizeAndPositionToRelativePoint:relativePoint];
}

// calculate the window position and put it in the right spot
- (void)calculateAndSetInterfaceSizeAndPositionToRelativePoint:(NSPoint)relativePoint {
    
    NSWindow * popover = [self window];
    NSRect frameRect = [popover frame];
    
    // calculate position
    CGFloat newX = relativePoint.x;
    CGFloat newY = relativePoint.y;
    newX -= (frameRect.size.width / 2);
    newY -= ((CGFloat) GAP_FROM_TOP + frameRect.size.height);
    NSPoint newOrigin = NSMakePoint( newX, newY );
    frameRect.origin = newOrigin;
    
    if ([popover conformsToProtocol:@protocol(VV_ArrowedWindow)]) {
        // calculate  and set arrow position
        CGFloat arrowXLocation = frameRect.size.width/2;
        [(NSWindow <VV_ArrowedWindow> *)popover setArrowXPosition:arrowXLocation];
    }
    
    if ([popover inLiveResize]) { // don't screw up the resize
    } else {
        [popover setFrameOrigin:newOrigin];
    }
        
    // now, hide the title bar by readjusting the content view location, and using NSCompositeCopy
    NSRect testRect = [self.window.contentView frame];
    CGFloat sizeDifference = self.window.frame.size.height - testRect.size.height;
    testRect.size.height += sizeDifference;
    [self.window.contentView setFrame:testRect];
}

- (void)windowDidResize:(NSNotification *)notification {
    [self reposition];
}

- (void)windowDidEndLiveResize:(NSNotification *)notification {
    [self reposition];
}

#pragma mark interaction

// hide the window when it's not being used
- (void)windowDidResignKey:(NSNotification *)notification {
    if ([self.window attachedSheet]) {
        if ([NSApp keyWindow] != [self.window attachedSheet]) {
            // there's a sheet attached and it doesn't have focus
            [[self.window attachedSheet] orderOut:self];
            [self setHasActiveInterface:NO];
        }
    }
    else if ([NSApp keyWindow]!=self.window) {
        [self setHasActiveInterface:NO];
    }
}

@end
