//
//  HCDebugToolMenuViewController.m
//  HCDebugTool
//
//  Created by 黄鸿昌 on 2018/12/5.
//  Copyright © 2018年 黄鸿昌. All rights reserved.
//

#import "HCDebugToolMenuViewController.h"
#import "HCDebugToolManager.h"

//#import "HCDebugToolModuleProtocol.h"
//#import "HCDebugToolVisionModule.h"

@interface HCDebugToolMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSObject<HCDebugToolModuleProtocol> *> *modules;

@end

@implementation HCDebugToolMenuViewController

#pragma mark - Life Function

- (instancetype)init {
    if (self = [super init]) {
        [self configProperty];
        [self setupSubviews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Private Function

- (void)configProperty {
    self.modules = [[HCDebugToolManager sharedManager] registeredModules];
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modules.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.modules objectAtIndex:section] numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.modules objectAtIndex:indexPath.section]
            cellForRow:indexPath.row tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.modules objectAtIndex:indexPath.section]
            heightForRow:indexPath.row];
}

#pragma mark - getter setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

@end
