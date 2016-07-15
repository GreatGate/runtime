//
//  Student.m
//  RumtimeTest
//
//  Created by XiaoXiao on 16/7/15.
//  Copyright © 2016年 GaoDe. All rights reserved.
//

#import "Student.h"
@interface Student ()
{
    float _xWei;
    
    float _yWei;
    
    float _tWei;
    
}

@end
@implementation Student
- (instancetype)init
{
    if (self = [super init])
    {
        _friend = @"非洲大野牛";
        
        name = @"xx";
        
        _age = 30;
        _xWei = 60.1;
        
        _yWei = 90.1;
        
        _tWei = 200.0;
        
    }
    
    
    
    
    return  self;
}


- (void)eat
{
    
    NSLog(@"我在吃饭");
}

- (void)play
{
    NSLog(@"我在玩耍");
}

@end
