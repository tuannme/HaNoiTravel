//
//  MainViewController.m
//  HaNoiTravel
//
//  Created by TRAMS on 8/11/16.
//  Copyright © 2016 DREAMUP. All rights reserved.
//

#import "MainViewController.h"
#import "DirectionService.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *naviView;
@property (weak, nonatomic) IBOutlet UIView *windowsView;

@property (weak, nonatomic) IBOutlet UIButton *grabTravelBtn;
@property (weak, nonatomic) IBOutlet UIButton *placeBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UIView *slideLineView;

- (IBAction)grabTravelAction:(id)sender;
- (IBAction)placeAction:(id)sender;
- (IBAction)accountAction:(id)sender;

@end

#define COLOR_BTN_NORMAL [UIColor colorWithRed:120.0/255 green:120.0/255 blue:120.0/255 alpha:1]
#define COLOR_BTN_SELECTED [UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1]

@implementation MainViewController{
  CGFloat frameW;
  CGFloat frameH;
  CGRect slideFrame;
  
  GMSMapView *mapView_;
  NSMutableArray *waypoints_;
  NSMutableArray *waypointStrings_;
  CLLocationManager *locationManager;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  frameH = [[UIScreen mainScreen] bounds].size.height;
  frameW = [[UIScreen mainScreen]bounds].size.width;
  slideFrame = _slideLineView.frame;
  slideFrame.size.width = 108*frameW/320;
  
  _placeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  
  [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  [_placeBtn setTitleColor:COLOR_BTN_SELECTED  forState:UIControlStateNormal];
  [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  
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


- (IBAction)grabTravelAction:(id)sender {
  _grabTravelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  _placeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  
  [_grabTravelBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
  [_placeBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  
  [UIView animateWithDuration:0.2 animations:^{
    slideFrame.origin.x = 0;
    _slideLineView.frame = slideFrame;
  }];
}

- (IBAction)placeAction:(id)sender {
  _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  _placeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  
  [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  [_placeBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
  [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  
  [UIView animateWithDuration:0.2 animations:^{
    slideFrame.origin.x = slideFrame.size.width;;
    _slideLineView.frame = slideFrame;
  }];
}

- (IBAction)accountAction:(id)sender {
  _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  _placeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
  _accountBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  
  [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  [_placeBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
  [_accountBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
  
  [UIView animateWithDuration:0.2 animations:^{
    slideFrame.origin.x = 2*slideFrame.size.width;
    _slideLineView.frame = slideFrame;
  }];
}

#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:
(CLLocationCoordinate2D)coordinate {
  
  CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
                                                               coordinate.latitude,
                                                               coordinate.longitude);
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
  [self.windowsView addSubview:mapView_];
}

@end
