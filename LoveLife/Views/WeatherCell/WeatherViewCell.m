//
//  WeatherViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "WeatherViewCell.h"
#import "WeatherModel.h"
#import "UIImageView+WebCache.h"
#import "NewFrame.h"
@implementation WeatherViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _wendu = [[UILabel alloc]init];
        _wendu.frame = [UIView getRectWithX:20 Y:0 Width:130 Height:80];
        
        _wind = [[UILabel alloc]init];
        _wind.frame = [UIView getRectWithX:20+130 Y:40 Width:100 Height:20];
        
        _city = [[UILabel alloc]init];
        _city.frame = [UIView getRectWithX:20+130+50 Y:50 Width:130 Height:80];
        
        _cityTem = [[UILabel alloc]init];
        _cityTem.frame = [UIView getRectWithX:12 Y:65 Width:130 Height:30];
        
        _tianqi = [[UILabel alloc]init];
        _tianqi.frame = [UIView getRectWithX:20+130 Y:20 Width:140 Height:20];
        
        _pm = [[UILabel alloc]init];
        _pm.frame = [UIView getRectWithX:20 Y:70 Width:200 Height:20];
        
        _date = [[UILabel alloc]init];
        _date.frame = [UIView getRectWithX:20 Y:90 Width:200 Height:20];
        
        _clothes = [[UILabel alloc]init];
        _clothes.frame = [UIView getRectWithX:20 Y:120 Width:200 Height:20];
        
        _advice = [[UILabel alloc]init];
        _advice.frame = [UIView getRectWithX:20 Y:140 Width:320-40 Height:50];
        
        _ganmao = [[UILabel alloc]init];
        _ganmao.frame = [UIView getRectWithX:20 Y:190 Width:200 Height:20];
        _advice1 = [[UILabel alloc]init];
        _advice1.frame = [UIView getRectWithX:20 Y:210 Width:320-40 Height:40];
        _travel = [[UILabel alloc]init];
        _travel.frame = [UIView getRectWithX:20 Y:250 Width:200 Height:20];
        _advice2 = [[UILabel alloc]init];
        _advice2.frame = [UIView getRectWithX:20 Y:270 Width:320-40 Height:50];
        
        _dayView1 = [[UIImageView alloc]init];
        _dayView1.frame = [UIView getRectWithX:15 Y:340 Width:42 Height:30];
        
        _nightView1 = [[UIImageView alloc]init];
        _nightView1.frame = [UIView getRectWithX:15+46 Y:340 Width:42 Height:30];
        
        _mingtian = [[UILabel alloc]init];
        _mingtian.frame = [UIView getRectWithX:15 Y:320 Width:100 Height:20];
        _weather1 = [[UILabel alloc]init];
        _weather1.frame = [UIView getRectWithX:15 Y:370 Width:100 Height:20];
        _temperature1 = [[UILabel alloc]init];
        _temperature1.frame = [UIView getRectWithX:15 Y:385 Width:100 Height:20];
        _dayView2 = [[UIImageView alloc]init];
        _dayView2.frame = [UIView getRectWithX:15+50+50+2 Y:340 Width:42 Height:30];
        _nightView2 = [[UIImageView alloc]init];
        _nightView2.frame = [UIView getRectWithX:15+50+50+50-2 Y:340 Width:42 Height:30];
        
        _houtian = [[UILabel alloc]init];
        _houtian.frame = [UIView getRectWithX:15+50+50+2 Y:320 Width:100 Height:20];
        _weather2 = [[UILabel alloc]init];
        _weather2.frame = [UIView getRectWithX:15+50+50+2 Y:370 Width:100 Height:20];
        _temperature2 = [[UILabel alloc]init];
        _temperature2.frame = [UIView getRectWithX:15+50+50+2 Y:385 Width:100 Height:20];
        _dayView3 = [[UIImageView alloc]init];
        _dayView3.frame = [UIView getRectWithX:15+50+50+50+50+2 Y:340 Width:42 Height:30];
        _nightView3 = [[UIImageView alloc]init];
        _nightView3.frame = [UIView getRectWithX:15+50+50+50+50+50-2 Y:340 Width:42 Height:30];
        _dahoutian = [[UILabel alloc]init];
        _dahoutian.frame = [UIView getRectWithX:15+50+50+50+50+2 Y:320 Width:100 Height:20];
        _weather3 = [[UILabel alloc]init];
        _weather3.frame = [UIView getRectWithX:15+50+50+50+50+2 Y:370 Width:100 Height:20];
        _temperature3 = [[UILabel alloc]init];
        _temperature3.frame = [UIView getRectWithX:15+50+50+50+50+2 Y:385 Width:100 Height:20];

    }
    return self;
}
- (void)relyoutUI:(WeatherModel *)_model{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"weatherBackground2.jpg" ofType:nil];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    _imgView.image = img;
    [self.contentView addSubview:_imgView];
    
    //  "date": "周二 09月29日 (实时：15℃)",
    NSString *text = _model.weather_data[0][@"date"];
    NSArray *arr = [text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"：)"]];
    _wendu.text = arr[1];
    _wendu.textColor = [UIColor whiteColor];
    _wendu.font = [UIFont systemFontOfSize:55];
    [_imgView addSubview:_wendu];
    
    _wind.textColor = [UIColor whiteColor];
    _wind.font = [UIFont systemFontOfSize:14];
    _wind.text = [NSString stringWithFormat:@"%@",_model.weather_data[0][@"wind"]];
    [_imgView addSubview:_wind];
    
    _city.text = _model.results[0][@"currentCity"];
    _city.textColor = [UIColor greenColor];
    _city.font = [UIFont systemFontOfSize:55];
    [_imgView addSubview:_city];
    
    
    NSDictionary *dic0 = _model.weather_data[0];
    _cityTem.text = dic0[@"temperature"];
    _cityTem.textColor = [UIColor whiteColor];
    _cityTem.font = [UIFont systemFontOfSize:20];
    [_city addSubview:_cityTem];
    
    _tianqi.textColor = [UIColor whiteColor];
    _tianqi.font = [UIFont systemFontOfSize:14];
    _tianqi.text = _model.weather_data[0][@"weather"];
    [_imgView addSubview:_tianqi];

    _pm.textColor = [UIColor whiteColor];
    _pm.font = [UIFont systemFontOfSize:13];
    _pm.text = [NSString stringWithFormat:@"空气质量指数:%@",_model.results[0][@"pm25"]];
    [_imgView addSubview:_pm];
    
    _date.textColor = [UIColor whiteColor];
    _date.font = [UIFont systemFontOfSize:13];
    _date.text = [NSString stringWithFormat:@"发布时间：%@",_model.date];
    [_imgView addSubview:_date];
    
    
    _clothes.textColor = [UIColor whiteColor];
    _clothes.font = [UIFont systemFontOfSize:13];
    _clothes.text = [NSString stringWithFormat:@"%@:%@",_model.results[0][@"index"][0][@"tipt"],_model.results[0][@"index"][0][@"zs"]];
    
    _advice.textColor = [UIColor whiteColor];
    _advice.font = [UIFont systemFontOfSize:13];
    _advice.text = [NSString stringWithFormat:@"今日建议：%@",_model.results[0][@"index"][0][@"des"]];
    _advice.numberOfLines = 0;
    [_imgView addSubview:_clothes];
    [_imgView addSubview:_advice];
    
    
    _ganmao.textColor = [UIColor whiteColor];
    _ganmao.font = [UIFont systemFontOfSize:13];
    _ganmao.text = [NSString stringWithFormat:@"%@:%@",_model.results[0][@"index"][3][@"tipt"],_model.results[0][@"index"][3][@"zs"]];
    
    _advice1.textColor = [UIColor whiteColor];
    _advice1.font = [UIFont systemFontOfSize:13];
    _advice1.text = [NSString stringWithFormat:@"今日建议：%@",_model.results[0][@"index"][3][@"des"]];
    _advice1.numberOfLines = 0;
    [_imgView addSubview:_ganmao];
    [_imgView addSubview:_advice1];
    
    _travel.textColor = [UIColor whiteColor];
    _travel.font = [UIFont systemFontOfSize:13];
    _travel.text = [NSString stringWithFormat:@"%@:%@",_model.results[0][@"index"][2][@"tipt"],_model.results[0][@"index"][2][@"zs"]];
    
    _advice2.textColor = [UIColor whiteColor];
    _advice2.font = [UIFont systemFontOfSize:13];
    _advice2.text = [NSString stringWithFormat:@"今日建议：%@",_model.results[0][@"index"][2][@"des"]];
    _advice2.numberOfLines = 0;
    [_imgView addSubview:_travel];
    [_imgView addSubview:_advice2];
    
    
    NSDictionary *dic1 = _model.weather_data[1];
    [_dayView1 sd_setImageWithURL:[NSURL URLWithString:dic1[@"dayPictureUrl"]]];
    [_nightView1 sd_setImageWithURL:[NSURL URLWithString:dic1[@"nightPictureUrl"]]];
    [_imgView addSubview:_dayView1];
    [_imgView addSubview:_nightView1];
    
    _mingtian.textAlignment = NSTextAlignmentCenter;
    _mingtian.textColor = [UIColor whiteColor];
    _mingtian.font = [UIFont systemFontOfSize:14];
    _mingtian.text =dic1[@"date"];
    [_imgView addSubview:_mingtian];
    
    
    _weather1.textColor = [UIColor whiteColor];
    _weather1.font = [UIFont systemFontOfSize:12];
    _weather1.text =dic1[@"weather"];
    [_imgView addSubview:_weather1];
   
    _temperature1.textColor = [UIColor whiteColor];
    _temperature1.font = [UIFont systemFontOfSize:12];
    _temperature1.text =dic1[@"temperature"];
    [_imgView addSubview:_temperature1];
    
    NSDictionary *dic2 = _model.weather_data[2];
    [_dayView2 sd_setImageWithURL:[NSURL URLWithString:dic2[@"dayPictureUrl"]]];
    [_nightView2 sd_setImageWithURL:[NSURL URLWithString:dic2[@"nightPictureUrl"]]];
    [_imgView addSubview:_dayView2];
    [_imgView addSubview:_nightView2];
    
    _houtian.textAlignment = NSTextAlignmentCenter;
    _houtian.textColor = [UIColor whiteColor];
    _houtian.font = [UIFont systemFontOfSize:14];
    _houtian.text =dic2[@"date"];
    [_imgView addSubview:_houtian];
    
    
    _weather2.textColor = [UIColor whiteColor];
    _weather2.font = [UIFont systemFontOfSize:12];
    _weather2.text =dic2[@"weather"];
    [_imgView addSubview:_weather2];
   
    _temperature2.textColor = [UIColor whiteColor];
    _temperature2.font = [UIFont systemFontOfSize:12];
    _temperature2.text =dic2[@"temperature"];
    [_imgView addSubview:_temperature2];
    
    
    NSDictionary *dic3 = _model.weather_data[3];
    [_dayView3 sd_setImageWithURL:[NSURL URLWithString:dic3[@"dayPictureUrl"]]];
    [_nightView3 sd_setImageWithURL:[NSURL URLWithString:dic3[@"nightPictureUrl"]]];
    [_imgView addSubview:_dayView3];
    [_imgView addSubview:_nightView3];
    
    _dahoutian.textAlignment = NSTextAlignmentCenter;
    _dahoutian.textColor = [UIColor whiteColor];
    _dahoutian.font = [UIFont systemFontOfSize:14];
    _dahoutian.text =dic3[@"date"];
    [_imgView addSubview:_dahoutian];
    
    _weather3.textColor = [UIColor whiteColor];
    _weather3.font = [UIFont systemFontOfSize:12];
    _weather3.text =dic3[@"weather"];
    [_imgView addSubview:_weather3];
    
    _temperature3.textColor = [UIColor whiteColor];
    _temperature3.font = [UIFont systemFontOfSize:12];
    _temperature3.text =dic3[@"temperature"];
    [_imgView addSubview:_temperature3];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
