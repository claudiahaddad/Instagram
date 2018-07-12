//
//  InfiniteScrollActivityView.h
//  Instagram
//
//  Created by Claudia Haddad on 7/12/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"


@interface InfiniteScrollActivityView : UIActivityIndicatorView

@property (class, nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end
