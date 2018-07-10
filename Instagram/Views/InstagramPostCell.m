//
//  InstagramPostCell.m
//  Instagram
//
//  Created by Claudia Haddad on 7/10/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "InstagramPostCell.h"


@implementation InstagramPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setPost:(Post *)post {
    _post = post;
    self.imagePost.file = post[@"image"];
    [self.imagePost loadInBackground];
    self.captionPost.text = post[@"caption"];
  //  self.userPost.text = post[@"author"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
