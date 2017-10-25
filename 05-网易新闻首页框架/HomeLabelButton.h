//
//  HomeLabelButton.h
//  05-网易新闻首页框架
//
//  Created by apple on 15/1/15.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLabelButton : UIButton
/**
 *  传入一个百分值来调整按钮内部的细节
 *
 *  @param percent 按钮占据的百分比
 */
- (void)adjust:(CGFloat)percent;
@end
