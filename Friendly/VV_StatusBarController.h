//
//  VV_StatusBarController.h
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VV_StatusBarController : NSObject

// create the first status bar item and main window for use
// call this method before using the status bar controller
- (void)constructInitialWindow;
// show or hide the window
- (void)toggleWindowVisibility;

@end
