//
//  SQLAppDelegate.h
//  ExampleReadWriteData
//
//  Created by Júlio Menezes Noronha on 29/05/14.
//  Copyright (c) 2014 Júlio César Menezes Noronha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
