//
//  RACOperationVC.m
//  CNDemoOC
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RACOperationVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
#import <ReactiveObjC/RACStream.h>

@interface RACOperationVC ()

@end

@implementation RACOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //--------------核心方法bind的使用------------------------
    //所有的信号（RACSignal）都可以进行操作处理，因为所有操作方法都定义在RACStream.h中，因此只要继承RACStream就有了操作处理方法
    //[self bindSignal];
    
    //--------ReactiveCocoa操作方法之映射(flattenMap,Map)----------
    /*
     1.FlatternMap中的Block返回信号。
     2.Map中的Block返回对象。
     3.开发中，如果信号发出的值不是信号，映射一般使用Map
     4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap。
     */
    //flattenMap:信号中信号,signalOfSignals
    //[self flattenMap]
    //map： 用于普通信号,信号发出普通值
    //[self map];
    
    //-----------------ReactiveCocoa操作方法之组合---------------------
    /*
     concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号
     then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
     then跟concat区别:监听不到第一个信号的值,共同点都是必须第一个信号完成,第二个信号才会激活
     merge: 把多个信号合并为一个信号，任何一个信号有新值的时候就会调用
     zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件
     combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号
     combineLatest跟reduce：常见的用法，（先组合在聚合）
     */
    //[self combination_concat];
    //[self combination_then];
    //[self combination_merge];
    //[self combination_zipWith];
    //[self combination_combineLatest];
    //[self combination_reduce];

    //------------------ReactiveCocoa操作方法之过滤--------------------
    /*
     ignore:忽略完某些值的信号
     distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉
     take:从开始一共取N次的信号
     takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号
     takeUntil:(RACSignal *):获取信号直到执行完这个信号
     skip:(NSUInteger):跳过几个信号,不接受
     switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号
     */
    
    //------------------ReactiveCocoa操作方法之秩序--------------------
    /*
     doNext: 执行Next之前，会先执行这个Block
     doCompleted: 执行sendCompleted之前，会先执行这个Block
     */
    
    //------------------ReactiveCocoa操作方法之线程--------------------
    /*
     deliverOn: 内容传递切换到制定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用
     subscribeOn: 内容传递和副作用都会切换到制定线程中
     */
    
    //-------------------ReactiveCocoa操作方法之时间-------------------
    /*
     timeout：超时，可以让一个信号在一定的时间后，自动报错
     interval 定时：每隔一段时间发出信号
     delay: 延迟发送next
     */
    
    //------------------ReactiveCocoa操作方法之重复--------------------
    /*
     retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功
     replay重放：当一个信号被多次订阅,反复播放内容
     throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出
     */
}

- (void)bindSignal{
    // 执行流程
    /*
     1.文字改变源信号
     2.绑定源信号,[_textField.rac_textSignal bind]
     * 调用bind返回绑定好的信号,didSubscribe
     3.订阅绑定信号
     * 创建订阅者
     * 调用绑定信号的didSubscribe
     4.执行绑定信号didSubscribe
     5.执行bind方法传入的block
     6.订阅源信号
     7.只要源信号一发出内容,就会调用id signal = bindingBlock(x, &stop);
     * signal:把值处理完的信号
     
     */
    
    RACSignal *bindSignal = [_textField.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id value, BOOL *stop){
            // RACStreamBindBlock什么时候调用:每次源信号发出内容,就会调用这个block
            
            // value:源信号发出的内容
            NSLog(@"源信号发出的内容:%@",value);
            
            // RACStreamBindBlock作用:在这个block处理源信号的内容
            value = [NSString stringWithFormat:@"xmg%@",value];
            // block返回值:信号(把处理完的值包装成一个信号,返回出去)
            
            // 创建一个信号,并且这个信号的传递的值是我们处理完的值,value
            return [RACReturnSignal return:value];
        };
    }];
    
//
//    RACSignal *bindSignal = [_textField.rac_textSignal bind:^RACStreamBindBlock{
//        // block调用时刻:只要一个信号被绑定就会调用.表示信号绑定完成
//
//        NSLog(@"源信号被绑定");
//        return ^RACStream *(id value, BOOL *stop){
//            // RACStreamBindBlock什么时候调用:每次源信号发出内容,就会调用这个block
//
//            // value:源信号发出的内容
//            NSLog(@"源信号发出的内容:%@",value);
//
//            // RACStreamBindBlock作用:在这个block处理源信号的内容
//            value = [NSString stringWithFormat:@"xmg%@",value];
//            // block返回值:信号(把处理完的值包装成一个信号,返回出去)
//
//            // 创建一个信号,并且这个信号的传递的值是我们处理完的值,value
//            return [RACReturnSignal return:value];
//        };
//
//    }];
    
   
    
    // 订阅绑定信号,不在是源信号
    [bindSignal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
}

- (void)flattenMap{
    
    [[_textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        // value:源信号的内容
        value = [NSString stringWithFormat:@"xmg%@",value];
        // 返回值:信号,把处理完的值包装成信号返回出去
        return [RACReturnSignal return:value];
    }] subscribeNext:^(id  _Nullable x) {
        // 订阅[RACReturnSignal return:value发送值
        // x:绑定信号的值
        NSLog(@"%@",x);
    }];
    
//    [[_textField.rac_textSignal flattenMap:^RACStream *(id value) {
//        // value:源信号的内容
//        value = [NSString stringWithFormat:@"xmg%@",value];
//        // 返回值:信号,把处理完的值包装成信号返回出去
//        return [RACReturnSignal return:value];
//    }] subscribeNext:^(id x) {
//        // 订阅[RACReturnSignal return:value发送值
//
//        // x:绑定信号的值
//        NSLog(@"%@",x);
//    }];
    
}

- (void)map{
    [[_textField.rac_textSignal map:^id(id value) {
        // value:源信号的内容
        // 返回值,就是处理源信号的内容,直接返回
        return [NSString stringWithFormat:@"----xmg%@",value];
        
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
   
}

- (void)combination_concat{
    // concat:连接信号,有顺序的拼接,一定要等第一个信号完成的时候,第二个信号才会被激活
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 组合信号
    RACSignal *signals = [signalA concat:signalB];
    
    // 订阅组合信号
    [signals subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 发送数据

    [signalA sendNext:@1];
    [signalA sendCompleted];//这行执行了，signalB发送信号才有用
    [signalB sendNext:@2];
    
}

- (void)combination_then{
    //then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 组合
    RACSignal *signals = [signalA then:^RACSignal *{
        return signalB;
    }];
    
    [signals subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [signalA sendNext:@1];
    [signalA sendCompleted];
    [signalB sendNext:@2];
   
}

- (void)combination_merge{
    
    // merge:合并,任何一个信号只要发送值,就能订阅
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    RACSignal *signals = [signalA merge:signalB];
    [signals subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [signalA sendNext:@1];
    [signalB sendNext:@2];
    [signalB sendNext:@3];

}

- (void)combination_zipWith{
    
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    RACSignal *signals = [signalA zipWith:signalB];
    
    [signals subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // zipWith:当两个信号都发出内容的时候,才能被订阅到
    [signalA sendNext:@1];
    [signalB sendNext:@2];
    
    [signalB sendNext:@3];
    [signalA sendNext:@4];

}

- (void)combination_combineLatest{
    // 第一个参数:就是存放需要合并信号
    [[RACSignal combineLatest:@[_textField.rac_textSignal,_textField2.rac_textSignal] reduce:^id(NSString *str1,NSString *str2){
        NSLog(@"%@ ---- %@",str1,str2);
        // block:只要任意一个信号发出内容,就会调用
        // block参数个数:由信号决定
        // block参数类型:block的参数就是信号发出值
        // 把两个信号中的值聚合成哪个值
        return @(str1.length && str2.length);
    }] subscribeNext:^(id x) {
        _btn.enabled = [x boolValue];
        NSLog(@"%@",x);
    }];

}

- (void)combination_reduce{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];
    
    // 聚合
    // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
    // reduce中的block简介:
    // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
    // reduceblcok的返回值：聚合信号之后的内容。
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
        
        return [NSString stringWithFormat:@"%@ %@",num1,num2];
        
    }];
    
    [reduceSignal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
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
