//
//  CaculatorMaker.m
//  CNDemoOC
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CaculatorCP.h"

@implementation CaculatorCP

-(CaculatorCP *(^)(float))add{
    return ^CaculatorCP *(float value){
        _result += value;
        return self;
    };
}

-(CaculatorCP *(^)(float))subtract{
    return ^CaculatorCP *(float value){
        _result -= value;
        return self;
    };
}

-(CaculatorCP *(^)(float))multiply{
    return ^CaculatorCP *(float value){
        _result *= value;
        return self;
    };
}

-(CaculatorCP *(^)(float))divide{
    return ^CaculatorCP *(float value){
        _result /= value;
        return self;
    };
}

@end
