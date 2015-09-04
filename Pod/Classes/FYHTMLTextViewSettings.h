//
//  FYHTMLTextViewSettings.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <Foundation/Foundation.h>

@interface FYHTMLTextViewSettings : NSObject

+ (instancetype)sharedInstance;
+ (void)registerClass:(Class)className tagName:(NSString*)name;

@end