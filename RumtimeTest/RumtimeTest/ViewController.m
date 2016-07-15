//
//  ViewController.m
//  RumtimeTest
//
//  Created by XiaoXiao on 16/7/15.
//  Copyright © 2016年 GaoDe. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
//#import <objc/runtime.h>
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Student *student = [[Student alloc] init];
    
    objc_msgSend(student, @selector(setAge:), 20);
    NSLog(@"_____%ld", student.age );
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    
    
    [array addObject:@"kk"];
    
    NSLog(@"-----------%@", array);

      [self getIvarsNameListWithClassName:@"Student"];
    [self getMethodNameListWithClassName:@"Student"];
}
/**
 *  通过类的名字来获取类里面包含的所有属性,查询类成员变量及类型
 *
 *  @param className 类名(egs:UIView)
 */
- (void)getIvarsNameListWithClassName:(NSString *)className
{
    //通过类的名字获取到类(egs:通过"学生"这个类的名字找到"学生"这个类)
    Class ClassName = NSClassFromString(className);
    
    //定义一个变量来存放遍历出来类里面属性的个数
    unsigned int outConut = 0;
    //查取类里面所有的属性
    Ivar * vars = class_copyIvarList([ClassName class], &outConut);
    //打印类里面有多少个属性
    NSLog(@"%d",outConut);
    //遍历类里面所有的属性 和 属性类型
    for (int i = 0; i < outConut; i ++) {
        //获取类里面属性的名字(将IVar变量转化为字符串)
        const char * ivarName = ivar_getName(vars[i]);
        //获取类里面属性的类型(获取IVar的类型)
        const char * ivarType = ivar_getTypeEncoding(vars[i]);
        //打印属性的名字和类型
        printf("属性名字:%s 属性类型:%s\n",ivarName,ivarType);
    }
}
/**
 *  通过类的名字,查看类中所有的方法
 *
 *  @param className 类的名字(egs:UIView)
 */
- (void)getMethodNameListWithClassName:(NSString *)className
{
    /**
     * class_copyMethodList：获取所有方法
     * method_getName：读取一个Method类型的变量，输出我们在上层中很熟悉的SEL
     *
     */
    
    //通过类的名字,获取到类
    Class ClassName = NSClassFromString(className);
    //定义一个变量来存放遍历出来类里面属性的个数
    unsigned int count = 0;
    //查取类里面所有的属性
    Method * method = class_copyMethodList(ClassName, &count);
    //遍历类里面所有的属性 和 属性类型
    for (int i = 0; i < count; i ++) {
        //获取类里面方法的名字
        SEL methodName = method_getName(method[i]);
        //获取类里面方法的类型
        const char * methodType = method_copyReturnType(method[i]);
        NSLog(@"方法名字:%@,方法类型:%s",NSStringFromSelector(methodName),methodType);
    }
    
    
}
////可以根据实例查找其在类中的名字，也就是“反射”
//-(NSString *)nameWithInstance:(id)instance {
//    unsigned int numIvars = 0;
//    NSString *key=nil;
//    Ivar * ivars = class_copyIvarList([self class], &numIvars);
//    for(int i = 0; i < numIvars; i++) {
//        Ivar thisIvar = ivars[i];
//        const char *type = ivar_getTypeEncoding(thisIvar);
//        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
//        if (![stringType hasPrefix:@"@"]) {
//            continue;
//        }
//        if ((object_getIvar(self, thisIvar) == instance)) {//此处若 crash 不要慌！
//            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
//            break;
//        }
//    }
//    free(ivars);
//    return key;
//}

@end
