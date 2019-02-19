//
//  ViewController.swift
//  Telligent
//
//  Created by MaLynn on 2017/7/18.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

import Foundation



class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //    var internetReachability:Reachability!; //網路狀態監控
    
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: phoneTextField.frame.size.height - width, width:  phoneTextField.frame.size.width, height: phoneTextField.frame.size.height)
        border.borderWidth = width
        phoneTextField.layer.addSublayer(border)
        phoneTextField.layer.masksToBounds = true
        
        let companyIV = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        companyIV.image = UIImage(named: "login_ico_company")
        phoneTextField.leftView = companyIV
        
        phoneTextField.leftViewMode = UITextFieldViewMode.always
        phoneTextField.attributedPlaceholder = NSAttributedString(string: phoneTextField.placeholder!, attributes:[NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.3)])
        phoneTextField.delegate = self
        
        let border2 = CALayer()
        let width2 = CGFloat(1.0)
        border2.borderColor = UIColor.white.cgColor
        border2.frame = CGRect(x: 0, y: accountTextField.frame.size.height - width2, width:  accountTextField.frame.size.width, height: accountTextField.frame.size.height)
        border2.borderWidth = width2
        accountTextField.layer.addSublayer(border2)
        accountTextField.layer.masksToBounds = true
        
        let accountIV = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        accountIV.image = UIImage(named: "login_ico_people")
        accountTextField.leftView = accountIV
        
        accountTextField.leftViewMode = UITextFieldViewMode.always
        accountTextField.attributedPlaceholder = NSAttributedString(string: accountTextField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.3)])
        accountTextField.delegate = self
        
        
        let border3 = CALayer()
        let width3 = CGFloat(1.0)
        border3.borderColor = UIColor.white.cgColor
        border3.frame = CGRect(x: 0, y: accountTextField.frame.size.height - width3, width:  accountTextField.frame.size.width, height: accountTextField.frame.size.height)
        border3.borderWidth = width3
        passwordTextField.layer.addSublayer(border3)
        passwordTextField.layer.masksToBounds = true
        
        let passwordIV = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        passwordIV.image = UIImage(named: "login_ico_key")
        passwordTextField.leftView = passwordIV
        passwordTextField.leftViewMode = UITextFieldViewMode.always
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.3)])
        passwordTextField.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            
            if (UserDefaults.standard.object(forKey: "loginState") as! String) == "autologin" {
                self.checkLoginState()
            }
        }
        else{
            
            UIAlertView(title: "網路狀態", message: "未連接至網路，無法顯示網頁，請檢查您的裝置是否連上網路或wifi", delegate: nil, cancelButtonTitle: "OK").show();
            
        }
        //        //在通知中心註冊事件,當網路狀態有變動的時候會觸發
        //        NotificationCenter.default.addObserver(forName: NSNotification.Name.reachabilityChanged, object: nil, queue: OperationQueue.main) { (NSNotification) -> Void in
        //            let networksStatus: NetworkStatus = self.internetReachability.currentReachabilityStatus()
        //            var status: String!
        //
        //
        //
        //            if networksStatus.rawValue == 0 {
        //                status = "Disconnection"
        //
        //            } else if networksStatus.rawValue == 1 {
        //                status = "Connection"
        //
        //                if (UserDefaults.standard.object(forKey: "loginState") as! String) == "autologin" {
        //                    self.checkLoginState()
        //                }
        //            } else {
        //                status = "Connection"
        //            }
        //            UIAlertView(title: "網路狀態", message: status, delegate: nil, cancelButtonTitle: "OK").show();
        //        }
        //
        //        self.internetReachability = Reachability.forInternetConnection();
        //        //開始監控狀況
        //        self.internetReachability.startNotifier()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        /*
         let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as! MenuVC
         
         self.navigationController?.pushViewController(secondViewController, animated: true)
         */
        if Connectivity.isConnectedToInternet() {
            var warning = "";
            
            if (accountTextField.text?.isEmpty)!{
                warning = warning + "\n" + "帳號不能為空值";
            }
            
            if phoneTextField.text == ""{
                warning = warning + "\n" + "公司名稱不能為空值";
            }
            
            if passwordTextField.text == ""{
                warning = warning + "\n" + "密碼不能為空值";
            }
            
            if warning.characters.count > 0 {
                let alertController = UIAlertController(title : "提示",
                                                        message : warning,
                                                        preferredStyle : UIAlertControllerStyle.alert)
                
                let alertAction = UIAlertAction(title : "OK",
                                                style : UIAlertActionStyle.default,
                                                handler : nil )
                
                alertController.addAction(alertAction)
                
                self.present(alertController,
                             animated : true,
                             completion : nil)
            }
            else{
                
                self.checkLoginState()
            }
        }
        else{
            
            UIAlertView(title: "網路狀態", message: "未連接至網路，無法顯示網頁，請檢查您的裝置是否連上網路或wifi", delegate: nil, cancelButtonTitle: "OK").show();
            
        }
    }
    
    @IBAction func forgetPW(_ sender: UIButton) {
        
        
        
    }
    
    func checkLoginState() {
        
        var parameters: [String : Any]
        
        if (UserDefaults.standard.object(forKey: "loginState") as! String) == "autologin" {
            parameters = UserDefaults.standard.object(forKey: "loginNow") as! [String : Any]
        }
        else{
            
            var companyName : String = phoneTextField.text!
            
            companyName = companyName.uppercased()
            
            companyName = companyName.replacingOccurrences(of: " ", with: "")
            
            print("companyName",companyName)
            
            print ("token",UserDefaults.standard.string(forKey: "pushToken")!)
            
            parameters = [
                "LoginType":"applogin",
                "strDeviceID": UserDefaults.standard.string(forKey: "pushToken")!,
                "strDeviceType":"iOS",
                "strLoginID":accountTextField.text!,
                "strCompanyAccountID":companyName,//去掉空格，全轉小寫比較字串
                "strPassword":passwordTextField.text!
            ]
        }
        
        
        var currentUrl : String = ""
        //1 SCRMQA
        if (parameters["strCompanyAccountID"] as! String) == "SCRMQA" {
            currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-QA/APPAPi/MDAuthAPi/LoginCheck"
        }
        //2 SCRMQAP2
        if (parameters["strCompanyAccountID"] as! String) == "SCRMQAP2" {
            currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-QA-P2/APPAPi/MDAuthAPi/LoginCheck"
        }
        //3 ASOUAT
        if (parameters["strCompanyAccountID"] as! String) == "ASOUAT" {
            currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-ASO-QA/APPAPi/MDAuthAPi/LoginCheck"
        }
        //4 寬庭美學UAT
        if (parameters["strCompanyAccountID"] as! String) == "寬庭美學UAT" {
            currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-Kuans-QA/APPAPi/MDAuthAPi/LoginCheck"
        }
        //5 ASO
        if (parameters["strCompanyAccountID"] as! String) == "ASO" {
            currentUrl = "https://telligent-aso.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //6 寬庭美學
        if (parameters["strCompanyAccountID"] as! String) == "寬庭美學" {
            currentUrl = "https://telligent-kuans.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //7 KSPACE
        if (parameters["strCompanyAccountID"] as! String) == "KSPACE" {
            currentUrl = "https://telligent-kspace.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //8 LIFE8
        if (parameters["strCompanyAccountID"] as! String) == "LIFE8" {
            currentUrl = "https://telligent-life8.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //9 ABBOTT
        if (parameters["strCompanyAccountID"] as! String) == "ABBOTT_AND" {
            currentUrl = "https://telligent-abbott.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //10 PM
        if (parameters["strCompanyAccountID"] as! String) == "PMUAT" {
            currentUrl = "https://telligent-pm.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //11 PMDemo
        if (parameters["strCompanyAccountID"] as! String) == "PMDEMO" {
            currentUrl = "https://teola.3rdchannel.com.tw/Telligent-Demo/APPAPi/MDAuthAPi/LoginCheck"
        }
        //12 MJN
        if (parameters["strCompanyAccountID"] as! String) == "MJN" {
            currentUrl = "https://telligent-MJN.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //13 Simulation
        if (parameters["strCompanyAccountID"] as! String) == "SIMULATION" {
            currentUrl = "https://teola.3rdchannel.com.tw/Telligent-Simulation/APPAPi/MDAuthAPi/LoginCheck"
        }
        //14 bbtugg
        if (parameters["strCompanyAccountID"] as! String) == "BBTUGG" {
            currentUrl = "https://telligent-bbtugg.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        //15 bbtmos
        if (parameters["strCompanyAccountID"] as! String) == "BBTMOS" {
            currentUrl = "https://telligent-bbtmos.3rdchannel.com.tw/APPAPi/MDAuthAPi/LoginCheck"
        }
        print(currentUrl)
        
        if currentUrl.isEmpty{
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "登入失敗，請檢查您的公司帳號密碼是否輸入正確。"
            //背景渐变效果
            hud.dimBackground = true
            
            //延迟隐藏
            //            hud.hide(true, afterDelay: 0.8)
            hud.hide(animated: true, afterDelay: 0.8)
        }
        else{
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "登入中"
            //背景渐变效果
            hud.dimBackground = true
            
            
            Alamofire.request(currentUrl,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default).responseJSON { response in
                                
                                
                                print(response)
                                
                                
                                //to get status code
                                if let status = response.response?.statusCode {
                                    switch(status){
                                    case 200:
                                        print("example success")
                                        
                                        //to get JSON return value
                                        if let result = response.result.value {
                                            let JSON = result as! NSDictionary
                                            
                                            print(JSON)
                                            
                                            let status : String = JSON.object(forKey: "status") as! String
                                            
                                            if status == "SUCCESS"{
                                                
                                                UIApplication.shared.applicationIconBadgeNumber = JSON.value(forKey:"NotReadNum") as! Int
                                                
                                                
                                                UserDefaults.standard.set(JSON, forKey: "result")
                                                UserDefaults.standard.set(parameters, forKey: "loginNow")
                                                UserDefaults.standard.set("autologin", forKey: "loginState")
                                                UserDefaults.standard.synchronize()
                                                
                                                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as! MenuVC
                                                hud.hide(animated: true, afterDelay: 0.8)
                                                
                                                self.phoneTextField.text = ""
                                                self.accountTextField.text = ""
                                                self.passwordTextField.text = ""
                                                
                                                
                                                self.navigationController?.pushViewController(secondViewController, animated: true)
                                            }
                                            else{
                                                
                                                hud.hide(animated: true)
                                                
                                                
                                                let alertController = UIAlertController(title : "提示",
                                                                                        message : JSON.object(forKey: "statusMsg") as? String,
                                                                                        preferredStyle : UIAlertControllerStyle.alert)
                                                
                                                let alertAction = UIAlertAction(title : "OK",
                                                                                style : UIAlertActionStyle.default,
                                                                                handler : nil )
                                                
                                                alertController.addAction(alertAction)
                                                
                                                UserDefaults.standard.removeObject(forKey: "result")
                                                UserDefaults.standard.removeObject(forKey: "loginNow")
                                                UserDefaults.standard.set("applogin", forKey: "loginState")
                                                UserDefaults.standard.synchronize()
                                                
                                                self.present(alertController,
                                                             animated : true,
                                                             completion : nil)
                                            }
                                            
                                        }
                                        
                                    default:
                                        
                                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                                        hud.label.text = "登入失敗，請檢查您的公司帳號密碼是否輸入正確"
                                        //背景渐变效果
                                        hud.dimBackground = true
                                        
                                        //延迟隐藏
                                        hud.hide(animated: true, afterDelay: 0.8)
                                        
                                        print("error with response status: \(status)")
                                    }
                                }
            }
            
        }
    }
}

