// CItem.m
#import "InvisibleButtonView.h"

@interface InvisibleButtonView() {
    UIView* gray;
    BOOL showingEdit;
}

@end

@implementation InvisibleButtonView

//@synthesize myViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touched google link part*************");
}

@end
