//
//  AppDelegate.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUpController.h"
@import GoogleMaps;
#import <Parse/Parse.h>
#import "InvitedView.h"

@interface AppDelegate () {
    NSUserDefaults *userdefaults;
    InvitedView *invitedView;
}

@end

@implementation AppDelegate

@synthesize viewController;

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //NSLog(@"PRESENT******: %@", [notification description]);
    //[PFPush handlePush:notification.request.content.userInfo];
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);

    
    if([[[NSString alloc] initWithString:notification.request.content.body] containsString:@"invited"]) {
        NSArray *arrayWithTwoStrings = [notification.request.content.body componentsSeparatedByString:@"!"];
         _idbyusy = [[NSString alloc] initWithString:[arrayWithTwoStrings objectAtIndex:1]];
        
        NSArray *invby = [_idbyusy componentsSeparatedByString:@","];
        NSLog(@"object at index *********** %@", [invby objectAtIndex:0]);
        self.invitedby = [[NSString alloc] initWithString:[invby objectAtIndex:0]];
        NSLog(@"object at indexdddddd *********** %@", self.invitedby);
        
        //[[[[_navController.childViewControllers firstObject] view] viewWithTag:68] performSelectorOnMainThread:@selector(setHoldUser:) withObject:self.invitedby waitUntilDone:YES];
        //[[[_navController.childViewControllers firstObject] view] setNeedsLayout];
        
        if([screenWidth intValue] == 320) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
        }
        if([screenWidth intValue] == 375) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(77.5, 278.5, 220, 120)];
        }
        if([screenWidth intValue] == 414) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(57, 288, 300, 160)];
        }
        if([screenWidth intValue] == 768) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(84, 392, 500, 240)];
        }
        if([screenWidth intValue] == 1024) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(187, 443, 650, 420)];
        }
        
        invitedView.tag = 68;
        invitedView.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        
        NSLog(@"debug description navcontroller viewcontrollers ****###$$$$$%@", [_navController.childViewControllers debugDescription]);
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [[[_navController.childViewControllers firstObject] view] addSubview:invitedView];
            //[[[_navController.childViewControllers firstObject] view] bringSubviewToFront:[[[_navController.childViewControllers firstObject] view] viewWithTag:68]];
            //[[[_navController.childViewControllers firstObject] view] setNeedsLayout];
            completionHandler( UNNotificationPresentationOptionNone );
        }
        else {
            //[[[[_navController.childViewControllers firstObject] view] viewWithTag:68] setNeedsLayout];
            [[[_navController.childViewControllers firstObject] view] addSubview:invitedView];
            //[[[_navController.childViewControllers firstObject] view] bringSubviewToFront:[[[_navController.childViewControllers firstObject] view] viewWithTag:68]];
            //[[[_navController.childViewControllers firstObject] view] setNeedsLayout];
            completionHandler( UNNotificationPresentationOptionAlert );
        }
        
        /*if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
        {
            NSLog( @"INACTIVE" );
            if([screenWidth intValue] == 320) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
            }
            if([screenWidth intValue] == 375) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(77.5, 278.5, 220, 120)];
            }
            if([screenWidth intValue] == 414) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(57, 288, 300, 160)];
            }
            if([screenWidth intValue] == 768) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(84, 392, 500, 240)];
            }
            if([screenWidth intValue] == 1024) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(187, 443, 650, 420)];
            }
            
            z.tag = 68;
            completionHandler( UNNotificationPresentationOptionAlert );
            //_receivednotif = YES;
            
        }
        else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
        {
            NSLog( @"BACKGROUND" );
            if([screenWidth intValue] == 320) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
            }
            if([screenWidth intValue] == 375) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(77.5, 278.5, 220, 120)];
            }
            if([screenWidth intValue] == 414) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(57, 288, 300, 160)];
            }
            if([screenWidth intValue] == 768) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(84, 392, 500, 240)];
            }
            if([screenWidth intValue] == 1024) {
                z = [[InvitedView alloc] initWithFrame:CGRectMake(187, 443, 650, 420)];
            }
            
            z.tag = 68;
            completionHandler( UNNotificationPresentationOptionAlert );
            //_receivednotif = YES;
            
        }
        else
        {
            NSLog( @"FOREGROUND" );
            NSLog(@"%@", [[_navController childViewControllers] firstObject]);
            [[[_navController childViewControllers] firstObject] performSelector:@selector(setAFlagForHid:) withObject:[NSNumber numberWithBool:YES]];
            //completionHandler( UNNotificationPresentationOptionAlert );
            //_receivednotif = YES;
        }*/
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (NSString*)getIdbyusy {
    return _idbyusy;
}


- (NSString*)getInvitedBy {
    return self.invitedby;
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)())completionHandler {

    /*NSLog(@"RESPONSE******: %@", [response description]);
    
    // custom code to handle notification content*/
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        if([screenWidth intValue] == 320) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
        }
        if([screenWidth intValue] == 375) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(77.5, 278.5, 220, 120)];
        }
        if([screenWidth intValue] == 414) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(57, 288, 300, 160)];
        }
        if([screenWidth intValue] == 768) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(84, 392, 500, 240)];
        }
        if([screenWidth intValue] == 1024) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(187, 443, 650, 420)];
        }
        
        invitedView.tag = 68;
        invitedView.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        
        [[[_navController.childViewControllers firstObject] view] addSubview:invitedView];

        completionHandler( UIBackgroundFetchResultNewData );
        //_receivednotif = YES;
        
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        NSLog( @"BACKGROUND" );
        if([screenWidth intValue] == 320) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
        }
        if([screenWidth intValue] == 375) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(77.5, 278.5, 220, 120)];
        }
        if([screenWidth intValue] == 414) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(57, 288, 300, 160)];
        }
        if([screenWidth intValue] == 768) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(84, 392, 500, 240)];
        }
        if([screenWidth intValue] == 1024) {
            invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(187, 443, 650, 420)];
        }
        
        invitedView.tag = 68;
        invitedView.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        
        [[[_navController.childViewControllers firstObject] view] addSubview:invitedView];
        
        completionHandler( UIBackgroundFetchResultNewData );
        //_receivednotif = YES;
    }
    else
    {
        //
    }
    
    /*if([viewController getInvitedIsSetHid]) {

        NSLog(@"inside getinvitedissethid**(***(*(*(*(");
        [viewController setInvitedIsSetHid:NO];
            
    }
    else {

        NSLog(@"inside setinvitedissethid**(***(*(*(*(");
        [viewController setInvitedIsSetHid:YES];
        
    }*/
    
    /*[[[[[[[UIApplication sharedApplication] delegate] window] rootViewController] childViewControllers] firstObject] performSelector:@selector(setAFlagForHid:) withObject:[NSNumber numberWithBool:YES]];*/
    
    completionHandler( UIBackgroundFetchResultNewData );
}

/*- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
    
    NSLog(@"did enter region in app delegate 8***************");
    
    if(![userdefaults objectForKey:@"idbyuser"]) {
        PFQuery *sosQuery = [PFUser query];
        [sosQuery whereKey:@"username" equalTo:[userdefaults objectForKey:@"pfuser"]];
        sosQuery.limit = 1;
        
        NSLog(@"entered and sent push************");
        
        [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            [PFCloud callFunctionInBackground:@"sendpushnear"
                               withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"]}];
        }];
    }
    else {
        PFQuery *sosQuery = [PFUser query];
        [sosQuery whereKey:@"username" equalTo:[userdefaults objectForKey:@"pfuser"]];
        sosQuery.limit = 1;
        
        NSLog(@"entered and sent push for group************");
        
        [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            [PFCloud callFunctionInBackground:@"sendpushneargroup"
                               withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"]}];
        }];
    }
}*/

- (void)setInvitedBy:(NSString *)set {
    self.invitedby = [[NSString alloc] initWithString:set];
}

/*- (void)setReceivedNotifToNo {
    _receivednotif = NO;
}*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    
    
    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:@"MDgESuvjvz1K7l302i90N40A0EZDbwSKzb8k3QzL"
                  clientKey:@"pC3lhDsBTukDfJO8uR2hS9ZFZGpgQIIOjj05dP4A"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setDelegate:self];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        if([settings authorizationStatus] == UNAuthorizationStatusNotDetermined) {
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
                if( !error ){
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                }
                else {
                    NSLog(@"%@", [error description]);
                }
            }];
        }

    }];

    [GMSServices provideAPIKey:@"AIzaSyA9gyzAzIjHmwfoLc_V2FCXaeS-SMjclCA"];
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    _locationMgr = [[CLLocationManager alloc] init];
    [_locationMgr setDelegate:self];
    
    if([_locationMgr respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)])
        [_locationMgr setAllowsBackgroundLocationUpdates:YES];
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if([_locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationMgr requestAlwaysAuthorization];
    }

    if([launchOptions valueForKey:UIApplicationLaunchOptionsLocationKey] != nil) {
        [_locationMgr startMonitoringSignificantLocationChanges];
    }
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationMgr startMonitoringSignificantLocationChanges];
    }
    
    _navController = [[UINavigationController alloc] init];
    _navController.navigationBar.hidden = YES;
    
    if([userdefaults objectForKey:@"pfuser"] == nil) {
        SignUpController *signup = [[SignUpController alloc] init];
        [_navController setViewControllers:@[signup]];
    }
    
    else {
        ViewController *map = [[ViewController alloc] init];
        map.view.tag = 1337;
        [_navController setViewControllers:@[map]];
    }
    
    [self.window setRootViewController:_navController];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)startSignificantChangeUpdates
{
    
    if (nil == _locationMgr) {
        _locationMgr = [[CLLocationManager alloc] init];
        _locationMgr.delegate = self;
    }
    
    [CLLocationManager significantLocationChangeMonitoringAvailable];
    
    [_locationMgr startMonitoringSignificantLocationChanges];
    
}

-(void)locationManger:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
      didUpdateLocations:(NSArray *)locations {
    
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
                
        if(![userdefaults objectForKey:@"idbyuser"]) {
            PFQuery *querygeo = [PFQuery queryWithClassName:@"MapPoints"];
            [querygeo whereKey:@"location" nearGeoPoint:userGeoPoint withinMiles:0.28409091];
            querygeo.limit = 1;
            
            [querygeo findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                
                if ([[objects firstObject] objectForKey:@"marker_id"]){
                    /*NSLog(@"%@ ***********geo description**********     :", [geo description]);
                    CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake([[geo valueForKey:@"location"] latitude], [[geo valueForKey:@"location"] longitude]);
                    MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                    ViewController *x = (ViewController*)_navController.visibleViewController;
                    [x registerRegionWithCircularOverlay:circ andIdentifier:[geo valueForKey:@"marker_id"]];*/
                    
                    PFQuery *sosQuery = [PFUser query];
                    [sosQuery whereKey:@"username" equalTo:[userdefaults objectForKey:@"pfuser"]];
                    sosQuery.limit = 1;
                    
                    NSLog(@"entered and sent push************");
                    
                    [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                        [PFCloud callFunctionInBackground:@"sendpushnear"
                                           withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"]}];
                    }];
                }
            }];
        }
        else {
            PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
            [query2 whereKey:@"idbyuser" equalTo:[userdefaults objectForKey:@"idbyuser"]];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                    // Do something with the found objects
                    for (PFObject *object in objects) {
                        NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                        NSLog(@"%@", [yy description]);
                        
                        NSArray *keyArray = [yy allKeys];
                        
                        for(NSString *keyd in keyArray) {
                            NSLog(@"keyd: %@    yyobjectforkey: %@", keyd, [yy objectForKey:keyd]);
                            NSMutableArray *locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                            
                            for(NSDictionary *outterar in locs) {
                                PFGeoPoint *storin = [outterar objectForKey:@"pointdat"];
                                    
                                if([storin distanceInMilesTo:userGeoPoint] <= 0.28409091) {
                                    /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(storin.latitude, storin.longitude);
                                    MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                    ViewController *x = (ViewController*)_navController.visibleViewController;
                                    [x registerRegionWithCircularOverlay:circ andIdentifier:[storin valueForKey:@"marker_id"]];
                                    count++;*/
                                    if([outterar objectForKey:@"marker_id"]) {
                                        PFQuery *sosQuery = [PFUser query];
                                        [sosQuery whereKey:@"username" equalTo:[userdefaults objectForKey:@"pfuser"]];
                                        sosQuery.limit = 1;
                                        
                                        NSLog(@"entered and sent push for group************");
                                        
                                        [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                                            [PFCloud callFunctionInBackground:@"sendpushneargroup"
                                                               withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"]}];
                                        }];
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    NSLog(@"%@", [error description]);
                }
            }];
        }
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveEventually];
}

/*- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    NSLog(@"userinfo ************* \n %@", [userInfo description]);
}*/

/*-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog( @"HANDLE PUSH, didReceiveRemoteNotification: %@", userInfo );
    
    // custom code to handle notification content
    [PFPush handlePush:userInfo];
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        completionHandler( UIBackgroundFetchResultNewData );
        _receivednotif = YES;
        
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        NSLog( @"BACKGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
        _receivednotif = YES;
        
    }
    else
    {
        NSLog( @"FOREGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
        _receivednotif = YES;
        
    }
}*/

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.eamon.sneek" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"sneek" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sneek.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
