//
//  VV_TopLevelProtocols.h
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VV_ArrowedWindow

@property (assign) CGFloat arrowXPosition;

// an NSBezierPath describing the outline (shape) of the transparent area to cut out of the window (to form the arrow)
- (NSBezierPath *)transparentArea;

// where does transparency need to be drawn (around the outline)? Performance optimization purposes.
- (NSRect)rectOfTransparentArea;

@end
