
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
    _headImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 55, 55) imageName:nil];
    [self.contentView addSubview:_headImageView];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
    _headImageView.layer.masksToBounds = YES;
    
    //昵称
    _nickNameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_headImageView.frame.size.width + _headImageView.frame.origin.x + 10, 30, 150, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nickNameLabel];
    
    //发表时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 20 - 130, 40, 130, 15) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_timeLabel];
    
    //大图
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _headImageView.frame.size.height + _headImageView.frame.origin.y + 10, SCREEN_W - 20, 250) imageName:nil];
    [self.contentView addSubview:_mainImageView];
    
    //内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:17];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_contentLabel];
}

-(void)configUI:(UtteranceModel *)model
{
    //special_palcehold
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    _nickNameLabel.text = model.publisher_name;
    _timeLabel.text = model.pub_time;
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    
    //计算内容的大小
    CGSize contentSize = [model.text boundingRectWithSize:CGSizeMake(SCREEN_W - 20, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentLabel.frame = CGRectMake(10, _mainImageView.frame.size.height + _mainImageView.frame.origin.y + 10, SCREEN_W - 20, contentSize.height + 20);
    _contentLabel.text = model.text;
    
    self.cellHeight = CGRectGetHeight(_contentLabel.frame) + 330 + 10;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
