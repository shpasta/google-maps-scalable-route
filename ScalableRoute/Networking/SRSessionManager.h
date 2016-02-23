//
//  SRSessionManager.h
//  ScalableRoute
//
//  Created by Stanislav Shpak on 2/1/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

/*!
 * @discussion Manager for HTTP network calls
 */
@interface SRSessionManager : AFHTTPSessionManager

+ (SRSessionManager *)sharedManager;

- (void)directionWithOrigin:(CLLocationCoordinate2D)origin
                destinaiton:(CLLocationCoordinate2D)destinaiton
                  waypoints:(NSArray *)waypoints
                 completion:(void(^)(NSString *result, NSError* error))completion;

@end
