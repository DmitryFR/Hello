//
//  getUser.m
//  Hello
//
//  Created by Дмитрий Фролов on 18.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "getUser.h"
#import "Hello-Swift.h"
@implementation getUser 


//-(NSMutableDictionary*)getUserVK:(VKAccessToken*)tok{
//    VKRequest *request = [[VKApi users] get: @{VK_API_ACCESS_TOKEN: tok, VK_API_FIELDS: @"first_name, last_name, uid, photo_400_orig,sex"}];
//    [request executeWithResultBlock:^(VKResponse *response) {
//        NSLog(@"%@",response);
//        NSString *gender;
//        NSString *path = [[response.json firstObject]objectForKey:@"photo_400_orig"];
//        NSString *idd = [[[response.json firstObject]objectForKey:@"id"] stringValue];
//        if ([[response.json firstObject]objectForKey:@"sex"] == 1){
//            gender = @"Ж";
//        }
//        else if ([[response.json firstObject]objectForKey:@"sex"] == 2){
//            gender = @"М";
//        }
//        else { gender = @"X";}
//        self.currentUser = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[response.json firstObject]objectForKey:@"first_name"],@"first_name",[[response.json firstObject]objectForKey:@"last_name"],@"last_name",idd,@"id",path,@"photo_400_orig",gender,@"gender",@"",@"additionalInfo",@"",@"message", nil];
//    }
//                         errorBlock:^(NSError *error) {
//                             NSLog(@"Error: %@", error);
//                         }];
//    return self.currentUser;
//
//}

-(NSMutableDictionary *)getUserVK:(VKAccessToken *)tok{
    VKRequest *request = [[VKApi users] get: @{VK_API_ACCESS_TOKEN: tok, VK_API_FIELDS: @"first_name, last_name, uid,bdate, photo_100"}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Result: %@", response);
            }                    errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    return nil;
}

@end

