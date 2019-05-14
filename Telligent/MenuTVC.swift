//
//  MenuTVC.swift
//  Telligent
//
//  Created by MaLynn on 2017/8/28.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
import Alamofire

class MenuTVC: UITableViewController {
    
    //    var TableArray = Array<String;:Any> = Array<String:Any>()
    
    var TableArray = [[String:Any]]()
    
    override func viewDidLoad() {
        let logout : Dictionary<String, Any> = ["title": "登出", "id": "logout", "image": "ico_logout"]
        TableArray = [logout]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath)
        
        let  ideentifier : NSDictionary =  TableArray[indexPath.row] as NSDictionary
        
        print(ideentifier)
        
        print(ideentifier.object(forKey: "id") as! String)
        
        let cell = tableView.dequeueReusableCell(withIdentifier:ideentifier.object(forKey: "id") as! String, for: indexPath)
        
        
        cell.textLabel?.text = ideentifier.object(forKey: "title") as? String
        cell.imageView?.image = UIImage(named: (ideentifier.object(forKey: "image") as? String)!)//ideentifier.object(forKey: "image") as? String
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        if selectedCell?.textLabel?.text == "登出"{
            let result = UserDefaults.standard.object(forKey: "result") as! NSDictionary
            
            let parameters: [String : Any] = result.object(forKey: "data") as! [String : Any]
            
            print("logout:",parameters)
            
            let loginNow : NSDictionary = UserDefaults.standard.object(forKey:"loginNow") as! NSDictionary
            
            let loginAccountID : String = loginNow.object(forKey: "strCompanyAccountID") as! String
            
            print("loginNow:",loginAccountID)
            
            var currentUrl : String = ""
            
            //1 SCRMQA
            if loginAccountID == "SCRMQA" {
                currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-QA/APPAPi/MDAuthAPi/Logout"
            }
            //2 SCRMQAP2
            if loginAccountID == "SCRMQAP2" {
                currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-QA-P2/APPAPi/MDAuthAPi/Logout"
            }
            //3 ASOUAT
            if loginAccountID == "ASOUAT" {
                currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-ASO-QA/APPAPi/MDAuthAPi/Logout"
            }
            //4 寬庭美學UAT
            if loginAccountID == "寬庭美學UAT" {
                currentUrl = "https://teola.3rdchannel.com.tw/SocialChat-Kuans-QA/APPAPi/MDAuthAPi/Logout"
            }
            //5 ASO
            if loginAccountID == "ASO" {
                currentUrl = "https://telligent-aso.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //6 寬庭美學
            if loginAccountID == "寬庭美學" {
                currentUrl = "https://telligent-kuans.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //7 KSPACE
            if loginAccountID == "KSPACE" {
                currentUrl = "https://telligent-kspace.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //8 LIFE8
            if loginAccountID == "LIFE8" {
                currentUrl = "https://telligent-life8.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //9 ABBOTT
            if loginAccountID == "ABBOTT_AND" {
                currentUrl = "https://telligent-abbott.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //10 PM
            if loginAccountID == "PMUAT" {
                currentUrl = "https://telligent-pm.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //11 PMDemo
            if loginAccountID == "PMDEMO" {
                currentUrl = "https://telligent-pmdemo.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //12 MJN
            if loginAccountID == "MJN" {
                currentUrl = "https://telligent-MJN.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //13 Simulation
            if loginAccountID == "SIMULATION" {
                currentUrl = "https://teola.3rdchannel.com.tw/Telligent-Simulation/APPAPi/MDAuthAPi/Logout"
            }
            //14 bbtugg
            if loginAccountID == "BBTUGG" {
                currentUrl = "https://telligent-bbtugg.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //15 bbtmos
            if loginAccountID == "BBTMOS" {
                currentUrl = "https://telligent-bbtmos.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //16 JP
            if loginAccountID == "JP手工定制" {
                currentUrl = "https://telligent-jp.digitalcenter.cn/APPAPi/MDAuthAPi/Logout"
            }
            //17 寬庭美學CN
            if loginAccountID == "宽庭美学" {
                currentUrl = "https://telligent-kuans.digitalcenter.cn/APPAPi/MDAuthAPi/Logout"
            }
            //18 SIT
            if loginAccountID == "SIT" {
                currentUrl = "https://teola.3rdchannel.com.tw/Telligent-SIT/APPAPi/MDAuthAPi/Logout"
            }
            //19 京華鑽石
            if loginAccountID == "EMPEROR.DIAMOND" {
                currentUrl = "https://telligent-emperordiamond.3rdchannel.com.tw/APPAPi/MDAuthAPi/Logout"
            }
            //20 PXG
            if loginAccountID == "PXG_GOLF" {
                currentUrl = "https://telligent-pxg.digitalcenter.cn/APPAPi/MDAuthAPi/Logout"
            }
            //21 PMDemoCN
            if loginAccountID == "PMDEMOCN" {
                currentUrl = "https://telligent-pmdemo.digitalcenter.cn/APPAPi/MDAuthAPi/Logout"
            }
            //22 FCC
            if loginAccountID == "FCCGROUP" {
                currentUrl = "https://telligent-fccgroup.digitalcenter.cn/APPAPi/MDAuthAPi/Logout"
            }
            
            print(currentUrl)
            
            Alamofire.request(currentUrl,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default).responseJSON { response in
                                
                                //to get status code
                                //                                if let status = response.response?.statusCode {
                                //                                    switch(status){
                                //                                    case 200:
                                //                                        print("example success")
                                
                                UIApplication.shared.applicationIconBadgeNumber = 0
                                
                                UserDefaults.standard.removeObject(forKey: "result")
                                UserDefaults.standard.removeObject(forKey: "loginNow")
                                UserDefaults.standard.set("applogin", forKey: "loginState")
                                UserDefaults.standard.synchronize()
                                
                                
                                //                                    default:
                                //                                        print("error with response status: \(status)")
                                //
                                self.navigationController?.popToRootViewController(animated: true)
                                //
                                //                                    }
                                //                                }
            }
            
        }
        
        
    }
    
    
    /*
     override func viewDidLoad() {
     super.viewDidLoad()
     
     // Uncomment the following line to preserve selection between presentations
     // self.clearsSelectionOnViewWillAppear = false
     
     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     // self.navigationItem.rightBarButtonItem = self.editButtonItem()
     }
     
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     
     // MARK: - Table view data source
     
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return info[section].count
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }
     */
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
