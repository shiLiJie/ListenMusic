//
//  AppDelegate.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/8.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "AppDelegate.h"
#import "TextViewController.h"
#import "PlusButton.h"
#import "TabBarControllerConfig.h"
#import "AppDelegate+YCLaunchAd.h"
#import "LJLoginViewController.h"


@interface AppDelegate ()

@property (strong, nonatomic) UIView *lunchView;

@property (nonatomic, strong) TabBarControllerConfig *tabBarControllerConfig;

@end

@implementation AppDelegate
@synthesize lunchView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // git测试
    
    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    
    
    //根据需求加广告页,这里代替连接启动页完成gif效果
//    [self setupYCLaunchAd];
    
    // 添加跟控制器
    [self addTabbarVc];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEn) name:@"ENGLISH" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCh) name:@"CHINESE" object:nil];
    
    return YES;
}

-(void)addTabbarVc{
    
    // 中间按钮
//    [PlusButton registerPlusButton];
    
//    LJLoginViewController *login = [[LJLoginViewController alloc] init];
//    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:login];
//    _window.rootViewController = vc;
    
    // 添加根控制器
    self.tabBarControllerConfig = [[TabBarControllerConfig alloc]init];
    _window.rootViewController = self.tabBarControllerConfig.tabBarController;
    
    
    [_window makeKeyAndVisible];
}

-(void)chaninde2
{
    self.tabBarControllerConfig.tabBarController.selectedIndex = 1;
    
}


-(void)changeEn{
    [self addTabbarVc];
}


-(void)changeCh{
    [self addTabbarVc];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
