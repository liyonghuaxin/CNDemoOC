//
//  SubView.m
//  CNDemoOC
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SubView.h"

@implementation SubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"点击" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(10, 10, 50, 30);
        btn.layer.borderWidth=1.0f;
        btn.layer.cornerRadius = 5.0;
        btn.layer.borderColor = UIColorFromRGB(0, 0, 0).CGColor;
        [self addSubview:btn];
    }
    return self;
}

- (void)btnClick:(id)sender{

}
    
@end
