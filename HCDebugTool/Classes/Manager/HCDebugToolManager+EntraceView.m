//
//  HCDebugToolManager+EntraceView.m
//  HCDebugTool
//
//  Created by 黄鸿昌 on 2018/12/17.
//

#import "HCDebugToolManager+EntraceView.h"
#import "HCDebugToolEntranceViewController.h"

@interface HCDebugToolManager ()

@property (nonatomic, strong) HCDebugToolEntranceViewController *entranceVC;

@end

@implementation HCDebugToolManager (EntraceView)

- (void)showEntranceView {
    [self.entranceVC showEntranceView];
}

- (void)showMenuView {
    [self.entranceVC showMenuView];
}

- (void)hideMenuView {
    [self hideMenuView:nil];
}

- (void)hideMenuView:(void (^)(void))completion {
    [self.entranceVC hideMenuView:completion];
}

- (void)checkAutoShowEntranceView {
    BOOL isAutoShowEntranceViewDisable =
    [[NSUserDefaults standardUserDefaults] boolForKey:HCDebugToolManagerKeys.autoShowEntranceViewDisable];
    if (!isAutoShowEntranceViewDisable) {
        [self performSelector:@selector(showEntranceView) withObject:nil afterDelay:3];
    }
}

- (void)setAutoShowEntranceViewDisable:(BOOL)isDisable {
    [[NSUserDefaults standardUserDefaults] setBool:isDisable
                                            forKey:HCDebugToolManagerKeys.autoShowEntranceViewDisable];
}

@end
