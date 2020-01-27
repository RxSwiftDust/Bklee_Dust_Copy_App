//
//  BusStationInfo.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation
import Moya

enum BusStationInfo {
    private static let serviceKey: String = "서비스키 입력"
    case getRouteByStation(id: Int)
}

extension BusStationInfo: TargetType {
    public var baseURL: URL {
        return URL(string: "http://ws.bus.go.kr/api/rest/stationinfo")!
    }

    public var path: String {
        switch self {
        case .getRouteByStation:
            return "/getRouteByStation"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getRouteByStation:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getRouteByStation(let id):
            return .requestParameters(parameters: ["serviceKey": BusStationInfo.serviceKey, "arsId": id], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Cookie" : "WMONID=gqpbEZKjyZL"]
    }
    
    var sampleData: Data {
        switch self {
        case .getRouteByStation:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}
