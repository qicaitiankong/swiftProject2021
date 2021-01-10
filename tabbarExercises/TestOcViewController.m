//
//  TestOcViewController.m
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/9.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

#import "TestOcViewController.h"
#import"tabbarExercises-Swift.h"

@interface TestOcViewController ()

@end

@implementation TestOcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //oc 调用swift 文件
    MainPageViewController *mainVC = [[MainPageViewController alloc]init];
    
    
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
