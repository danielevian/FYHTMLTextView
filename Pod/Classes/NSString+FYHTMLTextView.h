//
//  NSString+FYHTMLTextView.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (FYHTMLTextView)

- (NSString*)parseHTMLContentWithRegisteredObjects:(NSArray*)registeredObjects;
- (NSString*)removeTagsWithName:(NSString*)tag;

@end
