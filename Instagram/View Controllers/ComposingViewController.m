//
//  ComposingViewController.m
//  Instagram
//
//  Created by Claudia Haddad on 7/9/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "ComposingViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import <Photos/Photos.h>

@interface ComposingViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imagePost;
@property (strong, nonatomic) IBOutlet UITextField *captionPost;


@end

@implementation ComposingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   //  *imageSize = CGSizeMake(width, height);
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
   UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.imagePost.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//TO DO: add functionality to share button

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

- (IBAction)onShare:(id)sender {
    NSString *caption = self.captionPost.text;
    UIImage *picture = self.imagePost.image;
 
    UIImage *resizedPic = [self resizeImage:picture withSize:CGSizeMake(100,100)];
    
    [Post postUserImage:resizedPic withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    [self dismissViewControllerAnimated:true completion:nil];

    
}
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

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
