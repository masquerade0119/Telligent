//
//  MenuVC.swift
//  Telligent
//
//  Created by MaLynn on 2017/8/20.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MenuVC: SlideMenuController {
    
     
    
    override func awakeFromNib() {
        if let mainController = self.storyboard?.instantiateViewController(withIdentifier: "Main") {
            self.mainViewController = mainController
        }
        if let lefController = self.storyboard?.instantiateViewController(withIdentifier: "Left") {
            self.leftViewController = lefController
        }
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showVerification(noti:)), name:  Notification.Name(rawValue: "PCLoginVerification"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginState(noti:)), name:  Notification.Name(rawValue: "PCLoginMsg"), object: nil)
        
        
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

    @objc fileprivate func showVerification(noti : Notification) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "verificationVC") as! VerificationVC
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @objc fileprivate func showLoginState(noti : Notification) {
        
        UserDefaults.standard.removeObject(forKey: "result")
        UserDefaults.standard.removeObject(forKey: "loginNow")
        UserDefaults.standard.set("applogin", forKey: "loginState")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
