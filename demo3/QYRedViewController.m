//
//  QYRedViewController.m
//  demo3
//
//  Created by 乔岩 on 2017/2/7.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "QYRedViewController.h"
#import "QYBlueViewController.h"

@interface QYRedViewController ()

@end

@implementation QYRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = NSStringFromClass([self class]);
    // Do any additional setup after loading the view.
}

- (void)buttonClick {
    QYBlueViewController *blueVC = [[QYBlueViewController alloc] init];
    [self.navigationController pushViewController:blueVC animated:YES];
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
