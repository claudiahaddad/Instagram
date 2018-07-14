//
//  ProfileViewController.m
//  Instagram
//
//  Created by Claudia Haddad on 7/11/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "PostCollectionCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet PFImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (nonatomic, strong) NSArray *posts;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // Do any additional setup after loading the view.
    [self getPosts];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat postsPerLine = 3;
    CGFloat itemWidth = self.collectionView.frame.size.width / postsPerLine;

    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPosts {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"image"];
    [postQuery includeKey:@"createdAt"];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)onPhotoClick:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImage.image = editedImage;
    //PFFile *imageFile = [self getPFFileFromImage:editedImage];
    
    PFUser *user = PFUser.currentUser;
    user[@"image"] = [Post getPFFileFromImage:editedImage];
    [user saveInBackground];
    if (user) {
        self.profileImage.file = user[@"image"];
    }
    [self.profileImage loadInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    
    [cell setContents];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}



@end
