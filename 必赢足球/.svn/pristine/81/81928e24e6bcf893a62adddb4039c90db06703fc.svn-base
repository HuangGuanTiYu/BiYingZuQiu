

#import <UIKit/UIKit.h>

@interface UILabel (sunny)

+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (int) fontsize text: (NSString*) text;
+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (int) fontsize fontColor: (UIColor*) color text: (NSString*) text;

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text;

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text;

/*
 * 设置 文本中 一段文字的大小
 * allString 整体文本
 * subString 不同大小的 部分文字
 * font 字体大小
 */
- (void) setAttributedTextFont : (NSString *) allString subString : (NSString *) subString font : (UIFont *) font;

/*
 * 设置 文本中 一段文字的颜色
 * allString 整体文本
 * subString 不同大小的 部分文字
 * color 颜色
 */
- (void) setAttributedTextColor : (NSString *) allString subString : (NSString *) subString color : (UIColor *) color;

/*
 * 添加下划线
 */
- (void) addUnderline;

/**
 *  改变字间距
 */
- (void)changeWordSpaceForLabelWithSpace:(float)space;

@end
