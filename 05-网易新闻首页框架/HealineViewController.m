//
//  HealineViewController.m
//  05-网易新闻首页框架
//
//  Created by apple on 15/1/15.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HealineViewController.h"

@interface HealineViewController ()

@end

@implementation HealineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ -- viewDidLoad", self.title);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"news";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- 数据", self.title];
    return cell;
}
@end
