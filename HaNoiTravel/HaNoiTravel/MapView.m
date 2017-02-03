//
//  MapView.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "MapView.h"
#import "DirectionService.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "User.h"

@interface MapView ()<GMSMapViewDelegate,CLLocationManagerDelegate>

@property (strong,nonatomic) void (^completion)(BOOL done);

@end

@implementation MapView{
    CGFloat frameW;
    CGFloat frameH;
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    CLLocationManager *locationManager;
    GMSMarker *myMarker;
    BOOL isShowDirection;
    
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    frameW = frame.size.width;
    frameH = frame.size.height;
    return self;
}

- (void) startLoadMapCompletion:(void(^)(BOOL done))completion{
    
    self.completion = completion;
    
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    myMarker = [[GMSMarker alloc] init];
    
    mapView_ = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    mapView_.delegate = self;
    [self addSubview:mapView_];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
}

- (void) showDirection:(BOOL)show{
    isShowDirection = show;
}

- (void) resetMapAtAddress:(NSString*) address{
    //https://maps.googleapis.com/maps/api/geocode/json?address=대한민국 경기도 김포시&key=AIzaSyD1QCgT0qX-BfkHBIxOG3UemOGpEA1FT_0
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://maps.googleapis.com"]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *path = [NSString stringWithFormat:@"maps/api/geocode/json?address=%@&key=AIzaSyBJXeGpMwsRCdK-sKgvAMsax0RZV2wY5X4",address];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //대한민국 경기도 김포시
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"OK"]){
            id result = [responseObject objectForKey:@"results"];
            id geoObj = [result lastObject];
            id geometry = [geoObj objectForKey:@"geometry"];
            id location = [geometry objectForKey:@"location"];
            
            float lat = [[location objectForKey:@"lat"] floatValue];
            float lng = [[location objectForKey:@"lng"] floatValue];
            
            NSString *address = [geoObj objectForKey:@"formatted_address"];
            
            [[User shareInstance] setLatitude:lat];
            [[User shareInstance] setLongitude:lng];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMap:lat lgn:lng address:address];
            });
            
        }else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"검색 실패" message:@"해당 지역을 검색할 수 없습니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ERROR MAP : %@",error);
    }];
    
}

#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    if(!isShowDirection){
        
        [[User shareInstance] setLatitude:coordinate.latitude];
        [[User shareInstance] setLongitude:coordinate.longitude];
        [self getAddressWithLatitude:coordinate.latitude longitude:coordinate.longitude completion:^(NSString *address){
            //[mapView_ clear];
             [self showMap:coordinate.latitude lgn:coordinate.longitude address:address];
        }];
        
    }else{
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
    
    if(self.completion == nil){
        [self getAddressWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude completion:^(NSString *address){
            
            [self showMap:newLocation.coordinate.latitude lgn:newLocation.coordinate.longitude address:address];
            
        }];
    }else if([[User shareInstance] latitude] == 0){
        [[User shareInstance] setLatitude:newLocation.coordinate.latitude];
        [[User shareInstance] setLongitude:newLocation.coordinate.longitude];
        self.completion(YES);
    }
    
}

- (void) getAddressWithLatitude:(CGFloat)lat longitude:(CGFloat)lgn completion:(void(^)(NSString *address))completion{
    
    GMSGeocoder* geocoder = [[GMSGeocoder alloc] init];
    [geocoder reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lat, lgn)
                     completionHandler:^(GMSReverseGeocodeResponse *placeMarks, NSError *error) {
                         if (!error)
                         {
                             NSMutableString *address = [NSMutableString stringWithString:@""];
                             
                             GMSAddress* result = [placeMarks firstResult]; //첫번째 결과값
                             if(result.administrativeArea != nil)
                                 [address appendString:[result.administrativeArea stringByAppendingString:@" "]];
                             if(result.locality != nil)
                                 [address appendString:[result.locality stringByAppendingString:@" "]];
                             if(result.subLocality != nil)
                                 [address appendString:[result.subLocality stringByAppendingString:@" "]];
                             if(result.thoroughfare != nil)
                                 [address appendString:[result.thoroughfare stringByAppendingString:@" "]];
                             completion(address);
                         }
                     }];
    
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [self showMap:21.024303 lgn:105.841093 address:@"Ga Hà Nội"];
}

- (void) showMap:(CGFloat)lat lgn:(CGFloat)lgn address:(NSString*)address{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lgn
                                                                 zoom:12];
    
    mapView_.camera = camera;
    myMarker.position = CLLocationCoordinate2DMake(lat,lgn);;
    myMarker.map = mapView_;
    myMarker.title = address;
    
    
}


- (void) setPlaces:(NSMutableArray*)arrPlaces withIcon:(NSString*)iconName{
    
    UIImage *image = [self imageWithImage:[UIImage imageNamed:iconName] scaledToSize:CGSizeMake(20, 20)];
    for(Place *place in arrPlaces){
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.latitude,place.longitude);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.snippet = [NSString stringWithFormat:@"%@\n%@",place.name,place.address];
        marker.icon = image;
        marker.map = mapView_;
        
    }
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
