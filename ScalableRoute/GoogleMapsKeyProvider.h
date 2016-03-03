//
//  GoogleMapsKeyProvider.h
//  ScalableRoute
//
//  Created by Vladimir Yanov on 2/12/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleMapsKeyProvider : NSObject
+ (void)generateDebugApiKeyFile;
+ (NSString *)debugMapsApiKey;
+ (NSString *)debugDirectionsApiKey;
@end
