//
//  StudyCircleFrame.m
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import "StudyCircleFrame.h"
#import "StudyCircleModel.h"
#import "NSAttributedString+Extension.h"
#import "NSString+Extension.h"
#import "NSDataEx.h"
#import "StudyAttachs.h"
#import "StudyReply.h"
#import "EmotionTool.h"
#import "NSDate+Extension.h"
#import "StudyPraises.h"
#import "MJExtension.h"
#import "PraiseUsers.h"

//图片间距
#define imageSpacint 4

@implementation StudyCircleFrame

MJCodingImplementation

- (void)setStudyCircleModel:(StudyCircleModel *)studyCircleModel
{
    _studyCircleModel = studyCircleModel;
    
    _headerFrame = CGRectMake(mainSpacing, mainSpacing, 35, 35);
    
    // 昵称X
    CGFloat namex = CGRectGetMaxX(_headerFrame) + mainSpacing;
    CGSize size = [studyCircleModel.nickname returnStringRect:studyCircleModel.nickname size:CGSizeMake(SCREEN_WIDTH - namex - mainSpacing, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]];
    _nameFrame = CGRectMake(namex, mainSpacing, size.width > SCREEN_WIDTH - namex - mainSpacing ? SCREEN_WIDTH - namex - mainSpacing : size.width, 20);
    
    //图片Y
    CGFloat imageY = CGRectGetMaxY(_headerFrame) + mainSpacing;
    
    //内容
    if (studyCircleModel.content.length > 0) {
        
        CGFloat contentW = SCREEN_WIDTH - mainSpacing15 * 2;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self base64DecodeString:studyCircleModel.content]];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[self base64DecodeString:studyCircleModel.content] length])];
        
        CGSize contentSize = [attributedString returnAttributedStringRect:attributedString size:CGSizeMake(contentW, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]];

        _contentFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_headerFrame) + mainSpacing, contentW, contentSize.height);
        
        //需要 展示全部内容
        if (!self.needShowAllContent) {
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:_contentFrame];
            contentLabel.attributedText = attributedString;
            NSNumber *count = @((contentLabel.size.height + LineSpacing) / (contentLabel.font.lineHeight + LineSpacing));
            
            if ([count intValue] > 3) {
                _isMoreThanSix = YES;
                
                _contentFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_headerFrame) + mainSpacing, contentW, 3 * contentLabel.font.lineHeight + LineSpacing * 2);
                
                _allFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_contentFrame) + mainSpacing, [@"全文" returnStringRect:@"全文" size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width, 20);
                
                imageY = CGRectGetMaxY(_allFrame);
                
            }else
            {
                _isMoreThanSix = NO;
                _allFrame = CGRectZero;
                imageY = CGRectGetMaxY(_contentFrame);
            }
        }else
        {
            _isMoreThanSix = YES;
            
            _allFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_contentFrame) + mainSpacing, [@"全文" returnStringRect:@"全文" size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width, 20);
            
            imageY = CGRectGetMaxY(_allFrame);
        }
    }
    
    //时间
    CGFloat timeY = imageY + mainSpacing;
    
    //图片
    if (studyCircleModel.attachs.count > 0) {
        //计算 图片宽高
        CGFloat imageWH = ((SCREEN_WIDTH - namex * 1.5) - 2 * imageSpacint) / 3;
        
        //9张图片时的宽高
        CGFloat nightWH = SCREEN_WIDTH - namex * 1.5;
        
        //只有一张图片 特殊处理
        if (studyCircleModel.attachs.count == 1) {
            
            StudyAttachs *attach = [studyCircleModel.attachs firstObject];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:attach.thumbnail]];
            UIImage *image = [UIImage imageWithData:data];

            CGFloat baseSize = (SCREEN_WIDTH - 2 * mainSpacing15) * 0.6;
            
            if (image.size.width >= image.size.height) {
                _imagesFrame = CGRectMake(mainSpacing15, imageY, baseSize , (baseSize / image.size.width) * image.size.height);

            }else
            {
                _imagesFrame = CGRectMake(mainSpacing15, imageY, (baseSize / image.size.height) *image.size.width , baseSize);

            }
            
            if (image == nil) {
                _imagesFrame = CGRectZero;
            }
            
            _oneImageFrame = CGRectMake(0, 0, _imagesFrame.size.width, _imagesFrame.size.height);
        
        }else if(studyCircleModel.attachs.count != 4)
        {
            int count = (int)studyCircleModel.attachs.count;
            CGFloat imageH = 0;
            
            if (count < 4) { // 一行
                imageH = imageWH;
            }else if(count < 7) // 二行
            {
                imageH = imageWH * 2 + imageSpacint;
            }else //三行
            {
                imageH = imageWH * 3 + 2 * imageSpacint;
            }
            
            _imagesFrame = CGRectMake(mainSpacing15, imageY, count > 2 ? nightWH : imageWH * 2 + imageSpacint, imageH);
            
            _oneImageFrame = CGRectMake(0, 0, imageWH, imageWH);
        }else //4张图片 特殊处理
        {
            _imagesFrame = CGRectMake(mainSpacing15, imageY, imageWH * 2 + imageSpacint, imageWH * 2 + imageSpacint);
            _oneImageFrame = CGRectMake(0, 0, imageWH, imageWH);
        }
        
        timeY = CGRectGetMaxY(_imagesFrame) + mainSpacing;
    }
    
    NSString *time = studyCircleModel.indate;
    
    CGFloat newTimeY = timeY;
    
    if (studyCircleModel.attachs.count > 0) {
        StudyAttachs *attach = studyCircleModel.attachs.firstObject;
        if ([attach.attach_businesscode isEqualToString:courseType]) {
            _describeFrame = CGRectMake(mainSpacing15, timeY, [attach.title returnStringRect:attach.title size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + mainSpacing, 20);
            newTimeY = CGRectGetMaxY(_describeFrame);
        }else
        {
            newTimeY = timeY;
            _describeFrame = CGRectZero;
        }
    }else
    {
        newTimeY = timeY;
        _describeFrame = CGRectZero;
    }
    
    //点赞Frame
    CGFloat goodW = [NSString returnStringRect:studyCircleModel.praise.num size:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + 25;
    _goodFrame = CGRectMake(SCREEN_WIDTH - goodW - mainSpacing, newTimeY, goodW, 20);
    
    //评论Frame
    CGFloat commentW = [NSString returnStringRect:studyCircleModel.commentcount size:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + 25;
    _commentFrame = CGRectMake(_goodFrame.origin.x - mainSpacing - commentW, _goodFrame.origin.y, commentW, 30);
    
    //中间分割线
    _centerSepaViewFrame = CGRectMake(_contentFrame.origin.x, CGRectGetMaxY(_goodFrame) + mainSpacing, SCREEN_WIDTH - _contentFrame.origin.x, 0.5);
    
    CGFloat timeW = [time returnStringRect:time size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + mainSpacing;
    _timeFrame = CGRectMake(SCREEN_WIDTH - timeW, mainSpacing15, timeW, 20);
    
    //自己发布
    if (studyCircleModel.isself == 1) {
        CGSize size = [@"删除" returnStringRect:@"删除" size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]];
        _deleteFrame = CGRectMake(_commentFrame.origin.x - mainSpacing15 - size.width - 15, _timeFrame.origin.y, size.width + 25, size.height);
    }else
    {
        _deleteFrame = CGRectZero;
    }
    
    CGFloat commentButtonY = 0;
    if (14 - _timeFrame.size.height > 0) {
        commentButtonY = _timeFrame.origin.y - (14 - _timeFrame.size.height) * 0.5;
    }else
    {
        commentButtonY = _timeFrame.origin.y + (_timeFrame.size.height - 14) * 0.5;
    }
    
    //赞👍
    if (studyCircleModel.praise.praiseUsers.count > 0) {
        NSMutableString *praiseContent = [NSMutableString string];
        for (PraiseUsers *praise in studyCircleModel.praise.praiseUsers) {
            [praiseContent appendString:[NSString stringWithFormat:@"%@  ",praise.nickname]];
        }
        
        if ([praiseContent containsString:@"  "]) {
            praiseContent = (NSMutableString *)[praiseContent substringToIndex:praiseContent.length - 1];
        }
        
        NSMutableAttributedString *praiseAttribute = [[NSMutableAttributedString alloc] initWithString:praiseContent];

        //图片名称
        NSTextAttachment *textAttach = [[NSTextAttachment alloc] init];
        textAttach.bounds = CGRectMake(0, -2, 20, 15);
        textAttach.image = [UIImage imageNamed:@"dianzanming"];
        
        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttach];
        
        [praiseAttribute insertAttributedString:imageStr atIndex:0];
        
        self.praiseAttribute = praiseAttribute;
        
        CGSize size = [praiseAttribute returnAttributedStringRect:praiseAttribute size:CGSizeMake(SCREEN_WIDTH - mainSpacing - mainSpacing15, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]];
        _praiseListFrame = CGRectMake(mainSpacing15 + 5, CGRectGetMaxY(_centerSepaViewFrame) + mainSpacing, SCREEN_WIDTH - mainSpacing - mainSpacing15 - 5, size.height);
        
        _cellHeight = CGRectGetMaxY(_praiseListFrame);

    }else
    {
        _praiseListFrame = CGRectZero;
        _cellHeight = CGRectGetMaxY(_goodFrame) + mainSpacing;
    }

    //评论
    if (studyCircleModel.comments.count > 0) {
        
        self.commentsF = [NSMutableArray array];
        
        CGFloat replyLabelX = mainSpacing15;
        
        for (int i = 0; i < [studyCircleModel.comments count]; i++) {
            StudyReply *reply = studyCircleModel.comments[i];
            
            //内容
            NSString *content = @"";
            
            //有回复
            if (reply.touserid > 0) {
                content = [NSString stringWithFormat:@"%@ 回复 %@：%@",reply.nickname,reply.tonickname,reply.content];
            }else
            {
                content = [NSString stringWithFormat:@"%@：%@",reply.nickname,reply.content];
            }
            
            //正则表达式
            NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
            NSError *error = nil;
            NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
            
            //通过正则表达式来匹配字符串
            NSArray *resultArray = [re matchesInString:content options:0 range:NSMakeRange(0, content.length)];
            
            //用来存放字典，字典中存储的是图片和图片对应的位置
            NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
            
            for (NSInteger i = 0; i  < [resultArray count]; ++i) {
                NSTextCheckingResult *result = resultArray[i];
                NSRange range =  [result range];
                
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                NSString *subStr = [content substringWithRange:range];
                
                //图片名称
                NSString *imageName = [EmotionTool imageNameWithString:subStr];
                
                NSTextAttachment *textAttach = [[NSTextAttachment alloc] init];
                textAttach.bounds = CGRectMake(0, -2, 14, 14);
                textAttach.image = [UIImage imageNamed:imageName];
                
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttach];
                
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                [imageArray addObject:imageDic];
            }
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
            
            for (NSInteger i = [imageArray count]-1; i >= 0; i--) {
                NSDictionary *dic = imageArray[i];
                NSRange range = [dic[@"range"] rangeValue];
                [attributeString replaceCharactersInRange:range withAttributedString:dic[@"image"]];
            }
            
            reply.replyString = attributeString;
                        
            CGSize replyLabelSize = [attributeString returnAttributedStringRect:attributeString size:CGSizeMake(SCREEN_WIDTH - mainSpacing - mainSpacing15, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]];
            
            CGFloat replyLabelY = _cellHeight;
            CGFloat replyLabelWidth = replyLabelSize.width;
            CGFloat replyLabelHeight = replyLabelSize.height + 5;
            _cellHeight += replyLabelHeight;
            CGRect replyF = CGRectMake(replyLabelX, replyLabelY, replyLabelWidth, replyLabelHeight);
            [self.commentsF addObject:[NSValue valueWithCGRect:replyF]];
        }
        
        //评论的背景
        _cellHeight = CGRectGetMaxY([(NSValue *)[self.commentsF lastObject] CGRectValue]) + mainSpacing * 2;
        
        CGFloat replyBackgroundWidth = SCREEN_WIDTH - mainSpacing - mainSpacing15;
        CGFloat replyBackgroundHeight = self.cellHeight - mainSpacing * 2 - newTimeY;

        //有赞 有评论
        if (studyCircleModel.praise.praiseUsers.count > 0) {

            _commentViewFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_praiseListFrame) + mainSpacing, replyBackgroundWidth, replyBackgroundHeight);
        }else //只有评论
        {
            _commentViewFrame = CGRectMake(mainSpacing15, CGRectGetMaxY(_centerSepaViewFrame) + mainSpacing, replyBackgroundWidth, replyBackgroundHeight);

        }
    }else if(studyCircleModel.praise.praiseUsers.count > 0) //只有赞
    {
        _commentViewFrame = CGRectZero;
        
        _cellHeight = _cellHeight + mainSpacing * 0.5;
        
    }else
    {
        _commentViewFrame = CGRectZero;
    }
    
    //评论数量大于3 显示查看全部
    if (studyCircleModel.comments.count > 3) {
        _lookAllCommentFrame = CGRectMake(0, 0, 100, 20);
    }else
    {
        _lookAllCommentFrame = CGRectZero;
    }

    _cellHeight += mainSpacing;
    _cellSepaViewFrame = CGRectMake(0, _cellHeight - mainSpacing, SCREEN_WIDTH, mainSpacing);

}

-(NSString *)base64DecodeString:(NSString *)string

{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [NSData dataWithBase64EncodedString:string];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (void) reloadData
{
    [self setStudyCircleModel:self.studyCircleModel];
}

- (CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

//  获取PNG图片的大小
- (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

//  获取jpg图片的大小
- (CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

@end
