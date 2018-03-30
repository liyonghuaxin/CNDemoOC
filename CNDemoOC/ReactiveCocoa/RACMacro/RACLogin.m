//
//  RACLogin.m
//  CNDemoOC
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RACLogin.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface RACLogin (){
    UIImageView *imageV;
}

@end

@implementation RACLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self addCancelKeyboard];
    RAC(self.loginBtn, enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal, self.pwdTF.rac_textSignal] reduce:^id(NSString *userName, NSString *password) {
        return @(userName.length >= 6 && password.length >= 6);
    }];
    
    imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"FRP_combine"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.loginBtn).with.offset(0);
        make.bottom.right.equalTo(self.view).with.offset(-10);

    }];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    
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

- (IBAction)click:(id)sender {

}
@end
