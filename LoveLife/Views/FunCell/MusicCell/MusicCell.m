//
//  MusicCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/22.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MusicCell.h"

@implementation MusicCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    [self.contentView addSubview:_imageView];
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 15, 25, SCREEN_W - 20 - 10 - _imageView.frame.size.width, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x,_titleLabel.frame.origin.y + _titleLabel.frame.size.height,100, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_authorLabel];
    
}

-(void)configUI:(MusicModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    _titleLabel.text = model.title;
    _authorLabel.text = model.artist;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
