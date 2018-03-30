//
//  ViewController.m
//  CNDemoOC
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "NetworkVC.h"
#import "CNAnimation.h"
#import "SocketTest.h"
#import "RACList.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataArray = @[@"网络", @"动画", @"Socket编程", @"ReactivaCocoa"];
}

#pragma mark UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            NetworkVC *net = [[NetworkVC alloc] init];
            [self.navigationController pushViewController:net animated:YES];
            break;
        }
        case 1:{
            CNAnimation  *animation = [[CNAnimation alloc] init];
            [self.navigationController pushViewController:animation animated:YES];
            break;
        }
        case 2:{
            SocketTest  *socket = [[SocketTest alloc] init];
            [self.navigationController pushViewController:socket animated:YES];
            break;
        }
        case 3:{
            RACList *rac = [[RACList alloc] init];
            [self.navigationController pushViewController:rac animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
