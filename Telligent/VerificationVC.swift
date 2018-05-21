//
//  VerificationVC.swift
//  Telligent
//
//  Created by MaLynn on 2017/8/21.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class VerificationVC: UIViewController {
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var checkNumberLab: UILabel!
    @IBOutlet weak var timeCountLab: UILabel!
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var tipErrorLab: UILabel!
    
    var timer:Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let result = UserDefaults.standard.dictionary(forKey: "result")! as NSDictionary
        
        let getData = result.object(forKey: "data")! as! NSDictionary
        
        let url = URL(string: getData.object(forKey: "strHeadImgUrl")! as! String)
//        let data = Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        
//        print("image url",url)
        
//       userIV.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        
        
        //Any
        let objectValue : NSDictionary = (UserDefaults.standard.object(forKey: "apsInfo") as? NSDictionary)!
        
        print("objectValue",objectValue)
        
        
        let dataInfo : NSDictionary = objectValue["data"] as! NSDictionary
        let apsInfo : NSDictionary = objectValue["aps"] as! NSDictionary
        
        print("apsInfo",apsInfo)
        
        let alertInfo : NSDictionary = apsInfo["alert"] as! NSDictionary
        
        print("alertInfo",alertInfo)
        
        tipErrorLab.isHidden = true
        
        tipLab.isHidden = false
        checkNumberLab.isHidden = false
        timeCountLab.isHidden = false
        
//        userIV.image = UIImage(data:data)
        
//        userIV.image = self.maskRoundedImage(image: UIImage(data: data!)!, radius: (userIV.image?.size.height)!/2)
//        userIV.layer.cornerRadius = (userIV.image?.size.height)!/2
//        userIV.clipsToBounds = true
        
//        let url = URL(string: image.url)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            DispatchQueue.main.async {
                
                if data == nil {
                    self.userIV.image  = #imageLiteral(resourceName: "login_ico_people")
                }
                else{
                    
                    self.userIV.image = UIImage(data: data!)
                }
                
                self.userIV.image = self.maskRoundedImage(image: self.userIV.image!, radius: (self.userIV.image?.size.height)!/2)
                self.userIV.layer.cornerRadius = (self.userIV.image?.size.height)!/2
                self.userIV.clipsToBounds = true
            }
        }
        
        
        
        checkNumberLab.text = dataInfo.object(forKey: "strCode") as? String
        checkNumberLab.layer.borderWidth = 1.0
        checkNumberLab.layer.borderColor = UIColor.white.cgColor
        
        
//        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
//        
//        print(Date())
//        
//        let dtmExpiryDate : String = dataInfo.object(forKey: "dtmExpiryDate") as! String
//        
//        self.backCount(dtmExpiryDate: dtmExpiryDate)
//        
//        let additionalTime: DispatchTimeInterval = .seconds(1)
//        
//        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
////            print(Date())
//            
//            self.backCount(dtmExpiryDate: dtmExpiryDate)
//            
//        }
        
        // 启用计时器，控制每秒执行一次tickDown方法
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(VerificationVC.backCount), userInfo: nil, repeats: false)
//        timer = Timer.scheduledTimerWithTimeInterval(1,
//                                                     target:self,selector:Selector("backCount"),
//                                                     userInfo:nil,repeats:true)

        
//        let now = NSDate()
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        
//        let string = formatter.string(from: now as Date)
//        
//        print("kltjweoijflkd : ",string)

        tipLab.numberOfLines = 0
        tipLab.adjustsFontSizeToFitWidth = true
        tipLab.textAlignment = .center
//        tipLab.text = (dataInfo.object(forKey: "Title")as? String)! + "\n" + (dataInfo.object(forKey: "Body")as? String)!
        tipLab.text = "請到電腦上輸入此驗證碼並按確認送出，以確保是您本人的操作"
        
        
        tipErrorLab.numberOfLines = 0
        tipErrorLab.adjustsFontSizeToFitWidth = true
        tipErrorLab.textAlignment = .center
        tipErrorLab.text = "目前尚無驗證碼，請到電腦上登錄帳號密碼並按確認送出，再到此處領取驗證碼，以確保是您本人的操作"
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginActivity(noti:)), name:  Notification.Name(rawValue: "PCLoginMsg"), object: nil)
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
    
    func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
    func backCount()  {
       
        //Any
        let objectValue : NSDictionary? = UserDefaults.standard.object(forKey: "apsInfo") as? NSDictionary
        
        let dataInfo : NSDictionary = objectValue!["data"] as! NSDictionary
        let dtmExpiryDate : String = dataInfo.object(forKey: "dtmExpiryDate") as! String
        
        //let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss", options: 0, locale: NSLocale.current)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 28800)
        
        let datedtmExpiryDate : Date = dateFormatter.date(from: dtmExpiryDate)!
        //以上為了處理傳進字串沒帶時區,寫死時區為+8
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dtmExpiryDateString = dateFormatter.string(from: datedtmExpiryDate)
        
        let date1 = NSDate()
        let date2 : Date = dateFormatter.date(from: dtmExpiryDateString)!
        
        print("date1 : ",date1)
        print("date2 : ",date2)
        
        if date1.compare(date2 as Date) == ComparisonResult.orderedAscending {
            print("date1 is earlier")
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(VerificationVC.backCount), userInfo: nil, repeats: false)
            
            //full
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.unitsStyle = .short
            
            let interval = date2.timeIntervalSince(date1 as Date)
            dateComponentsFormatter.string(from: interval)
            
            
            
            dateComponentsFormatter.allowedUnits = [.minute,.second]
            let autoFormattedDifference = dateComponentsFormatter.string(from: date1 as Date, to: date2 as Date)
            
            
            self.timeCountLab.text = "剩餘時間：  " + autoFormattedDifference!
            
            tipErrorLab.isHidden = true
            
            tipLab.isHidden = false
            checkNumberLab.isHidden = false
            timeCountLab.isHidden = false
            
        } else{
            print("Same date!!!")
            
            print("Time Out")
            
            timer.invalidate()
            
            tipErrorLab.isHidden = false
            
            tipLab.isHidden = true
            checkNumberLab.isHidden = true
            timeCountLab.isHidden = true
        }
    
    }
    
    @IBAction func logOut(_ sender: UIButton) {
//       self.dismissViewControllerAnimated(false, completion: nil)
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func showLoginActivity(noti : Notification) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }

}
