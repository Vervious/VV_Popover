//
//  VV_PopoverWindow.h
//  Friendly
//
//  Created by Vervious on 7/25/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VV_TopLevelProtocols.h"

// this window draws an arrow on top
@interface VV_PopoverWindow : NSWindow <VV_ArrowedWindow> {
    
}

@property (assign) CGFloat arrowXPosition;

@end
