//
//  getUser.h
//  Hello
//
//  Created by Дмитрий Фролов on 18.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VK_ios_sdk/VKSdk.h>
@interface getUser : NSObject <VKSdkDelegate,VKSdkUIDelegate>
@property (strong, nonatomic)NSMutableDictionary *currentUser;
-(NSMutableDictionary*)getUserVK:(VKAccessToken*)tok;
@end
