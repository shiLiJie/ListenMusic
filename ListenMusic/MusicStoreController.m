//
//  MusicStoreController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/29.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "MusicStoreController.h"
#import "HttpRequest.h"
#import "musicClassModel.h"
#import "NSString+md5Token.h"
#import "musicModel.h"
#import "SLJAVPlayer.h"
//#import "MBProgressHUD.h"


@interface MusicStoreController ()<UITableViewDataSource,UITableViewDelegate,playerDelegate>

// 音乐列表数组
@property (nonatomic, strong) NSArray *listArr;
// 音乐播放器
@property (nonatomic, strong) SLJAVPlayer *player;

@end

@implementation MusicStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.musicTableVIew.delegate = self;
    self.musicTableVIew.dataSource = self;
    
    //初始化音乐播放器
    self.player               = [[SLJAVPlayer alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width-40, 220)];
    self.player.delegate      = self;
    
//    NSDictionary *dict     = @{
//                               @"token":token,
//                               @"uid":@"99"
//                               };
//    
//    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/MusicApi/get_music_cate"
//     
//                                                 parameters:dict
//                                                    success:^(id obj) {
//                                                        
//                                                        
//                                                        NSArray *arr = obj;//取出需要的数据数组
//                                                        NSMutableArray *arrayM = [NSMutableArray array];//中间中转数组
//                                                        for (int i = 0; i < arr.count; i ++) {//遍历数组
//                                                            NSDictionary *dict = arr[i];
//                                                            [arrayM addObject:[musicClassModel musicClassWithDict:dict]];//中转数组存放转成模型的字典
//                                                        }
//                                                        self.listArr = arrayM;
//                                                        
//                                                        [self.musicTableVIew reloadData];
//                                                        
//                                                        
//                                                    }
//                                                       fail:^(NSError *error) {
//                                                           NSLog(@"error--%@",error);
//                                                       }];
    

}

-(void)viewWillAppear:(BOOL)animated{
    NSString *token        = [NSString md5WithString];
    NSDictionary *dict     = @{
                               @"token":token,
                               @"p":@"1",
                               @"num":@"20",
                               @"cate":@"28",
                               @"cate1":@""
                               };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/MusicApi/get_cate_music"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        
                                                        NSLog(@"%@",obj[@"msg"]);
                                                        
                                                        NSArray *arr = [obj valueForKey:@"data"];//取出需要的数据数组
                                                        NSMutableArray *arrayM = [NSMutableArray array];//中间中转数组
                                                        for (int i = 0; i < arr.count; i ++) {//遍历数组
                                                            NSDictionary *dict = arr[i];
                                                            [arrayM addObject:[musicModel musicListWithDict:dict]];//中转数组存放转成模型的字典
                                                        }
                                                        self.listArr = arrayM;
                                                        
                                                        [self.musicTableVIew reloadData];
                                                        
                                                        
                                                    }
                                                       fail:^(NSError *error) {
                                                           NSLog(@"error--%@",error);
                                                       }];
}

#pragma mark - UI设置 -
// 设置导航栏标题
-(NSMutableAttributedString *)setTitle
{
    return [self changeTitle:@"曲库"];
}
// 设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor grayColor];
}

//是否隐藏导航栏底部的黑线 默认也为NO
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    musicModel *model = self.listArr[indexPath.row];
    cell.textLabel.text  = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.player resetPlayer];//重置播放器
    musicModel *model            = self.listArr[indexPath.row];
    NSString *musicUrlstr        = model.url;
    NSURL *url = [NSURL URLWithString:musicUrlstr];
    [self.player playWithUrlStr:url PlayerLayer:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 220)];
    [self.player startPaly];
    if (self.player.levelTimer) {
        [self.player.levelTimer invalidate];
        self.player.levelTimer   = nil;
    }
    self.player.levelTimer       = [NSTimer scheduledTimerWithTimeInterval: 1
                                                                       target: self
                                                                     selector: @selector(startTime)
                                                                     userInfo: nil repeats: YES];
}

//播放器定时器一秒调用一次方法
- (void)startTime{
    if (self.player.palyItem.duration.timescale != 0) {
        
//        self.progressView.value  = CMTimeGetSeconds([self.zhuplayer.palyItem currentTime]) / (self.zhuplayer.palyItem.duration.value / self.player.palyItem.duration.timescale);//当前进度
        
        
        //当前时长进度progress
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([self.player.player currentTime]) / 60;//当前秒
        NSInteger proSec = (NSInteger)CMTimeGetSeconds([self.player.player currentTime]) % 60;//当前分钟
        
        //duration 总时长
        NSInteger durMin = (NSInteger)self.player.palyItem.duration.value / self.player.palyItem.duration.timescale / 60;//总秒
        NSInteger durSec = (NSInteger)self.player.palyItem.duration.value / self.player.palyItem.duration.timescale % 60;//总分钟
        
        NSString *pro    = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
        NSString *pro1   = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
        
        if ([pro isEqualToString:@"00:01"]) {
            [MBProgressHUD hideHUD];
        }
    }
}

#pragma mark - 播放器代理方法 -
-(void)startPlay{
//    self.musicNameLab.text = self.musicName;
    
    NSLog(@"开始播放");
//    self.isPlaying = YES;
//    [self.startOrStopBtn setImage:[UIImage imageNamed:@"kaishi"] forState:UIControlStateNormal];
//    
//    if (self.isDanru) {
//        self.player.player.volume = 0;
//    }else{
//        self.player.player.volume = 1;
//    }
    [MBProgressHUD showMessage:@"正在缓冲请稍后"];
}

-(void)endPlay{
//    if (self.musicIndex.row+1 == self.dataArr.count) {
//        self.isPlaying  = NO;
//        [self.startOrStopBtn setImage:[UIImage imageNamed:@"zantingicon"] forState:UIControlStateNormal];
//        return;
//    }else{
//        self.musicIndex = [NSIndexPath indexPathForRow:self.musicIndex.row+1 inSection:self.musicIndex.section];
//        [self tableView:self.tableView didSelectRowAtIndexPath:self.musicIndex];
//        self.isPlaying  = NO;
//        [self.startOrStopBtn setImage:[UIImage imageNamed:@"zantingicon"] forState:UIControlStateNormal];
//    }
    NSLog(@"结束播放");
}

#pragma mark - 懒加载-

-(NSArray *)listArr{
    if (!_listArr) {
        _listArr = [[NSArray alloc] init];;
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
