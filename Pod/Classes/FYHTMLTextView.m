//
//  FYHTMLTextView.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "FYHTMLTextView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FYHTMLTextView () <DTAttributedTextContentViewDelegate>

@property (nonatomic, strong) DTAttributedTextView *textView;

@end

@implementation FYHTMLTextView

- (instancetype)initWithFrame:(CGRect)frame htmlString:(NSString *)htmlString attributes:(FYTextViewAttributes *)attributes {
    self = [super init];
    if (self) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithHTMLData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:attributes.attributes documentAttributes:nil];
        frame.size.height = [[[DTCoreTextLayouter alloc] initWithAttributedString:attributedString] layoutFrameWithRect:frame range:NSMakeRange(0, attributedString.length)].frame.size.height;
        
        self.textView = [[DTAttributedTextView alloc] init];
        [self.textView setScrollEnabled:NO];
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.textView setTextDelegate:self];
        [self.textView setAttributedString:attributedString];
        [self addSubview:self.textView];
        
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.textView setFrame:self.bounds];
}
- (void)dealloc {
    [self forceDealloc];
}
- (void)forceDealloc {
    
    for (DTTextAttachment *attachment in [self.textView.attributedTextContentView.layoutFrame textAttachments]) {
        if ([attachment isKindOfClass:[FYAttachment class]]) [(FYAttachment*)attachment forceDealloc];
    }

    [self.textView removeFromSuperview];
    self.textView = nil;
}

#pragma mark - DTAttributedTextContentView

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    if ([attachment isKindOfClass:[FYAttachment class]]) {
        [(FYAttachment*)attachment setTextContentView:attributedTextContentView];
        return [(FYAttachment*)attachment attachmentViewWithFrame:frame];
    }
    else if (self.delegate && [self.delegate respondsToSelector:@selector(FYHTMLTextView:viewForAttachment:frame:)]) {
        return [self.delegate FYHTMLTextView:self viewForAttachment:(FYAttachment*)attachment frame:frame];
    }
    return nil;
}
- (UIView*)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForLink:(NSURL *)url identifier:(NSString *)identifier frame:(CGRect)frame {
    DTLinkButton *button = [[DTLinkButton alloc] init];
    button.URL = url;
    button.GUID = identifier;
    button.frame = frame;
    [button addTarget:self action:@selector(openLink:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context {
    if (self.delegate && [self.delegate respondsToSelector:@selector(FYHTMLTextView:didUpdateHeight:)]) {
        [self.delegate FYHTMLTextView:self didUpdateHeight:layoutFrame.frame.size.height];
    }
}
- (void)openLink:(DTLinkButton*)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(FYHTMLTextView:didClickOnLinkURL:)]) {
        [self.delegate FYHTMLTextView:self didClickOnLinkURL:button.URL];
    }
}

@end