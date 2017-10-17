//
//  SystemConfigController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "SystemConfigController.h"
#import "SystemConfigCell.h"

@interface SystemConfigController ()<UITableViewDelegate,UITableViewDataSource>
// 系统设置列表
@property (weak, nonatomic) IBOutlet UITableView *sysConfigTable;
// 自定义cell
@property (nonatomic, strong) SystemConfigCell *cell;

@end

@implementation SystemConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sysConfigTable.delegate = self;
    self.sysConfigTable.dataSource = self;
    self.sysConfigTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.sysConfigTable.scrollEnabled = NO;
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

//设置标题
-(NSMutableAttributedString*)setTitle
{
    return [self changeTitle:@"系统设置 "];
}

//设置左边按键
-(UIButton*)set_leftButton
{
    UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [left_button setImage:[UIImage imageNamed:@"jiantou010"] forState:UIControlStateNormal];
    [left_button setImage:[UIImage imageNamed:@"jiantou010"] forState:UIControlStateHighlighted];
    return left_button;
}

// 点击左边事件
- (void)left_button_event:(UIButton *)sender
{

}

#pragma mark - tableviewdelegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

static SystemConfigCell * extracted(SystemConfigController *object) {
    return object.cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSArray *nib1             = [[NSBundle mainBundle] loadNibNamed:@"SystemConfigCell" owner:nil options:nil];
    self.cell                 = nib1[indexPath.row];
    self.cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.cell.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];

    
    return extracted(self);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 自定义代码
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x333333) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
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
