//
//  FYAttachment.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <DTCoreText/DTCoreText.h>

typedef void (^FYAttachmentVoidBlock)();

@interface FYAttachmentView : UIView

@property (nonatomic, strong) id target;
@property (nonatomic) SEL selector;


@end

@class FYHTMLTextView;

@interface FYAttachment : DTTextAttachment

@property (nonatomic, strong) FYHTMLTextView *textView;
@property (nonatomic, strong) FYAttachmentView *contentView;

- (UIView*)attachmentViewWithFrame:(CGRect)frame;

- (void)setUpAttachment;

- (void)layoutSubViews;
- (void)reLayout;

- (void)forceDealloc;

@end

