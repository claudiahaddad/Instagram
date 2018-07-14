//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Claudia Haddad on 7/13/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "PostCollectionCell.h"
#import "Post.h"

@implementation PostCollectionCell

- (void)setContents {
    
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    
}
@end
