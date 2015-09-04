//
//  FYAttachment.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "FYAttachment.h"
#import "FYHTMLTextView.h"

@implementation FYAttachment

- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options {
    self = [super initWithElement:element options:options];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.originalSize = CGSizeMake(screenWidth - 30, screenWidth + 30);
    return self;
    
}
- (void)forceDealloc {
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView*)attachmentViewWithFrame:(CGRect)frame {
    return nil;
}
- (void)reLayout {
    if (self.textView) [self.textView relayout];
}

@end
