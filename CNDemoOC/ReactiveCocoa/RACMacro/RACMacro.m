//
//  RACMacro.m
//  CNDemoOC
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RACMacro.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface RACMacro ()

@property (nonatomic, copy) NSString *username;

@end

@implementation RACMacro

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCancelKeyboard];

    //---------------UI Event----------------
    //RAC还为系统UI提供了很多category，来方便消息的创建和传递，比如按钮被点击或文本框有改动等等
    RAC(self.label, text) = self.textfield.rac_textSignal;
   
    //---------------KVO----------------
    self.username = @"Luce";
    [RACObserve(self, self.username) subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACObserve = %@", x);
    }];
    self.username = @"TOM";
    
    //同上、上面用的这个方法的宏
    [[self rac_valuesForKeyPath:@"username" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"rac_valuesForKeyPath = %@", x);
    }];
    self.username = @"Jim";

    //1、比KVO更加强大的是信号可以被链起来(chain) 2、filter（过滤）的运用
    [[RACObserve(self, self.username) filter:^(NSString *newName) {
        return [newName hasPrefix:@"J"];
    }] subscribeNext:^(NSString *newName) {
         NSLog(@"filter = %@", newName);
    }];
    self.username = @"Sun";
    self.username = @"Java";
    
    //----------元组
    //包装 解包
    RACTuple *tuple = RACTuplePack(@"123",@1);
    RACTupleUnpack(NSString *str,NSNumber *num) = tuple;
    NSLog(@"%@ %@",str,num);
    
    //--------Network Request && Async work-------
    //这些可以通过自定义信号，也就是RACSubject(继承自RACSignal，可以理解为自由度更高的signal)来搞定。比如一个异步网络操作，可以返回一个subject，然后将这个subject绑定到一个subscriber或另一个信号。
    [self doTest];

}

- (void)doTest
{
    RACSubject *subject = [self doRequest];
    
    [subject subscribeNext:^(NSString *value){
        NSLog(@"value:%@", value);
    }];
}

- (RACSubject *)doRequest
{
    RACSubject *subject = [RACSubject subject];
    // 模拟2秒后得到请求内容
    // 只触发1次
    // 尽管subscribeNext什么也没做，但如果没有的话map是不会执行的
    // subscribeNext就是定义了一个接收体
    [[[[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] take:1] map:^id(id _){
        // the value is from url request
        NSString *value = @"content fetched from web";
        [subject sendNext:value];
        return nil;
    }] subscribeNext:^(id _){}];
    return subject;
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
