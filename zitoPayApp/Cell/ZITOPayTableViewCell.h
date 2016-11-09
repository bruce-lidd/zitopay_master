//
//  ZITOPayTableViewCell.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/5.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZITOPayTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)cellHeight:(NSDictionary *)dic;

@end

/*
 *首页
 */
@interface HomeTableViewCell : ZITOPayTableViewCell

@end

/*
 *流水
 */
@interface MessageTableViewCell : ZITOPayTableViewCell

@end
