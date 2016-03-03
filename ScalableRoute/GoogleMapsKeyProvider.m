//
//  GoogleMapsKeyProvider.m
//  ScalableRoute
//
//  Created by Vladimir Yanov on 2/12/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import "GoogleMapsKeyProvider.h"

@implementation GoogleMapsKeyProvider
static NSString *kGoogleMapsApiKey = @"GoogleMapsApiKey";
static NSString *kGoogleDirectionsApiKey = @"GoogleDirectionssApiKey";

+ (NSString *)filePath
{
    return [PROJECT_DIR stringByAppendingPathComponent:@"GoogleMapsKey.plist"];
}

+ (void)generateDebugApiKeyFile
{
    NSDictionary *d = @{kGoogleMapsApiKey:@"123456789",
                        kGoogleDirectionsApiKey:@"123456789"};
    [d writeToFile:[self filePath] atomically:YES];
}

+ (NSString *)debugMapsApiKey
{
    NSString *filePath = [self filePath];
    
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:filePath];

    if (!d &&  ![d objectForKey:kGoogleMapsApiKey])
    {
        NSString *reason = [NSString stringWithFormat:@"Bad access to %@. If you don't have Google Maps key, generate it first.", filePath];
        @throw [NSException exceptionWithName:@"GoogleMapsKeyProvider debugApiKey exception" reason:reason userInfo:nil];
    }
    
    return d[kGoogleMapsApiKey];
}

+ (NSString *)debugDirectionsApiKey
{
    NSString *filePath = [self filePath];
    
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    if (!d &&  ![d objectForKey:kGoogleDirectionsApiKey])
    {
        NSString *reason = [NSString stringWithFormat:@"Bad access to %@. If you don't have Google Directions key, generate it first.", filePath];
        @throw [NSException exceptionWithName:@"GoogleMapsKeyProvider debugApiKey exception" reason:reason userInfo:nil];
    }
    
    return d[kGoogleDirectionsApiKey];
}

@end
