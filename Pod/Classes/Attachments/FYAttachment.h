//
//  FYAttachment.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <DTCoreText/DTCoreText.h>

@interface FYAttachment : DTTextAttachment

@property (nonatomic, strong) DTAttributedTextContentView *textContentView;
@property (nonatomic, strong) UIView *contentView;

- (UIView*)attachmentViewWithFrame:(CGRect)frame;
- (void)reLayout;
- (void)forceDealloc;

@end
