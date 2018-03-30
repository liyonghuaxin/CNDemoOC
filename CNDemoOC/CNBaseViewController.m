//
//  CNBaseViewController.m
//  CNDemoOC
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CNBaseViewController.h"

@interface CNBaseViewController ()

@end

@implementation CNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayWhiteColor;

}

- (void)addCancelKeyboard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)cancelKeyoard{
    [self.view endEditing:YES];
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
