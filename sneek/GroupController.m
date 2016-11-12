//
//  LeaderboardController.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "GroupController.h"
#import <Parse/Parse.h>

@interface GroupController () {
    NSMutableArray *tableData;
    NSMutableArray *entries;
    int countUsers;
    NSArray *sortedFirstArray;
    NSArray *sortedSecondArray;
    UIButton *backToMap;
    UIButton *leaveGroup;
    NSDictionary *dictionary;
    UILabel *leaderboardtit;
    UILabel *username;
    UILabel *matches;
    UIView *tableHolder;
    NSNumber *screenWidth;
    NSUserDefaults *userdefaults;
    NSString *letters;
}
@end

@implementation GroupController {}

@synthesize myViewController;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
        NSLog(@"inside contains object**************&&&&&&&&&&");
        _matchesForUser = [[NSMutableArray alloc] init];
        [_matchesForUser addObject:[userdefaults objectForKey:@"pfuser"]];
        [_tableViewScore reloadData];
    }
    else {
        NSLog(@"%@ inside else contains object else EELSE@@@@*@**@@**@*@*@*", [userdefaults objectForKey:@"idbyuser"]);
        PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
        [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                // Do something with the found objects
                
                for(PFObject* object in objects) {
                    NSLog(@"gotinto where stuff goes into _matchesForUser&^&^^");
                    NSString *yy = [object valueForKey:@"idbyuser"];
                    NSArray *items2 = [yy componentsSeparatedByString:@","];
                    /*NSMutableArray *items = [[NSMutableArray alloc] initWithArray:items2];
                     NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:[items lastObject]];
                     NSCharacterSet *numSet = [NSCharacterSet decimalDigitCharacterSet];
                     
                     if([numSet isSupersetOfSet: charSet])
                     {
                     // It is an integer (or it contains only digits)
                     [items removeObject:[items lastObject]];
                     }*/
                    
                    _matchesForUser = [NSMutableArray arrayWithArray:items2];
                    if([[_matchesForUser objectAtIndex:0] length] == 0) {
                        [_matchesForUser removeObjectAtIndex:0];
                    }
                    [_tableViewScore reloadData]; //*********PROBABLY NEED THIS**************
                }
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

- (void)viewDidLoad {
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    letters  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    
    [userdefaults setValue:nil forKey:@"idbyusertemp"];
    [userdefaults synchronize];
    
    /*if(![userdefaults objectForKey:@"idbyuser"]) {
        NSLog(@"inside contains object**************&&&&&&&&&&viewappeared");
        _matchesForUser = [[NSMutableArray alloc] init];
        [_matchesForUser addObject:[userdefaults objectForKey:@"pfuser"]];
        [_tableViewScore reloadData];
    }*/
    
    //[myViewController setLeftgroup:@"here"];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
    tableData = [[NSMutableArray alloc] init];
    sortedFirstArray = [[NSArray alloc] init];
    
    screenWidth = @([UIScreen mainScreen].bounds.size.width);
    CGRect tablehold = CGRectZero;
    CGRect tableviewhold = CGRectZero;
    CGRect tableviewscore = CGRectZero;
    CGRect leaderboardtitrect = CGRectZero;
    CGRect userrect = CGRectZero;
    CGRect matchesrect = CGRectZero;
    CGRect backtomaprect = CGRectZero;
    CGRect leavegrouprect = CGRectZero;
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"GROUP GAMES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}];
    
    username = [[UILabel alloc] initWithFrame:userrect];
    matches = [[UILabel alloc] initWithFrame:matchesrect];
    backToMap = [[UIButton alloc] initWithFrame:backtomaprect];
    leaveGroup = [[UIButton alloc] initWithFrame:leavegrouprect];
    
    if([screenWidth intValue] == 320) {
        tablehold = CGRectMake(10, 120, 300, 368);
        tableviewhold = CGRectMake(0, 0, 140, 368);
        tableviewscore = CGRectMake(160, 0, 140, 368);
        leaderboardtitrect = CGRectMake(0, 20, 320, 60);
        userrect = CGRectMake(10, 90, 140, 20);
        matchesrect = CGRectMake(170, 90, 140, 20);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 498, 145, 60);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        leavegrouprect = CGRectMake(165, 498, 145, 60);
        leaveGroup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    }
    if([screenWidth intValue] == 375) {
        tablehold = CGRectMake(10, 140, 355, 432);
        tableviewhold = CGRectMake(0, 0, 165.66, 432);
        tableviewscore = CGRectMake(189.33, 0, 165.66, 432);
        leaderboardtitrect = CGRectMake(0, 20, 375, 60);
        userrect = CGRectMake(10, 105, 140, 20);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        matchesrect = CGRectMake(224, 105, 140, 20);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 585, 175, 72);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        leavegrouprect = CGRectMake(185, 585, 175, 72);
        leaveGroup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];

    }
    if([screenWidth intValue] == 414) {
        tablehold = CGRectMake(10, 154, 394, 477);
        tableviewhold = CGRectMake(0, 0, 235, 477);
        tableviewscore = CGRectMake(255, 0, 139, 477);
        leaderboardtitrect = CGRectMake(0, 22, 414, 80);
        userrect = CGRectMake(10, 116, 154, 22);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        matchesrect = CGRectMake(247, 116, 154, 22);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 645.5, 192, 80);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        leavegrouprect = CGRectMake(202, 645.5, 192, 80);
        leaveGroup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    }
    if([screenWidth intValue] == 768){
        tablehold = CGRectMake(20, 215, 727, 663);
        tableviewhold = CGRectMake(0, 0, 407, 663);
        tableviewscore = CGRectMake(427, 0, 300, 663);
        leaderboardtitrect = CGRectMake(0, 30, 768, 110.5);
        attrString = [[NSAttributedString alloc] initWithString:@"GROUP GAMES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:48.0]}];
        
        userrect = CGRectMake(20, 161, 287, 30);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
        matchesrect = CGRectMake(459, 161, 287, 30);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
        backtomaprect = CGRectMake(20, 898, 353.5, 110.5);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        leavegrouprect = CGRectMake(373.5, 898, 353.5, 110.5);
        leaveGroup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    }
    if([screenWidth intValue] == 1024){
        tablehold = CGRectMake(27, 287, 969, 885);
        tableviewhold = CGRectMake(0, 0, 600, 885);
        tableviewscore = CGRectMake(627, 0, 342, 885);
        
        leaderboardtitrect = CGRectMake(0, 20, 1024, 200);
        attrString = [[NSAttributedString alloc] initWithString:@"GROUP GAMES" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0]}];
        
        userrect = CGRectMake(27, 215, 382, 73);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        matchesrect = CGRectMake(612, 215, 382, 73);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        
        backtomaprect = CGRectMake(27, 1198, 471, 147);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        
        leavegrouprect = CGRectMake(498, 1198, 471, 147);
        leaveGroup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    }
    
    _matchesForUser = [[NSMutableArray alloc] init];
    
    tableHolder = [[UIView alloc] initWithFrame:tablehold];
    tableHolder.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableHolder];
    
    _tableView = [[UITableView alloc] initWithFrame:tableviewhold];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1;
    _tableView.separatorColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.layoutMargins = UIEdgeInsetsZero;
    if([_tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        _tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [tableHolder addSubview:_tableView];
    
    _tableViewScore = [[UITableView alloc] initWithFrame:tableviewscore];
    _tableViewScore.delegate = self;
    _tableViewScore.dataSource = self;
    _tableViewScore.tag = 2;
    _tableViewScore.separatorColor = [UIColor clearColor];
    _tableViewScore.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    _tableViewScore.layer.masksToBounds = true;
    CGSize scrollableSize = CGSizeMake(140, 368);
    [_tableViewScore setContentSize:scrollableSize];
    if([_tableViewScore respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        _tableViewScore.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [tableHolder addSubview:_tableViewScore];
    [_tableViewScore reloadData];
    
    leaderboardtit = [[UILabel alloc] initWithFrame:leaderboardtitrect];
    leaderboardtit.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    leaderboardtit.numberOfLines = 0;
    leaderboardtit.attributedText = attrString;
    [self.view addSubview:leaderboardtit];
    
    [username setFrame:userrect];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    username.attributedText = [[NSAttributedString alloc] initWithString:@"USERS"
                                                              attributes:underlineAttribute];
    username.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:username];
    
    [matches setFrame:matchesrect];
    matches.backgroundColor = [UIColor clearColor];
    NSDictionary *underlineAttribute2 = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    matches.attributedText = [[NSAttributedString alloc] initWithString:@"ADDED"
                                                             attributes:underlineAttribute2];
    matches.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    matches.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:matches];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    [_tableViewScore registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                for (PFObject *object in objects) {
                    [tableData addObject:[object valueForKey:@"username"]];
                }
                
                //FIGURE OUT GROUP BACKEND?????
                
                [_tableView reloadData];
                //[_tableViewScore reloadData]; //*********NEED THIS????**************
                
            }else{
                NSLog(@"%@", [error description]);
            }
        });
    }];
    
    /*if([_matchesForUser count] == 0 || !_matchesForUser) {
        NSLog(@"inside contains object**************&&&&&&&&&&");
        _matchesForUser = [[NSMutableArray alloc] init];
        [_matchesForUser addObject:[userdefaults objectForKey:@"pfuser"]];
        [_tableViewScore reloadData];
    }*/
    
    if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
        NSLog(@"inside contains object**************&&&&&&&&&&");
        _matchesForUser = [[NSMutableArray alloc] init];
        [_matchesForUser addObject:[userdefaults objectForKey:@"pfuser"]];
        [_tableViewScore reloadData];
    }
    else {
        NSLog(@"%@ inside else contains object else EELSE@@@@*@**@@**@*@*@*", [userdefaults objectForKey:@"idbyuser"]);
        PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
        [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                // Do something with the found objects
                
                for(PFObject* object in objects) {
                    NSLog(@"gotinto where stuff goes into _matchesForUser&^&^^");
                    NSString *yy = [object objectForKey:@"idbyuser"];
                    NSArray *items2 = [yy componentsSeparatedByString:@","];
                    /*NSMutableArray *items = [[NSMutableArray alloc] initWithArray:items2];
                    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:[items lastObject]];
                    NSCharacterSet *numSet = [NSCharacterSet decimalDigitCharacterSet];
                    
                    if([numSet isSupersetOfSet: charSet])
                    {
                        // It is an integer (or it contains only digits)
                        [items removeObject:[items lastObject]];
                    }*/
                    
                    _matchesForUser = [NSMutableArray arrayWithArray:items2];
                    if([[_matchesForUser objectAtIndex:0] length] == 0) {
                        [_matchesForUser removeObjectAtIndex:0];
                    }
                    [_tableViewScore reloadData]; //*********PROBABLY NEED THIS**************
                }
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }

    [backToMap setFrame:backtomaprect];
    backToMap.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [backToMap setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [backToMap addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backToMap setTitle:@"SAVE OR EXIT" forState:UIControlStateNormal];
    backToMap.layer.masksToBounds = true;
    //backToMap.layer.cornerRadius = 5.0;
    [self.view addSubview:backToMap];
    
    [leaveGroup setFrame:leavegrouprect];
    leaveGroup.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [leaveGroup setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [leaveGroup addTarget:self action:@selector(leaveGroupFunc) forControlEvents:UIControlEventTouchUpInside];
    [leaveGroup setTitle:@"LEAVE GROUP" forState:UIControlStateNormal];
    leaveGroup.layer.masksToBounds = true;
    //leaveGroup.layer.cornerRadius = 5.0;
    [self.view addSubview:leaveGroup];
}

- (void)leaveGroupFunc {
    [userdefaults setObject:nil forKey:@"idbyuser"];
    [userdefaults setInteger:0 forKey:@"groupcount"];
    [userdefaults setInteger:0 forKey:@"groupmatches"];
    [myViewController.matchesNumber setText:[NSString stringWithFormat:@"%i", 0]];
    [userdefaults synchronize];
    _matchesForUser = [[NSMutableArray alloc] init];
    [_tableViewScore reloadData];
    [self dismissViewControllerAnimated:NO completion:^{
        [[myViewController mapView_] clear];
        [myViewController showallmarkers];
        [myViewController setAFlag:YES];
    }];
}

-(NSString *)randomStringWithLength:(int)len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

- (void)dismiss {
    
    /* DUMB STRUCTURE FIX*/

    NSMutableString *stringstore = [[NSMutableString alloc] init];
    //NSString *forend;
    for(NSString* string in _matchesForUser) {
        NSLog(@"string in matchesforuser *****(((())))))*&&&&&*: %@", string);
        NSString *string2 = [[NSString alloc] initWithFormat:@"%@,", string];
        [stringstore appendString:string2];
    }
    
    //REALLY DUMB FIX
    NSMutableString __block *tagon = [[NSMutableString alloc] initWithString:stringstore];
    //forend = [[NSString alloc] initWithString:stringstore];
    NSLog(@"stringstore******: %@", tagon);
    //**********
    
    /*PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
    [query2 whereKey:@"idbyuser" equalTo:tagon];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            int __block count = 1;
            for(PFObject *obj in objects) {
                
                NSLog(@"invalue last object: *****::: * %@", [[[obj objectForKey:@"idbyuser"] componentsSeparatedByString:@","] lastObject]);
                if([[[[obj objectForKey:@"idbyuser"] componentsSeparatedByString:@","] lastObject] intValue] >= 0) {
                    count = [[[[obj objectForKey:@"idbyuser"] componentsSeparatedByString:@","] lastObject] intValue];
                    count++;
                    [tagon appendString:[NSString stringWithFormat:@"%i", count]];
                }
                else {
                    [tagon appendString:[NSString stringWithFormat:@"%i", count]];
                    NSLog(@"stringstore****** appended ocunted 1: %@", tagon);
                }
                
                [obj setValue:tagon forKey:@"idbyuser"];
                [obj saveEventually];
                
                [userdefaults setValue:tagon forKey:@"idbyuser"];
                [userdefaults synchronize];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/

    
    UIAlertController __block *deviceNotFoundAlertController;
    UIAlertAction *deviceNotFoundAlert  = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];;
    
    NSMutableArray *starter = [[NSMutableArray alloc] init];
    
    [_matchesForUser enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        [starter addObject:[[NSArray alloc] init]];
    }];
    
    [userdefaults setValue:@"groupg" forKey:@"groupbuttonaction"];
    
    NSString __block *r = [[NSString alloc] initWithString:[self randomStringWithLength:8]];
    
    PFQuery *quer = [PFQuery queryWithClassName:@"GroupGame"];
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
    
    /*NSMutableArray* fill = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_matchesForUser count]; i++)
    {
        fill[i] = [NSNull null];
    }*/

    NSDictionary *userspoints = [[NSDictionary alloc] initWithObjects:starter forKeys:_matchesForUser];
    NSLog(@" DICKTIONARY::: HAHAHAHA******* %@", [userspoints debugDescription]);
    NSLog(@" MATCHESFORUSER::: HAHAHAHA******* %@", [_matchesForUser debugDescription]);
    NSLog(@" FILLLLLLLLLPHILIIP::: HAHAHAHA******* %@", [starter debugDescription]);

    PFObject *groupGame = [PFObject objectWithClassName:@"GroupGame"];
    groupGame[@"usersAndPoints"] = userspoints;
    groupGame[@"idbyuser"] = tagon;
    groupGame[@"groupgame_id"] = r;
    [groupGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            BOOL track = NO;
            NSLog(@"userdefaults idbyuser *****###$$$$$$$ %@", [userdefaults valueForKey:@"idbyuser"]);
            if([userdefaults valueForKey:@"idbyuser"] == NULL) {
                NSLog(@"inside groupgamestorerespond ********");
                track = YES;
                for(NSString* user in _matchesForUser) {
                    PFQuery *sosQuery = [PFUser query];
                    [sosQuery whereKey:@"username" equalTo:user];
                    sosQuery.limit = 1;
                    
                    [sosQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                        [PFCloud callFunctionInBackground:@"sendinvite"
                                           withParameters:@{@"user":(PFUser *)object.objectId, @"username":[userdefaults objectForKey:@"pfuser"], @"idbyuser":tagon}];
                    }];
                }
            }
            
            //_matchesForUser = nil;
            
            /*if([[tagon componentsSeparatedByString:@","] lastObject] == NULL) {
                NSMutableArray *quick = [[NSMutableArray alloc] initWithArray:[tagon componentsSeparatedByString:@","]];
                [quick removeLastObject];
                tagon = [[NSMutableString alloc] init];
                for(NSString* insif in quick) {
                    [tagon appendString:insif];
                }
            }*/
            
            NSLog(@"INSIF ATTEMPT &&&&#&#&#&$^#$&$#^&#$#&");
            [userdefaults setValue:tagon forKey:@"idbyuser"];
            [userdefaults setValue:r forKey:@"groupgame_id"];
            [userdefaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:^{
                if(track) {
                    [[myViewController mapView_] clear];
                    
                    deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"MARKERS" message:@"Only markers from your group game will be visible to you. To view all markers, tap the show all markers button in the top left corner of the screen." preferredStyle:UIAlertControllerStyleAlert];
                    [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
                    [myViewController presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
                }
            }];
        } else {
            UIAlertController *deviceNotFoundAlertController = [UIAlertController alertControllerWithTitle:@"NOT SAVED" message:@"Your game was not saved, try again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *deviceNotFoundAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [deviceNotFoundAlertController addAction:deviceNotFoundAlert];
            [self presentViewController:deviceNotFoundAlertController animated:NO completion:NULL];
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _tableView)
        return [tableData count];
    else
        return [_matchesForUser count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];*/
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(tableView.tag == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        
        if (cell == nil) {
            NSString *CellIdentifier = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 44)];
        contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        contentV.tag = 100;
        if([screenWidth intValue] == 1024) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 737, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        }
        if([screenWidth intValue] == 768) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 607, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        
        contentV.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        contentV.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        
        cell.contentView.layoutMargins = UIEdgeInsetsZero;
        
        NSString *username2 = [tableData objectAtIndex:indexPath.row];
        
        contentV.text = username2;
        [cell.contentView addSubview:contentV];
        
        return cell;
    }
    else {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        if([screenWidth intValue] == 1024) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        }
        if([screenWidth intValue] == 768) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        cell.textLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:211.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (cell == nil) {
            NSString *CellIdentifier = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSLog(@"indexpath.row: %ld", (long)indexPath.row);
        NSLog(@"_matchesForUsercount: %ld", (unsigned long)[_matchesForUser count]);
        if([_matchesForUser count] > indexPath.row) {
            NSString *matchAmount = [_matchesForUser objectAtIndex:indexPath.row];
            cell.textLabel.text = matchAmount;
        }
        
        return cell;
    }
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if(tableView.tag == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *label = (UILabel*)[cell viewWithTag:100];
        
        if(![userdefaults objectForKey:@"idbyuser"]) {
            NSLog(@"got into userdefaults***********");
            if(![label.text isEqualToString:@""]) {
                NSLog(@"got into userdefaults add name***********");
                if(![_matchesForUser containsObject:[userdefaults objectForKey:@"pfuser"]]) {
                    [_matchesForUser addObject:[userdefaults objectForKey:@"pfuser"]];
                }
                
                if (![_matchesForUser containsObject:[label text]]) {
                    NSLog(@"got into userdefaults add label text***********");
                    NSLog(@"%@", [label text]);
                    [_matchesForUser addObject:[label text]];
                }
                
                NSLog(@"%@", [_matchesForUser description]);
                
                [_tableView reloadData];
                [_tableViewScore reloadData];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"*** memory warning ***");
    // Dispose of any resources that can be recreated.
}

@end
