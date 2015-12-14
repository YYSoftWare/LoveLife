
//
//  UtteranceTableViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/14.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "UtteranceTableViewCell.h"

@implementation UtteranceTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI
{
    //头像
    _headImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 60, 60) imageName:nil];
    [self.contentView addSubview:_headImageView];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
    _headImageView.layer.masksToBounds = YES;
    
    //昵称
    _nickNameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_headImageView.frame.size.width + _headImageView.frame.origin.x + 10, 20, 70, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nickNameLabel];
    
    //发表时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 20 - 80, 20, 80, 15) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_timeLabel];
    
    //大图
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _headImageView.frame.size.height + _headImageView.frame.origin.y + 10, SCREEN_W - 20, 200) imageName:nil];
    [self.contentView addSubview:_mainImageView];
    
    //内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_contentLabel];
}

-(void)configUI:(UtteranceModel *)model
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url]];
    _nickNameLabel.text = model.publisher_name;
    _timeLabel.text = model.pub_time;
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image_urls[1]]];
    
    //计算内容的大小
    CGSize contentSize = [model.text boundingRectWithSize:CGSizeMake(SCREEN_W - 20, 500) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentLabel.frame = CGRectMake(10, _mainImageView.frame.size.height + _mainImageView.frame.origin.y + 10, SCREEN_W - 20, contentSize.height);
    
    self.cellHeight = CGRectGetMaxY(_contentLabel.frame) + 280 + 10;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
