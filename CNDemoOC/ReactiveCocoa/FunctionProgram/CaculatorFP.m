//
//  CaculatorFP.m
//  CNDemoOC
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CaculatorFP.h"

@implementation CaculatorFP

-(CaculatorFP *)caculator:(float (^)(float))block{
    _result = block(_result);
    return self;
}

-(CaculatorFP *)equal:(BOOL (^)(float))block{
    _isEqual = block(_result);
    return self;
}

-(BOOL)isEqual{
    return _isEqual;
}

@end
