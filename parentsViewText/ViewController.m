
//
//  ViewController.m
//  parentsViewText
//
//  Created by 张君泽 on 16/7/25.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "ViewController.h"
#import "HMImageCell.h"
#import "HMLineLayout.h"

static NSString *const ID = @"image";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UICollectionView *collectionView;
///选中的Itme
@property (nonatomic)NSInteger selectRow;
///动画效果
@property (nonatomic) BOOL animated;;
@end

@implementation ViewController

- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=5; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _animated = YES;
    self.selectRow = 0;
    CGFloat w = self.view.frame.size.width - 100;
    CGRect rect = CGRectMake(50, 64, w, 160);
    HMLineLayout *layout = [[HMLineLayout alloc] init];
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    self.collectionView = collectionV;
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.backgroundColor = [UIColor whiteColor];
    [collectionV registerNib:[UINib nibWithNibName:NSStringFromClass([HMImageCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionV];
    CGRect rect1 = CGRectMake(0, 64, 50, 160);
    CGRect rect2 = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 64, 50, 160);
    UIButton *rightBtn = [self creatBtnWithFram:rect2];
    UIButton *liftBtn = [self creatBtnWithFram:rect1];
    [rightBtn addTarget:self action:@selector(clickeRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [liftBtn addTarget:self action:@selector(clickLiftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [self.view addSubview:liftBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (UIButton *)creatBtnWithFram:(CGRect)rect{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    button.backgroundColor = [UIColor cyanColor];
    return button;
}
- (void)clickeRightBtn{
    NSLog(@"点击右侧按钮");
    _selectRow ++;
    if (self.selectRow == _images.count) {
        _animated = NO;
        _selectRow = 0;
    }else{
        _animated = YES;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectRow inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}
- (void)clickLiftBtn{
    NSLog(@"点击左侧按钮");
    _selectRow --;
    if (_selectRow < 0) {
        _animated = NO;
        _selectRow = _images.count -1;
    }else{
        _animated = YES;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectRow inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];

    
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectRow = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:_animated];
    NSLog(@"点击%zd",indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
