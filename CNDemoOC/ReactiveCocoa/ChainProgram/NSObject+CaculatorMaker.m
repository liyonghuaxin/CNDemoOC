//
//  NSObject+CaculatorMaker.m
//  CNDemoOC
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSObject+CaculatorMaker.h"

@implementation NSObject (CaculatorMaker)

+(float)makeCaculateors:(void (^)(CaculatorCP *))caculatorMaker{
    CaculatorCP *maker = [[CaculatorCP alloc] init];
    caculatorMaker(maker);
    return maker.result;
}

@end
