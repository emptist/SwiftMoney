//
//  SimplestView.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct ConnectView: View {
    @ObservedObject var ib: IbAPI
    @Binding var ibConfig: IbConfig
    
    
    
    var body: some View {
        Button(action: {
            self.ib.rebalance(ibConfig: self.ibConfig)
        }) {
            Text("Go")
        }
        .disabled(!self.ibConfig.connect)
    }
}

struct SimplestView: View {
    @State private var ibConfig = IbConfig() //(autoConnect: false)
    //@ObservedObject private var ibConfig = IbSettings()
    
    
    
    var body: some View {
        HStack {
            HStack {
                Toggle(isOn: $ibConfig.connect) {
                    Text("On")
                }
                .toggleStyle(SwitchToggleStyle())
            }
            
            Toggle(isOn: $ibConfig.workstation) {
                Text("W/S") //(ibConfig.workstation ? "W/S" : "G/W")
            }
            //            Spacer()
            Toggle(isOn: $ibConfig.paper) {
                Text("Paper") //(ibConfig.paper ? "Paper" : "Live")
            }
            
            Spacer()
            
            HStack {
                TextField("Stock Symbol", text: $ibConfig.symbolA)
                
                //Spacer()
                
                Slider(value: $ibConfig.percentage,in: 10.0...90.0, step:10.0, onEditingChanged: { ratio in
                    print(self.ibConfig.percentage, ratio)
                }, minimumValueLabel: Text("\(Int(ibConfig.percentage))"), maximumValueLabel: Text("\(Int(100.0 - ibConfig.percentage))"), label: {Text("")})
                TextField("Stock Symbol", text: $ibConfig.symbolB)
                
                //                Button(action: {
                //                    self.rebalance()
                //                }) {
                //                    Text("Go")
                //                }
                //                .disabled(!self.ibConfig.connect)
            }
            ConnectView(ib: IbAPI(ibConfig: self.ibConfig), ibConfig: $ibConfig)
        }
    }
}


struct SimplestView_Previews: PreviewProvider {
    static var previews: some View {
        SimplestView()
    }
}
