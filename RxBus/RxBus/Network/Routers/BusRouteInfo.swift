//
//  BusRouteInfo.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation
import Moya

enum BusRouteInfo {
    private static let serviceKey: String = "서비스키 입력"
    case getBusRouteList(id: Int)
}

extension BusRouteInfo: TargetType {
    public var baseURL: URL {
        return URL(string: "http://ws.bus.go.kr/api/rest/busRouteInfo")!
    }

    public var path: String {
        switch self {
        case .getBusRouteList:
            return "/getBusRouteList"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getBusRouteList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getBusRouteList(let id):
            return .requestParameters(parameters: ["serviceKey": BusRouteInfo.serviceKey, "strSrch": id], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Cookie" : "WMONID=gqpbEZKjyZL"]
    }
    
    var sampleData: Data {
        switch self {
        case .getBusRouteList:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}
