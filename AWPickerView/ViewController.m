//
//  ViewController.m
//  AWPickerView
//
//  Created by lei-wen on 2019/4/9.
//  Copyright © 2019 lei-wen. All rights reserved.
//

#import "ViewController.h"
#import "AWpickerView.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define AWColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    self.cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT / 2 - 50, SCREEN_WIDTH - 40, 30)];
    self.cityTextField.placeholder = @"城市选择器";
    self.cityTextField.textAlignment = NSTextAlignmentCenter;
    self.cityTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.cityTextField];
    
    self.dateTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT / 2 + 50, SCREEN_WIDTH - 40, 30)];
    self.dateTextField.placeholder = @"时间选择器";
    self.dateTextField.textAlignment = NSTextAlignmentCenter;
    self.dateTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.dateTextField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*城市选择器*/
    AWPickerView *pickerView = [[AWPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 256, SCREEN_WIDTH, 256)];
    pickerView.pickerMode = AWPickerCityMode;
    
    /** 设置初始显示的省市
     1.标准是江苏省-南京市-玄武区，如果不是，则默认查找失败
     2.如果2级，默认显示2级的第一个
     */
    pickerView.defaultAddress = @"江苏省-南京市-玄武区";
    pickerView.backgroundColor = [UIColor whiteColor];
    
    // 点击确认后的回调按钮可以拿到3个字典，字典中根据areaName获得名字，areaId获得对应的ID
    __weak ViewController *weakSelf = self;
    pickerView.doneBtnBlock = ^(NSDictionary * _Nonnull province, NSDictionary * _Nonnull city, NSDictionary * _Nonnull area) {
        NSString *str = [NSString stringWithFormat:@"%@-%@, %@-%@, %@-%@", province[@"areaName"], province[@"areaId"], city[@"areaName"], city[@"areaId"], area[@"areaName"], area[@"areaId"]];
        weakSelf.cityTextField.text = str;
        [weakSelf.view endEditing:YES];
    };
    
    pickerView.scrollBlock = ^(NSDictionary * _Nonnull province, NSDictionary * _Nonnull city, NSDictionary * _Nonnull area) {
        NSString *str = [NSString stringWithFormat:@"%@-%@, %@-%@, %@-%@", province[@"areaName"], province[@"areaId"], city[@"areaName"], city[@"areaId"], area[@"areaName"], area[@"areaId"]];
        weakSelf.cityTextField.text = str;
    };
    
    pickerView.cancelBlock = ^{
        [weakSelf.view endEditing:YES];
    };
    self.cityTextField.inputView = pickerView;
    
    /*时间选择器*/
    AWPickerView *datePickerView = [[AWPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 256, SCREEN_WIDTH, 256)];
    datePickerView.pickerMode = AWPickerDateMode;
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.dateScrollBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month, NSString * _Nonnull day) {
        weakSelf.dateTextField.text = [NSString stringWithFormat:@"%@年-%@月-%@日", year, month, day];
    };
    
    datePickerView.dateDoneBtnBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month, NSString * _Nonnull day) {
        weakSelf.dateTextField.text = [NSString stringWithFormat:@"%@年-%@月-%@日", year, month, day];
        [weakSelf.view endEditing:YES];
    };
    
    datePickerView.cancelBlock = ^{
        [weakSelf.view endEditing:YES];
    };
    self.dateTextField.inputView = datePickerView;
}

@end
