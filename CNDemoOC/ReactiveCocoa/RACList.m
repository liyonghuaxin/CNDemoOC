//
//  RACList.m
//  CNDemoOC
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RACList.h"
#import <Masonry/Masonry.h>
#import "RACLogin.h"
#import "RACUnify.h"
#import "CaculatorVC.h"
#import "RACCommonClass.h"
#import "RACTest.h"

@interface RACList ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *dataArray;
}

@end

@implementation RACList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = @[@[@"常见类", @"常见方法", @"常见宏",], @[@"链式、函数编程"], @[ @"水龙头合并：combineLatest:reduce:"]];
    
    UITableView *tableview = [[UITableView alloc] init];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(navbarParaEXTERN);
    }];
    tableview.tableFooterView = [[UIView alloc] init];
    tableview.delegate = self;
    tableview.dataSource = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                RACCommonClass *common = [[RACCommonClass alloc] init];
                [self.navigationController pushViewController:common animated:YES];
                break;
            }
            case 1:{
                RACTest *test = [[RACTest alloc] init];
                [self.navigationController pushViewController:test animated:YES];
                break;
            }
            case 2:{
                RACUnify *unify = [[RACUnify alloc] init];
                [self.navigationController pushViewController:unify animated:YES];
                break;
            }
            default:
                break;
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                CaculatorVC *caculator = [[CaculatorVC alloc] init];
                [self.navigationController pushViewController:caculator animated:YES];
                break;
            }
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                RACLogin *login = [[RACLogin alloc] init];
                [self.navigationController pushViewController:login animated:YES];
                break;
            }
            default:
                break;
        }
    }
   

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"类的认识、方法的使用";
    }else if (section == 1){
        return @"相关原理";
    }else{
        return @"案例";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    return cell;
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
