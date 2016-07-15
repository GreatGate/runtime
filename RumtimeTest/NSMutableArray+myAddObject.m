//
//  NSMutableArray+myAddObject.m
//  RumtimeTest
//
//  Created by XiaoXiao on 16/7/15.
//  Copyright © 2016年 GaoDe. All rights reserved.
//

#import "NSMutableArray+myAddObject.h"
#import <objc/runtime.h>

@implementation NSMutableArray (myAddObject)
+ (void)load
{
    Method method1 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(myAddobject:));
    Method method2 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    /*如果类中已经有了想要替换的方法，那么就调用method_exchangeImplementations函数交换了两个方法的 IMP，这是苹果提供给我们用于实现 Method Swizzling 的便捷方法。
     */
    method_exchangeImplementations(method1, method2);
}


- (void)myAddobject:(id)object
{
    /*myAddobject方法的定义看似是递归调用引发死循环，其实不会的。因为[self myAddobject:object]消息会动态找到myAddobject:方法的实现，而它的实现已经被我们与addObject:方法实现进行了互换，所以这段代码不仅不会死循环，如果你把[self myAddobject:object]换成[self addObject:object]反而会引发死循环。*/
    if (object != nil) {
        [self myAddobject:object];
//        [self addObject:object];
    }else {
        NSLog(@"值为空");
    }
}



@end
