//
//  ViewController.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "ViewController.h"
#import "SignUpController.h"
#import <Parse/Parse.h>
#import "AFHTTPSessionManager.h"
#import "LeaderboardController.h"
#import "Tutorial.h"
#import "RespTutorial.h"
#import "AppDelegate.h"
#import "InvisibleButtonView.h"
#import "GroupController.h"
#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>

@import GoogleMaps;

typedef void (^CompletionHandlerType)();

@interface MotionHandler : NSObject

@end

@implementation MotionHandler {
@private
    // this is a private variable for this class that is not visible outside
    // (also, iOS handles memory and access management of these faster than properties)
    CMMotionActivityManager *_motionActivityManager;
}

// initialization method, you can do other stuff here too
- (instancetype)init {
    self = [super init];
    if (self) {
        // check to see if the device can handle motion activity
        if ([CMMotionActivityManager isActivityAvailable]) {
            // if so, initialize the activity manager
            _motionActivityManager = [[CMMotionActivityManager alloc] init];
        }
    }
    return self;
}

- (void)startMotionActivityMonitoring {
    // create the motion activity handler
    CMMotionActivityHandler motionActivityHandler = ^(CMMotionActivity *activity) {
        if(activity.automotive) {
            [[(AppDelegate*)[[UIApplication sharedApplication] delegate] locationMgr] stopMonitoringSignificantLocationChanges];
        }
        else {
            [[(AppDelegate*)[[UIApplication sharedApplication] delegate] locationMgr] startMonitoringSignificantLocationChanges];
        }
    };
    
    // check to see if the motion activity manager exists
    if (_motionActivityManager) {
        // if so, start monitoring activity
        // notice that we add updates to the mainQueue. This will call your handler on the main thread
        [_motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:motionActivityHandler];
    }
}

@end

@interface ViewController () {
    GMSMapView *_mapView_;
    BOOL firstLocationUpdate_;
    bool add;
    UIImageView *image;
    UIButton *respondButton;
    UIButton *xButton;
    UIButton *reportButton;
    UIButton *leaderboard;
    UIButton *leadbut;
    UIButton *tome;
    UIButton *camerabut;
    UIButton *infobut;
    UIButton *groupGame;
    UIButton *markershow;
    bool isResponding;
    GMSMarker *staticMarker;
    NSNumber *staticCount;
    UILabel *myMatches;
    NSNumber *matched;
    NSString *staticObjectId;
    NSString *newtitle;
    UIView *menu;
    UIView *statusback;
    PFObject *deleteObjectId;
    NSString *letters;
    NSString* r;
    UIAlertController *deviceNotFoundAlertController;
    UIAlertAction *deviceNotFoundAlert;
    UIImagePickerController *picker;
    NSUserDefaults *userdefaults;
    NSArray* placesObjects;
    UILabel *notclose;
    int gotahit;
    Tutorial *first;
    RespTutorial *resptute;
    UILabel *tute;
    InvisibleButtonView *invisible;
    GroupController *groupcontroller;
    NSString *deleteObjectIdForGroup;
    InvitedView* invitedView;
}

@end

@implementation ViewController {}

- (void)acceptInvite {
    [userdefaults setValue:[userdefaults objectForKey:@"idbyuser"] forKey:@"idbyusertemp"];
    [userdefaults setValue:[(AppDelegate*)[[UIApplication sharedApplication] delegate] getIdbyusy] forKey:@"idbyuser"];
    [userdefaults synchronize];
    [[self.view viewWithTag:68] removeFromSuperview];
    //[userdefaults setObject:[(AppDelegate*)[[UIApplication sharedApplication] delegate] getInvitedBy] forKey:@"idbyuser"];
    NSLog(@"IN ACCEPT INVITE*****");
}

/*- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.leftgroup addObserver:self forKeyPath:@"leftgroup" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    //[self.invitedIsSetHid addObserver:self forKeyPath:@"invitedis" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}*/

/*- (void)setInvited:(InvitedView*)invite {
    invitedView = invite;
}*/

- (void)declineInvite {
    
    if([[userdefaults valueForKey:@"idbyusertemp"] length] != 0) {
        NSLog(@"inside != 0 ---_D__D_D_D_D_D_D_D_D_D_Dddddd");
        [userdefaults setValue:[userdefaults objectForKey:@"idbyusertemp"] forKey:@"idbyuser"];
        NSLog(@"%@ uiserfdkd defaults idyuser;jkd *******88888 lets go!", [userdefaults valueForKey:@"idbyuser"]);
    }
    else {
        NSLog(@"inside ELSE IIEEKEKE ---_D__D_D_D_D_D_D_D_D_D_Dddddd");
        [userdefaults setObject:nil forKey:@"idbyuser"];
    }
    
    [userdefaults synchronize];

    [[self.view viewWithTag:68] removeFromSuperview];
    
    NSLog(@"IN ACCEPT DECLINE*****");
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    //ADD WALKING DETECTION MAYBE
    /*MotionHandler* motion = [[MotionHandler alloc] init];
    [motion startMotionActivityMonitoring];*/
    
    __aFlag = NO;
    __aFlagForHid = NO;
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkForReceivedNote:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];*/
    
    [userdefaults setValue:nil forKey:@"idbyusertemp"];
    [userdefaults synchronize];
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.36
                                                            longitude:-71.06
                                                                 zoom:8];
    _mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView_.settings.compassButton = NO;
    _mapView_.settings.indoorPicker = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        _mapView_.myLocationEnabled = YES;
    });
    
    [_mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = _mapView_;
    
    _mapView_.delegate = self;
    
    [self centerloc];
    
    
    
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    
    [userdefaults setObject:@"old" forKey:@"new"];
    [userdefaults synchronize];
    
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===
    //remove**************//*****//------===


    
    [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:@"user"];
    [[PFInstallation currentInstallation] saveEventually];
    
    groupcontroller = [[GroupController alloc] init];
    groupcontroller.myViewController = self;
    
    first = [[Tutorial alloc] init];
    first.myViewController = self;
    first.tag = 99;
    
    if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
        if([screenWidth intValue] == 320) {
            first = [[Tutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
            resptute = [[RespTutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        }
        if([screenWidth intValue] == 375) {
            first = [[Tutorial alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
            resptute = [[RespTutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];

        }
        if([screenWidth intValue] == 414) {
            first = [[Tutorial alloc] initWithFrame:CGRectMake(0, 0, 414, 737)];
            resptute = [[RespTutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        }
        if([screenWidth intValue] == 768) {
            first = [[Tutorial alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
            resptute = [[RespTutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        }
        if([screenWidth intValue] == 1024) {
            first = [[Tutorial alloc] initWithFrame:CGRectMake(0, 0, 1024, 1366)];
            resptute = [[RespTutorial alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        }
        
        first.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.4f];
        resptute.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.4f];
        
        [self.view addSubview:first];
        [self.view addSubview:resptute];
        [resptute setHidden:YES];
    }
    else {
        if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
            PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    [userdefaults setValue:@"allpix" forKey:@"groupbuttonaction"];
                    //[groupGame setHidden:NO];
                    //[markershow setHidden:YES];
                    for (PFObject *object in objects) {
                        PFGeoPoint *point = [object objectForKey:@"location"];
                        
                        GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
                        initMarker.title = [object valueForKey:@"title"];
                        initMarker.appearAnimation = kGMSMarkerAnimationPop;
                        initMarker.icon = [UIImage imageNamed:@"marker"];
                        initMarker.userData = @{@"marker_id":[object objectForKey:@"marker_id"]};
                        initMarker.map = _mapView_;
                        
                        /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(point.latitude, point.longitude);
                        MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                        [self registerRegionWithCircularOverlay:circ andIdentifier:[object objectForKey:@"marker_id"]];*/
                    }
                }else{
                    NSLog(@"%@", [error description]);
                }
            }];
        }
        else {
            PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
            [query2 whereKey:@"idbyuser" equalTo:[userdefaults objectForKey:@"idbyuser"]];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    //[groupGame setHidden:YES];
                    //[markershow setHidden:NO];
                    // The find succeeded.
                    [userdefaults setValue:@"groupg" forKey:@"groupbuttonaction"];
                    NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                    // Do something with the found objects
                    for (PFObject *object in objects) {
                        NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                        NSLog(@"%@", [yy description]);
                        
                        NSArray *keyArray = [yy allKeys];
                        
                        for(NSString *keyd in keyArray) {
                            if(![keyd isEqualToString:@""]) {
                                NSMutableArray *locs;
                                if([yy valueForKey:keyd] == (id)[NSNull null]) {
                                    //
                                }
                                else {
                                    locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                }
                                for(NSDictionary *outterar in locs) {
                                    //if(!([outterar valueForKey:@"hideit"] == [NSNumber numberWithInt:1])) {
                                        PFGeoPoint *here = [outterar objectForKey:@"pointdat"];
                                        GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(here.latitude, here.longitude)];
                                        initMarker.title = keyd;
                                        initMarker.appearAnimation = kGMSMarkerAnimationPop;
                                        initMarker.icon = [UIImage imageNamed:@"marker"];
                                        initMarker.userData = @{@"marker_id":[outterar objectForKey:@"marker_id"]};
                                        initMarker.map = _mapView_;
                                        
                                        /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(here.latitude, here.longitude);
                                        MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                        [self registerRegionWithCircularOverlay:circ andIdentifier:[outterar objectForKey:@"marker_id"]];*/
                                    /*}
                                    else {
                                        NSUInteger ind = [locs indexOfObject:outterar];
                                        [locs removeObjectAtIndex:ind];
                                        //[outterar setValue:[NSNumber numberWithInt:1] forKey:@"hideit"];
                                        [yy setObject:locs forKey:keyd];
                                        [object setObject:yy forKey:@"usersAndPoints"];
                                        [object saveEventually];
                                    }*/
                                }
                            }
                        }
                    }
                } else {
                    // Log details of the failu
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        
        /*CLLocationCoordinate2D circleCenter = _mapView_.myLocation.coordinate;
        CLCircularRegion *geoRegion = [[CLCircularRegion alloc]
                                       initWithCenter:circleCenter
                                       radius:91.44
                                       identifier:@"uniqueid"];
        
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] requestStateForRegion:geoRegion];*/
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    deviceNotFoundAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    letters  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    
    tute = [[UILabel alloc] init];
    
    notclose = [[UILabel alloc] init];
    notclose.textAlignment = NSTextAlignmentCenter;
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 5.0f;
    style.headIndent = 5.0f;
    style.tailIndent = -5.0f;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"MY MATCHES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}];
    
    if([screenWidth intValue] == 320) {
        //invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(50, 244, 220, 120)];
        invisible = [[InvisibleButtonView alloc] initWithFrame:CGRectMake(0, 538, 80, 30)];
        tute.frame = CGRectMake(20, 90, 280, 120);
        image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 300, 426)];
        image.layer.cornerRadius = 10.0;
        respondButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 466, 300, 92)];
        respondButton.layer.cornerRadius = 10.0;
        respondButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(222, 23, 60, 25)];
        reportButton.layer.cornerRadius = 2.0;
        reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
        xButton = [[UIButton alloc] initWithFrame:CGRectMake(292, 23, 25, 25)];
        infobut = [[UIButton alloc] initWithFrame:CGRectMake(283, 531, 25, 25)];
        menu = [[UIView alloc] initWithFrame:CGRectMake(58.75, 494, 202.5, 54)];
        leadbut = [[UIButton alloc] initWithFrame:CGRectMake(19, 7, 39.5, 39.5)];
        leadbut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leadbut"]];
        tome = [[UIButton alloc] initWithFrame:CGRectMake(144, 7, 39.5, 39.5)];
        tome.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tome"]];
        myMatches = [[UILabel alloc] initWithFrame:CGRectMake(67.5, 40, 185, 30)];
        myMatches.layer.cornerRadius = 3.0f;
        _matchesNumber = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 60, 20)];
        _matchesNumber.layer.cornerRadius = 3.0f;
        [_matchesNumber setFont:[UIFont systemFontOfSize:16]];
        statusback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        [notclose setFrame:CGRectMake(10, 466, 300, 92)];
        notclose.layer.cornerRadius = 10.0;
        [notclose setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
        camerabut = [[UIButton alloc] initWithFrame:CGRectMake(79.75, 5.5, 43, 43)];
        camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
        groupGame = [[UIButton alloc] initWithFrame:CGRectMake(270.5, 32, 37.5, 37.5)];
        groupGame.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:8.0];
        [[groupGame layer] setBorderWidth:1.0f];
        markershow = [[UIButton alloc] initWithFrame:CGRectMake(12, 32, 37.5, 37.5)];
        markershow.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9.0];
    }
    if([screenWidth intValue] == 375) {
        //invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(100, 288.5, 175, 100)];
        invisible = [[InvisibleButtonView alloc] initWithFrame:CGRectMake(0, 637, 80, 30)];
        tute.frame = CGRectMake(23, 105, 328, 141);
        image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 355, 500)];
        image.layer.cornerRadius = 10.0;
        respondButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 547, 355, 92)];
        respondButton.layer.cornerRadius = 10.0;
        respondButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(276, 23, 60, 25)];
        reportButton.layer.cornerRadius = 2.0;
        reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
        xButton = [[UIButton alloc] initWithFrame:CGRectMake(346, 23, 25, 25)];
        infobut = [[UIButton alloc] initWithFrame:CGRectMake(338, 630, 25, 25)];
        menu = [[UIView alloc] initWithFrame:CGRectMake(86.25, 593, 202.5, 54)];
        leadbut = [[UIButton alloc] initWithFrame:CGRectMake(19, 7, 39.5, 39.5)];
        leadbut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leadbut"]];
        tome = [[UIButton alloc] initWithFrame:CGRectMake(144, 7, 39.5, 39.5)];
        tome.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tome"]];
        myMatches = [[UILabel alloc] initWithFrame:CGRectMake(95, 40, 185, 30)];
        myMatches.layer.cornerRadius = 3.0f;
        _matchesNumber = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 60, 20)];
        _matchesNumber.layer.cornerRadius = 3.0f;
        [_matchesNumber setFont:[UIFont systemFontOfSize:16]];
        statusback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 20)];
        camerabut = [[UIButton alloc] initWithFrame:CGRectMake(79.75, 5.5, 43, 43)];
        camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
        [notclose setFrame:CGRectMake(10, 547, 355, 92)];
        notclose.layer.cornerRadius = 10.0;
        [notclose setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
        groupGame = [[UIButton alloc] initWithFrame:CGRectMake(325.5, 32, 37.5, 37.5)];
        groupGame.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:8.0];
        [[groupGame layer] setBorderWidth:1.0f];
        markershow = [[UIButton alloc] initWithFrame:CGRectMake(12, 32, 37.5, 37.5)];
        markershow.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9.0];

    }
    if([screenWidth intValue] == 414) {
        //invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(100, 318, 214, 100)];
        invisible = [[InvisibleButtonView alloc] initWithFrame:CGRectMake(0, 706, 80, 30)];
        tute.frame = CGRectMake(26, 116, 362, 155.5);
        image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 394, 544)];
        image.layer.cornerRadius = 10.0;
        respondButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 584, 392, 142)];
        respondButton.layer.cornerRadius = 10.0;
        respondButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(310, 22, 60, 33.5)];
        reportButton.layer.cornerRadius = 2.0;
        reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
        xButton = [[UIButton alloc] initWithFrame:CGRectMake(378, 22, 33.5, 33.5)];
        infobut = [[UIButton alloc] initWithFrame:CGRectMake(371, 693, 33.5, 33.5)];
        menu = [[UIView alloc] initWithFrame:CGRectMake(104, 654, 205, 73)];
        leadbut = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 53, 53)];
        leadbut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leadbut"]];
        tome = [[UIButton alloc] initWithFrame:CGRectMake(142, 10, 53, 53)];
        tome.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tome"]];
        myMatches = [[UILabel alloc] initWithFrame:CGRectMake(105, 44, 204, 33)];
        myMatches.layer.cornerRadius = 3.0f;
        _matchesNumber = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, 77, 20)];
        _matchesNumber.layer.cornerRadius = 3.0f;
        [_matchesNumber setFont:[UIFont systemFontOfSize:16]];
        statusback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 20)];
        camerabut = [[UIButton alloc] initWithFrame:CGRectMake(71.5, 5.5, 62, 62)];
        camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
        [notclose setFrame:CGRectMake(10, 584, 392, 142)];
        notclose.layer.cornerRadius = 10.0;
        [notclose setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
        groupGame = [[UIButton alloc] initWithFrame:CGRectMake(364.5, 32, 37.5, 37.5)];
        groupGame.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:8.0];
        [[groupGame layer] setBorderWidth:1.0f];
        markershow = [[UIButton alloc] initWithFrame:CGRectMake(12, 32, 37.5, 37.5)];
        markershow.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9.0];
    }
    if([screenWidth intValue] == 768) {
        //invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(150, 462, 468, 200)];
        invisible = [[InvisibleButtonView alloc] initWithFrame:CGRectMake(0, 994, 80, 30)];
        tute.frame = CGRectMake(48, 161, 671.7, 216.4);
        image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 46, 727, 768)];
        image.layer.cornerRadius = 7.5;
        respondButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 840, 727, 141)];
        respondButton.layer.cornerRadius = 7.5;
        respondButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(664.5, 35, 60, 25)];
        reportButton.layer.cornerRadius = 2.0;
        reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
        xButton = [[UIButton alloc] initWithFrame:CGRectMake(734.5, 35, 25, 25)];
        infobut = [[UIButton alloc] initWithFrame:CGRectMake(731, 987, 25, 25)];
        menu = [[UIView alloc] initWithFrame:CGRectMake(177, 873, 415, 111)];
        leadbut = [[UIButton alloc] initWithFrame:CGRectMake(30, 15, 82, 82)];
        leadbut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leadbutipadp"]];
        tome = [[UIButton alloc] initWithFrame:CGRectMake(303, 15, 82, 82)];
        tome.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tomeipadp"]];
        camerabut = [[UIButton alloc] initWithFrame:CGRectMake(163.5, 11.5, 88, 88)];
        camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabutipadp"]];
        myMatches = [[UILabel alloc] initWithFrame:CGRectMake(195, 61, 379, 51)];
        myMatches.layer.cornerRadius = 5.5f;
        attrText = [[NSAttributedString alloc] initWithString:@"MY MATCHES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0]}];
        _matchesNumber = [[UILabel alloc] initWithFrame:CGRectMake(229, 6, 144.5, 39)];
        _matchesNumber.layer.cornerRadius = 3.0f;
        [_matchesNumber setFont:[UIFont systemFontOfSize:32]];
        statusback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 20)];
        [notclose setFrame:CGRectMake(20, 840, 727, 141)];
        notclose.layer.cornerRadius = 7.5;
        [notclose setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];
        groupGame = [[UIButton alloc] initWithFrame:CGRectMake(669, 44, 75, 75)];
        groupGame.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        [[groupGame layer] setBorderWidth:2.0f];
        markershow = [[UIButton alloc] initWithFrame:CGRectMake(24, 44, 75, 75)];
        markershow.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
    }
    if([screenWidth intValue] == 1024) {
        //invitedView = [[InvitedView alloc] initWithFrame:CGRectMake(250, 1241, 524, 250)];
        invisible = [[InvisibleButtonView alloc] initWithFrame:CGRectMake(0, 1336, 80, 30)];
        tute.frame = CGRectMake(64, 215, 895.6, 288.7);
        image = [[UIImageView alloc] initWithFrame:CGRectMake(27, 60, 969, 1009)];
        image.layer.cornerRadius = 5.0;
        respondButton = [[UIButton alloc] initWithFrame:CGRectMake(27, 1096, 969, 230)];
        respondButton.layer.cornerRadius = 5.0;
        respondButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0];
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(913.5, 47, 60, 25)];
        reportButton.layer.cornerRadius = 2.0;
        reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
        xButton = [[UIButton alloc] initWithFrame:CGRectMake(983.5, 47, 25, 25)];
        infobut = [[UIButton alloc] initWithFrame:CGRectMake(987, 1329, 25, 25)];
        menu = [[UIView alloc] initWithFrame:CGRectMake(235.5, 1214, 553, 110.5)];
        leadbut = [[UIButton alloc] initWithFrame:CGRectMake(52, 14, 82, 82)];
        leadbut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leadbutipadp"]];
        tome = [[UIButton alloc] initWithFrame:CGRectMake(419, 14, 82, 82)];
        tome.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tomeipadp"]];
        camerabut = [[UIButton alloc] initWithFrame:CGRectMake(232.5, 11, 88, 88)];
        camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabutipadp"]];
        myMatches = [[UILabel alloc] initWithFrame:CGRectMake(300, 109, 425, 60)];
        myMatches.layer.cornerRadius = 8.0f;
        attrText = [[NSAttributedString alloc] initWithString:@"MY MATCHES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0]}];
        _matchesNumber = [[UILabel alloc] initWithFrame:CGRectMake(228, 10, 189, 41)];
        _matchesNumber.layer.cornerRadius = 8.0f;
        [_matchesNumber setFont:[UIFont systemFontOfSize:32]];
        statusback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 20)];
        [notclose setFrame:CGRectMake(27, 1096, 969, 230)];
        notclose.layer.cornerRadius = 5.0;
        [notclose setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]];
        groupGame = [[UIButton alloc] initWithFrame:CGRectMake(875.5, 56, 112.5, 112.5)];
        groupGame.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        [[groupGame layer] setBorderWidth:3.0f];
        markershow = [[UIButton alloc] initWithFrame:CGRectMake(36, 56, 112.5, 112.5)];
        markershow.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0];
    }
    
    [self.view addSubview:invisible];
    
    markershow.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [markershow setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [markershow addTarget:self action:@selector(showallmarkers) forControlEvents:UIControlEventTouchUpInside];
    [markershow setTitle:@"ALL\nPIX" forState:UIControlStateNormal];
    markershow.layer.masksToBounds = true;
    markershow.layer.cornerRadius = 5.0;
    [[markershow layer] setBorderWidth:1.0f];
    [[markershow layer] setBorderColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f].CGColor];
    markershow.titleLabel.textAlignment = NSTextAlignmentCenter;
    markershow.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:markershow];
    
    groupGame.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [groupGame setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [groupGame addTarget:self action:@selector(group) forControlEvents:UIControlEventTouchUpInside];
    [groupGame setTitle:@"GROUP\nGAME" forState:UIControlStateNormal];
    groupGame.layer.masksToBounds = true;
    groupGame.layer.cornerRadius = 5.0;
    
    [[groupGame layer] setBorderColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f].CGColor];
    groupGame.titleLabel.textAlignment = NSTextAlignmentCenter;
    groupGame.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:groupGame];
    
    tute.text = @"TAP THE MARKER, THEN TAP THE INFO WINDOW POPUP";
    tute.numberOfLines = 0;
    tute.textAlignment = NSTextAlignmentCenter;
    [tute setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
    tute.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [tute setHidden:YES];
    [self.view addSubview:tute];
    
    [image setHidden:YES];
    image.layer.masksToBounds = true;
    [self.view addSubview:image];
    
    respondButton.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [respondButton setTitle:@"MATCH IT" forState:UIControlStateNormal];
    [respondButton setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [respondButton addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [respondButton setHidden:YES];
    respondButton.layer.masksToBounds = true;
    [self.view addSubview:respondButton];
    
    reportButton.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:1.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
    [reportButton setTitle:@"REPORT" forState:UIControlStateNormal];
    [reportButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];
    [reportButton setHidden:YES];
    reportButton.layer.masksToBounds = true;
    [self.view addSubview:reportButton];
    
    xButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xbutton"]];
    [xButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [xButton setHidden:YES];
    [self.view addSubview:xButton];
    
    infobut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"info"]];
    [infobut addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infobut];
    
    menu.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:0.9f];
    menu.layer.masksToBounds = true;
    menu.layer.cornerRadius = 10.0;
    [self.view addSubview:menu];
    
    
    [leadbut addTarget:self action:@selector(leaderboardOpen) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:leadbut];
    
    [tome addTarget:self action:@selector(centerloc) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:tome];
    
    [camerabut addTarget:self action:@selector(dropSneek) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:camerabut];
    
    myMatches.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:0.9f];
    myMatches.numberOfLines = 0;
    myMatches.layer.masksToBounds = true;
    myMatches.attributedText = attrText;
    [self.view addSubview:myMatches];
    
    _matchesNumber.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    _matchesNumber.textAlignment = NSTextAlignmentCenter;
    _matchesNumber.textColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    _matchesNumber.layer.masksToBounds = true;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController = picker;
    }
    
    NSUInteger matches;

    if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
        matches = [userdefaults integerForKey:@"matches"];
    }
    else {
        matches = [userdefaults integerForKey:@"groupmatches"];
    }
    
    _matchesNumber.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)matches];
    [myMatches addSubview:_matchesNumber];
    
    statusback.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [self.view addSubview:statusback];
    
    notclose.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [notclose setText:@"YOU NEED TO BE WITHIN 300 FEET"];
    notclose.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [notclose setHidden:YES];
    notclose.layer.masksToBounds = true;
    [self.view addSubview:notclose];
    
    if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
        [self.view bringSubviewToFront:first];
    }
}

/*- (BOOL)registerRegionWithCircularOverlay:(MKCircle*)overlay andIdentifier:(NSString*)identifier {
    
    NSLog(@"in ****** registerregion ******* !!!!!!");
    // Check the authorization status
    if (([CLLocationManager authorizationStatus] != UNAuthorizationStatusAuthorized) &&
        ([CLLocationManager authorizationStatus] != UNAuthorizationStatusNotDetermined))
            [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] requestAlwaysAuthorization];
    
    // Clear out any old regions to prevent buildup.
    if ([[[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr]  monitoredRegions] count] > 0) {
        for (id obj in [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr]  monitoredRegions]) {
            
            [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] stopMonitoringForRegion:obj];
        }
    }
    
    // If the overlay's radius is too large, registration fails automatically,
    // so clamp the radius to the max value.
    CLLocationDistance radius = overlay.radius;
    if (radius > [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] maximumRegionMonitoringDistance]) {
        radius = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] maximumRegionMonitoringDistance];
    }
    
    // Create the geographic region to be monitored.
    CLCircularRegion *geoRegion = [[CLCircularRegion alloc]
                                   initWithCenter:overlay.coordinate
                                   radius:radius
                                   identifier:identifier];
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] locationMgr] startMonitoringForRegion:geoRegion];
    
    return YES;
}*/

/*- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
    
    NSLog(@"did enter region in view controller*************");
    
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

- (void)group {
    
    if(![userdefaults valueForKey:@"lastidbyuser"]) {
        //if(![[userdefaults valueForKey:@"groupbuttonaction"] isEqualToString:@"allpix"]) {
            [self presentViewController:groupcontroller animated:YES completion:nil];
        }
        else {
            //[userdefaults setObject:[userdefaults objectForKey:@"idbyuser"] forKey:@"lastidbyuser"];
            //[groupGame setHidden:YES];
            //[markershow setHidden:NO];
            [_mapView_ clear];
            [userdefaults setObject:[userdefaults objectForKey:@"lastidbyuser"] forKey:@"idbyuser"];
            [userdefaults setObject:NULL forKey:@"lastidbyuser"];
            [userdefaults synchronize];
            
            NSUInteger matches;
            matches = [userdefaults integerForKey:@"groupmatches"];
            _matchesNumber.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)matches];
            
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
                        
                        [yy removeObjectForKey:@""];
                        
                        NSArray *keyArray = [yy allKeys];
                        
                        for(NSString *keyd in keyArray) {
                            NSMutableArray *locs;
                            if([yy objectForKey:keyd] != (id)[NSNull null]) {
                                locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                            }
                            else {
                                locs = [[NSMutableArray alloc] init];
                            }
                            for(NSDictionary *outterar in locs) {
                                NSLog(@"hide it ***(*((**(*( %@", [outterar valueForKey:@"hideit"]);
                                //if(!([outterar valueForKey:@"hideit"] == [NSNumber numberWithInt:1])) {
                                PFGeoPoint *here = [outterar objectForKey:@"pointdat"];
                                GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(here.latitude, here.longitude)];
                                initMarker.title = keyd;
                                initMarker.appearAnimation = kGMSMarkerAnimationPop;
                                initMarker.icon = [UIImage imageNamed:@"marker"];
                                initMarker.userData = @{@"marker_id":[outterar objectForKey:@"marker_id"]};
                                initMarker.map = _mapView_;
                                
                                /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(here.latitude, here.longitude);
                                 MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                 [self registerRegionWithCircularOverlay:circ andIdentifier:[outterar objectForKey:@"marker_id"]];*/
                                //}
                                /*else {
                                 NSUInteger ind = [locs indexOfObject:outterar];
                                 [locs removeObjectAtIndex:ind];
                                 //[outterar setValue:[NSNumber numberWithInt:1] forKey:@"hideit"];
                                 [yy setObject:locs forKey:keyd];
                                 [object setObject:yy forKey:@"usersAndPoints"];
                                 [object saveEventually];
                                 }*/
                            }
                        }
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        //}
    }
    /*else {
        [self presentViewController:groupcontroller animated:YES completion:nil];
    }*/
    
    [userdefaults setValue:@"groupg" forKey:@"groupbuttonaction"];
}

- (void)showallmarkers {
    //[groupGame setHidden:NO];
    //[markershow setHidden:YES];
    [userdefaults setValue:@"allpix" forKey:@"groupbuttonaction"];
    [userdefaults setObject:[userdefaults objectForKey:@"idbyuser"] forKey:@"lastidbyuser"];
    [userdefaults setObject:nil forKey:@"idbyuser"];
    [userdefaults synchronize];
    
    NSUInteger matches;
    matches = [userdefaults integerForKey:@"matches"];
    _matchesNumber.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)matches];
    
    [_mapView_ clear];
    
    PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                PFGeoPoint *point = [object objectForKey:@"location"];
                
                GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
                initMarker.title = [object valueForKey:@"title"];
                initMarker.appearAnimation = kGMSMarkerAnimationPop;
                initMarker.icon = [UIImage imageNamed:@"marker"];
                initMarker.userData = @{@"marker_id":[object objectForKey:@"marker_id"]};
                initMarker.map = _mapView_;
                
                /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(point.latitude, point.longitude);
                MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                [self registerRegionWithCircularOverlay:circ andIdentifier:[object objectForKey:@"marker_id"]];*/
            }
        }else{
            NSLog(@"%@", [error description]);
        }
    }];
    
}

- (void)leaderboardOpen {
    [self presentViewController:[[LeaderboardController alloc] init] animated:YES completion:nil];
}

- (void)centerloc {
    CLLocation *location = _mapView_.myLocation;
    if (location) {
        [_mapView_ animateToLocation:location.coordinate];
    }
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [_matchesNumber setHidden:YES];
        [myMatches setHidden:YES];
        [menu setHidden:YES];
        [tute setHidden:YES];
        [infobut setHidden:YES];
    });
    
    gotahit = 0;
    
    staticMarker = marker;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude];
    
    if(![userdefaults objectForKey:@"idbyuser"]) {

        PFQuery *querygeo = [PFQuery queryWithClassName:@"MapPoints"];
        [querygeo whereKey:@"location" nearGeoPoint:userGeoPoint withinMiles:0.05681818];
        querygeo.limit = 10;
        
        [querygeo findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            for(PFGeoPoint* object in objects) {
                
                PFGeoPoint *storin = [object valueForKey:@"location"];
                
                if(fabs((float)storin.latitude - (float)marker.position.latitude) <= 0.0001 && fabs((float)storin.longitude - (float)marker.position.longitude) <= 0.0001) {
                    
                    gotahit = 1;
                    
                    PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            for (PFObject *object in objects) {
                                deleteObjectId = object;
                                
                                if([[object valueForKey:@"title"] isEqualToString:marker.title] && [[[NSString alloc] initWithFormat:@"%@", [marker.userData objectForKey:@"marker_id"]] isEqualToString:[[NSString alloc] initWithFormat:@"%@", [object objectForKey:@"marker_id"]]]) {
                                    
                                    staticObjectId = [object valueForKey:@"marker_id"];
                                    staticCount = [object valueForKey:@"count"];
                                    
                                    PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                        if (!error) {
                                            for (PFObject *object in objects) {
                                                if([[object valueForKey:@"marker_id"] isEqualToString:staticObjectId]) {
                                                    newtitle = [object valueForKey:@"title"];
                                                }
                                            }
                                        }else{
                                            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:[[NSString alloc] initWithString: [error description]] preferredStyle:UIAlertControllerStyleAlert];
                                            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                        }
                                    }];
                                    
                                    _manager = [AFHTTPSessionManager manager];
                                    _manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
                                    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                                    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
                                    
                                    NSString *usernameEncoded = marker.title;
                                    
                                    NSDictionary *params = @{@"username": usernameEncoded, @"count": [object valueForKey:@"count"]};
                                    
                                    [indicator startAnimating];
                                    
                                    [_manager POST:@"http://www.eamondev.com/sneekback/getimage.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        
                                        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"image"] options:0];
                                        image.image = [UIImage imageWithData:decodedData scale:300/2448];
                                        dispatch_async(dispatch_get_main_queue(), ^(void){
                                            [image setHidden:NO];
                                            [respondButton setHidden:NO];
                                            [xButton setHidden:NO];
                                            [infobut setHidden:YES];
                                            [reportButton setHidden:NO];
                                        });
                                        
                                        if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                                
                                                [resptute setHidden:NO];
                                                [self.view bringSubviewToFront:resptute];
                                                
                                            });
                                        }
                                        
                                        [indicator stopAnimating];
                                        
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        
                                        NSLog(@"%@ ******** pointy2", [error description]);

                                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"HMMM" message:@"Maybe your connection is bad" preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                        
                                        [indicator stopAnimating];
                                    }];
                                }
                            }
                        }
                        else {
                            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:[[NSString alloc] initWithString: [error description]] preferredStyle:UIAlertControllerStyleAlert];
                            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                        }
                    }];
                }
            }
            
            if(gotahit == 0) {
                
                PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        for (PFObject *object in objects) {
                            deleteObjectId = object;
                            
                            if([[object valueForKey:@"title"] isEqualToString:marker.title] && [[[NSString alloc] initWithFormat:@"%@", [marker.userData objectForKey:@"marker_id"]] isEqualToString:[[NSString alloc] initWithFormat:@"%@", [object objectForKey:@"marker_id"]]]) {
                                
                                staticObjectId = [object valueForKey:@"marker_id"];
                                staticCount = [object valueForKey:@"count"];
                                
                                PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                    if (!error) {
                                        for (PFObject *object in objects) {
                                            if([[object valueForKey:@"marker_id"] isEqualToString:staticObjectId]) {
                                                newtitle = [object valueForKey:@"title"];
                                            }
                                        }
                                        
                                    }else{
                                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                    }
                                }];
                                
                                _manager = [AFHTTPSessionManager manager];
                                _manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
                                _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                                _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
                                
                                NSString *usernameEncoded = marker.title;
                                
                                NSDictionary *params = @{@"username": usernameEncoded, @"count": [object valueForKey:@"count"]};
                                
                                [indicator startAnimating];
                                
                                [_manager POST:@"http://www.eamondev.com/sneekback/getimage.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    
                                    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"image"] options:0];
                                    image.image = [UIImage imageWithData:decodedData scale:300/2448];
                                    dispatch_async(dispatch_get_main_queue(), ^(void){
                                        [image setHidden:NO];
                                        [respondButton setHidden:YES];
                                        [notclose setHidden:NO];
                                        [xButton setHidden:NO];
                                        [infobut setHidden:YES];
                                        [reportButton setHidden:NO];
                                    });
                                    
                                    if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                                        dispatch_async(dispatch_get_main_queue(), ^(void){
                                            [resptute setHidden:NO];
                                        });
                                    }
                                    
                                    [indicator stopAnimating];
                                    
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                    NSLog(@"%@ ******** pointy3", [error description]);

                                    deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"HMMM" message:@"Maybe your connection is bad" preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                    
                                    [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                    [indicator stopAnimating];
                                }];
                            }
                        }
                    }
                    else{
                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:[[NSString alloc] initWithString:[error description]] preferredStyle:UIAlertControllerStyleAlert];
                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                    }
                }];
            }
        }];
    }
    else {
        NSLog(@"got into else************");
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude];
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
        [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                    NSLog(@"%@ yy descrip *****", [yy description]);
                    
                    if ([[yy allKeys] containsObject:@""]) {
                        [yy removeObjectForKey:@""];
                    }
                    
                    NSArray *keyArray = [yy allKeys];
                    
                    for(NSString *keyd in keyArray) {
                        NSLog(@"keyd222222: %@    yyobjectforkey22222: %@", keyd, [yy objectForKey:keyd]);
                        NSMutableArray *locs;
                        if([yy valueForKey:keyd] == (id)[NSNull null]) {
                            locs = [[NSMutableArray alloc] init];
                        }
                        else {
                            locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                        }

                        for(NSDictionary *outterar in locs) {
                            
                            PFGeoPoint *storin = [outterar objectForKey:@"pointdat"];
                            
                            if([storin distanceInMilesTo:userGeoPoint] <= 0.05681818) {
                                
                                if(fabs((float)storin.latitude - (float)marker.position.latitude) <= 0.0001 && fabs((float)storin.longitude - (float)marker.position.longitude) <= 0.0001) {
                                    
                                    NSLog(@"*********GOTAHIT = 1*************");
                                    
                                    gotahit = 1;
                                    
                                    deleteObjectIdForGroup = [outterar objectForKey:@"marker_id"];
                                    
                                    if( [[[NSString alloc] initWithFormat:@"%@", [marker.userData objectForKey:@"marker_id"]] isEqualToString:[[NSString alloc] initWithFormat:@"%@", [outterar objectForKey:@"marker_id"]]]) {
                                        
                                        staticObjectId = [outterar valueForKey:@"marker_id"];
                                        staticCount = [outterar valueForKey:@"count"];
                                        
                                        newtitle = (NSString*)keyd;
                                        
                                        _manager = [AFHTTPSessionManager manager];
                                        _manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
                                        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                                        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
                                        
                                        NSString *usernameEncoded = marker.title;
                                        
                                        NSLog(@"count count count beforE: %@", [outterar valueForKey:@"count"]);
                                        
                                        NSDictionary *params = @{@"username": usernameEncoded, @"count": [outterar valueForKey:@"count"], @"idbyuser":[userdefaults objectForKey:@"idbyuser"]};
                                        
                                        [indicator startAnimating];
                                        
                                        [_manager POST:@"http://www.eamondev.com/sneekback/getimage.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            
                                            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"image"] options:0];
                                            image.image = [UIImage imageWithData:decodedData scale:300/2448];
                                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                                [image setHidden:NO];
                                                [respondButton setHidden:NO];
                                                [xButton setHidden:NO];
                                                [infobut setHidden:YES];
                                                [reportButton setHidden:NO];
                                                [notclose setHidden: YES]; /***ADDED PROBLEM MAYBE***/
                                            });
                                            
                                            if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                                                dispatch_async(dispatch_get_main_queue(), ^(void){
                                                    
                                                    [resptute setHidden:NO];
                                                    [self.view bringSubviewToFront:resptute];
                                                    
                                                });
                                            }
                                            
                                            [indicator stopAnimating];
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            NSLog(@"%@ ******** pointy", [error description]);
                                            
                                            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"HMMM" message:@"Maybe your connection is bad" preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                            
                                            [indicator stopAnimating];
                                        }];
                                    }
                                    else {
                                        NSLog(@"%@ error when tapping for group", [error description]);
                                        /*deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:[[NSString alloc] initWithString:[error description]] preferredStyle:UIAlertControllerStyleAlert];
                                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                         */
                                    }
                                }
                            }
                            else {
                            
                                NSLog(@"*********GOTAHIT = 0*************");
                                
                                PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
                                [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
                                [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                    if (!error) {
                                        // The find succeeded.
                                        NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                                        // Do something with the found objects
                                        for (PFObject *object in objects) {
                                            NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                                            NSLog(@"%@", [yy description]);
                                            
                                            if ([[yy allKeys] containsObject:@""]) {
                                                [yy removeObjectForKey:@""];
                                            }
                                            
                                            NSArray *keyArray = [yy allKeys];
                                            
                                            for(NSString *keyd in keyArray) {
                                                NSMutableArray *locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                                for(NSDictionary *outterar in locs) {
                                                    
                                                    deleteObjectIdForGroup = [outterar objectForKey:@"marker_id"];
                                                    
                                                    if([[outterar valueForKey:@"title"] isEqualToString:marker.title] && [[[NSString alloc] initWithFormat:@"%@", [marker.userData objectForKey:@"marker_id"]] isEqualToString:[[NSString alloc] initWithFormat:@"%@", [outterar objectForKey:@"marker_id"]]]) {
                                                        
                                                        staticObjectId = [outterar valueForKey:@"marker_id"];
                                                        staticCount = [outterar valueForKey:@"count"];
                                                        
                                                        //for (PFObject *object in outterar) {
                                                        //if([[outterar valueForKey:@"marker_id"] isEqualToString:staticObjectId]) {
                                                        newtitle = [outterar valueForKey:@"title"];
                                                        //}
                                                        //}
                                                        
                                                        _manager = [AFHTTPSessionManager manager];
                                                        _manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
                                                        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                                                        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
                                                        
                                                        NSString *usernameEncoded = marker.title;
                                                        
                                                        NSDictionary *params = @{@"username": usernameEncoded, @"count": [outterar valueForKey:@"count"]};
                                                        
                                                        [indicator startAnimating];
                                                        
                                                        [_manager POST:@"http://www.eamondev.com/sneekback/getimage.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                            
                                                            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"image"] options:0];
                                                            image.image = [UIImage imageWithData:decodedData scale:300/2448];
                                                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                [image setHidden:NO];
                                                                [respondButton setHidden:YES];
                                                                [notclose setHidden:NO];
                                                                [xButton setHidden:NO];
                                                                [infobut setHidden:YES];
                                                                [reportButton setHidden:NO];
                                                            });
                                                            
                                                            if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                                                                dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                    [resptute setHidden:NO];
                                                                });
                                                            }
                                                            
                                                            [indicator stopAnimating];
                                                            
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            
                                                            NSLog(@"%@ ******** pointy", [error description]);
                                                            
                                                            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"HMMM" message:@"Maybe your connection is bad" preferredStyle:UIAlertControllerStyleAlert];
                                                            
                                                            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                                            
                                                            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                                            [indicator stopAnimating];
                                                        }];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else{
                                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:[[NSString alloc] initWithString:[error description]] preferredStyle:UIAlertControllerStyleAlert];
                                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                    }
                                }];
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

- (void)dealloc {
    [_mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

/*- (BOOL)getInvitedIsSetHid {
    return _invitedIsSetHid;
}*/

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    /*if ([keyPath isEqual:@"leftgroup"]) {
        if([_leftgroup isEqualToString:@"left"]) {
            UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"REMOVED" message:@"You have left the group" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertCont addAction:alertAct];
            [self presentViewController:alertCont animated:YES completion:^{
                _leftgroup = @"here";
            }];
        }
        
        // The BOOL value of myBoolean changed, so do something here, like check
        // what the new BOOL value is, and then turn the indicator view on or off
    }
    if ([keyPath isEqual:@"invitedis"]) {
        NSLog(@"recieved!!!! ****** display VIEW CHOICE ***** \n");
        if(_invitedIsSetHid) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                [invitedView setHidden:YES];
                
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                [invitedView setHidden:NO];
                
            });
        }
        //[(AppDelegate*)[[UIApplication sharedApplication] delegate] setReceivedNotifToNo];
    }*/
    if(!firstLocationUpdate_) {
        
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        _mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
    
}

- (void)setAFlag:(BOOL)flag{
    BOOL valueChanged = NO;
    
    if(__aFlag != flag){
        valueChanged = YES;
    }
    __aFlag = flag;
    
    if(valueChanged)
        [self doSomethingWithTheNewValueOfFlag];
}

/*- (void)setAFlagForHid:(BOOL)flag{
    NSLog(@"INSIDE aflagforhid *****((***(*(*(*");
    BOOL valueChanged = NO;
    
    if(__aFlagForHid != flag){
        NSLog(@"that value changgggeed!!!(!(!(!(!(!(");
        valueChanged = YES;
    }
    
    __aFlagForHid = flag;
    
    if(valueChanged) {
        NSLog(@"value changed!!!!!!(((()@)(@OIOD");
        [self doSomethingWithTheNewValueOfFlagForHid];
    }
}*/

- (void)doSomethingWithTheNewValueOfFlag {
    UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"REMOVED" message:@"You have left the group" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertCont addAction:alertAct];
    [self presentViewController:alertCont animated:YES completion:NULL];
}

- (void)doSomethingWithTheNewValueOfFlagForHid {
    NSLog(@"issettingtheview******");
    dispatch_async(dispatch_get_main_queue(), ^(void){
        NSLog(@"issettingtheviewmu2******");
        [invitedView removeFromSuperview];
    });
}

- (void)close {
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [respondButton setHidden:YES];
        [xButton setHidden:YES];
        [infobut setHidden:NO];
        [reportButton setHidden:YES];
        [image setHidden:YES];
        [notclose setHidden:YES];
        [_matchesNumber setHidden:NO];
        [myMatches setHidden:NO];
        [menu setHidden:NO];
    });
}

- (void)openCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"NO DEVICE" message:@"Camera is not available" preferredStyle:UIAlertControllerStyleAlert];
        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        
        [tute removeFromSuperview];
    } else {
        isResponding = true;
        if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [resptute setHidden:YES];
            });
        }
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (void)report {
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    NSDictionary *parameters = @{@"markerid": [staticMarker.userData valueForKey:@"marker_id"], @"user": [userdefaults valueForKey:@"pfuser"]};
    [_manager POST:@"http://www.eamondev.com/sneekback/sendreport.php" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"REPORTED" message:@"Thank you, Pixovery has been notified." preferredStyle:UIAlertControllerStyleAlert];
            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
            
            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"SORRY" message:@"Sorry, something went wrong - try to report it again." preferredStyle:UIAlertControllerStyleAlert];
            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
            
            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        });
        
    }];
}

- (void)info {
    deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"CONTACT INFO" message:@"Website: http://eamondev.com\nE-mail: eamon@eamondev.com" preferredStyle:UIAlertControllerStyleAlert];
    [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
    
    [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
}

- (void)dropSneek {
    isResponding = false;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
        
        [first removeFromSuperview];
    }
    
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"NO DEVICE" message:@"Camera is not available" preferredStyle:UIAlertControllerStyleAlert];
        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        
    } else {
        [indicator startAnimating];
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{
            [indicator stopAnimating];
        }];
    }
}

-(NSString *)randomStringWithLength:(int)len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}



- (void)imagePickerController:(UIImagePickerController *)pickery didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    if(!isResponding) {
        
        [indicator startAnimating];
        
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage], nil, nil, nil);
        
        NSString * uploadURL = @"http://www.eamondev.com/sneekback/upload.php";
        NSLog(@"uploadImageURL: %@", uploadURL);
        NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.5);
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        
        NSString *usernameEncoded = [[userdefaults objectForKey:@"pfuser"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [pickery dismissViewControllerAnimated:YES completion:NULL];
        
        r = [[NSString alloc] initWithString:[self randomStringWithLength:8]];
        
        if(![userdefaults objectForKey:@"idbyuser"]) {
            PFQuery *quer = [PFQuery queryWithClassName:@"MapPoints"];
            [quer findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    for (PFObject *object in objects) {
                        while([r isEqualToString:[[NSString alloc] initWithFormat:@"%@", [object objectForKey:@"marker_id"]]]) {
                            r = [[NSString alloc] initWithString:[self randomStringWithLength:8]];
                        }
                    }
                }
                else {
                    deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                    [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                    [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                }
            }];
        }
        else {
            PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
            [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
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
                            NSMutableArray *locs;
                            if([yy valueForKey:keyd] == (id)[NSNull null]) {
                                //
                            }
                            else {
                                locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                            }
                            for(NSDictionary *outterar in locs) {
                                while([r isEqualToString:[[NSString alloc] initWithFormat:@"%@", [outterar objectForKey:@"marker_id"]]]) {
                                    r = [[NSString alloc] initWithString:[self randomStringWithLength:8]];
                                }
                            }
                        }
                    }
                }
                else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        
        NSDictionary *params = [[NSDictionary alloc] init];
        if(![userdefaults objectForKey:@"idbyuser"]) {
            params = @{@"username": usernameEncoded, @"count": [userdefaults valueForKey:@"count"]};
        }
        else {
            NSLog(@"groupcount: %@", [userdefaults valueForKey:@"groupcount"]);
            params = @{@"username": usernameEncoded, @"groupcount": [userdefaults valueForKey:@"groupcount"], @"idbyuser":[userdefaults objectForKey:@"idbyuser"]};
        }
        
        [_manager POST:@"http://www.eamondev.com/sneekback/upload.php" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSUInteger count;
            NSNumber *stored;
            if(![userdefaults objectForKey:@"idbyuser"]) {
                count = [userdefaults integerForKey:@"count"];
                stored = [NSNumber numberWithInteger:count];
                count++;
                [userdefaults setInteger:count forKey:@"count"];
            }
            else {
                count = [userdefaults integerForKey:@"groupcount"];
                stored = [NSNumber numberWithInteger:count];
                count++;
                [userdefaults setInteger:count forKey:@"groupcount"];
            }
            
            add = true;
            
            if(![userdefaults objectForKey:@"idbyuser"]) {

                PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        for (PFObject *object in objects) {
                            if(fabs((float)_mapView_.myLocation.coordinate.latitude - (float)[[object objectForKey:@"location"] latitude]) <= 0.0001 && fabs((float)_mapView_.myLocation.coordinate.longitude - (float)[[object objectForKey:@"location"] longitude]) <= 0.0001) {
                                
                                add = false;
                            }
                        }
                    }else{
                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                    }
                }];
            }
            else {
            
                PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
                [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
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
                                if([yy objectForKey:keyd] != (id)[NSNull null]) {
                                    NSMutableArray *locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                    for(NSDictionary *outterar in locs) {
                                        if(fabs((float)_mapView_.myLocation.coordinate.latitude - (float)[[outterar objectForKey:@"location"] latitude]) <= 0.0001 && fabs((float)_mapView_.myLocation.coordinate.longitude - (float)[[outterar objectForKey:@"location"] longitude]) <= 0.0001) {
                                            
                                            add = false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else {
                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                    }
                }];
                
            }
            
            if(add) {
                
                matched = [[NSNumber alloc] initWithBool:NO];
                
                PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:_mapView_.myLocation.coordinate.latitude longitude:_mapView_.myLocation.coordinate.longitude];
                
                if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
                    PFObject *pointstore = [PFObject objectWithClassName:@"MapPoints"];
                    pointstore[@"title"] = [userdefaults objectForKey:@"pfuser"];
                    pointstore[@"location"] = point;
                    pointstore[@"count"] = stored;
                    pointstore[@"matched"] = matched;
                    pointstore[@"marker_id"] = r;
                    
                    [pointstore saveEventually:^(BOOL succeeded, NSError *error) {
                        
                        if (error) {
                            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PROBLEM" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                        }
                        else {
                            GMSMarker *marker3 = [[GMSMarker alloc] init];
                            marker3.position = _mapView_.myLocation.coordinate;
                            marker3.title = [userdefaults objectForKey:@"pfuser"];
                            marker3.icon = [UIImage imageNamed:@"marker"];
                            marker3.userData = @{@"marker_id":r};
                            marker3.map = _mapView_;
                            
                            /*CLLocationCoordinate2D circleCenter = _mapView_.myLocation.coordinate;
                            MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                            [self registerRegionWithCircularOverlay:circ andIdentifier:r];*/
                        }
                    }];
                }
                else {
                    PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
                    [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
                    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            // The find succeeded.
                            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                            // Do something with the found objects
                            for (PFObject *object in objects) {
                                NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                                NSLog(@"usersandpoints: &&&&&LLL : : : %@", [object objectForKey:@"usersAndPoints"]);
                                
                                NSArray *keyArray = [yy allKeys];
                                
                                for(NSString *keyd in keyArray) {
                                    if([keyd isEqualToString:[userdefaults objectForKey:@"pfuser"]]) {
                                        NSLog(@"key key key: %@", keyd);
                                        NSLog(@"userdefault: %@", [userdefaults valueForKey:@"pfuser"]);
                                        NSMutableArray *locs;
                                        if([yy objectForKey:keyd] != (id)[NSNull null]) {
                                            locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                        }
                                        else {
                                            locs = [[NSMutableArray alloc] init];
                                        }
                                            
                                        int countup = [[userdefaults valueForKey:@"groupmatches"] intValue];
                                        countup++;
                                        NSNumber *hideit = [NSNumber numberWithInt:0];
                                        NSDictionary *alloooc = [[NSDictionary alloc] initWithObjectsAndKeys:[userdefaults valueForKey:@"pfuser"], @"username", r, @"marker_id", point, @"pointdat", [userdefaults objectForKey:@"pfuser"], @"title", stored, @"count", [[NSString alloc] initWithFormat:@"%i", countup], @"groupmatches", [userdefaults objectForKey:@"idbyuser"], @"idbyuser", hideit, @"hideit", nil];
                                        
                                        //NSLog(@"locs: %@", [locs description]);
                                        
                                        [locs addObject:alloooc];
                                        [yy setObject:locs forKey:keyd];
                                        [object setObject:yy forKey:@"usersAndPoints"];
                                        [object saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
                                            if(!error) {
                                                GMSMarker *marker3 = [[GMSMarker alloc] init];
                                                marker3.position = _mapView_.myLocation.coordinate;
                                                marker3.title = [userdefaults objectForKey:@"pfuser"];
                                                marker3.icon = [UIImage imageNamed:@"marker"];
                                                marker3.userData = @{@"marker_id":r};
                                                marker3.map = _mapView_;
                                                
                                                /*CLLocationCoordinate2D circleCenter = _mapView_.myLocation.coordinate;
                                                 MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                                 [self registerRegionWithCircularOverlay:circ andIdentifier:r];*/
                                            }
                                            else {
                                                NSLog(@"%@", [error description]);
                                            }
                                        }];
                                        //}
                                    }
                                }
                            }
                        } else {
                            // Log details of the failure
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                }
                
                [indicator stopAnimating];
                
                if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [tute setHidden:NO];
                    });
                }
            }
            else {
                [indicator stopAnimating];
                deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"PLEASE MOVE A LITTLE" message:@"You are within 1.1 meters of another pix - to take a picture, you must move a few feet." preferredStyle:UIAlertControllerStyleAlert];
                
                [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                
                [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                add = true;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@ *****", error);
            [indicator stopAnimating];
            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"SORRY" message:@"Either you are taking a nude picture, or your connection is bad" preferredStyle:UIAlertControllerStyleAlert];
            
            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
            
            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        }];
    }
    else {
        [tute removeFromSuperview];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [myMatches setHidden:YES];
            [_matchesNumber setHidden:YES];
        });
        
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage], nil, nil, nil);
        
        NSString * uploadURL = @"http://www.eamondev.com/sneekback/respond.php";
        NSLog(@"uploadImageURL: %@", uploadURL);
        NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.5);
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        
        NSString *usernameEncoded = [[userdefaults objectForKey:@"pfuser"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSDictionary *params = @{@"username": staticMarker.title, @"challenger": usernameEncoded, @"count": staticCount};
        
        [pickery dismissViewControllerAnimated:YES completion:NULL];
        
        [respondButton setUserInteractionEnabled:NO];
        [respondButton setEnabled:NO];
        [xButton setUserInteractionEnabled:NO];
        [xButton setEnabled:NO];
        [indicator startAnimating];
        
        NSString* chaleng = [userdefaults objectForKey:@"pfuser"];
        
        [_manager POST:@"http://www.eamondev.com/sneekback/respond.php" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:chaleng mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [image setHidden:YES];
                [respondButton setHidden:YES];
                [xButton setHidden:YES];
                [infobut setHidden:NO];
                [reportButton setHidden:YES];
                [myMatches setHidden:NO];
                [_matchesNumber setHidden:NO];
                [menu setHidden:NO];
            });
            
            staticMarker.map = nil;
            
            deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"A MATCH!" message:@"This perspective is no longer, because you matched it!" preferredStyle:UIAlertControllerStyleAlert];
            
            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
            
            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
            
            NSUInteger matches;
            
            if(![userdefaults objectForKey:@"idbyuser"]) {
                matches = [userdefaults integerForKey:@"matches"];
                matches++;
                [userdefaults setInteger:matches forKey:@"matches"];
            }
            else {
                matches = [userdefaults integerForKey:@"groupmatches"];
                matches++;
                [userdefaults setInteger:matches forKey:@"groupmatches"];
            }
            
            _matchesNumber.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)matches];
            
            PFUser *currentUser = [PFUser currentUser];
            if (currentUser) {
                if(![userdefaults objectForKey:@"idbyuser"])
                    [currentUser setValue:_matchesNumber.text forKey:@"matches"];
                else
                    [currentUser setValue:_matchesNumber.text forKey:@"groupmatches"];
                
                [currentUser saveInBackground];
            } else {
                [PFUser logInWithUsernameInBackground:[userdefaults objectForKey:@"pfuser"] password:[userdefaults objectForKey:@"pfpass"]
                                                block:^(PFUser *user, NSError *error) {
                                                    if (user) {
                                                        if(![userdefaults objectForKey:@"idbyuser"])

                                                            [user setObject:_matchesNumber.text forKey:@"matches"];
                                                        else {
                                                            [user setObject:_matchesNumber.text forKey:@"groupmatches"];
                                                        }
                                                        
                                                        [user saveInBackground];
                                                    } else {
                                                        deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"LOGIN ERROR" message:[[NSString alloc] initWithString: [error description]] preferredStyle:UIAlertControllerStyleAlert];
                                                        [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                                                        [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                                                    }
                                                }];
            }
            
            if(![userdefaults objectForKey:@"idbyuser"]) {
                [deleteObjectId deleteInBackground];
            }
            else {
                PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
                [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
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
                                NSMutableArray *locs;
                                if([yy objectForKey:keyd] != (id)[NSNull null]) {
                                    locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                }
                                else {
                                    locs = [[NSMutableArray alloc] init];
                                }
                                for(NSDictionary *outterar in locs) {
                                    
                                    //PFGeoPoint *storin = [outterar objectForKey:@"pointdat"];
                                    NSLog(@"deleteObjectIdForGroup: %@\n", deleteObjectIdForGroup);
                                    NSLog(@"marker_id: %@", [outterar objectForKey:@"marker_id"]);
                                    
                                    if([deleteObjectIdForGroup isEqualToString:[outterar objectForKey:@"marker_id"]]) {
                                        NSUInteger ind = [locs indexOfObject:outterar];
                                        [outterar setValue:NULL forKey:@"pointdat"];
                                        [locs removeObjectAtIndex:ind];
                                        [locs insertObject:outterar atIndex:ind];
                                        //[outterar setValue:[NSNumber numberWithInt:1] forKey:@"hideit"];
                                        [yy setObject:locs forKey:keyd];
                                        [object setObject:yy forKey:@"usersAndPoints"];
                                        [object saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
                                            staticMarker.map = nil;
                                        }];
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
            
            PFQuery *sosQuery = [PFUser query];
            [sosQuery whereKey:@"username" equalTo:newtitle];
            sosQuery.limit = 1;
            
            [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                [PFCloud callFunctionInBackground:@"sendpush"
                                   withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"]}];
            }];
            
            [respondButton setUserInteractionEnabled:YES];
            [respondButton setEnabled:YES];
            [xButton setUserInteractionEnabled:YES];
            [xButton setEnabled:YES];
            [indicator stopAnimating];
            
            if([[[NSString alloc] initWithString:[userdefaults objectForKey:@"new"]] isEqualToString:@"new"]) {
                [userdefaults setObject:@"old" forKey:@"new"];
                [userdefaults synchronize];
                
                if(![userdefaults objectForKey:@"idbyuser"]) {

                    PFQuery *query = [PFQuery queryWithClassName:@"MapPoints"];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            for (PFObject *object in objects) {
                                PFGeoPoint *point = [object objectForKey:@"location"];
                                
                                GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
                                initMarker.title = [object valueForKey:@"title"];
                                initMarker.appearAnimation = kGMSMarkerAnimationPop;
                                initMarker.icon = [UIImage imageNamed:@"marker"];
                                initMarker.userData = @{@"marker_id":[object objectForKey:@"marker_id"]};
                                initMarker.map = _mapView_;
                                
                                /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(point.latitude, point.longitude);
                                MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                [self registerRegionWithCircularOverlay:circ andIdentifier:[object objectForKey:@"marker_id"]];*/
                            }
                        }else{
                            NSLog(@"%@", [error description]);
                        }
                    }];
                }
                else {
                    PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
                    [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
                    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            // The find succeeded.
                            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                            // Do something with the found objects
                            for (PFObject *object in objects) {
                                NSLog(@"%@ object for making group mark *****************", [object description]);
                                NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                                NSLog(@"%@", [yy description]);
                                
                                NSArray *keyArray = [yy allKeys];
                                
                                for(NSString *keyd in keyArray) {
                                    NSMutableArray *locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                                    for(NSDictionary *outterar in locs) {
                                        PFGeoPoint *point = [outterar objectForKey:@"location"];
                                        
                                        GMSMarker *initMarker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
                                        initMarker.title = [outterar valueForKey:@"title"];
                                        initMarker.appearAnimation = kGMSMarkerAnimationPop;
                                        initMarker.icon = [UIImage imageNamed:@"marker"];
                                        initMarker.userData = @{@"marker_id":[outterar objectForKey:@"marker_id"]};
                                        initMarker.map = _mapView_;
                                        
                                        /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(point.latitude, point.longitude);
                                        MKCircle *circ = [MKCircle circleWithCenterCoordinate:circleCenter radius:91.44];
                                        [self registerRegionWithCircularOverlay:circ andIdentifier:[outterar objectForKey:@"marker_id"]];*/
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
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSHTTPURLResponse* z = (NSHTTPURLResponse*)task.response;
            
            if(z.statusCode == 404) {
                deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"NOT A MATCH!" message:@"If at first you don't succeed..." preferredStyle:UIAlertControllerStyleAlert];
                [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                
                [respondButton setUserInteractionEnabled:YES];
                [respondButton setEnabled:YES];
                [xButton setUserInteractionEnabled:YES];
                [xButton setEnabled:YES];
                [indicator stopAnimating];
            }
            else {
                deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"OOPS!" message:@"Something went wrong, try again." preferredStyle:UIAlertControllerStyleAlert];
                [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                
                [respondButton setUserInteractionEnabled:YES];
                [respondButton setEnabled:YES];
                [xButton setUserInteractionEnabled:YES];
                [xButton setEnabled:YES];
                [indicator stopAnimating];
            }
        }];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)pickery {
    if(!isResponding) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [_matchesNumber setHidden:NO];
            [myMatches setHidden:NO];
        });
    }
    else {
        [_matchesNumber setHidden:YES];
        [myMatches setHidden:YES];
    }
    
    [pickery dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"*** memory warning ***");
    // Dispose of any resources that can be recreated.
}

@end

