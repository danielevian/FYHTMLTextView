//
//  FYAttachment.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "FYAttachment.h"
#import "FYHTMLTextView.h"
#import "FYHTMLTextViewSettings.h"

@implementation FYAttachment

- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options {
    self = [super initWithElement:element options:options];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width - 40;
    self.originalSize = CGSizeMake(screenWidth, screenWidth);
    return self;
    
}
- (void)forceDealloc {
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView*)attachmentViewWithFrame:(CGRect)frame {

    if (self.contentView == nil) {

        self.contentView = [[FYAttachmentView alloc] initWithFrame:CGRectMake(0, frame.origin.y, (self.textView ? self.textView.frame.size.width : frame.size.width), 0)];
        [self.contentView setBackgroundColor:(self.textView ? self.textView.backgroundColor : [UIColor whiteColor])];
        [self.contentView setClipsToBounds:YES];
        [self.contentView setTarget:self];
        [self.contentView setSelector:@selector(shouldLayoutSubViews)];

        [self setUpAttachment];
        
    }

    return self.contentView;
}
- (void)setUpAttachment {
    // subclass
}
- (void)shouldLayoutSubViews {
    if (self.displaySize.width != self.textView.frame.size.width) {
        [self layoutSubViews];
    }
}
- (void)layoutSubViews {
    // subclass
}
- (void)reLayout {
    if (self.textView) [self.textView relayout];
}
+ (void)registerClass:(Class)theClass forTagName:(NSString *)tagName {
    [FYHTMLTextViewSettings registerClass:theClass tagName:tagName];
}

@end

@implementation FYAttachmentView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.target && self.selector && [self.target respondsToSelector:self.selector]) [self.target performSelector:self.selector];
}

@end
