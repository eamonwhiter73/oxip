//
//  LeaderboardController.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "LeaderboardController.h"
#import <Parse/Parse.h>

@interface LeaderboardController () {
    NSMutableArray *tableData;
    NSMutableArray *matchesForUser;
    NSMutableArray *entries;
    NSArray *transfer1;
    NSArray *transfer2;
    int countUsers;
    NSArray *sortedFirstArray;
    NSArray *sortedSecondArray;
    UIButton *backToMap;
    NSDictionary *dictionary;
    UILabel *leaderboardtit;
    UILabel *username;
    UILabel *matches;
    UIView *tableHolder;
    NSUserDefaults *userdefaults;
}
@end


@implementation LeaderboardController {}

- (void)viewDidLoad {
    
    userdefaults = [NSUserDefaults standardUserDefaults];

    [self.view setBackgroundColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
    tableData = [[NSMutableArray alloc] init];
    matchesForUser = [[NSMutableArray alloc] init];
    sortedFirstArray = [[NSArray alloc] init];
    sortedSecondArray = [[NSArray alloc] init];
    transfer2 = [[NSArray alloc] init];
    transfer1 = [[NSArray alloc] init];
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    CGRect tablehold = CGRectZero;
    CGRect tableviewhold = CGRectZero;
    CGRect tableviewscore = CGRectZero;
    CGRect leaderboardtitrect = CGRectZero;
    CGRect userrect = CGRectZero;
    CGRect matchesrect = CGRectZero;
    CGRect backtomaprect = CGRectZero;
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}];
    
    username = [[UILabel alloc] initWithFrame:userrect];
    matches = [[UILabel alloc] initWithFrame:matchesrect];
    backToMap = [[UIButton alloc] initWithFrame:backtomaprect];
    
    if([screenWidth intValue] == 320) {
        tablehold = CGRectMake(10, 120, 300, 368);
        tableviewhold = CGRectMake(0, 0, 230, 368);
        tableviewscore = CGRectMake(240, 0, 60, 368);
        leaderboardtitrect = CGRectMake(0, 20, 320, 60);
        userrect = CGRectMake(10, 90, 140, 20);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        matchesrect = CGRectMake(170, 90, 140, 20);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 498, 300, 60);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 375) {
        tablehold = CGRectMake(10, 140, 355, 432);
        tableviewhold = CGRectMake(0, 0, 270, 432);
        tableviewscore = CGRectMake(285, 0, 70, 432);
        leaderboardtitrect = CGRectMake(0, 20, 375, 60);
        userrect = CGRectMake(10, 105, 140, 20);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        matchesrect = CGRectMake(224, 105, 140, 20);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 585, 355, 72);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 414) {
        tablehold = CGRectMake(10, 154, 394, 477);
        tablehold = CGRectMake(0, 0, 298, 477);
        tableviewscore = CGRectMake(317, 0, 77, 477);
        leaderboardtitrect = CGRectMake(0, 22, 414, 80);
        userrect = CGRectMake(10, 116, 154, 22);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        matchesrect = CGRectMake(247, 116, 154, 22);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        backtomaprect = CGRectMake(10, 645.5, 394, 80);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 768){
        tablehold = CGRectMake(20, 215, 727, 663);
        tableviewhold = CGRectMake(0, 0, 607, 663);
        tableviewscore = CGRectMake(627, 0, 100, 663);
        
        leaderboardtitrect = CGRectMake(0, 30, 768, 110.5);
        attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:48.0]}];
        
        userrect = CGRectMake(20, 161, 287, 30);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
        matchesrect = CGRectMake(459, 161, 287, 30);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
        backtomaprect = CGRectMake(20, 898, 727, 110.5);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42.0];
    }
    if([screenWidth intValue] == 1024){
        tablehold = CGRectMake(27, 287, 969, 885);
        tableviewhold = CGRectMake(0, 0, 737, 885);
        tableviewscore = CGRectMake(778, 0, 191, 885);
        
        leaderboardtitrect = CGRectMake(0, 20, 1024, 200);
        attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0]}];
        
        userrect = CGRectMake(27, 215, 382, 73);
        username.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        matchesrect = CGRectMake(612, 215, 382, 73);
        matches.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
        
        backtomaprect = CGRectMake(27, 1198, 969, 147);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:54.0];
    }
    
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
    _tableViewScore.layer.cornerRadius = 5.0;
    CGSize scrollableSize = CGSizeMake(60, 368);
    [_tableViewScore setContentSize:scrollableSize];
    [tableHolder addSubview:_tableViewScore];
    
    leaderboardtit = [[UILabel alloc] initWithFrame:leaderboardtitrect];
    leaderboardtit.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    leaderboardtit.numberOfLines = 0;
    leaderboardtit.attributedText = attrString;
    [self.view addSubview:leaderboardtit];
    
    [username setFrame:userrect];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                               attributes:underlineAttribute];
    username.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:username];
    
    [matches setFrame:matchesrect];
    matches.backgroundColor = [UIColor clearColor];
    NSDictionary *underlineAttribute2 = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    matches.attributedText = [[NSAttributedString alloc] initWithString:@"MATCHES"
                                                             attributes:underlineAttribute2];
    matches.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    matches.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:matches];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    [_tableViewScore registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    
    //MAYBE CHANGE IF STATEMENTS INSIDE???????
    NSLog(@"VERY IMPORTANT ************* VALUE FOR IDBYUSER INIT: %@", [userdefaults valueForKey:@"idbyuser"]);
    
    if([[userdefaults valueForKey:@"idbyuser"] length] == 0) {
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                    entries = [NSMutableArray new];
                    for (PFObject *object in objects) {
                        [tableData addObject:[object valueForKey:@"username"]];
                        [matchesForUser addObject:[object valueForKey:@"matches"]];
                        
                        NSMutableDictionary* entry = [NSMutableDictionary new];
                        
                        entry[@"username"] = [object valueForKey:@"username"];
                        entry[@"matches"] = [object valueForKey:@"matches"];
                        
                        [entries addObject:entry];
                    }
                    
                    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"matches" ascending:NO selector:@selector(localizedStandardCompare:)];
                    NSArray *entrieshold = [entries sortedArrayUsingDescriptors:@[descriptor]];
                    transfer1 = [entrieshold copy];

                    [_tableView reloadData];
                    [_tableViewScore reloadData];
                    
                }else{
                    NSLog(@"%@", [error description]);
                }
            });
        }];
    }
    else {
        
        /*PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
        [query2 whereKey:@"idbyuser" equalTo:[userdefaults objectForKey:@"idbyuser"]];
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                entries = [NSMutableArray new];
                
                    NSArray *items = [[objects firstObject] componentsSeparatedByString:@","];
                    NSMutableArray *muty = [[NSMutableArray alloc] initWithArray:items];
                    [muty removeLastObject];
                    items = [[NSArray alloc] initWithArray:muty];
                    
                    for(NSString* item in items) {
                        
                        NSLog(@"888888888%@888888888", item);

                        [tableData addObject:item];
                        
                        [matchesForUser addObject:[[objects firstObject] objectForKey:@"usersAndPoints"]];
                    
                        NSMutableDictionary* entry = [NSMutableDictionary new];
                        entry[@"username"] = [[objects firstObject] valueForKey:@"username"];
                        entry[@"matches"] = [[objects firstObject] valueForKey:@"groupmatches"];
                        
                        NSLog(@"%@ entry description ***(*", [[objects firstObject] valueForKey:@"groupmatches"]);
                        
                    }
                
                NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"matches" ascending:NO selector:@selector(localizedStandardCompare:)];
                NSLog(@"%@ entries", [entries description]);

                NSArray *entrieshold = [entries sortedArrayUsingDescriptors:@[descriptor]];
                transfer = [entrieshold copy];
                
                [_tableView reloadData];
                [_tableViewScore reloadData];

            } else {
                // Log details of the fail
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];*/
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"GroupGame"];
        [query2 whereKey:@"groupgame_id" equalTo:[userdefaults objectForKey:@"groupgame_id"]];
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                entries = [NSMutableArray new];
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores. YOU YOU YOU &&&***&&&&****&&&&&", (unsigned long)objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    NSMutableDictionary *yy = [[NSMutableDictionary alloc] initWithDictionary:[object objectForKey:@"usersAndPoints"]];
                    NSLog(@"%@ ****&&&666%%%%66^^^^^^^&&*****", [object description]);
                    
                    
                    NSArray *keyArray = [yy allKeys];
                    for(NSString *keyd in keyArray) {
                        NSLog(@"yy objectforkey *********: %@", [yy objectForKey:keyd]);
                        if ([yy objectForKey:keyd] == nil || [[yy objectForKey:keyd] count] == 0) {

                            NSMutableDictionary* entry = [NSMutableDictionary new];
                            
                            NSLog(@"inside yy obejet for key count 0 *****####***##*#*#*#");
                            [tableData addObject:keyd];
                            [matchesForUser addObject:@"0"];
                            entry[@"username"] = keyd;
                            entry[@"matches"] = @"0";
                            [entries addObject:entry];
                        }
                        else {
                            NSMutableArray *locs = [[NSMutableArray alloc] initWithArray:[yy objectForKey:keyd]];
                            //NSString *outerouter;
                            //NSNumber *outeroutermatches = [NSNumber numberWithInt:0];
                            for(NSDictionary *outterar in locs) {
                                
                                NSMutableDictionary* entry = [NSMutableDictionary new];

                                NSLog(@"%@ outtererjar descriptiong ##(#(#(#(#(#(#(#(#(#((#", [outterar description]);
                                
                                entry[@"username"] = keyd;
                                
                                entry[@"matches"] = [outterar valueForKey:@"groupmatches"];
                                
                                if([entries count] > 0) {
                                    for(int counter = 0; counter < [entries count]; counter++) {
                                        if([[[entries objectAtIndex:counter] valueForKey:@"matches"] intValue] < [[entry valueForKey:@"matches"] intValue]) {
                                            NSLog(@"GETTING IN IFFFFFF ABOOOVVEEEEE ******8888888*********");

                                            //NSMutableDictionary *stud = [[NSMutableDictionary alloc] initWithObjectsAndKeys:keyd, @"username", nil];
                                            [matchesForUser addObject:[outterar objectForKey:@"groupmatches"]];
                                            [tableData addObject:keyd];
                                            
                                            NSLog(@"%@ WHAT IS ENTRIES>>>!!!!??!?!?!", [[entries objectAtIndex:counter] valueForKey:@"username"]);
                                            if([keyd isEqualToString:[[entries objectAtIndex:counter] valueForKey:@"username"]]) {
                                                NSLog(@"GETTING IN IFFFFFF ******8888888*********");
                                                [entries removeObjectAtIndex:counter];
                                                [entries insertObject:entry atIndex:counter];
                                            }
                                            else {
                                                [entries addObject:entry];
                                            }
                                        }
                                        else {
                                            [entries addObject:entry];
                                        }
                                    }
                                }
                                else {
                                    [matchesForUser addObject:[outterar objectForKey:@"groupmatches"]];
                                    [tableData addObject:keyd];
                                    [entries addObject:entry];
                                }
                                
                                //[entries addObject:entry];
                                //outerouter = [[NSString alloc] initWithString:[outterar valueForKey:@"idbyuser"]];
                                //outeroutermatches = [[NSNumber alloc] initWithInt:[[outterar valueForKey:@"groupmatches"] intValue]];
                            }
                        }
                    }
                }
                
                NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"matches" ascending:NO selector:@selector(localizedStandardCompare:)];
                NSArray *entrieshold = [entries sortedArrayUsingDescriptors:@[descriptor]];
                transfer2 = [entrieshold copy];
                //NSMutableArray *transfer3 = [[NSMutableArray alloc] initWithArray:transfer2];
                //[transfer3 removeLastObject];
                //transfer2 = [transfer3 copy];
                
                [_tableView reloadData];
                [_tableViewScore reloadData];
            }
            else {
                NSLog(@"%@", [error description]);
            }
        }];
    }
    
    [backToMap setFrame:backtomaprect];
    backToMap.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [backToMap setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [backToMap addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backToMap setTitle:@"BACK TO MAP" forState:UIControlStateNormal];
    backToMap.layer.masksToBounds = true;
    backToMap.layer.cornerRadius = 5.0;
    [self.view addSubview:backToMap];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);

    if(tableView.tag == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
       

        UILabel *contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 44)];
        contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        if([screenWidth intValue] == 1024) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 737, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0];
        }
        else if([screenWidth intValue] == 768) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 607, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        
        contentV.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        contentV.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];

        cell.contentView.layoutMargins = UIEdgeInsetsZero;
        
        NSString *username2;
        
        if([[userdefaults objectForKey:@"idbyuser"] length] == 0) {
            //NSDictionary* storeg = [transfer valueForKey:@"username"];
            username2 = [[NSString alloc] initWithString:[[transfer1 objectAtIndex:indexPath.row] valueForKey:@"username"]];//[[NSString alloc] initWithString:[storeg objectForKey:@"username"]];
        }
        else {
            NSLog(@"%ld INDEXPATH ABOVE***", (long)indexPath.row);
            NSLog(@"%ld transfer COUNT ABOVE*****", (unsigned long)[transfer2 count]);
            if(indexPath.row < [transfer2 count]) {
                NSLog(@"%@", [[NSString alloc] initWithString:[[transfer2 objectAtIndex:indexPath.row] valueForKey:@"matches"]]);
                //if(([[transfer2 objectAtIndex:indexPath.row] valueForKey:@"username"] != (id)[NSNull null])) {
                    username2 = [[NSString alloc] initWithString:[[transfer2 objectAtIndex:indexPath.row] valueForKey:@"username"]];
                //}
            }
        }
        
        contentV.text = username2;
        [cell.contentView addSubview:contentV];

        return cell;
    }
    else {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        if([screenWidth intValue] == 1024) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0];
        }
        else if([screenWidth intValue] == 768) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        cell.textLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:211.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        NSString* matches2;
        if([[userdefaults objectForKey:@"idbyuser"] length] == 0 ) {
            //NSDictionary* storeg = [transfer valueForKey:@"username"];
            matches2 = [[NSString alloc] initWithString:[[transfer1 objectAtIndex:indexPath.row] valueForKey:@"matches"]];//[[NSString alloc] initWithString:[storeg objectForKey:@"username"]];
        }
        else {
            NSLog(@"%ld INDEXPATH ***", (long)indexPath.row);
            NSLog(@"%ld transfer COUNT *****", (unsigned long)[transfer2 count]);
            if(indexPath.row < [transfer2 count]) {
                NSLog(@"%@", [[NSString alloc] initWithString:[[transfer2 objectAtIndex:indexPath.row] valueForKey:@"matches"]]);
                
                matches2 = [[NSString alloc] initWithString:[[transfer2 objectAtIndex:indexPath.row] valueForKey:@"matches"]];
                
                if([[[transfer2 objectAtIndex:indexPath.row] valueForKey:@"matches"] isKindOfClass:[NSString class]]) {
                    NSLog(@"its a string");
                }
            }
        }
        
        /*if(![userdefaults objectForKey:@"idbyuser"]) {
            NSDictionary* tempdic = [transfer1 objectAtIndex:indexPath.row];
        }
        else {
            NSDictionary* tempdic = [[NSDictionary alloc] initWithObjectsAndKeys:[transfer2 valueForKey:<#(nonnull NSString *)#>], ..., nil     cell.textLabel.text = [tempdic objectForKey:@"matches"];
        }*/
                                     
        cell.textLabel.text = matches2;
                                     
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    UITableView *slaveTable = nil;
    
    if (_tableView == scrollView) {
        slaveTable = _tableViewScore;
    } else if (_tableViewScore == scrollView) {
        slaveTable = _tableView;
    }
    
    [slaveTable setContentOffset:scrollView.contentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"*** memory warning ***");
    // Dispose of any resources that can be recreated.
}

@end
