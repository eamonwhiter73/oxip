//
//  AppDelegate.h
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
@import UserNotifications;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationMgr;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, assign) NSNumber* ran;
@property (nonatomic, assign) BOOL receivednotif;
@property (nonatomic, strong) NSString* invitedby;
@property (weak) ViewController *viewController;
@property (strong, nonatomic) NSString *idbyusy;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//- (void)setReceivedNotifToNo;
- (void)setInvitedBy:(NSString *)set;
- (NSString*)getInvitedBy;
- (NSString*)getIdbyusy;


@end

