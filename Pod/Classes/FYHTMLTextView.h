//
//  FYHTMLTextView.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <DTCoreText/DTCoreText.h>
#import "FYTextViewAttributes.h"
#import "FYAttachment.h"

@protocol FYHTMLTextViewDelegate;

@interface FYHTMLTextView : UIView

@property (nonatomic, weak) id<FYHTMLTextViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString attributes:(FYTextViewAttributes*)attributes;
- (void)forceDealloc;

@end

@protocol FYHTMLTextViewDelegate <NSObject>

@optional

- (void)FYHTMLTextView:(FYHTMLTextView*)textView didClickOnLinkURL:(NSURL*)url;
- (void)FYHTMLTextView:(FYHTMLTextView*)textView didUpdateHeight:(CGFloat)height;
- (UIView*)FYHTMLTextView:(FYHTMLTextView*)textView viewForAttachment:(FYAttachment*)attachment frame:(CGRect)frame;

@end
