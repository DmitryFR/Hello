//
//  HTPChooseViewController.m
//  Hello
//
//  Created by Дмитрий Фролов on 21.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "HTPChooseViewController.h"
#import "chatViewController.h"
@interface HTPChooseViewController ()

@end

@implementation HTPChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.lastname.text = [self.loggedUser valueForKey:@"last_name"];
    NSNumber *idd = [self.loggedUser valueForKey:@"id"];
    self.ident.text = [idd stringValue];
    
}



- (IBAction)goForChat:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"chat"]){
        chatViewController *vc  = segue.destinationViewController;
        vc.tok = self.tok;
        vc.loggedUser = self.loggedUser;
    }
}


@end
