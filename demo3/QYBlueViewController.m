//
//  QYBlueViewController.m
//  demo3
//
//  Created by 乔岩 on 2017/2/7.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "QYBlueViewController.h"
#import "QYGreenViewController.h"

@interface QYBlueViewController ()

@end

@implementation QYBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = NSStringFromClass([self class]);
}

- (void)buttonClick {
    QYGreenViewController *greenVC = [[QYGreenViewController alloc] init];
    [self.navigationController pushViewController:greenVC animated:YES];
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
