//
//  ViewController.m
//  bolingbolingboji
//
//  Created by SmartFun on 2017/12/20.
//  Copyright © 2017年 SmartFun. All rights reserved.
//

#import "ViewController.h"
#import "blingTool.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) blingTool *tool;

@end

@implementation ViewController

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tool = [[blingTool alloc] init];
    [self.tool addBehaviorArea:self.view];
    [self creatItem];
}

- (void)creatItem{
    for (int i = 0; i < 50; i++) {
        [self creatOneForItem];
    }
}


- (void)creatOneForItem{
    float size = arc4random() % 30 + 10;
    float x = arc4random() % (int)self.view.frame.size.width;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 100, size, size)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:self.data[arc4random() % self.data.count]];
    [self.view addSubview:imageView];
    [self.tool addBehaviorForItem:imageView];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeItem:)];
    [imageView addGestureRecognizer:taps];
}


- (void)removeItem:(UITapGestureRecognizer *)taps{
    UIView *tempViews = taps.view;
    [self.tool removeItem:tempViews];
    [tempViews removeFromSuperview];
    [self creatOneForItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
