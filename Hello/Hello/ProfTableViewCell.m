//
//  ProfTableViewCell.m
//  Hello
//
//  Created by Дмитрий Фролов on 19.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "ProfTableViewCell.h"
#import "AppDelegate.h"
@interface ProfTableViewCell()
@property AppDelegate *appdelegate;
@property NSManagedObjectContext *context;
//@property (retain, nonatomic)NSManagedObject *manObj;

@end
@implementation ProfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.appdelegate = [[UIApplication sharedApplication]delegate];
    self.context = self.appdelegate.persistentContainer.viewContext;
}

-(void)aalpha{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)addToFavBtnPressed:(id)sender {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Chat" inManagedObjectContext:self.context];
    NSManagedObject *manObj = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:self.context];
    [manObj setValue:[self.currentUser valueForKey:@"id"] forKey:@"userID"];
    [_appdelegate saveContext];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Пользователь успешно добавлен в избранное" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
