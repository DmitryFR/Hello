//
//  Profile.h
//  Hello
//
//  Created by Дмитрий Фролов on 12.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VK_ios_sdk/VKSdk.h>
#import <Firebase.h>

@interface Profile : UIViewController{
@private
    VKRequest *callingRequest;
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fam;
@property (weak, nonatomic) IBOutlet UILabel *bdate;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *idd;

- (IBAction)logout:(id)sender;


@property (nonatomic, strong)VKAccessToken *res;
@property (nonatomic, strong)FIRDatabaseReference *rootRef;
@property (nonatomic, strong)NSMutableDictionary *usr;
@end
