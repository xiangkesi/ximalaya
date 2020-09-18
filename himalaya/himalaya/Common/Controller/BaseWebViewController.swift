//
//  BaseWebViewController.swift
//  gokarting
//
//  Created by Farben on 2020/7/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class BaseWebViewController: UIViewController {

    private var wkWebView: WKWebView?
    
    
    var urlString: String? {
        didSet {
           
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.xm.xm_230_20_color
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
        initWebView()
        view.addSubview(progressView)
        
        
        wkWebView?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        wkWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        if let str = urlString, let url = URL(string: str) {
            let request = URLRequest(url: url)
            wkWebView?.load(request)
        }
        
    }
    
    @objc func backPop() {
        
        let a = wkWebView?.goBack()
        if a == nil {
            navigationController?.popViewController(animated: true)
        }
//        print(a)
//        if wkWebView?.url?.absoluteString == urlString {
//            navigationController?.popViewController(animated: true)
//        }else {
//
//        }
    }
    
    private var progressView: UIProgressView = {
        let progress_view = UIProgressView()
        progress_view.tintColor = UIColor.red
        progress_view.trackTintColor = UIColor.white
        return progress_view
    }()
    
    private var btnBack: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "XMEmoticon_xmb_back_h"), for: .normal)
        btn.setImage(UIImage(named: "XMEmoticon_xmb_back_h"), for: .selected)
        btn.bounds.size = CGSize(width: 50, height: 30)
        btn.contentHorizontalAlignment = .left
        btn.imageView?.isUserInteractionEnabled = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(backPop), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wkWebView?.frame = view.bounds
        progressView.frame = CGRect(x: 0, y: 0, width: view.xm_width, height: 2)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            navigationItem.title = wkWebView?.title
        }else if keyPath == "estimatedProgress" {
            progressView.progress = Float(wkWebView!.estimatedProgress)
            if wkWebView!.estimatedProgress >= Double(1) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.progressView.progress = 0
                }
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        wkWebView?.configuration.userContentController.removeScriptMessageHandler(forName: "jsToOcNoPrams")
        wkWebView?.configuration.userContentController.removeScriptMessageHandler(forName: "jsToOcWithPrams")
        wkWebView?.removeObserver(self, forKeyPath: "title")
        wkWebView?.removeObserver(self, forKeyPath: "estimatedProgress")

    }
    


}

extension BaseWebViewController: WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    //被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
    //通过接收JS传出消息的name进行捕捉的回调方法
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       
        
        if message.name == "jsToOcNoPrams" {
            let alertController = UIAlertController(title: "js调用到了oc", message: "不带参数", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }else if message.name == "jsToOcWithPrams" {
//             let parameter = message.body as! [String: String]
            var parameter: [String: String]?
            if let paramDic = message.body as? [String: String]  {
                parameter = paramDic
            }
            
            let alertController = UIAlertController(title: "js调用到了oc", message: (parameter != nil) ? (parameter!["params"]): "咋回事呢" , preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                           
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
// MARK: -----------WKNavigationDelegate------------------
    
    /*
    WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
    */
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.setProgress(0, animated: false)
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        getCookie()
        
        ///禁止放大缩小
//        let injectionJSString = """
//        var script = document.createElement('meta');"
//        "script.name = 'viewport';"
//        "script.content=\"width=device-width, user-scalable=no\";"
//        "document.getElementsByTagName('head')[0].appendChild(script);
//        """
//        webView.evaluateJavaScript(injectionJSString, completionHandler: nil)
        
    }
    
    //提交发生错误时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.setProgress(0, animated: false)
    }
    // 接收到服务器跳转请求即服务重定向时之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlStr = navigationAction.request.url?.absoluteString
        print("发送跳转请求: \(urlStr!)")
        let htmlHeadString = "iting://open"
        if urlStr?.hasPrefix(htmlHeadString) == true {
            let topListVc = XMTopListViewController()
            self.navigationController?.pushViewController(topListVc, animated: true)
            decisionHandler(.cancel)
        }else {
            decisionHandler(.allow)
        }
    }
    
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let urlStr = navigationResponse.response.url?.absoluteString
        print("发送跳转地址: \(urlStr!)")
        
        decisionHandler(.allow)
//        decisionHandler(.cancel)

    }
    
    //需要响应身份验证时调用 同样在block中需要传入用户身份凭证
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let newCred = URLCredential(user: "", password: "", persistence: .none)
        challenge.sender?.use(newCred, for: challenge)
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, newCred)
        
    }
    
    //进程被终止时调用
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
// MARK: ------------------------------WKUIDelegate--------------------
    
    /// web界面中有弹出警告框时调用
    /// - Parameters:
    ///   - webView: 实现该代理的webview
    ///   - message: 警告框中的内容
    ///   - frame: <#frame description#>
    ///   - completionHandler: 警告框消失调用
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "HTML的弹出框", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            completionHandler()
        }))
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
            completionHandler(false)
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            completionHandler(true)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: defaultText ?? "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            completionHandler(alertController.textFields![0].text ?? "")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == true {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    @objc func actionBack() {
        
    }
    private func initWebView() {
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionBack))
       
        
        let config = WKWebViewConfiguration()
        let preference = WKPreferences()
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = true
        //在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preference
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = true
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放10之后过期
//        config.requiresUserActionForMediaPlayback = true;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = true
         //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = "gokarting"
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        let weakScriptMessageDelegate = WeakWebViewScriptMessageDelegate.init(script_delegate: self)
        
        //这个类主要用来做native与JavaScript的交互管理
        let wkUController = WKUserContentController()
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        wkUController.add(weakScriptMessageDelegate, name: "jsToOcNoPrams")
        wkUController.add(weakScriptMessageDelegate, name: "jsToOcWithPrams")
        config.userContentController = wkUController
        //以下代码适配文本大小
//        let jSString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
//        let wkUScript = WKUserScript(source: jSString, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
//        config.userContentController.addUserScript(wkUScript)
        
        wkWebView = WKWebView(frame: CGRect.zero, configuration: config)
        // UI代理
        wkWebView?.uiDelegate = self
        //导航代理
        wkWebView?.navigationDelegate = self
        //是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        wkWebView?.allowsBackForwardNavigationGestures = true
        view.addSubview(wkWebView!)
        wkWebView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
       
        
        
        //可返回的页面列表, 存储已打开过的网页
//               WKBackForwardList * backForwardList = [_webView backForwardList];
               
               //        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chinadaily.com.cn"]];
               //        [request addValue:[self readCurrentCookieWithDomain:@"http://www.chinadaily.com.cn"] forHTTPHeaderField:@"Cookie"];
               //        [_webView loadRequest:request];
        
        
        
        
    }
    
 
    
    //解决第一次进入的cookie丢失问题
    private func readCurrentCookieWithDomain(domainStr: String) -> String{
        let cookieJar = HTTPCookieStorage.shared
        
        let cookieString = NSMutableString()
        if let cookies = cookieJar.cookies {
            for cookie in cookies {
                cookieString.appendFormat("%@=%@", cookie.name, cookie.value)
            }
            //删除最后一个“;”
            if cookieString.hasSuffix(";") {
                cookieString.deleteCharacters(in: NSRange(location: cookieString.length - 1, length: 1))
            }
        }
        return cookieString as String
    }
    
    //解决 页面内跳转（a标签等）还是取不到cookie的问题
    private func getCookie() {
        let cookieStorage = HTTPCookieStorage.shared
        let JSFuncString = """
        function setCookie(name,value,expires)\
        {\
        var oDate=new Date();\
        oDate.setDate(oDate.getDate()+expires);\
        document.cookie=name+'='+value+';expires='+oDate+';path=/'\
        }\
        function getCookie(name)\
        {\
        var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
        if(arr != null) return unescape(arr[2]); return null;\
        }\
        function delCookie(name)\
        {\
        var exp = new Date();\
        exp.setTime(exp.getTime() - 1);\
        var cval=getCookie(name);\
        if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
        }
        """
        
        let JSCookieString = NSMutableString(string: JSFuncString)
        if let cookies = cookieStorage.cookies {
            for cookie in cookies {
                let excuteJSString = String(format: "setCookie('%@', '%@', 1);", cookie.name, cookie.value)
                JSCookieString.append(excuteJSString)
            }
        }
        wkWebView?.evaluateJavaScript(JSCookieString as String, completionHandler: nil)
        
        
        
    }
    private func removeCookies() {
        if let setTypes = NSSet(array: [WKWebsiteDataTypeDiskCache,
        WKWebsiteDataTypeMemoryCache,
        WKWebsiteDataTypeOfflineWebApplicationCache,
        WKWebsiteDataTypeCookies,
        WKWebsiteDataTypeSessionStorage,
        WKWebsiteDataTypeLocalStorage,
        WKWebsiteDataTypeWebSQLDatabases,
        WKWebsiteDataTypeIndexedDBDatabases]) as? Set<String> {
            WKWebsiteDataStore.default().removeData(ofTypes: setTypes, modifiedSince: Date()) {
                       print("clear web cache")
            }
        }
        
//        WKWebsiteDataStore.default().
       
        
    }
}

class WeakWebViewScriptMessageDelegate: NSObject {
    
    weak var scriptDelegate: WKScriptMessageHandler?
        
    init(script_delegate: WKScriptMessageHandler) {
        super.init()
        self.scriptDelegate = script_delegate
    }
}
extension WeakWebViewScriptMessageDelegate: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if (self.scriptDelegate?.responds(to: #selector(userContentController(_:didReceive:)))) != nil {
            self.scriptDelegate?.userContentController(userContentController, didReceive: message)
        }
    }
    
   
    
}
