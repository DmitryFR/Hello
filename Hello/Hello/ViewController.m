//
//  ViewController.m
//  Hello
//
//  Created by Дмитрий Фролов on 05.11.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

#import "ViewController.h"
#import "Profile.h"
static NSString *const TOKEN_KEY = @"my_application_access_token";
static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"ToProfile";
static NSArray *SCOPE = nil;
@interface ViewController () <UIAlertViewDelegate, VKSdkUIDelegate>

@property (nonatomic, strong)VKAccessToken *res;
@property (strong, nonatomic)UITabBarController *tbController;
@end

@implementation ViewController

- (void)viewDidLoad {
    SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [super viewDidLoad];
    [[VKSdk initializeWithAppId:@"5711848"] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            _res = [VKSdk accessToken];
            [self startWorking];
        } else if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
}

- (void)startWorking {
  
    [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authorize:(id)sender {
    [VKSdk authorize:SCOPE];
}
// создание записи на стене
/*
- (IBAction)openShareDialog:(id)sender {
    VKShareDialogController *shareDialog = [VKShareDialogController new];
    shareDialog.text = @"This post created created created created and made and post and delivered using #vksdk #ios";
    shareDialog.uploadImages = @[ [VKUploadImage uploadImageWithImage:[UIImage imageNamed:@"apple"] andParams:[VKImageParameters jpegImageWithQuality:1.0] ] ];
    [shareDialog setCompletionHandler:^(VKShareDialogController *dialog, VKShareDialogControllerResult result) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:shareDialog animated:YES completion:nil];
}*/


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self.navigationController.topViewController];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self authorize:nil];
}

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token ) {
        self.res = result;
       
        [self startWorking];
    } else if (result.error) {
        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Access denied\n%@", result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.tbController = (UITabBarController *)[segue destinationViewController];
    Profile *prof = [self.tbController.viewControllers objectAtIndex:0];
    prof.res = self.res;
    
}
- (void)vkSdkUserAuthorizationFailed {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}


@end