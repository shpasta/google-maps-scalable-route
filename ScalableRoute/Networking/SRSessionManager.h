//
//  SRSessionManager.h
//  ScalableRoute
//
//  Created by Stanislav Shpak on 2/1/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/*!
 * @discussion Manager for HTTP network calls
 */
@interface SRSessionManager : AFHTTPSessionManager

+ (SRSessionManager *)sharedManager;

@end
