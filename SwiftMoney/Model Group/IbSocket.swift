//
//  IbSocket.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//


import AppKit
import Foundation
import SwiftIB


//struct IbSocket {
//    var connected = false
//    var host: String
//    var port: UInt32
//    var tickers:[String]
//
//    var testData: MarketData {
//      MarketData(host: host, port: port, tickers: tickers)
//    }
//}


struct LoggingWrapper: EWrapper {
    var connected = false
    var outputFiles:[FileHandle] = []

    func tickPrice(_ tickerId: Int, field: Int, price: Double, canAutoExecute: Int) {
        print("tickerId \(tickerId),field \(field),price \(price)")
        
        let f = outputFiles[tickerId]
        let s = "PRICE field \(field) price \(price)\n"
        f.write(s.data(using: String.Encoding.utf8, allowLossyConversion: true)!);f.synchronizeFile()
    }
    
    func tickSize(_ tickerId: Int, field: Int, size: Int) {
        print("tickerId \(tickerId),field \(field),size \(size)")
        
        let f = outputFiles[tickerId]
        let s = "SIZE  \(field) \(size)\n"
        f.write(s.data(using: String.Encoding.utf8, allowLossyConversion: true)!);f.synchronizeFile()
    }
    
    func tickGeneric(_ tickerId: Int, tickType: Int, value: Double) {
        print("tickerId \(tickerId),tickType \(tickType),value \(value)")
        
        let f = outputFiles[tickerId]
        let s = "GENERIC \(tickType) \(value)\n"
        f.write(s.data(using: String.Encoding.utf8, allowLossyConversion: true)!);f.synchronizeFile()
    }
    
    func tickString(_ tickerId: Int, tickType: Int, value: String) {
        let f = outputFiles[tickerId]
        var s = ""
        switch tickType {
            case 45:
                let tickI: Int? = Int(value)
                let tick: Double = tickI != nil ? Double(tickI!) : 0
                s = "STR TS \(LoggingWrapper.timeToStr(Date(timeIntervalSince1970: TimeInterval(tick)), millis:true))\n"
            
            default:
                s = "STR \(tickType) \(value)\n"
        }
        print(s)
        
        f.write(s.data(using: String.Encoding.utf8, allowLossyConversion: true)!);f.synchronizeFile()
    }
    
    func accountDownloadEnd(_ accountName: String){
        print("Account name \(accountName) download end.")
    }
    
    
    
    // error handling
    func error( _ e: NSException) {}
    func error( _ str: String) {
        print("error: \(str)")
    }
    func error( _ id: Int, errorCode: Int, errorMsg:String) {
        print("error: id(\(id)) code(\(errorCode)) msg:\(errorMsg)")
    }
    mutating func connectionClosed() {
        print("!!CONNECTION CLOSE")
        connected = false
    }
    
    static func timeToStr(_ time: Date, millis: Bool) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = millis ? "yyyy-MM-dd HH:mm:ss.SSS zzz" : "yyyy-MM-dd HH:mm:ss zzz"
        return fmt.string(from: time)
    }
}

//struct MarketData {
struct IbSocket {
    var connected = false
    var host: String //= "127.0.0.1"
    var port: UInt32 //= 4002 //7496
    var tickers:[String] //= ["TQQQ"]
    var outputDir: String = FileManager.default.currentDirectoryPath
    let filePrefix = LoggingWrapper.timeToStr(Date(timeIntervalSinceNow: 0), millis:false)
    var outputFiles:[FileHandle] = []

    //    var index = 1
    //    var argValue:[Bool] = [Bool](repeating: false, count: CommandLine.arguments.count)
    //    for arg in CommandLine.arguments[1..<CommandLine.arguments.count] {
    //        switch arg {
    //            case "--host":
    //                if index+1<CommandLine.arguments.count {host = CommandLine.arguments[index+1]}
    //                argValue[index+1] = true
    //            case "--output":
    //                if index+1<CommandLine.arguments.count {outputDir = CommandLine.arguments[index+1]}
    //                argValue[index+1] = true
    //            case "--port":
    //                if index+1<CommandLine.arguments.count {
    //                    if let p = Int(CommandLine.arguments[index+1]) {
    //                        port = UInt32(p)
    //                    }
    //                }
    //                argValue[index+1] = true
    //            default:
    //                if argValue[index] == false {
    //                    tickers.append(arg)
    //            }
    //        }
    //        index += 1
    //    }
    
    //    print("Output dir: \(outputDir)")
    //    print("Symbols to fetch: \(tickers)")
    
    mutating func testConnection() throws {
//        for i in 0 ..< tickers.count {
//            let outf = outputDir.appendingFormat("%@ %@.raw.dump.md", filePrefix, tickers[i]);
//            var file = FileHandle(forWritingAtPath:outf)
//            if file == nil {
//                FileManager.default.createFile(atPath: outf, contents: nil, attributes: nil)
//                file = FileHandle(forWritingAtPath:outf)
//            }
//            if file != nil {
//                outputFiles.append(file!)
//                let s = "SYMBOL \(tickers[i]) \n"
//                print(s)
//
//                //file!.write(s.data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                //file!.synchronizeFile()
//            }
//        }
//        if outputFiles.count != tickers.count {
//            print("Error: cannot correct output files")
//            NSApplication.shared.terminate(nil)
//        }
        
        while true {
            let wrapper = LoggingWrapper()
            let client = EClientSocket(p_eWrapper: wrapper, p_anyWrapper: wrapper)
            print("Host: \(host), Port: \(port) Connecting to IB API...")
            client.eConnect(host, p_port: port)
            connected = true
            for i in 0 ..< tickers.count {
                let con = Contract(p_conId: 0, p_symbol: tickers[i], p_secType: "STK", p_expiry: "", p_strike: 0.0, p_right: "", p_multiplier: "",
                                   p_exchange: "SMART", p_currency: "USD", p_localSymbol: tickers[i], p_tradingClass: "", p_comboLegs: nil, p_primaryExch: "ISLAND",
                                   p_includeExpired: true, p_secIdType: "", p_secId: "")
                // tickerId is strickly 0..<tickers.count
                client.reqMktData(i, contract: con, genericTickList: "", snapshot: false, mktDataOptions: nil)
            }
            while connected { Thread.sleep(forTimeInterval: TimeInterval(3.0)) }
            client.eDisconnect()
            client.close()
        }
        
    }
}
