//
//  RouteByStationResponse.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation

struct RouteByStationResponse: Codable {
    let header: ResponseHeader
    let body: BusInfoListBody?
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BusInfoListBody: Codable {
    var itemList: [BusInfo]?
}

struct BusInfo: Codable {
    /// 노선 ID
    let id: Int
    /// 노선명
    let name: String
    /// 노선 길이(Km)
    let length: Double
    /// 노선 유형
    let type: Int
    /// 기점 이름
    let startStationName: String?
    /// 종점 이름
    let endStationName: String?
    /// 배차간격(분)
    let term: Int
    
    
        
    private enum CodingKeys: String, CodingKey {
        case id = "busRouteId"
        case name = "busRouteNm"
        case length
        case type = "busRouteType"
        case startStationName = "stBegin"
        case endStationName = "stEnd"
        case term
    }
    
    
}
