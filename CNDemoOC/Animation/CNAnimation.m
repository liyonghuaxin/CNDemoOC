//
//  CNAnimation.m
//  CNDemoOC
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CNAnimation.h"
#import "CallAnimationMethod.h"
#import "BaseAnimationController.h"
#import "KeyFrameAnimationController.h"
#import "GroupAnimationController.h"
#import "TransitionAnimationController.h"
#import "AffineTransformController.h"
#import "ComprehensiveCaseController.h"

@interface CNAnimation (){
    NSArray *dataArray;
}

@end

@implementation CNAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = @[@[@"动画调用方式"], @[@"基础动画（CABaseAnimation）", @"关键帧动画（CAKeyframeAnimation）", @"组动画（CAAnimationGroup）", @"转场动画（CATransition）", @"仿射变换" ], @[@"综合案例"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"动画的调用方式";
    }else if (section == 1){
        return @"动画的使用";
    }else{
        return @"综合案例";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CallAnimationMethod *method = [[CallAnimationMethod alloc] init];
        [self.navigationController pushViewController:method animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            BaseAnimationController *base = [[BaseAnimationController alloc] init];
            [self.navigationController pushViewController:base animated:YES];
        }else if (indexPath.row == 1){
            KeyFrameAnimationController *keyFrame = [[KeyFrameAnimationController alloc] init];
            [self.navigationController pushViewController:keyFrame animated:YES];
        }else if (indexPath.row == 2){
            GroupAnimationController *group = [[GroupAnimationController alloc] init];
            [self.navigationController pushViewController:group animated:YES];
        }else if (indexPath.row == 3){
            TransitionAnimationController *transition = [[TransitionAnimationController alloc] init];
            [self.navigationController pushViewController:transition animated:YES];
        }else{
            AffineTransformController *affine = [[AffineTransformController alloc] init];
            [self.navigationController pushViewController:affine animated:YES];
        }
    }else{
        ComprehensiveCaseController *affine = [[ComprehensiveCaseController alloc] init];
        [self.navigationController pushViewController:affine animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
