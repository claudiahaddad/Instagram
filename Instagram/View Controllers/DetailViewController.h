//
//  DetailViewController.h
//  Instagram
//
//  Created by Claudia Haddad on 7/10/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Post *post;

@end
