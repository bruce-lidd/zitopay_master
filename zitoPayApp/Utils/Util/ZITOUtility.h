//
//  ZITOUtility.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREENSIZE [[UIScreen mainScreen] bounds].size
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface ZITOUtility : NSObject
/*
 *NSUserDefaults操作取值
 */
+ (id)getDefaultValueForKey:(NSString *)key;
/*
 *NSUserDefaults设置值
 */
+ (void)setDefaultValue:(id)value key:(NSString *)key;
/*
 *param imageName
 *return img path
 */
+ (NSString *)getFilePathWithImageName:(NSString *)imageName;
/*
 *文件操作相关
 *判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;

/*
 *系统操作相关
 *获取系统版本
 */
+ (CGFloat)getSystemVersion;

/*
 *获取设备UA信息
 */
+ (NSString *)getDeviceUA;

/*
 *param date NSDate 
 *param format NSString
 *return timerDes NSString
 */
+ (NSString *)getTimeDesFromDate:(NSDate * )date withFormat:(NSString *)format;
@end
