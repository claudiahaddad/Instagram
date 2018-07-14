//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Claudia Haddad on 7/13/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>


@interface PostCollectionCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *postImage;
- (void)setContents;

@end
