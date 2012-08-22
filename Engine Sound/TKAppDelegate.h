//
//  TKAppDelegate.h
//  Engine Sound
//
//  Created by Timofey Korchagin on 20/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
