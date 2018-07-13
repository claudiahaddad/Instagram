//
//  ProfileViewController.m
//  Instagram
//
//  Created by Claudia Haddad on 7/11/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet PFImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *username;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPhotoClick:(id)sender {
    [self performSegueWithIdentifier:@"selectSegue" sender:nil];

    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
