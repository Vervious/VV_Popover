//
//  VV_ArrowCreatorView.h
//  Friendly
//
//  Created by Vervious on 7/25/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//
//  This subclass of NSView draws the transparent area around the arrow of a window (that conforms to VV_ArrowedWindow)
//

#import <Cocoa/Cocoa.h>
#import "VV_TopLevelProtocols.h"

@interface VV_ArrowCreatorView : NSView

// the window we will draw the arrow for
@property (weak, nonatomic) NSWindow <VV_ArrowedWindow> *delegate;

// window is the window we will query for parameters
- (id)initWithWindow:(NSWindow <VV_ArrowedWindow> *)window;

@end
