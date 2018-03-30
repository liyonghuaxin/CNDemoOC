//
//  RACLogin.h
//  CNDemoOC
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CNBaseViewController.h"

@interface RACLogin : CNBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
- (IBAction)click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
