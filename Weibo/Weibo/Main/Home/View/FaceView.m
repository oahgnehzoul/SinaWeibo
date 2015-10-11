//
//  FaceView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "FaceView.h"
#define item_width  (kScreenWidth/7.0)  //单个表情占用的区域宽度
#define item_height 45   //单个表情占用的区域高度

#define face_height 30   //表情图片的宽度
#define face_width 30   //表情图片的高度
@implementation FaceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _initData];
    }
    return self;
}
-(NSInteger)pageNumber {
    return _items.count;
}

- (void)_initData {
    _items = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *emoticons = [NSArray arrayWithContentsOfFile:filePath];
    NSInteger pageCount = 28;
    NSInteger page = emoticons.count/28;
    for (int i = 0; i<= page; i++) {
        NSInteger sub = emoticons.count - i*28;
        if (sub < pageCount) {
            pageCount = sub;
        }
        NSRange range = NSMakeRange(pageCount*i, pageCount);
        NSArray *item2D = [emoticons subarrayWithRange:range];
        [_items addObject:item2D];
    }
    
    //计算当前视图的宽度、高度
    
}

@end
