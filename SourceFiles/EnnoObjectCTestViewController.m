//
//  EnnoObjectCTestViewController.m
//  EnnoPannoS2
//
//  Created by Zouwanli on 2019/12/6.
//  Copyright © 2019 Zouwanli. All rights reserved.
//

#import "EnnoObjectCTestViewController.h"

@interface myGenericsTest <__covariant T:NSString*> : NSObject
//@interface myGenericsTest <__contravariant T> : NSObject

//@property(nonatomic,readonly)NSMutableArray <__kindof T>* elements;
//@property(nonatomic,readonly)NSMutableArray <__kindof T>* elements;

@property(nonatomic,readonly)NSMutableArray <T>* elements;

- (void)push:(T)obj;
- (T)pop;

@end

@implementation myGenericsTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _elements = [NSMutableArray array];
    }
    return self;
}
- (void)push:(id)obj{
    [_elements addObject:obj];
}

- (id)pop{
    id obj = [_elements lastObject];
    [_elements removeLastObject];
    return obj;
}

@end

@interface EnnoObjectCTestViewController ()



@end

@implementation EnnoObjectCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myGenericsTest <NSMutableString*> * generic = [[myGenericsTest alloc] init];
    for (int i = 0; i < 10; i++) {
        [generic push:[NSMutableString stringWithFormat:@"sss = %d",i]];
    }
    
//    NSString* sss = generic.pop;
//    NSString* str = generic.elements.lastObject;
//    EnnoLog(@"%@",str);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
