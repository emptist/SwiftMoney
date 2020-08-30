//
//  SimplestView.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI



struct SimplestView: View {
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


struct SimplestView_Previews: PreviewProvider {
    static var previews: some View {
        SimplestView()
    }
}
