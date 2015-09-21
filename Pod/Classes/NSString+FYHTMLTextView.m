//
//  NSString+FYHTMLTextView.m
//  
//
//  Created by Francisco Yarad on 9/4/15.
//
//

#import "NSString+FYHTMLTextView.h"

@implementation NSString (FYHTMLTextView)

- (NSString*)parseHTMLContentWithRegisteredObjects:(NSArray *)registeredObjects {
    
    __block NSString *result = [[NSString alloc] initWithString:self];
    
    [[result componentsSeparatedByString:@"<iframe "] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSRange endRange = [obj rangeOfString:@"</iframe>"];
        
        if (endRange.location != NSNotFound) {
            
            NSString *string = [obj substringWithRange:NSMakeRange(0, endRange.location)];
            NSString *newObject = nil;
            
            if ([NSString urlIsYoutube:string] && [registeredObjects containsObject:@"youtube"]) {
                newObject = [string createYoutubeObject];
                
            }
            
            if (string && newObject) {
                result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<iframe %@</iframe>", string] withString:newObject];
            }
        }
        
    }];
    
    [[result componentsSeparatedByString:@"<blockquote "] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSRange endRange = [obj rangeOfString:@"</blockquote>"];
        
        if (endRange.location != NSNotFound) {
            
            NSString *string = [obj substringWithRange:NSMakeRange(0, endRange.location)];
            NSString *newObject = nil;
            
            if ([obj stringContains:@"class=\"instagram-media\""] && [registeredObjects containsObject:@"instagram"]) {
                newObject = [string createInstagramObject];
            }
            else if (([obj stringContains:@"class=\"twitter-tweet\""] || [obj stringContains:@"class=\"twitter-video\""]) && [registeredObjects containsObject:@"twitter"]) {
                newObject = [string createTwitterObject];
            }
            else if ([obj stringContains:@"cite"]) {
                NSString *citeURL = [string getCiteURL];
                if ([citeURL stringContains:@"facebook.com"] && [registeredObjects containsObject:@"facebook"]) {
                    
                    if ([citeURL stringContains:@"posts"]) {
                        newObject = [citeURL createFacebookPostObject];
                    }
                    
                }
            }
            if (string && newObject) {
                result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<blockquote %@</blockquote>", string] withString:newObject];
            }
        }
        
    }];
    
    return result;

    
}
- (NSString*)removeTagsWithName:(NSString*)tag {
    __block NSString *result = [[NSString alloc] initWithString:self];
    [[result componentsSeparatedByString:[NSString stringWithFormat:@"<%@ ", tag]] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSRange endRange = [obj rangeOfString:[NSString stringWithFormat:@"</%@>", tag]];
        if (endRange.location != NSNotFound) {
            result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<%@ %@</%@>", tag, [obj substringWithRange:NSMakeRange(0, endRange.location)], tag] withString:@""];
        }
        
    }];
    return result;
}

#pragma mark - Cite (Dynamic)

- (NSString*)getCiteURL {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"cite=\"" withString:@""];
    NSArray *array = [string componentsSeparatedByString:@"\""];
    return (array.count > 0) ? array[0] : nil;
}

#pragma mark - Instagram

- (NSString*)createInstagramObject {
    NSString *mediaId = [self getInstagramMediaId];
    return (mediaId) ? [NSString stringWithFormat:@"<instagram media_id=\"%@\"></instagram>", mediaId] : nil;
}
- (NSString*)getInstagramMediaId {
    __block NSString *postId = nil;
    [[self componentsSeparatedByString:@"https://instagram.com/p/"] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 1) {
            NSArray *components = [obj componentsSeparatedByString:@"/"];
            if (components.count > 0) postId = components[0];
        }
    }];
    return postId;
}

#pragma mark - Twitter

- (NSString*)createTwitterObject {
    NSString *tweetId = [self getTweetId];
    return (tweetId) ? [NSString stringWithFormat:@"<twitter media_id=\"%@\"></twitter>", tweetId] : nil;
}
- (NSString*)getTweetId {
    __block NSString *tweetId = nil;
    [[self componentsSeparatedByString:@"/status/"] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 1) {
            NSArray *components = [obj componentsSeparatedByString:@"\""];
            if (components.count > 0) {
                NSArray *url = [components[0] componentsSeparatedByString:@"/status/"];
                if (url) tweetId = url[0];
            }
        }
    }];
    return tweetId;
}

#pragma mark - Facebook

- (NSString*)createFacebookPostObject {
    return [NSString stringWithFormat:@"<iframe src=\"%@\"></iframe>", self];
    //return [NSString stringWithFormat:@"<facebook-post cite=\"%@\"></facebook-post>", self];
}

#pragma mark - Youtube

- (NSString*)createYoutubeObject {
    NSString *youtubeId = [self getYoutubeId];
    return (youtubeId) ? [NSString stringWithFormat:@"<youtube media_id=\"%@\"></youtube>", youtubeId] : nil;
}
- (NSString*)getYoutubeId {
    __block NSString *postId = nil;
    
    [[self componentsSeparatedByString:@"\""] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if ([obj stringContains:@"http"]) postId = [NSString getYouTubeIdFromURL:[NSURL URLWithString:obj]];
    }];
    
    return postId;
}
+ (NSString*)getYouTubeIdFromURL:(NSURL*)videoURL {
    NSString *result = nil;
    if ([videoURL.absoluteString stringContains:@"youtu.be/"] || ([videoURL.absoluteString stringContains:@"youtube.com/"] && [videoURL.absoluteString stringContains:@"embed"])) {
        result = videoURL.pathComponents.lastObject;
    }
    else if ([videoURL.absoluteString stringContains:@"youtube.com"] && [videoURL.absoluteString stringContains:@"watch?v="]) {
        result = [[[[[[[[videoURL.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@""] stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"www." withString:@""] stringByReplacingOccurrencesOfString:@"youtube.com/" withString:@""] stringByReplacingOccurrencesOfString:@"watch?v=" withString:@""] stringByAppendingString:@"&end"] componentsSeparatedByString:@"&"] firstObject];
        
    }
    return result;
}
+ (BOOL)urlIsYoutube:(NSString *)url {
    return ([url stringContains:@"youtube.com"] || [url stringContains:@"youtu.be"]);
}

#pragma mark - Helpers

- (BOOL)stringContains:(NSString *)string {
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:string];
    }
    else {
        return ([self rangeOfString:string].location != NSNotFound);
    }
}

@end
