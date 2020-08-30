//
//  IbAPI.swift
//  SwiftMoney
//
//  Created by jk on 2020/8/30.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

class IbAPI: ObservableObject {
    private static let defaultHost = "127.0.0.1"
    @Published var ibSocket: IbSocket = IbSocket(host: IbAPI.defaultHost)
}
