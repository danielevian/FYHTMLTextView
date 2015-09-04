//
//  FYTextViewAttributes.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <UIKit/UIKit.h>

@interface FYTextViewAttributes : NSObject

@property (nonatomic, strong) NSDictionary *attributes;

- (instancetype)initWithFontFamily:(NSString*)fontFamily fontName:(NSString*)fontName fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor linkColor:(UIColor*)linkColor linkDecoration:(NSUnderlineStyle)linkDecoration textAlignment:(NSTextAlignment)textAlignment lineHeightMultiplier:(CGFloat)lineHeightMultiplier;

@end
