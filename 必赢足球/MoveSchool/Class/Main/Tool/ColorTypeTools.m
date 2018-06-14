//
//  ColorTypeTools.m
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ColorTypeTools.h"
#import <CommonCrypto/CommonCryptor.h> //MD5的使用
#import "UIImageView+WebCache.h"

@implementation ColorTypeTools


+(NSString *)getTypeStringWith:(NSString *)type{
    
    if ([type isEqualToString:@"1"]) {
        type=@"朋友圈";
    }else if ([type isEqualToString:@"2"]){
        type=@"朋友圈回复通知";
        
    }else if ([type isEqualToString:@"3"]){
        type=@"考试";
        
    }else if ([type isEqualToString:@"4"]){
        type=@"资讯";
        
    }else if ([type isEqualToString:@"5"]){
        type=@"专题";
        
    }else if ([type isEqualToString:@"6"]){
        type=@"沙龙";
        
    }else if ([type isEqualToString:@"7"]){
        type=@"问卷";
        
    }else if ([type isEqualToString:@"8"]){
        type=@"直播";
        
    }else if ([type isEqualToString:@"9"]){
        type=@"讲师";
    }else if ([type isEqualToString:@"10"]){
        type=@"问答";
    }else if ([type isEqualToString:courseType]){
        type=@"课程";
    }
    return type;
}

+(NSString *) aes256_encrypt:(NSString *)key withString:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    //对数据进行加密
    NSData *result = [self DESEncrypt:data WithKey:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

+(NSString *) aes256_decrypt:(NSString *)key withString:(NSString *)str
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:str.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [self DESDecrypt:data WithKey:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/**
 *  把图片保存到相册
 *
 */
+(void)saveImageToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

+(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
}


+(NSString *)getStudyStatusWith:(NSString *)type{
    //-1  项目过期课程
    // 1有/无考试未学完显示‘学习中’绿色按钮
    // 2 有考试已学完显示‘考试’红色按钮
    // 3 有考试未通过考试‘补考’红色按钮
    // 4 有考试通过考试‘已通过’绿字
    // 5 有考试补考未通过‘未通过’红字
    // 6 无考试已学完‘已学完’绿字
    if ([type isEqualToString:@"1"]) {
        type=@"学习中";
    }else if ([type isEqualToString:@"2"]){
        type=@"考试";
        
    }else if ([type isEqualToString:@"3"]){
        type=@"补考";
        
    }else if ([type isEqualToString:@"4"]){
        type=@"已通过";
        
    }else if ([type isEqualToString:@"5"]){
        type=@"未通过";
        
    }else if ([type isEqualToString:@"6"]){
        type=@"已学完";
        
    }else{
        
        type=@"过期";
        
    }
    return type;
    
}

+(UIBarButtonItem *)itemWithTitleName:(NSString *)TitleName highTitleName:(NSString *)hightTitleName addTarget:(id )class action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:TitleName forState:UIControlStateNormal];
    [button setTitle:hightTitleName forState:UIControlStateSelected];
    [button setTitleColor:kColorBlack forState:UIControlStateNormal];
    button.titleLabel.font = kFont14;
    button.frame=CGRectMake(30, 0, 60, 44);
    [button addTarget:class action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName  addTarget:(id )class action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImageName] forState:UIControlStateHighlighted];
    
    //  设置按钮的尺寸
    button.size = button.currentBackgroundImage.size;
    [button addTarget:class action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(void)clearCache:(NSString *)path{    //清除缓存
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            
            
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];//清除缓存
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
}

+(NSString *)clearTmpPics
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    NSString *temp = [ManyLanguageMag getSettingStrWith:@"清除缓存"];
    NSString *clearCacheName = tmpSize >= 1024 ? [NSString stringWithFormat:@"%@(%.2fM)",temp,tmpSize/1024/1024] : [NSString stringWithFormat:@"%@(%.2fK)",temp,tmpSize/1024];
    
    return clearCacheName;
}

@end
