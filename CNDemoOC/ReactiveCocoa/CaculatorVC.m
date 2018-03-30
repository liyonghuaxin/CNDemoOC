//
//  CaculatorVC.m
//  CNDemoOC
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CaculatorVC.h"
#import "NSObject+CaculatorMaker.h"
#import "CaculatorFP.h"

@interface CaculatorVC ()

@end

@implementation CaculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //链式编程
    float result = [NSObject makeCaculateors:^(CaculatorCP *make) {
        make.add(10).subtract(3).multiply(4).divide(14);
    }];
    NSLog(@"(10-3)*4/14 = %f",result);
    
    //函数式编程
    CaculatorFP *fp = [[CaculatorFP alloc] init];
    BOOL a = [[[fp caculator:^float(float result) {
        result += 10;
        result *= 5;
        return result;
    }] equal:^BOOL(float result) {
        return result == 50;
    }] isEqual];
    NSLog(@"10*5 等于50 吗：%@",a?@"yes":@"no");
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
