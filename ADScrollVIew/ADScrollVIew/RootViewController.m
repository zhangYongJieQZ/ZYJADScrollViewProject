//
//  ViewController.m
//  TestADScrollView
//
//  Created by 张永杰 on 15/10/25.
//  Copyright © 2015年 张永杰. All rights reserved.
//

#import "RootViewController.h"
#import "ADScrollView.h"
#import "WebViewController.h"
#import "GameModel.h"
@interface RootViewController ()<jumpDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ADScrollView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    GameModel *model1 = [[GameModel alloc]initWithName:@"花千骨" JumpStr:@"http://www.hqgyouxi.com/?utm_source=baidu&utm_medium=cpc&utm_term=%E8%8A%B1%E5%8D%83%E9%AA%A8&utm_campaign=%E8%8A%B1%E5%8D%83%E9%AA%A8%E5%93%81%E7%89%8C" imageStr:@"http://img.douxie.com/upload/image/16d/vuu/PUBbNEArrzUd1iCfq1Tz_324x212.jpg"];
    GameModel *model2= [[GameModel alloc]initWithName:@"乱斗西游" JumpStr:@"http://ldxy.163.com/" imageStr:@"http://www.576.com/d/file/news/glmj/d5e345a15f37a97e58bd09be74a43206.png"];
    GameModel *model3 = [[GameModel alloc]initWithName:@"天天酷跑" JumpStr:@"http://ttkp.18183.com/?soucre=bdald" imageStr:@"http://www.apk8.com/editor/attached/20140718033733_69776.jpg"];
    GameModel *model4 = [[GameModel alloc]initWithName:@"全民飞机大战" JumpStr:@"http://feiji.qq.com/" imageStr:@"http://img.bufan.com/article/2014/10/23/14140321817374.jpg"];
    NSArray *imgAry = @[model1,model2,model3,model4];
    ADScrollView *adScroll = [[ADScrollView alloc]initWithFrame:CGRectMake(0, navigationBarHeight + statusBarHeight, ScreenWidth, 150) andImageArray:imgAry];
    adScroll.jumpDelegate = self;
    [self.view addSubview:adScroll];
    [adScroll createPageControllOnView:self.view];
    
    //    [ZYJADScrollView showADScrollViewOnView:self.view WithFrame:CGRectMake(0, 20, self.view.frame.size.width, 150) andImageArray:imgAry];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)pushToWebViewWithModel:(GameModel *)model{
    WebViewController *webViewCtl = [[WebViewController alloc]init];
    webViewCtl.title = model.gameName;
    [webViewCtl loadWebViewWithURL:model.jumpAddress];
    [self.navigationController pushViewController:webViewCtl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
