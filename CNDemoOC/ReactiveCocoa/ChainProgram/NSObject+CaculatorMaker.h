//
//  NSObject+CaculatorMaker.h
//  CNDemoOC
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorCP.h"

@interface NSObject (CaculatorMaker)

+ (float)makeCaculateors:(void(^)(CaculatorCP *make)) caculatorMaker;

@end
