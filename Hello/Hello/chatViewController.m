//
//  chatViewController.m
//  Hello
//
//  Created by Дмитрий Фролов on 21.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "chatViewController.h"

@interface chatViewController ()
@property (strong, nonatomic) NSArray *msgArr;
@property (strong, nonatomic)NSDictionary *dict;
@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    }

-(void)viewWillAppear:(BOOL)animated{
    NSNumber *idd = [self.loggedUser valueForKey:@"id"];
    VKRequest *history_req = [VKRequest requestWithMethod:@"messages.getHistory" parameters:@{VK_API_USER_ID: @"15157193", VK_API_COUNT:@20}];
    [history_req executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Result: %@", response);
        self.msgArr = [response.json valueForKey:@"items"];
        self.tableView.reloadData;
        
    }
                             errorBlock:^(NSError *error) {
                                 NSLog(@"Error: %@", error);
                             }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ([self.msgArr[indexPath.row]valueForKey:@"from_id" ] == [self.loggedUser valueForKey:@"id"]){
        cell.textLabel.text = [self.msgArr[indexPath.row] valueForKey:@"body"];
        cell.textLabel.textAlignment = UITextAlignmentRight;
    }
    else{
        cell.textLabel.text = [self.msgArr[indexPath.row] valueForKey:@"body"];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
    }
    return cell;
}

- (IBAction)sendMsg:(id)sender {
    NSNumber *idd = [self.loggedUser valueForKey:@"id"];
    NSString *method = @"messages.send";
    VKRequest *req = [VKRequest requestWithMethod:method parameters:@{VK_API_ACCESS_TOKEN: self.tok, VK_API_USER_ID: idd, VK_API_MESSAGE: self.messg.text }];
    [req executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Result: %@", response);
            }
                     errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
self.messg.text = @"";
   
    VKRequest *history_req = [VKRequest requestWithMethod:@"messages.getHistory" parameters:@{VK_API_USER_ID: @"15157193", VK_API_COUNT:@20}];
    [history_req executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Result: %@", response);
        self.msgArr = [response.json valueForKey:@"items"];
        self.tableView.reloadData;
        
    }
                             errorBlock:^(NSError *error) {
                                 NSLog(@"Error: %@", error);
                             }];
    }
@end
