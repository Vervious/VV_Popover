//
//  VV_PopoverWindow.m
//  Friendly
//
//  Created by Vervious on 7/25/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import "VV_PopoverWindow.h"
#import "VV_ArrowCreatorView.h"


#define LINE_THICKNESS 0
#define CORNER_RADIUS 10
#define ARROW_WIDTH 20
#define ARROW_HEIGHT 10


@interface VV_PopoverWindow () {
    NSBezierPath *transparentArea; // we don't want to recalculate it every time so we cache it
    NSRect previousBounds; // help us cache transparent area and check necessity of update
}

@property (nonatomic, strong) VV_ArrowCreatorView *arrowCreatorView;
@end

@implementation VV_PopoverWindow

@synthesize arrowXPosition = _arrowXPosition;
@synthesize arrowCreatorView = _arrowCreatorView;

- (void)awakeFromNib {
    previousBounds = NSZeroRect;
    self.arrowCreatorView = [[VV_ArrowCreatorView alloc] initWithWindow:self];
    [self.contentView addSubview:self.arrowCreatorView];
}

- (BOOL)isOpaque {
    return NO;
}

// an NSBezierPath describing the outline (shape) of the transparent area to cut out of the window (to form the arrow)
- (NSBezierPath *)transparentArea {
    NSRect bounds = [self.contentView bounds];
    
    if (!NSEqualRects(previousBounds, NSZeroRect) && transparentArea != nil && NSEqualRects(previousBounds, bounds)) {
        return transparentArea; // we have already calculated the bezier path
    }
    else {
        previousBounds = bounds;
    
        NSBezierPath *path = [NSBezierPath bezierPath];
        CGFloat _arrowX = self.arrowXPosition;
        
        // draw the arrow and the top
        [path moveToPoint:NSMakePoint(_arrowX, NSMaxY(bounds))];
        [path lineToPoint:NSMakePoint(_arrowX + ARROW_WIDTH / 2, NSMaxY(bounds) - ARROW_HEIGHT)];
        [path lineToPoint:NSMakePoint(NSMaxX(bounds) - CORNER_RADIUS, NSMaxY(bounds) - ARROW_HEIGHT)];
        
        // draw the top right
        NSPoint topRightCorner = NSMakePoint(NSMaxX(bounds), NSMaxY(bounds) - ARROW_HEIGHT);
        [path curveToPoint:NSMakePoint(NSMaxX(bounds), NSMaxY(bounds) - ARROW_HEIGHT - CORNER_RADIUS)
             controlPoint1:topRightCorner controlPoint2:topRightCorner];
        
        // now form the rest of the frame, because we're only making the top area transparent
        [path lineToPoint:NSMakePoint(NSMaxX(bounds), NSMaxY(bounds))];
        [path lineToPoint:NSMakePoint(NSMinX(bounds), NSMaxY(bounds))];
        [path lineToPoint:NSMakePoint(NSMinX(bounds), NSMaxY(bounds) - ARROW_HEIGHT - CORNER_RADIUS)];
        
        // draw the top left
        NSPoint topLeftCorner = NSMakePoint(NSMinX(bounds), NSMaxY(bounds) - ARROW_HEIGHT);
        [path curveToPoint:NSMakePoint(NSMinX(bounds) + CORNER_RADIUS, NSMaxY(bounds) - ARROW_HEIGHT)
                           controlPoint1:topLeftCorner controlPoint2:topLeftCorner];
        
        // finish it
        [path lineToPoint:NSMakePoint(_arrowX - ARROW_WIDTH / 2, NSMaxY(bounds) - ARROW_HEIGHT)];
        [path closePath];
        
        return path;
    }
}

// where does transparency need to be drawn (around the outline)? Performance optimization purposes.
- (NSRect)rectOfTransparentArea {
    // we return the full rect because coordinate systems change, and that's a problem when drawing paths, so
    // for the sake of consistency we keep everything the same size
    return NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    /*
    if ([self.contentView isFlipped]) {
        return NSMakeRect(0, 0, self.frame.size.width, 22);
    }
    else {
        return NSMakeRect(0, [self.contentView frame].size.height - 22, self.frame.size.width, 22);        
    }
     */
}

@end
