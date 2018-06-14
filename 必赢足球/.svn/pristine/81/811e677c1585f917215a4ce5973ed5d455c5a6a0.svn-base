

#import "UILabel+sunny.h"

@implementation UILabel (sunny)

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (int) fontsize
                       text: (NSString*) text {

    UILabel* label = [[UILabel alloc] initWithFrame: frame];

    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];

    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {

    UILabel* label = [[UILabel alloc] initWithFrame: frame];

    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];

    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {

    UILabel* label = [[UILabel alloc] initWithFrame: frame];

    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: fontsize];

    return label;
}

/*
 * 设置 文本中 一段文字的大小
 * allString 整体文本
 * subString 不同大小的 部分文字
 * font 字体大小
 */
- (void) setAttributedTextFont : (NSString *) allString subString : (NSString *) subString font : (UIFont *) font
{
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:allString];
    [titleString addAttribute:NSFontAttributeName value:font range:[allString rangeOfString:subString]];
    self.attributedText = titleString;
}

/*
 * 设置 文本中 一段文字的颜色
 * allString 整体文本
 * subString 不同大小的 部分文字
 * color 颜色
 */
- (void) setAttributedTextColor : (NSString *) allString subString : (NSString *) subString color : (UIColor *) color
{
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:allString];
    [titleString addAttribute:NSForegroundColorAttributeName value:color range:[allString rangeOfString:subString]];
    self.attributedText = titleString;
}

/*
 * 添加下划线
 */
- (void) addUnderline
{
    //添加下划线
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    self.attributedText = content;
}

/**
 *  改变字间距
 */
- (void)changeWordSpaceForLabelWithSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end
