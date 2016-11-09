//
//  ZITOPayTableViewCell.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/5.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "ZITOPayTableViewCell.h"

@implementation ZITOPayTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+ (CGFloat)cellHeight:(NSDictionary *)dic
{
    return 0;
}

@end

@implementation HomeTableViewCell

{
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, [HomeTableViewCell cellHeight:nil])];
        
        [container setBackgroundColor:[UIColor redColor]];
        [self addSubview:container];
    }
    return self;
}

+ (CGFloat)cellHeight:(NSDictionary *)dic
{
//    NSDictionary * temp = nil;
    
    return 100;
}
@end

@implementation MessageTableViewCell

{
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, [HomeTableViewCell cellHeight:nil])];
        
        [container setBackgroundColor:[UIColor redColor]];
        [self addSubview:container];
    }
    return self;
}

+ (CGFloat)cellHeight:(NSDictionary *)dic
{
    return 100;
}
@end
