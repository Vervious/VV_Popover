//
//  VV_AppDelegate.h
//  Friendly
//
//  Created by Nano8Blazex on 7/24/12.
//  Copyright (c) 2012 Vervious. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VV_AppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
