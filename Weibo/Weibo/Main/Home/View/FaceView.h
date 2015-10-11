//
//  FaceView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDelegate <NSObject>

- (void)faceDidSelect:(NSString *)text;

@end

@interface FaceView : UIView{
    NSMutableArray *_items; //二位数组
    UIImageView *_magnifierView; //放大镜
    NSString *_selectedFaceName; //选中的表情
}

@property (nonatomic,readonly) NSInteger pageNumber;
@property (nonatomic,weak) id<FaceViewDelegate> delegate;

@end
