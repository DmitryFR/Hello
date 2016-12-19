//
//  ProfTableViewCell.h
//  Hello
//
//  Created by Дмитрий Фролов on 19.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ChatButton;
@property (weak, nonatomic) IBOutlet UIView *FavoriteUserButton;
@property (weak, nonatomic) IBOutlet UIButton *ChatButtonTap;
@property (weak, nonatomic) IBOutlet UIImageView *ImageChat;
@property (weak, nonatomic) IBOutlet UIButton *FavoriteButtonTap;
@property (weak, nonatomic) IBOutlet UIImageView *ImageFavoriteUser;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfoField;
@property (weak, nonatomic) IBOutlet UILabel *fam;

@property(strong, nonatomic)NSMutableDictionary *currentUser;
@property NSInteger *Focus;
-(void) aalpha;
@end
