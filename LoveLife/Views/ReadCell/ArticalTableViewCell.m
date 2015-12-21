//
//  ArticalTableViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/14.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ArticalTableViewCell.h"

@implementation ArticalTableViewCell

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
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 10, 25, SCREEN_W - 20 - 10 - _imageView.frame.size.width, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 10, 140, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 115,_timeLabel.frame.origin.y,100, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_authorLabel];
    
}

-(void)configUI:(ArticalModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    _titleLabel.text = model.title;
    _authorLabel.text = model.author;
    _timeLabel.text = model.createtime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
