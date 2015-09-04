//
//  FYTextViewAttributes.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "FYTextViewAttributes.h"
#import "DTCoreText.h"

@implementation FYTextViewAttributes

- (instancetype)initWithFontFamily:(NSString *)fontFamily fontName:(NSString *)fontName fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor linkColor:(UIColor *)linkColor linkDecoration:(NSUnderlineStyle)linkDecoration textAlignment:(NSTextAlignment)textAlignment lineHeightMultiplier:(CGFloat)lineHeightMultiplier {
    self = [super init];
    if (self) {

        self.attributes = @{
                            DTDefaultFontFamily: fontFamily ?: @"Helvetica",
                            DTDefaultFontName: fontName ?: @"Helvetica",
                            DTDefaultFontSize: @(fontSize),
                            DTDefaultTextColor: textColor ?: [UIColor blackColor],
                            DTDefaultLinkColor: linkColor ?: [UIColor blueColor],
                            DTDefaultLinkDecoration: @(linkDecoration),
                            DTDefaultTextAlignment: @(textAlignment),
                            DTDefaultLineHeightMultiplier: @((lineHeightMultiplier > 0 ? lineHeightMultiplier : 1.0))
                            };

    }

    return self;
}

@end
