//
//  VV_StatusBarController.m
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import "VV_StatusBarController.h"
#import "StatusItemView.h"

#import "VV_PopoverWindowController.h"

@interface VV_StatusBarController ()
@property (nonatomic, strong) NSStatusItem *statusBarItem;
@property (nonatomic, strong) VV_PopoverWindowController *popover;
@end

@implementation VV_StatusBarController

@synthesize statusBarItem = _statusBarItem;
@synthesize popover = _popover;

- (void)constructInitialWindow {
    self.statusBarItem = [self vvCreateStatusBarItemWithAction:@selector(statusItemClicked:)];
    StatusItemView *statusItemView = (StatusItemView *)self.statusBarItem.view;
    // build the popover
    self.popover = [[VV_PopoverWindowController alloc] initWithWindowNibName:@"DefaultPopoverWindow"];
    // bind the popover's relativePoint to status Bar Item position, for correct positioning
    // note that changing popover's relativePoint does not propagate to status item view
    [self.popover bind:@"relativePoint" toObject:statusItemView withKeyPath:@"referencePoint" options:nil];
    // from here on, we basically let the popover do its own thing, and update ourself using notifications
    [self.popover addObserver:self forKeyPath:@"hasActiveInterface" options:0 context:NULL];
}

- (void)statusItemClicked:(id)sender {
    [self toggleWindowVisibility];
}

- (void)toggleWindowVisibility {
    // toggle showing the popover. Relative positions should have been updated through bindings
    [self.popover setHasActiveInterface:!(self.popover.hasActiveInterface)];
}

// Changes the menu item if the interface has been shown/hidden/changed
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ( [keyPath isEqualToString:@"hasActiveInterface"] && object == self.popover ) {
        // interface has been shown/hidden - directly grab its state and change the menu item
        [(StatusItemView *)self.statusBarItem.view setHighlighted:self.popover.hasActiveInterface];
    }
}

#pragma mark utility methods

// creates and returns a status bar item with preset parameters
- (NSStatusItem *)vvCreateStatusBarItemWithAction:(SEL)action {
    
    NSStatusBar *universalBar = [NSStatusBar systemStatusBar];
    NSStatusItem *newItem = [universalBar statusItemWithLength:NSSquareStatusItemLength];
    
    // draw a custom view for the status Item to be able to get its position
    StatusItemView *itemView = [[StatusItemView alloc] initWithStatusItem:newItem];
    [itemView setImage:[NSImage imageNamed:@"status-icon.png"]];
    [itemView setAlternateImage:[NSImage imageNamed:@"status-icon-alt.png"]];
    [itemView setAction:action];
    [itemView setTarget:self];
    [newItem setView:itemView];
    
    return newItem;
}

@end
