//
//  CallAnimationMethod.m
//  CNDemoOC
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CallAnimationMethod.h"

@interface CallAnimationMethod (){
    UIView *demoView;
    UIView *demoView2;
    UIView *demoView3;
}

@end

@implementation CallAnimationMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    float space = (SCREEN_WIDTH-80*3-20*2)/2.0;
    NSArray *title = @[@"代码块", @"commit", @"CAAnimation"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(20+(80+space)*i, 100, 80, 40);
        [btn setTitle:title[i] forState:UIControlStateNormal];
        btn.tag = i+10;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    demoView = [[UIView alloc] init];
    demoView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:demoView];

    demoView2 = [[UIView alloc] init];
    demoView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:demoView2];

    demoView3 = [[UIView alloc] init];
    demoView3.backgroundColor = [UIColor grayColor];
    demoView3.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
    [self.view addSubview:demoView3];
    
}

- (void)click:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 10) {
        demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
        [UIView animateWithDuration:1.0f animations:^{
            demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
        } completion:^(BOOL finished) {
            //demoView.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50, 50, 50);
        }];
    }else if (btn.tag == 11){
        demoView2.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        demoView2.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
        [UIView commitAnimations];
    }else{
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
        anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(25, SCREEN_HEIGHT/2-50+25)];
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH+25, SCREEN_HEIGHT/2-50+25)];
        anima.duration = 1.0f;
        [demoView3.layer addAnimation:anima forKey:@"positionAnimation"];
    }
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
