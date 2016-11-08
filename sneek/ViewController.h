//
//  ViewController.h
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "InvitedView.h"
@import MapKit;
@import GoogleMaps;

@interface ViewController : UIViewController <GMSMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;

#if TARGET_OS_IPHONE
@property NSMutableDictionary *completionHandlerDictionary;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) GMSMapView *mapView_;
@property (nonatomic, assign) NSString *leftgroup;
//@property (nonatomic, assign) BOOL invitedIsSetHid;
@property (nonatomic, assign) BOOL _aFlag;
@property (nonatomic, strong) NSNumber* _aFlagForHid;
@property (nonatomic, assign) BOOL _aFlagForInvited;
@property (nonatomic, strong) UILabel *matchesNumber;


- (NSString *)randomStringWithLength:(int)len;
- (void)dropSneek;
- (void)openCamera;
- (void)declineInvite;
- (void)acceptInvite;
//- (void)setInvited:(InvitedView*)invite;
//- (BOOL)getInvitedIsSetHid;
- (void)setAFlag:(BOOL)flag;
- (void)setAFlagForHid:(NSNumber*)flag;

/*- (BOOL)registerRegionWithCircularOverlay:(MKCircle*)overlay andIdentifier:(NSString*)identifier;*/

#endif

@end

