//
//  HTPChooseViewController.h
//  Hello
//
//  Created by Дмитрий Фролов on 21.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VK_ios_sdk/VKSdk.h>
@interface HTPChooseViewController : UIViewController <VKSdkDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *ident;
- (IBAction)goForChat:(id)sender;

@property (strong, nonatomic)NSDictionary *loggedUser;
@property (strong, nonatomic)VKAccessToken *tok;
@end
