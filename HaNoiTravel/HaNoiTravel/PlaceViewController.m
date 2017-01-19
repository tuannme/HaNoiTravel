//
//  PlaceViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/13/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceViewController.h"
#import "DirectionService.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface PlaceViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation PlaceViewController{
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    CLLocationManager *locationManager;
    
    CGFloat frameW;
    CGFloat frameH;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    frameW = [[UIScreen mainScreen] bounds].size.width;
    frameH = [[UIScreen mainScreen] bounds].size.height;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:
(CLLocationCoordinate2D)coordinate {
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = mapView_;
    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                coordinate.latitude,coordinate.longitude];
    [waypointStrings_ addObject:positionString];
    if([waypoints_ count]>1){
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                               nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                          forKeys:keys];
        DirectionService *mds=[[DirectionService alloc] init];
        SEL selector = @selector(addDirections:);
        [mds setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    }
}
- (void)addDirections:(NSDictionary *)json {
    
    NSArray *routes = [json objectForKey:@"routes"];
    
    if(routes && routes.count){
        NSDictionary *route = [routes[0] objectForKey:@"overview_polyline"];
        NSString *overview_route = [route objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.map = mapView_;
    }
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [locationManager stopUpdatingLocation];
    
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:13];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, frameW, 458*frameH/568) camera:camera];
    mapView_.delegate = self;
    [self.view addSubview:mapView_];
}


@end
