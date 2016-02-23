//
//  SRSessionManager.m
//  ScalableRoute
//
//  Created by Stanislav Shpak on 2/1/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import "SRSessionManager.h"
#import "GoogleMapsKeyProvider.h"

@implementation SRSessionManager

+ (SRSessionManager *)sharedManager {
    static SRSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[SRSessionManager alloc] init];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    return sessionManager;
}

/*!
 * @discussion Get route from GoogleMaps Directions API
 * @param origin CLLocationCoordinate2D coordinate of origin point
 * @param destinaiton CLLocationCoordinate2D coordinate of destinaiton point
 * @param waypoints NSArray array of waypoints coodinate
 * @param completion completion block
 */
- (void)directionWithOrigin:(CLLocationCoordinate2D)origin
                destinaiton:(CLLocationCoordinate2D)destinaiton
                  waypoints:(NSArray *)waypoints
                 completion:(void(^)(NSString *result, NSError* error))completion { // make points result instead of string
    
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.latitude, origin.longitude];
    NSString *destinaitonString = [NSString stringWithFormat:@"%f,%f", destinaiton.latitude, destinaiton.longitude];
    
    NSString *waypointsString = @"";
    for (int i = 0; i < waypoints.count; i++) {
        NSValue *coordinateObj = waypoints[i];
        CLLocationCoordinate2D coordinate;
        [coordinateObj getValue:&coordinate];
        
        NSString *waypointCoordinateString = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
        waypointsString = [NSString stringWithFormat:@"%@%@", i>0?@"%7C":@"", waypointCoordinateString];
    }
    
    NSDictionary *params = @{@"origin": originString,
                             @"destination": destinaitonString,
                             @"sensor": @NO,
                             @"waypoints": waypointsString,
                             @"key": [GoogleMapsKeyProvider debugApiKey]}; // provide directions api key here
    
    [self GET:kDirectionsGoogleMapsApi parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
