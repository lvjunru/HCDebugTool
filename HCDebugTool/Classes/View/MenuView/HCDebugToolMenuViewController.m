//
//  HCDebugToolMenuViewController.m
//  HCDebugTool
//
//  Created by 黄鸿昌 on 2018/12/5.
//  Copyright © 2018年 黄鸿昌. All rights reserved.
//

#import "HCDebugToolMenuViewController.h"
#import "HCDebugToolManager.h"
#import "HCDebugToolUIDefine.h"
#import "HCDebugToolModuleProtocol.h"
#import "HCDebugToolManager+Module.h"

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
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modules.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self moduleAtIndex:section] numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<HCDebugToolModuleProtocol> *module = [self moduleAtIndex:indexPath.section];
    return [module cellForRow:indexPath.row tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<HCDebugToolModuleProtocol> *module = [self moduleAtIndex:indexPath.section];
    return [module heightForRow:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSObject<HCDebugToolModuleProtocol> *module = [self moduleAtIndex:section];
    return module.moduleTitle;
}

- (NSObject<HCDebugToolModuleProtocol> *)moduleAtIndex:(NSInteger)index {
    if (self.modules.count < index)  {
        return nil;
    }
    return [self.modules objectAtIndex:index];
}

#pragma mark - getter setter

- (UITableView *)tableView {
    if (!_tableView) {
        
        CGFloat viewHeight = CGRectGetHeight(self.view.bounds) - kNavBarHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.bounds), viewHeight)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (NSArray<NSObject<HCDebugToolModuleProtocol> *> *)modules {
    return [[HCDebugToolManager sharedManager] afterSortModules];
}

@end
