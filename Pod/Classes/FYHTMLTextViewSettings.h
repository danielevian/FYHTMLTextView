//
//  FYHTMLTextViewSettings.h
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import <Foundation/Foundation.h>

@interface FYHTMLTextViewSettings : NSObject

@property (nonatomic, strong) NSArray *blockedTags;
@property (nonatomic, strong) NSArray *registeredTags;

+ (instancetype)sharedInstance;
+ (void)registerClass:(Class)className tagName:(NSString*)name;

@end