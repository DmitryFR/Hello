//
//  chatViewController.h
//  Hello
//
//  Created by Дмитрий Фролов on 21.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VKSdkFramework/VKSdkFramework.h>
@interface chatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messg;
- (IBAction)sendMsg:(id)sender;
@property (strong, nonatomic)NSDictionary *loggedUser;
@property (strong, nonatomic)VKAccessToken *tok;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end