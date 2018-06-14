#import "JamesStarViewController.h"



@interface JamesStarViewController ()

@end

@implementation JamesStarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // *** 初始化网页视图
    [self _InitFavoriteView];
    
    
    if (@available(iOS 11.0, *)) {
        if (JudgeIsIphoneX) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }else{
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}



// *** 初始化网页视图
- (void)_InitFavoriteView{
  
    // *** 进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // *** 实例化对象
    configuration.userContentController = [WKUserContentController new];
    // *** 调用JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"openSafariToWebWithUrl"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 20.0;// Road Fight.webarchive
    configuration.preferences = preferences;
    
    // *** 网页
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, YLScreenW, YLScreenH) configuration:configuration];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    // *** 加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:HomeUrl]];
    [self.webView loadRequest:request];
    
    
    if (JudgeIsIphoneX) {
       
        linShiHeight = 44;
        
        self.webView.frame = CGRectMake(0, linShiHeight, YLScreenW, YLScreenH - linShiHeight);
    
    }else{
        
        linShiHeight = 20;
        
        self.webView.frame = CGRectMake(0, linShiHeight, YLScreenW, YLScreenH - linShiHeight);
        
    }
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"openSafariToWebWithUrl"]) {
        // *** 打开URL
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message.body]];
    }
}


#pragma mark - WKWebView delegate
// *** 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    static BOOL firstLoading = YES;
    
    if (firstLoading == YES) {
        
        [SVProgressHUD show];
        
    }
    firstLoading = NO;
    
}
// ***  当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// *** 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [SVProgressHUD dismiss];
    
}
// *** 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
    [self performSelector:@selector(reloadWebViewWithUrlStr:) withObject:webView.URL.absoluteString afterDelay:1];
}

- (void)reloadWebViewWithUrlStr:(NSString*)urlStr{
    
    // *** 加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
   
    [self.webView loadRequest:request];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURL *requestURL = [navigationAction.request URL];
    if (([[requestURL scheme] isEqualToString:@"http"]||[[requestURL scheme] isEqualToString:@"https"]||[[requestURL scheme] isEqualToString: @"mailto"])
        && (navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked)){
        
        // *** 跳转
        [[UIApplication sharedApplication] openURL:requestURL];
        
        // 在发送请求之前，决定是否跳转
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else{
        
        // 在发送请求之前，决定是否跳转
        decisionHandler(WKNavigationActionPolicyAllow);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
