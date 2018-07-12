//
//  HomeViewController.m
//  Instagram
//
//  Created by Claudia Haddad on 7/9/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse.h"
#import "LoginViewController.h"
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "ComposingViewController.h"
#import "InfiniteScrollActivityView.h"
#import "InstagramPostCell.h"



@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *postArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) IBOutlet InfiniteScrollActivityView *loadingMoreView;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self getPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.tableView addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogout:(id)sender {

    [PFUser  logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;

}
- (IBAction)onCamera:(id)sender {
    [self performSegueWithIdentifier:@"composePost" sender:nil];
}
- (void)getPosts {
    // construct query
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery includeKey:@"author"];
    [postQuery orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = posts;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //  if ([segue.identifier isEqualToString:@"composePost"]) {
  //      UINavigationController *navigationController = [segue destinationViewController];
     //   ComposingViewController //*composeController = (ComposingViewController*)navigationController.topViewController;
  //  }
   //else
        if ([segue.identifier isEqualToString:@"detailSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
       DetailViewController *detailViewController = (DetailViewController*)navigationController.topViewController;

        InstagramPostCell *tappedCell = sender;
        Post *post = tappedCell.post;
        detailViewController.post = post;
        NSLog(@"Tapping on a post!");
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    InstagramPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramPostCell"forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Post *post = self.postArray[indexPath.row];
    cell.post = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        self.isMoreDataLoading = true;
        
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            [self loadMoreData];
    }
}
}

- (void)loadMoreData {
    //TO DO: if data is up to date
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (error != nil) {
        } else {
            self.isMoreDataLoading = false;
            [self.loadingMoreView stopAnimating];
            self.postArray = posts;
            [self.tableView reloadData];
        }
    }];

}

- (void)didPost:(Post *)post {
    [self.postArray insertObject:post atIndex:0];
    [self.tableView reloadData];
}


@end
