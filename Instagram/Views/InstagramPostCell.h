//
//  InstagramPostCell.h
//  Instagram
//
//  Created by Claudia Haddad on 7/10/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface InstagramPostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *imagePost;
@property (strong, nonatomic) IBOutlet UILabel *captionPost;
@property (strong, nonatomic) IBOutlet UILabel *userPost;

@end
