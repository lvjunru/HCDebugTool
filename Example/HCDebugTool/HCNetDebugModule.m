//
//  HCNetDebugModule.m
//  HCDebugTool_Example
//
//  Created by 黄鸿昌 on 2018/12/9.
//  Copyright © 2018年 honchwong404@gmail.com. All rights reserved.
//

#import "HCNetDebugModule.h"
#import "HCDebugModuleSortLevel.h"
#import "HCNetDebugMockViewController.h"

typedef NS_OPTIONS(NSInteger, HCNetDebugOptionViewTag) {
    HCNetDebugOptionViewTag_Mock = 1,
};

@implementation HCNetDebugModule

#pragma mark - Private

+ (void)load {
    [[HCDebugToolManager sharedManager] registerModule:[[self alloc] init]
                                             sortLevel:QRDebugModuleSortLevel_Net];
}

#pragma mark - HCDebugToolCommonOptionViewDelegate

- (void)optionDidSelected:(HCDebugToolCommonOptionItemViewModel *)option
                  atIndex:(NSInteger)index {
    switch (option.viewTag) {
        case HCNetDebugOptionViewTag_Mock:
        {
            HCNetDebugMockViewController *vc =
            [[HCNetDebugMockViewController alloc] init];
            UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self hideMenuView:^{
                [self presentViewController:naviVC];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - HCDebugToolModuleProtocol

- (NSString *)moduleTitle {
    return @"网络调试";
}

#pragma mark - SuperClass

- (NSArray <NSDictionary *>*)optionDicts {
    return @[@{HCDebugCommonModuleOptionKeys.title: @"Mock网络数据",
               HCDebugCommonModuleOptionKeys.viewTag: @(HCNetDebugOptionViewTag_Mock),
               }];
}

@end
