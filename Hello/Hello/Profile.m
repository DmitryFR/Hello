//
//  Profile.m
//  Hello
//
//  Created by Дмитрий Фролов on 12.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "Profile.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>
#import "Hello-Swift.h"
static VKAuthorizationResult *ress;
@interface Profile ()<CLLocationManagerDelegate>{
    CLLocationManager *locManager;
    NSNumber *lat;
    NSNumber *lon;
}


@end

@implementation Profile

- (void)viewDidLoad {
     [super viewDidLoad];
    self.rootRef = [[FIRDatabase database]reference];
    
    
   // ress = _res;
   
    VKRequest *request = [[VKApi users] get: @{VK_API_ACCESS_TOKEN: _res, VK_API_FIELDS: @"first_name, last_name, uid,bdate, photo_100"}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Result: %@", response);
        self.name.text = [[response.json firstObject] objectForKey:@"first_name"];
        self.fam.text = [[response.json firstObject] objectForKey:@"last_name"];
        NSNumber *idd =[[response.json firstObject] objectForKey:@"id"];
        self.idd.text = [idd stringValue];
        self.bdate.text = [[response.json firstObject] objectForKey:@"bdate"];
        NSString *path = [[response.json firstObject] objectForKey:@"photo_100"];
        self.img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
        
        // [_rootRef.childByAutoId setValue: [[response.json firstObject] objectForKey:@"first_name"]forKey:@"fisrt_name"];
//        [[[_rootRef child:@"users" ]child: self.idd.text ]setValue:@{@"first_name":self.name.text }];
//        [[[_rootRef child:@"users" ]child: self.idd.text ]setValue:@{@"last_name":self.fam.text }];
//        [[[_rootRef child:@"users" ]child: self.idd.text ]setValue:@{@"imgPath":path}];
//        [[[_rootRef child:@"users" ]child: self.idd.text ]setValue:@{@"bdate":self.bdate.text }];
       // [[_rootRef child:@"users" ]setValue:@{self.idd.text:[response.json firstObject]}];
        [[_rootRef child:@"users"]updateChildValues:@{self.idd.text:[response.json firstObject]}];
    }                    errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
   
    
    }
-(void)viewDidAppear:(BOOL)animated{
    self.usr = [NSDictionary dictionaryWithObjectsAndKeys:self.name.text,@"first_name", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    locManager = [[CLLocationManager alloc]init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locManager requestAlwaysAuthorization];
    
    [locManager startUpdatingLocation];
}

//ibeacon - определение тех кто рядома по блютус
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;//получение времени обновления геолокации
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];// временной интервал с последнео обновления до текущего времени
    if (fabs(howRecent)< 15.0){
        lat = [NSNumber numberWithDouble:location.coordinate.latitude];
        lon = [NSNumber numberWithDouble:location.coordinate.longitude];
    }
}



-(void)viewDidDisappear:(BOOL)animated{
   ProbaViewController *tabl = [self.tabBarController.viewControllers objectAtIndex:1];
    tabl.tok = self.res;
}



- (IBAction)logout:(id)sender {
    [VKSdk forceLogout];
//    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"regPage"];
//    [self presentViewController:vc animated:YES completion:nil];
}
@end