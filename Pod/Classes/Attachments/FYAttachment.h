//
//  FYAttachment.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <DTCoreText/DTCoreText.h>
#import "FYHTMLTextView.h"

@interface FYAttachment : DTTextAttachment

@property (nonatomic, strong) FYHTMLTextView *textView;
@property (nonatomic, strong) UIView *contentView;

- (UIView*)attachmentViewWithFrame:(CGRect)frame;
- (void)reLayout;
- (void)forceDealloc;

@end
