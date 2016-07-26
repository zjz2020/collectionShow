//
//  HMImageCell.m
//  02-自定义UICollectionView布局
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMImageCell.h"

@interface HMImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation HMImageCell

- (void)awakeFromNib {
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 40;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

@end
