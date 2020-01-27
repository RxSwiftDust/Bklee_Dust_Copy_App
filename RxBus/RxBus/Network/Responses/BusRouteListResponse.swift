//
//  BusRouteListResponse.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation


struct BusRouteListResponse: Codable {
    let header: ResponseHeader
    let body: BusRouteListBody?
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BusRouteListBody: Codable {
    var itemList: [BusRouteItem]?
}

struct BusRouteItem: Codable {
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
    /// 막차운행여부
    let lastBusYn: Int?
    
    ///
    let corporationName: String
    
        
    private enum CodingKeys: String, CodingKey {
        case id = "busRouteId"
        case name = "busRouteNm"
        case length
        case type = "routeType"
        case startStationName = "stStationNm"
        case endStationName = "edStationNm"
        case term
        case lastBusYn
        case corporationName = "corpNm"
    }
    
}
