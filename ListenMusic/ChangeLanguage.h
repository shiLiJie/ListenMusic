//
//  ChangeLanguage.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/22.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeLanguage : NSObject

+(NSBundle *)bundle;//获取当前资源文件
+(void)initUserLanguage;//初始化语言文件
+(NSString *)userLanguage;//获取应用当前语言
+(void)setUserlanguage:(NSString *)language;//设置当前语言

@end
