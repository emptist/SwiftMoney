//
//  Ewrapper+.swift
//  hedging
//
//  Created by 陈梦兵 on 2020/8/30.
//  Copyright © 2020 melissa. All rights reserved.
//

import Foundation
import SwiftIB

/// Provide default functions to avoid repeated implementions
extension EWrapper {
    func tickPrice(_ tickerId: Int, field: Int, price: Double, canAutoExecute: Int) {}
    func tickSize(_ tickerId: Int, field: Int, size: Int) {}
    func tickGeneric(_ tickerId: Int, tickType: Int, value: Double) {}
    func tickString(_ tickerId: Int, tickType: Int, value: String) {}
    func accountDownloadEnd(_ accountName: String){
        print("Account name \(accountName)")
    }
    func tickOptionComputation(_ tickerId: Int, field: Int, impliedVol: Double, delta: Double, optPrice: Double, pvDividend: Double, gamma: Double, vega: Double, theta: Double, undPrice: Double) {}
    func tickEFP(_ tickerId: Int, tickType: Int, basisPoints: Double,
                 formattedBasisPoints: String, impliedFuture: Double, holdDays: Int,
                 futureExpiry: String, dividendImpact: Double, dividendsToExpiry: Double){}
    func orderStatus(_ orderId: Int, status: String, filled: Int, remaining: Int,
                     avgFillPrice: Double, permId: Int, parentId: Int, lastFillPrice: Double,
                     clientId: Int, whyHeld: String){}
    func openOrder(_ orderId: Int, contract: Contract, order: Order, orderState: OrderState){}
    func openOrderEnd(){}
    func updateAccountValue(_ key: String, value: String, currency: String, accountName: String){}
    func updatePortfolio(_ contract: Contract, position: Int, marketPrice: Double, marketValue: Double,
                         averageCost: Double, unrealizedPNL: Double, realizedPNL: Double, accountName: String){}
    func updateAccountTime(_ timeStamp: String){}
    func nextValidId(_ orderId: Int){}
    func contractDetails(_ reqId: Int, contractDetails: ContractDetails){}
    func bondContractDetails(_ reqId: Int, contractDetails: ContractDetails){}
    func contractDetailsEnd(_ reqId: Int){}
    func execDetails(_ reqId: Int, contract: Contract, execution: Execution){}
    func execDetailsEnd(_ reqId: Int){}
    func updateMktDepth(_ tickerId: Int, position: Int, operation: Int, side: Int, price: Double, size: Int){}
    func updateMktDepthL2(_ tickerId: Int, position: Int, marketMaker: String, operation: Int,
                          side: Int, price: Double, size: Int){}
    func updateNewsBulletin(_ msgId: Int, msgType: Int, message: String, origExchange: String){}
    func managedAccounts(_ accountsList: String){}
    func receiveFA(_ faDataType: Int, xml: String){}
    func historicalData(_ reqId: Int, date: String, open: Double, high: Double, low: Double,
                        close: Double, volume: Int, count: Int, WAP: Double, hasGaps: Bool){}
    func scannerParameters(_ xml: String){}
    func scannerData(_ reqId: Int, rank: Int, contractDetails: ContractDetails, distance: String,
                     benchmark: String, projection: String, legsStr: String){}
    func scannerDataEnd(_ reqId: Int){}
    func realtimeBar(_ reqId: Int, time: Int64, open: Double, high: Double, low: Double, close: Double, volume: Int64, wap: Double, count: Int) {}
    func currentTime(_ time: Int64){}
    func fundamentalData(_ reqId: Int, data: String){}
    func deltaNeutralValidation(_ reqId: Int, underComp: UnderComp){}
    func tickSnapshotEnd(_ reqId: Int){}
    func marketDataType(_ reqId: Int, marketDataType: Int){}
    func commissionReport(_ commissionReport: CommissionReport){}
    func position(_ account: String, contract: Contract, pos: Int, avgCost: Double){}
    func positionEnd(){}
    func accountSummary(_ reqId: Int, account: String, tag: String, value: String, currency: String){}
    func accountSummaryEnd(_ reqId: Int){}
    func verifyMessageAPI(_ apiData: String){}
    func verifyCompleted(_ isSuccessful: Bool, errorText: String){}
    func displayGroupList(_ reqId: Int, groups: String){}
    func displayGroupUpdated(_ reqId: Int, contractInfo: String){}
    
    // error handling
    func error( _ e: NSException) {}
    func error( _ str: String) {
        print("error: \(str)")
    }
    func error( _ id: Int, errorCode: Int, errorMsg:String) {
        print("error: id(\(id)) code(\(errorCode)) msg:\(errorMsg)")
    }
    func connectionClosed() {
        print("!!CONNECTION CLOSE")
    }
}

