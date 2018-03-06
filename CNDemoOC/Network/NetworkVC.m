//
//  NetworkVC.m
//  CNDemoOC
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NetworkVC.h"

@interface NetworkVC ()

@property (nonatomic, strong) NSMutableData *localData;

@end

@implementation NetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     * 原生
        * NSURLConnection       - 最古老的方案
        * NSURLSession          - iOS7推出的新技术
        * CFNetworking          - NSURL的底层，纯C语言
     * 第三方框架
        * ASIHttpRequest        - 外号“HTTP终结者”，功能强大，可惜已经停止更新
        * AFNetworking          - 维护使用者多
        * MKNetworkKit          - 印度，维护使用者少
     * HTTP 请求
        * HTTP/1.1 中定义了8种方法
        * GET、POST、OPTIONS、HEAD、PUT、DELETE、TRACE、CONNECT、PATCH
        * 最常用的就是GET、POST
     */
    
    //-----------------AFNetworkings上封装------------------

    //-----------------AFNetworking------------------

    
    //-----------------9.0之后  NSURLSession------------------
    [self demo2];
    //-----------------9.0之前  NSURLConnection------------------
    //同步请求
    //[self requestSynch];
    //异步
    //[self requestAsync];
    //get
    //[self getRequest];
    //post
    //[self postRequest];
    //HTTP代理请求模式
    //[self requestHTTPDelegate];
    //-----------------数据解析------------------
    //[self dataParse];
    //-----------------数据转换------------------
    //[self dataConversion];
}

#pragma mark ---------数据处理--------------
- (void)dataParse{
    NSData *resultData;
    /*
     NSJSONReadingMutableContainers = (1UL << 0), // 可变容器
     NSJSONReadingMutableLeaves = (1UL << 1), // 子节点也是可变的，也就是说转换的所有数据都是可变的
     NSJSONReadingAllowFragments = (1UL << 2) // 接收零散数据，比如说单个的‘10’，'false'
     */
    NSError *serializationError = nil;
    //data转JSON
    id jsonObject = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&serializationError];
    /*
     NSJSONWritingPrettyPrinted = (1UL << 0) //是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
     NSJSONWritingSortedKeys //输出的json字符串就是一整行
     */
    //JSON转data
    [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingSortedKeys error:&serializationError];
}

- (void)dataConversion{
    //NSString--->NSData
    NSData *data=[@"www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    //NSDate---->NSString
    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark ---------iOS9之后--------------
-(void)demo2{
    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //根据返回的二进制数据，生成字符串！NSUTF8StringEncoding：编码方式
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //将浏览器加载到view上
        dispatch_async(dispatch_get_main_queue(), ^{
            //实例化一个客户端浏览器
            UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
            //加载html字符串：baseURL：基准的地址：相对路径/绝对路径
            [web loadHTMLString:html baseURL:nil];
            [self.view addSubview:web];
            
        });
        //        //在本地保存百度首页
        //        [data writeToFile:@"/Users/Liu/Desktop/baidu.html" atomically:YES];
    }];
    //5.执行任务
    [dataTask resume];
}

#pragma mark ---------iOS9之前--------------
- (void)requestSynch{
    // 1 创建请求连接
    NSURL *url = [NSURL URLWithString:@"http://www.lala.com/login?username=123&pwd=123"];
    // 2 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    // 3 发送同步请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    // 4.解析
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// 异步
- (void)requestAsync{
    // 1 创建请求连接
    NSURL *url = [NSURL URLWithString:@"http://123.123.123.123/login?username=123&pwd=123"];
    // 2 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    // 3 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 4.解析服务器返回的数据（解析成字符串）
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse* )response;
        NSLog(@"--%@--%zd--%@--",str,httpRes.statusCode,httpRes.allHeaderFields);
    }];
}

- (void)getRequest{
    NSString *userName = @"name";
    NSString *pwd = @"123456";
    NSString *format = [NSString stringWithFormat:@"http://123.123.123.123/login?username=%@&pwd=%@",userName,pwd];
    //汉字进行转换
    format = [format stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:format];
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"失败");
        }else{
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

- (void)postRequest{
    NSString *format = [NSString stringWithFormat:@"http://123.123.123.123/login"];
   
    NSURL *url = [NSURL URLWithString:format];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url ];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=520it&pwd=520it" dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 5;
    // 设置请求头
    //    [request setValue:@"ios9.0" forHTTPHeaderField:@"User-agent"];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"失败");
        }else{
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

- (void)requestHTTPDelegate{
    // 1 创建请求连接
    NSURL *url = [NSURL URLWithString:@"http://123.123.123.123/login?username=520it&pwd=520it"];
    // 2 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    // 3 代理请求模式,要遵守协议并实现代理方法
    [NSURLConnection connectionWithRequest:request delegate:self];
}
#pragma mark NSURLConnectionDataDelegate

//常用代理方法
// 接收服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.localData = [NSMutableData data];
    NSLog(@"-didReceiveResponse-%zd",((NSHTTPURLResponse *)response).statusCode);
}
// 接收到服务器的数据（如果数据量比较大，这个方法会被调用多次）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.localData appendData:data];
    NSLog(@"-didReceiveData-");
}
// 完成数据下载
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *str = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];
    NSLog(@"-connectionDidFinishLoading-%@",str);
}

#pragma mark NSURLConnectionDelegate
// 请求失败：请求超时等
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"-didFailWithError-");
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
