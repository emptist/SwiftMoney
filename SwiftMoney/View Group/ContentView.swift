//
//  ContentView.swift
//  hedging
//
//  Created by 陈梦兵 on 2020/8/29.
//  Copyright © 2020 melissa. All rights reserved.
//

import SwiftUI

struct IbConfig {
    var paper = true
    var workstation = true
    var connect = false
    
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

struct ContentView: View {
    @State private var ibConfig = IbConfig.init(autoConnect: true)
    
    @ObservedObject var ib: IbAPI = IbAPI()
    
    fileprivate func rebalance() {
        if self.ibConfig.connect {
            print("workstation \(self.ibConfig.workstation) paper \(self.ibConfig.paper)")
        }
    }
    
    var body: some View {
        HStack {
            Toggle(isOn: $ibConfig.workstation) {
                Text("workstation")
            }
            //            Spacer()
            Toggle(isOn: $ibConfig.paper) {
                Text("paper")
            }
            Toggle(isOn: $ibConfig.connect) {
                Text("connect")
            }
            .toggleStyle(SwitchToggleStyle())
            Spacer()
            
            Button(action: {
                self.rebalance()
            }) {
                Text("Hedge Now")
            }
             .disabled(!self.ibConfig.connect)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
