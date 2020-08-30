////
////  IbSettings.swift
////  SwiftMoney
////
////  Created by jk on 2020/8/30.
////  Copyright © 2020 ssl. All rights reserved.
////
//
//import Foundation
//
///// This is only a demo for @ObservedObject. @State is better for this purpose.
//class IbSettings: ObservableObject {
//    @Published var ibConfig = IbConfig() //(autoConnect: true)
//    
//    var paper: Bool {
//        get {
//            ibConfig.paper
//        }
//        set {
//            ibConfig.paper = newValue
//        }
//
//    }
//    var workstation: Bool {
//        get {
//            ibConfig.workstation
//        }
//        set {
//            ibConfig.workstation = newValue
//        }
//        
//    }
//    var connect: Bool {
//        get {
//            ibConfig.connect
//        }
//        set {
//            ibConfig.connect = newValue
//        }
//        
//    }
//    
//    var symbolA: String {
//        get {
//            ibConfig.symbolA
//        }
//        set {
//            ibConfig.symbolA = newValue
//        }
//        
//    }
//    var symbolB: String {
//        get {
//            ibConfig.symbolB
//        }
//        set {
//            ibConfig.symbolB = newValue
//        }
//        
//    }
//    var percentage: Double {
//        get {
//            ibConfig.percentage
//        }
//        set {
//            ibConfig.percentage = newValue
//        }
//        
//    }
//    
//}
