//
//  IbConfig.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

struct IbConfig {
    var paper = true
    var workstation = true
    var connect = false
    
    var symbolA = ""
    var symbolB = ""
    var percentage = 50.0
    
    var port: UInt32 {
        if workstation {
            if paper {
                return 7497
            } else {
                return 7496
            }
        } else {
            if paper {
                return 4002
            } else {
                return 4001
            }
        }
    }
}

extension IbConfig {
    //var connected = false
    init(autoConnect: Bool){
        if autoConnect {
            // add connecting code here
            print("connected to workstation \(self.workstation) paper \(self.paper)")
            connect = true
        }
    }
}


