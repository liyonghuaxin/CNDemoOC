//
//  CaculatorMaker.h
//  CNDemoOC
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorCP : NSObject

@property (nonatomic, assign) float result;

- (CaculatorCP *(^)(float))add;
- (CaculatorCP *(^)(float))subtract;
- (CaculatorCP *(^)(float))multiply;
- (CaculatorCP *(^)(float))divide;

@end
