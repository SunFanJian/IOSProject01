//
//  SFJSettingCell.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJSettingCell.h"

#import "SFJTableItem.h"
#import "SFJTableSection.h"
#import "SFJTableArrowItem.h"

@implementation SFJSettingCell

static NSString *const ID = @"SFJSettingCell";

//1.instancetype
+(instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style
{
    SFJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:style reuseIdentifier:ID];
    }
    return  cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupBaseSettingCellUI];
    }
    return self;
}

- (void)setupBaseSettingCellUI
{
    self.detailTextLabel.numberOfLines = 0;
}

//2.layout
-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//3. set
-(void)setItem:(SFJTableItem *)item
{
    _item = item;
    
    [self fillData];
    [self changeUI];
}

//数据显示
-(void)fillData
{
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subTitle;
    
    /** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
    if ([self.item.image isKindOfClass:[UIImage class]]) {
        self.imageView.image = self.item.image;
    }else if ([self.item.image isKindOfClass:[NSURL class]]) {
       // [self.imageView sd_setImageWithURL:self.item.image];
    }else if ([self.item.image isKindOfClass:[NSString class]]) {
        
        if ([self.item.image hasPrefix:@"http://"] || [self.item.image hasPrefix:@"https://"] || [self.item.image hasPrefix:@"file://"]) {
            
          //  NSString *imageUrl = [self.item.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
          //  [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }else {
            self.imageView.image = [UIImage imageNamed:self.item.image];
        }
    }
}

-(void)changeUI
{
    //基本样式
    self.textLabel.font = self.item.titleFont;
    self.textLabel.textColor = self.item.titleColor;
    
    self.detailTextLabel.font = self.item.subTitleFont;
    self.detailTextLabel.textColor = self.item.subTitleColor;
    self.detailTextLabel.numberOfLines = self.item.subTitleNumberOfLines;
    
    //是否带箭头
    if ([self.item isKindOfClass:[SFJTableArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    //cell 点击样式
    if (self.item.itemOperation || [self.item isKindOfClass:[SFJTableArrowItem class]]) {
        self.selectionStyle = UITableViewCellStyleDefault;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}
@end
