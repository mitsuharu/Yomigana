//
//  ErrorType.swift
//  Yomigana
//
//  Created by Mitsuhau Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

/// APIエラーの種類
enum ErrorType {
    case validation
    case unknown
    case networkOff
    case timeOut
    
    var description: String {
        switch self {
        case .unknown:
            return Constants.Alert.failed
        case .networkOff:
            return Constants.Alert.network
        case .timeOut:
            return Constants.Alert.timeout
        case .validation:
            return Constants.Alert.validation
        }
    }
}
