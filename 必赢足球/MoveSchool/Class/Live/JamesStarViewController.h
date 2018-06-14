


#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

#import "SVProgressHUD.h"

@interface JamesStarViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>{
    
    CGFloat linShiHeight;
    
}
@property(nonatomic,strong) WKWebView * webView;

@end
