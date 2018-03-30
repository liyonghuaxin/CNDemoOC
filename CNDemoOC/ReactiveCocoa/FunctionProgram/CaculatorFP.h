//
//  CaculatorFP.h
//  CNDemoOC
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorFP : NSObject

@property (nonatomic, assign) float result;
@property (nonatomic, assign) BOOL isEqual;

- (CaculatorFP *)caculator:(float (^)(float result))block;

- (CaculatorFP *)equal:(BOOL(^)(float result))block;

- (BOOL)isEqual;

@end
