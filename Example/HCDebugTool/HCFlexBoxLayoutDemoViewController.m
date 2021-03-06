//
//  HCFlexBoxLayoutDemoViewController.m
//  HCDebugTool_Example
//
//  Created by 黄鸿昌 on 2018/12/21.
//  Copyright © 2018年 honchwong404@gmail.com. All rights reserved.
//

#import "HCFlexBoxLayoutDemoViewController.h"
#import "UITableView+FBLayout.h"
#import "HCUIDefine.h"
#import "HCLeftPicRightTextViewModel.h"
#import "HCLeftPicRightTextView.h"
#import "HCAutoLayoutNetAPIManager.h"

@interface HCFlexBoxLayoutDemoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <HCLeftPicRightTextViewModel *>*viewModels;

@end

@implementation HCFlexBoxLayoutDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    self.title = @"FlexBoxLayout";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Data

- (void)loadData {
    [HCAutoLayoutNetAPIManager requestBookListWithCompletionHandler:^(BOOL success, NSArray<id<HCLeftPicRightTextViewModelProtocol>> *bookList) {
        [self.viewModels addObjectsFromArray:bookList];
        [self reloadData];
    }];
    
//    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"bookList" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
//    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSArray *bookListDicts = rootDict[@"bookList"];
    
//    [bookListDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [self.viewModels addObject:[[HCLeftPicRightTextViewModel alloc] initWithDictionary:obj]];
//    }];
}

- (void)reloadData {
    __weak typeof(self)weakSelf = self;
    [self.tableView fb_setCellContnetViewBlockForIndexPath:^UIView *(NSIndexPath *indexPath) {
        HCLeftPicRightTextView *view = [[HCLeftPicRightTextView alloc] init];
        [view setViewModel:[weakSelf.viewModels objectAtIndex:indexPath.row]];
        return view;
    }];

    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fb_heightForIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fb_cellForIndexPath:indexPath];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kNavBarHeight,
                                  self.view.bounds.size.width,
                                  self.view.bounds.size.height - kNavBarHeight);
        _tableView =
        [[UITableView alloc] initWithFrame:frame
                                     style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (NSArray<HCLeftPicRightTextViewModel *> *)viewModels {
    if (!_viewModels) {
        _viewModels = @[].mutableCopy;
    }
    return _viewModels;
}

@end
