//
//  MyViewController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/22.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface MyViewController : BaseViewController
// 头像
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
// 聆听总时长
@property (weak, nonatomic) IBOutlet UILabel *totalTImeNum;
// 聆听总时长Lab
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;
// 购买次数
@property (weak, nonatomic) IBOutlet UILabel *totalBuyNum;
// 购买次数Lab
@property (weak, nonatomic) IBOutlet UILabel *totalBuyLab;
// 详情列表
@property (weak, nonatomic) IBOutlet UITableView *detailList;

@end
