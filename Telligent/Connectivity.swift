//
//  Connectivity.swift
//  Telligent
//
//  Created by MaLynn on 2017/9/22.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
