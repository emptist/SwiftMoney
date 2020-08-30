//
//  IbAPI.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation


class IbAPI: ObservableObject {
    @Published var ibSocket: IbSocket
    
    init(ibConfig: IbConfig) {
        //self.ibConfig = ibConfig
        ibSocket = IbSocket(host: ibConfig.host, port: ibConfig.port, tickers: ibConfig.tickers)
//        if ibConfig.connect {
//            ibSocket.testConnection()
//        }
        
    
    }
    
    func rebalance(ibConfig: IbConfig) {
        if ibConfig.connect && !ibSocket.connected {
            DispatchQueue.global(qos: .userInitiated).async {
                try? self.ibSocket.testConnection()
            }
        }
        
        if ibSocket.connected {
            print("connected")
        }
    }
}
