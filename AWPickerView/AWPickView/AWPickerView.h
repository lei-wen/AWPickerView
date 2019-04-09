//
//  AWPickerView.h
//  AWPickerView
//
//  Created by lei-wen on 2019/4/9.
//  Copyright © 2019 lei-wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AWPickerMode) {
    AWPickerCityMode,
    AWPickerDateMode,
};

NS_ASSUME_NONNULL_BEGIN

@interface AWPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, readwrite, assign) AWPickerMode pickerMode;

/** 设置初始显示的省市
 1.标准是江苏省-南京市-玄武区，如果不是，则默认
 2.如果2级，默认显示2级的第一个
 3.暂不支持区域ID查找，因为太蠢
 */
@property (strong, nonatomic, readwrite) NSString *_Nullable defaultAddress;

/** 上方工具栏是否隐藏*/
@property (nonatomic, getter=isToolBarHidden, assign) BOOL toolBarHide;

/** 每个选择器滚动完成后*/
@property (strong, nonatomic, readwrite) void (^_Nullable scrollBlock)(NSDictionary * _Nonnull province, NSDictionary *_Nonnull city, NSDictionary *_Nonnull area);

@property (strong, nonatomic, readwrite) void (^_Nullable dateScrollBlock)(NSString * _Nonnull year, NSString *_Nonnull month, NSString *_Nonnull day);

/** 点击上方工具栏确定按钮*/
@property (strong, nonatomic, readwrite) void (^_Nullable doneBtnBlock)(NSDictionary *_Nonnull province, NSDictionary *_Nonnull city, NSDictionary *_Nonnull area);

@property (strong, nonatomic, readwrite) void (^_Nullable dateDoneBtnBlock)(NSString *_Nonnull year, NSString *_Nonnull month, NSString *_Nonnull day);

/** 点击上方工具栏取消按钮*/
@property (strong, nonatomic, readwrite) void (^_Nullable cancelBlock)(void);

@end

NS_ASSUME_NONNULL_END
