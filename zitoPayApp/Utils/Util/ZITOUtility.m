//
//  ZITOUtility.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "ZITOUtility.h"

@implementation ZITOUtility

+ (id)getDefaultValueForKey:(NSString *)key
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setDefaultValue:(id)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (CGFloat)getSystemVersion
{
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

+ (NSString *)getDeviceUA
{
    NSString * brand = @"Apple Computer, Inc.";
    NSString * model = [UIDevice currentDevice].model;
    NSString * osVersion = [[UIDevice currentDevice] systemName];
    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
    
    return [NSString stringWithFormat:@"%@^%@^%@^%@",brand,model,osVersion,systemVersion];
}

+ (NSString *)getTimeDesFromDate:(NSDate * )date withFormat:(NSString *)format
{
    NSString * timeDes = nil;
    
    NSDate * now = [NSDate date];
    NSTimeInterval fDate = [date timeIntervalSince1970];
    NSTimeInterval fNow = [now timeIntervalSince1970];
    
    NSTimeInterval sub = fNow - fDate;
    
    if (sub/60<1) {
        timeDes = @"刚刚";
    }else if (sub/3600<1){
        NSInteger temp = floor(sub/60.0);
        timeDes = [NSString stringWithFormat:@"%ld%@",temp,@"分钟前"];
    }else if (sub/3600>1 && sub/86400<1){
        NSInteger temp = floor(sub/3600.0);
        timeDes = [NSString stringWithFormat:@"%ld%@",temp,@"小时前"];
    }else if (sub/86400>1 && sub/86400<5 ){
        NSInteger temp = floor(sub/86400.0);
        timeDes = [NSString stringWithFormat:@"%ld%@",temp,@"天前"];
    }else if (sub/3600<1){
        timeDes = [ZITOUtility convertToStringFromDate:date withFormat:format];
    }
    return timeDes;
}

+ (NSString *)convertToStringFromDate:(NSDate *)inputDate withFormat:(NSString *)format
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSString * result = [dateFormat stringFromDate:inputDate];
    return result;
}
@end
