//
//  ViewController.m
//  ScalableRoute
//
//  Created by Stanislav Shpak on 1/28/16.
//  Copyright © 2016 Stanislav Shpak. All rights reserved.
//

#import "ViewController.h"
#import "SRSessionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "GoogleMaps/GoogleMaps.h"

@interface ViewController () <GMSMapViewDelegate> {
//    CLLocationCoordinate2D _origin;
//    CLLocationCoordinate2D _destination;

    CLLocation *_origin;
    CLLocation *_destination;
}

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)actionReset:(id)sender {
    _origin = nil;
    _destination = nil;
    [self.mapView clear];
}

#pragma mark - GMSMapView Delegate -

//https://developers.google.com/maps/documentation/ios-sdk/reference/protocol_g_m_s_map_view_delegate-p.html#a0499f484d9ea51041babd3ac8dcc7b27

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if (CLLocationCoordinate2DIsValid(coordinate) == false) {
        NSLog(@"Warning: Location is invalid: %f, %f", coordinate.latitude, coordinate.longitude);
        return;
    }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    if (_origin != nil && _destination != nil) {
        return;
    } else if (_origin == nil) {
        GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
        marker.title = @"Origin";
        marker.map = self.mapView;
        _origin = location;
    } else if (_destination == nil) {
        GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
        marker.title = @"Destination";
        marker.map = self.mapView;
        _destination = location;
        
        [[SRSessionManager sharedManager] directionWithOrigin:_origin.coordinate destinaiton:_destination.coordinate waypoints:@[] completion:^(NSString *result, NSError *error){
            if (!error) {
                NSLog(@"%@", result);
            } else {
                NSLog(@"Error: %@", error.localizedDescription);
            }

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
