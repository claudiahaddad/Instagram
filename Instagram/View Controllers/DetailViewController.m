//
//  DetailViewController.m
//  Instagram
//
//  Created by Claudia Haddad on 7/10/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import "HomeViewController.h"
#import "NSDate+DateTools.h"



@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet PFImageView *photoPost;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoPost.file = self.post.image;
    [self.photoPost loadInBackground];
    self.captionLabel.text = self.post.caption;
    PFUser *user = self.post[@"author"];
    self.userLabel.text = user.username;
    
    //timestamp
    NSDate *timestamp = self.post.createdAt;
 
    NSString *timeInterval = [NSDate shortTimeAgoSinceDate:timestamp];
  //  NSString *timeString = timeInterval;
    self.timestampLabel.text = timeInterval;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
