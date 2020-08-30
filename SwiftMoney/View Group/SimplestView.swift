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
                
                Slider(value: $ibConfig.percentage,in: 20.0...80.0, step:5.0, onEditingChanged: { ratio in
                    print(self.ibConfig.percentage, ratio)
                }, minimumValueLabel: Text("\(Int(ibConfig.percentage))"), maximumValueLabel: Text("\(Int(100.0 - ibConfig.percentage))"), label: {Text("")})
                TextField("Stock Symbol", text: $ibConfig.symbolB)
                
                Button(action: {
                    self.rebalance()
                }) {
                    Text("Go")
                }
                .disabled(!self.ibConfig.connect)
            }
        }
    }
}

//private
func onPercentChange(ratio: Float) -> Void {
    print(ratio)
}

struct SimplestView_Previews: PreviewProvider {
    static var previews: some View {
        SimplestView()
    }
}
