//
//  ViewController.m
//  多次绘制
//
//  Created by administrator on 16/3/1.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismiss:(UIStoryboardSegue*)segue {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
