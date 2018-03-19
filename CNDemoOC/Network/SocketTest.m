//
//  SocketTest.m
//  CNDemoOC
//
//  Created by apple on 2018/3/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SocketTest.h"

@interface SocketTest ()<NSStreamDelegate>{
    NSInputStream *_inputStream;//对应输入流
    NSOutputStream *_outputStream;//对应输出流
}
@property (strong, nonatomic) NSLayoutConstraint *inputViewConstraint;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *chatMsgs;//聊天消息数组
@end

@implementation SocketTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbFrmWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60+64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"连接主机" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10+64, 80, 40);
    [btn addTarget:self action:@selector(connectToHost:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(NSMutableArray *)chatMsgs{
    if(!_chatMsgs) {
        _chatMsgs =[NSMutableArray array];
    }
    return _chatMsgs;
}

//输入流监听
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    NSLog(@"%@",[NSThread currentThread]);
    //NSStreamEventOpenCompleted = 1UL << 0,//输入输出流打开完成//NSStreamEventHasBytesAvailable = 1UL << 1,//有字节可读//NSStreamEventHasSpaceAvailable = 1UL << 2,//可以发放字节//NSStreamEventErrorOccurred = 1UL << 3,//连接出现错误//NSStreamEventEndEncountered = 1UL << 4//连接结束
    switch(eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
                break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有字节可读");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"连接结束");
            //关闭输入输出流
            [_inputStream close];
            [_outputStream close];
            //从主运行循环移除
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        default:
            break;
    }
}

//连接服务器
- (void)connectToHost:(id)sender {
    
    //1.建立连接
    
    NSString *host =@"127.0.0.1";
    
    int port = 12345;
    
    //定义C语言输入输出流
    
    CFReadStreamRef readStream;
    
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
    
    //把C语言的输入输出流转化成OC对象
    
    _inputStream = (__bridge NSInputStream *)(readStream);
    
    _outputStream = (__bridge NSOutputStream *)(writeStream);
    
    //设置代理
    
    _inputStream.delegate = self;
    
    _outputStream.delegate = self;
    
    //把输入输入流添加到主运行循环
    
    //不添加主运行循环 代理有可能不工作
    
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    //打开输入输出流
    
    [_inputStream open];
    
    [_outputStream open];
    
}

//登录
- (void)loginBtnClick:(id)sender {
    
    //登录
    
    //发送用户名和密码
    
    //在这里做的时候，只发用户名，密码就不用发送
    
    //如果要登录，发送的数据格式为 "iam:zhangsan";
    
    //如果要发送聊天消息，数据格式为 "msg:did you have dinner";
    
    //登录的指令11
    NSString *loginStr =@"iam:zhangsan";
    
    //把Str转成NSData
    
    NSData *data =[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_outputStream write:data.bytes maxLength:data.length];
    
}

//读取服务器数据
#pragma mark 读了服务器返回的数据

-(void)readData{
    
    //建立一个缓冲区 可以放1024个字节
    
    uint8_t buf[1024];
    
    //返回实际装的字节数
    
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    
    //把字节数组转化成字符串
    
    NSData *data =[NSData dataWithBytes:buf length:len];
    
    //从服务器接收到的数据
    
    NSString *recStr =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",recStr);
    
    [self reloadDataWithText:recStr];
    
}

//发送数据
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *text =textField.text;
    
    NSLog(@"%@",text);
    
    //聊天信息
    
    NSString *msgStr = [NSString stringWithFormat:@"msg:%@",text];
    
    //把Str转成NSData
    NSData *data =[msgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //刷新表格
    
    [self reloadDataWithText:msgStr];
    
    //发送数据
    
    [_outputStream write:data.bytes maxLength:data.length];
    
    //发送完数据，清空textField
    
    textField.text =nil;
    
    return YES;
    
}

//数据显示
-(void)reloadDataWithText:(NSString *)text{
    
    [self.chatMsgs addObject:text];
    
    [self.tableView reloadData];
    
    //数据多，应该往上滚动
    
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.chatMsgs.count -1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark 表格的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.chatMsgs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *ID =@"Cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text =self.chatMsgs[indexPath.row];
    
    return cell;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}

//监听键盘
-(void)kbFrmWillChange:(NSNotification *)noti{
    
    NSLog(@"%@",noti.userInfo);
    
    //获取窗口的高度
    
    CGFloat windowH =[UIScreen mainScreen].bounds.size.height;
    
    //键盘结束的Frm
    
    CGRect kbEndFrm =[noti.userInfo[UIKeyboardFrameEndUserInfoKey]
                      CGRectValue];
    
    //获取键盘结束的y值
    
    CGFloat kbEndY =kbEndFrm.origin.y;
    
    self.inputViewConstraint.constant = windowH -kbEndY;
    
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
