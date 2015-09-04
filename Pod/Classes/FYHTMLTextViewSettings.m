//
//  FYHTMLTextViewSettings.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "FYHTMLTextViewSettings.h"
#import "DTAttributedTextView.h"
#import "FYAttachment.h"

@implementation FYHTMLTextViewSettings

+ (instancetype)sharedInstance {
    static FYHTMLTextViewSettings *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FYHTMLTextViewSettings alloc] init];
    });
    return _sharedInstance;
}
+ (void)registerClass:(Class)className tagName:(NSString *)name {
    [[self sharedInstance] setRegisteredTags:[[[self sharedInstance] registeredTags] arrayByAddingObject:name]];
    [DTTextAttachment registerClass:className forTagName:name];
}

@end
