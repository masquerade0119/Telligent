//
//  MainVC.swift
//  Telligent
//
//  Created by MaLynn on 2017/8/28.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift

class MainVC: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var showWV: UIWebView!
    @IBOutlet weak var showProgress: UIProgressView!
    @IBOutlet weak var showbar: UINavigationBar!
    //目前網域
    var currenthost:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //A9944F
        
        let leftBtn = UIBarButtonItem(image: UIImage(named: "ico_menu"), style: UIBarButtonItemStyle.plain, target: self, action: Selector("openLeftButton:"))

        let result = UserDefaults.standard.dictionary(forKey: "result")! as NSDictionary
        
        showWV.delegate=self
        
        let url = NSURL (string: result.object(forKey: "APPRedirect") as! String)
        let requestObj = URLRequest(url: url! as URL)
        showWV.loadRequest(requestObj)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func openLeftButton(_ sender: UIBarButtonItem) {
        self.openLeft()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        showProgress.setProgress(0.1, animated: false)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //取得目前網域
        currenthost =  self.showWV.request?.url?.host
        showProgress.setProgress(1.0, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        showProgress.setProgress(1.0, animated: true)
    }
    
    //在webview上點擊a link觸發
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //點擊欲前往的網址
        let url = request.url
        //網域
        let host = url?.host
            if ( navigationType == .linkClicked ) {
                if #available(iOS 10.0, *) {//ios10以上版本
                    //商品預覽頁 圖片資料夾內有uploadfiles的路徑 非目前網域內的網站
                    if !(host?.lowercased()==currenthost.lowercased()) || String(describing: url).lowercased().contains("uploadfiles")||String(describing: url).lowercased().contains("productpreview") {
                        //開啟 safari
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                        return false
                    }
                }
        }
        return true
    }
}
