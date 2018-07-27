 import UIKit
 import WebKit

 
 class MainMkVC : UIViewController,WKNavigationDelegate,WKUIDelegate {
    var webView : WKWebView!
    @IBOutlet weak var navBar: UINavigationBar!
    var progressView : UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //登出button
        let leftBtn = UIBarButtonItem(image: UIImage(named: "ico_menu"), style: UIBarButtonItemStyle.plain, target: self, action: Selector("openLeftButton:"))
        
        //載入網頁
        let result = UserDefaults.standard.dictionary(forKey: "result")! as NSDictionary
        let url = NSURL (string: result.object(forKey: "APPRedirect") as! String)
        let request = URLRequest(url: url! as URL)
        
        webView = WKWebView(frame: CGRect(x: 0, y: 66, width: self.view.bounds.size.width, height: self.view.bounds.size.height-66))
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                webView = WKWebView(frame: CGRect(x: 0, y: 86, width: self.view.bounds.size.width, height: self.view.bounds.size.height-86))
            default:
                print("unknown")
            }
        }
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(request)
        self.view.addSubview(webView)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        progressView.tintColor = UIColor.init(red: 0.66, green: 0.58, blue: 0.31, alpha: 1.0)
        // Set frame to exact below of navigation bar if available
        progressView.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 2)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                progressView.frame = CGRect(x: 0, y: 84, width: self.view.bounds.size.width, height: 2)
            default:
                print("unknown")
            }
        }
        self.view.addSubview(progressView)
        
        webView.addObserver(self, forKeyPath:
            #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }}
    
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url{
                if (String(describing: url).lowercased().contains("uploadfiles")||String(describing: url).lowercased().contains("productpreview")) {
                    //開啟 safari
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
                else{
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
    
    @IBAction func openLeftButton(_ sender: UIBarButtonItem) {
        self.openLeft()
    }
 }
