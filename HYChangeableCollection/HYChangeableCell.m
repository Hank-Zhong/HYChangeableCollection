//
//  HYChangeableCell.m
//  HYChangeableCollection
//
//  Created by Hank on 2019/1/2.
//  Copyright © 2019 Hank. All rights reserved.
//

#import "HYChangeableCell.h"

#import "Masonry.h"

@interface HYChangeableCell ()
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;

@property (strong, nonatomic) UILabel *label3;
@property (strong, nonatomic) UILabel *label4;

@property (nonatomic, strong) UIButton *buttonL;
@property (nonatomic, strong) UIButton *buttonR;

@end


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@implementation HYChangeableCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [UIView animateWithDuration:0.3 animations:^{
        [super layoutSubviews];
    }];
}


-(void)setupUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.myImageView = [UIImageView new];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.myImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.text = @"I am a big, long and dark title. 🌚🌚🌚🚀";
    [self.contentView addSubview:self.titleLabel];
    
    self.label1 = [UILabel new];
    self.label1.textColor = [UIColor redColor];
    self.label1.font = [UIFont systemFontOfSize:16];
    self.label1.text = @"What's this?🤔";
    [self.contentView addSubview:self.label1];
    
    self.label2 = [UILabel new];
    self.label2.textColor = [UIColor grayColor];
    self.label2.font = [UIFont systemFontOfSize:12];
    self.label2.numberOfLines = 2;
    self.label2.text = @"I am Groot!\nI am Groot!!😑";
    [self.contentView addSubview:self.label2];
    
    self.label3 = [UILabel new];
    self.label3.textColor = [UIColor greenColor];
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label3.numberOfLines = 2;
    self.label3.text = @"https://www.hlzhy.com";
    self.label3.frame = CGRectMake(12, 295, self.frame.size.width - 24, 15);
    [self.contentView addSubview:self.label3];
    
    self.label4 = [UILabel new];
    self.label4.textColor = [UIColor greenColor];
    self.label4.font = [UIFont systemFontOfSize:12];
    self.label4.text = @"Hank";
    self.label4.frame = CGRectMake(12, CGRectGetMaxY(self.label3.frame), self.frame.size.width - 24, 15);
    [self.contentView addSubview:self.label4];
    
    self.buttonL = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonL setTitle:@"Don't click me!!!" forState:(UIControlStateNormal)];
    [self.buttonL addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonL setBackgroundColor:[UIColor lightGrayColor]];
    self.buttonL.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.buttonL];
    
    self.buttonR = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.buttonR setTitle:@"buttonR" forState:(UIControlStateNormal)];
    [self.buttonR addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonR setBackgroundColor:[UIColor lightGrayColor]];
    self.buttonR.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.buttonR];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(12);
        make.left.offset(12);
        make.width.offset(self.frame.size.width - 24);
        make.height.equalTo(self.myImageView.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myImageView.mas_bottom).offset(12);
        make.left.equalTo(self.myImageView.mas_left).offset(0);
//        make.right.offset(-12);
        make.width.offset(self.frame.size.width - 24);
        make.height.offset(38);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titleLabel.mas_left).offset(0);
        make.height.offset(20);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label1.mas_centerY).offset(25);
        make.left.equalTo(self.label1.mas_left).offset(0);
        make.height.offset(30);
    }];
    
    [self.buttonL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label4.mas_bottom).offset(12);
        make.left.offset(12);
        make.height.offset(33);
    }];
    
    [self.buttonR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label4.mas_bottom).offset(12);
        make.left.offset(self.frame.size.width - 74);
        make.height.offset(33);
        make.width.offset(62);
    }];
    
}

-(void)buttonClick{}

-(void)setImageName:(NSString *)imageName{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:imageName];
    self.myImageView.image = [UIImage imageWithContentsOfFile:filePath];
}

#pragma mark - NSNotification

-(void)setNotificationName:(NSString *)notificationName{
    if ([_notificationName isEqualToString:notificationName]) return;
    _notificationName = notificationName;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isListChange:) name:_notificationName object:nil];
}

-(void)isListChange:(NSNotification *)noti{
    BOOL isList = [[noti object] boolValue];
    [self setIsList:isList];
}

#pragma mark - setIsList
-(void)setIsList:(BOOL)isList{
    if (_isList == isList) return;
    _isList = isList;
    //    NSLog(@"width : %lf", self.frame.size.width);
    //接收到通知时 cell的frame并不准确，此时如果需要用到self.width，则需要自行计算
    CGFloat width = _isList ? SCREEN_WIDTH : (SCREEN_WIDTH - 5) * 0.5;
    CGRect frame3 = self.label3.frame;
    CGRect frame4 = self.label4.frame;
    if (_isList) {
        //当布局相对简单时，约束使用mas_updateConstraints进行更新即可
        [self.myImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(120);
        }];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(12);
            make.left.equalTo(self.myImageView.mas_right).offset(12);
            make.width.offset(width - 120 - 36);
//            make.right.offset(-12);
        }];
        //当布局比较复杂，约束涉及到某控件宽，而这控件宽又是不固定的时候，可以考虑使用mas_remakeConstraints重做约束
        [self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.label1.mas_centerY).offset(0);
            //make.left.equalTo(self.label1.mas_left).offset(self.label1.mj_w + 5);
            make.left.equalTo(self.label1.mas_right).offset(5);
            make.height.offset(30);
        }];
        
        CGFloat x = 120 + 24;
        frame3.origin.x = x;
        frame3.origin.y = 100;
        frame4.origin.x = x;
        frame4.origin.y = frame3.origin.y + 15;
    }else{
        [self.myImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset((SCREEN_WIDTH - 5) * 0.5 - 24);
        }];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myImageView.mas_bottom).offset(12);
            make.left.equalTo(self.myImageView.mas_left).offset(0);
            make.width.offset(self.frame.size.width - 24);
//            make.right.offset(-12);
        }];
        
        [self.label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.label1.mas_centerY).offset(22);
            make.left.equalTo(self.label1.mas_left).offset(0);
            make.height.offset(30);
        }];
        
        CGFloat x = 12;
        frame3.origin.x = x;
        frame3.origin.y = 295;
        frame4.origin.x = x;
        frame4.origin.y = frame3.origin.y + 15;
    }

    [self.buttonR mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(width - 74);
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        //注意：如有用masonry约束关联了 用frame设置的视图，则此处需要把frame设置的视图写在前面
        self.label3.frame = frame3;
        self.label4.frame = frame4;
        
        [self.contentView layoutIfNeeded];
    }];
}

-(void)dealloc{
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
