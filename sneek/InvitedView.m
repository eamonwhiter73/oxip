#import "InvitedView.h"
#import "AppDelegate.h"

@class ViewController;

@interface InvitedView() {
    UIButton *accept;
    UIButton *decline;
    UILabel *question;
    UIView *gray;
    ViewController *myViewController;
    NSString *holduser;
}

@end

@implementation InvitedView

- (id)initWithFrame:(CGRect)frame {

/*(AppDelegate *)[[UIApplication sharedApplication] delegate];

Property *myProperty = appDelegate.property;*/\
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        holduser = [[NSString alloc] initWithString:[(AppDelegate *)[[UIApplication sharedApplication] delegate] getInvitedBy]];
        
        /*holduser = [[NSString alloc] initWithString:[(AppDelegate*)[[UIApplication sharedApplication] delegate] invitedby]];*/
        
        /*[self addSubview:[[UIView alloc] initWithFrame:frame]];*/
        self.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:0.9f];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        
        question = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height / 2)];
        accept = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width / 2, frame.size.height / 2)];
        decline = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 2, frame.size.height / 2, frame.size.width / 2, frame.size.height / 2)];
        
        /*accept.backgroundColor = [UIColor redColor];
        decline.backgroundColor = [UIColor greenColor];
        question.backgroundColor = [UIColor blueColor];*/
        
        NSLog(@"holduser way down ********: %@", holduser);
        [question setText:[[NSString alloc] initWithFormat:@"You have been invited to a group game by %@", holduser]];
        question.numberOfLines = 0;
        question.textAlignment = NSTextAlignmentCenter;
        [question setTextColor:[UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f]];
        [question setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
        
        [accept.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
        [accept setTitle:@"ACCEPT" forState:UIControlStateNormal];
        [accept setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];        //[[accept layer] setBorderWidth:3.0f];
        //[[accept layer] setBorderColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f].CGColor];
        
        [decline setTitle:@"DECLINE" forState:UIControlStateNormal];
        [decline.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
        [decline setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        //[[decline layer] setBorderWidth:3.0f];
        //[[decline layer] setBorderColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f].CGColor];
        
        [accept addTarget:myViewController action:@selector(acceptInvite) forControlEvents:UIControlEventTouchUpInside];
        [decline addTarget:myViewController action:@selector(declineInvite) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:accept];
        [self addSubview:decline];
        [self addSubview:question];
    }
    
    return self;
}

@end

