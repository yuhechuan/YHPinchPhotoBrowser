//
//  YHImageTableViewController.m
//  YHPinchPhotoBrowser
//
//  Created by yuhechuan on 2020/6/5.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHImageTableViewController.h"
#import "YHImageTableViewCell.h"
#import "UIViewController+YHPinchPhotoBrowser.h"

@interface YHImageTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation YHImageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"TableView多张图片";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YHImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YHImageTableViewCell class])];
    NSArray *datas = @[@"1.jpeg",@"2.jpeg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
    for (NSString *name in datas) {
        [self.dataList addObject:[UIImage imageNamed:name]];
    }
    [self.tableView reloadData];
    __weak typeof(self) weakSelf = self;
    self.yhPhotoBrowser.bz_dataSource = ^(UIPinchGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
        [weakSelf locationInImageView:recognizer locationInTarget:locationInTarget];
    };
}

- (void)locationInImageView:(UIPinchGestureRecognizer*)recognizer
           locationInTarget:(LocationInTarget)locationInTarget {
    CGPoint locationTable = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:locationTable];
    YHImageTableViewCell *targetCell = (YHImageTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imgeView = [targetCell getCurrentImageView];
    if (locationInTarget) {
        locationInTarget(imgeView);
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHImageTableViewCell class]) forIndexPath:indexPath];
    [cell setCellImage:self.dataList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YHImageTableViewCell cellHeight:self.dataList[indexPath.row]];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
