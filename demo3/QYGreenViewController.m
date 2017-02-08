//
//  QYGreenViewController.m
//  demo3
//
//  Created by 乔岩 on 2017/2/7.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "QYGreenViewController.h"

@interface QYGreenViewController ()

@end

@implementation QYGreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = NSStringFromClass([self class]);
}

- (void)buttonClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
