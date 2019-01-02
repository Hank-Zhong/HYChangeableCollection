//
//  ViewController.m
//  HYChangeableCollection
//
//  Created by Hank on 2019/1/2.
//  Copyright © 2019 Hank. All rights reserved.
//  Blog:https://www.hlzhy.com
//  GitHub:https://github.com/Hank-Zhong

#import "ViewController.h"

#import "HYChangeableCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, assign) BOOL isList;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;

@property (nonatomic, strong) NSArray *imageNameArray;
@end

#define NOTIFIC_N_NAME @"ViewController_changeList"
@implementation ViewController

-(UICollectionViewFlowLayout *)gridLayout{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (self.view.frame.size.width - 5) * 0.5;
        _gridLayout.itemSize = CGSizeMake(width, 200 + width);
        _gridLayout.minimumLineSpacing = 5;
        _gridLayout.minimumInteritemSpacing = 5;
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}

-(UICollectionViewFlowLayout *)listLayout{
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(self.view.frame.size.width, 190);
        _listLayout.minimumLineSpacing = 0.5;
        _listLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _listLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageNameArray = @[@"1.jpg",
                            @"2.jpg",
                            @"3.jpg",
                            @"4.jpg",
                            @"5.jpg",
                            @"6.jpg",
                            @"7.jpg",
                            @"8.jpg",
                            @"9.jpg",
                            @"10.jpg"];
    
    _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.backgroundColor = [UIColor grayColor];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [self.view addSubview:_myCollectionView];
    
    [self.myCollectionView registerClass:[HYChangeableCell class] forCellWithReuseIdentifier:@"HYChangeableCell"];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 44, 50, 20);
    [button setTitle:@"Change" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(changeListButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:button];
}

-(void)changeListButtonClick{
    _isList = !_isList;
    if (_isList) {
        [self.myCollectionView setCollectionViewLayout:self.listLayout animated:YES];
    }else{
        [self.myCollectionView setCollectionViewLayout:self.gridLayout animated:YES];
    }
//    [self.myCollectionView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFIC_N_NAME object:@(_isList)];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYChangeableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYChangeableCell" forIndexPath:indexPath];
    cell.isList = _isList;
    cell.notificationName = NOTIFIC_N_NAME;
    cell.imageName = self.imageNameArray[indexPath.row % 10];
    return cell;
}

@end
