//
//  MyViewController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/22.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "MyViewController.h"
#import "MyListCell.h"
#import "SystemConfigController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

// 我的列表cell
@property (nonatomic, strong) MyListCell *cell;
// 我的列表标题
@property (nonatomic, strong) NSArray *listArr;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailList.delegate = self;
    self.detailList.dataSource = self;
    self.detailList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.detailList.scrollEnabled = NO;
}

#pragma mark - UI设置 -
// 设置导航栏标题
-(NSMutableAttributedString *)setTitle
{
    return [self changeTitle:@"个人中心"];
}
// 设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor clearColor];
}
// 是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

#pragma mark - 自定义代码 -
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - tableviewdelegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSArray *nib1            = [[NSBundle mainBundle]loadNibNamed:@"MyListCell" owner:nil options:nil];
    self.cell                = [nib1 lastObject];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell.titleLab.text  = self.listArr[indexPath.row];
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        SystemConfigController *sys = [[SystemConfigController alloc] init];
        [self.navigationController pushViewController:sys animated:YES];
    }
}

#pragma mark - 懒加载- 

-(NSArray *)listArr{
    if (!_listArr) {
        _listArr = @[@"我的消息",@"我的优惠",@"我的优惠",@"用户指南",@"系统设置"];
    }
    return _listArr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
