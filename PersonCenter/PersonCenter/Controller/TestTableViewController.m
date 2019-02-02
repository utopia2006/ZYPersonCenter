//
//  TestTableViewController.m
//  PersonCenter
//
//  Created by admin on 1/2/19.
//  Copyright © 2019年 Zhuoyu. All rights reserved.
//

#import "TestTableViewController.h"

static NSString *identifier = @"reuseIdentifier";

@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%zi个cell",indexPath.row];
    
    return cell;
}

#pragma mark - EmbedScrollViewControllerProtocol
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLeaveTopNtf" object:@1];
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
    }
    
}

- (void)refresh {
    //[self requestData:NO];
}

- (void)resetOffset {
    self.tableView.contentOffset = CGPointZero;
}

- (void)finishRefreshing {
    if (self.delegate && [self.delegate respondsToSelector:@selector(embedViewControllerDidFinishRefreshing:)]) {
        [self.delegate embedViewControllerDidFinishRefreshing:self];
    }
}

@end
