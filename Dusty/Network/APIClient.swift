//
//  APIClient.swift
//  Dusty
//
//  Created by HellSage on 2019/11/29.
//  Copyright © 2019 HellSage. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    static func getDustList(stationName: String) -> Observable<[MeasuredDustData]> {
        return buildRequest(pathComponent: "getMsrstnAcctoRltmMesureDnsty", params: [("numOfRows", "1"), ("pageNo", "1"), ("stationName", stationName), ("dataTerm", "DAILY"), ("ver", "1.3"), ("_returnType", "json")])
            .map { data in
                let decoder = JSONDecoder()
                let response = try decoder.decode(DustInfoResponse.self, from: data)
                return response.list
        }
    }
    
    static func getDustInfoOfCityes(itemCode: String = "PM25") -> Observable<[AverageDustValueOfCities]> {
        return buildRequest(pathComponent: "getCtprvnMesureLIst", params: [("numOfRows", "1"), ("pageNo", "1"), ("itemCode", itemCode), ("dataGubun", "HOUR"), ("searchCondition", "MONTH"), ("ver", "1.3"), ("_returnType", "json")])
            .map { data in
                let decoder = JSONDecoder()
                let response = try decoder.decode(DustInfoOfCitiesResponse.self, from: data)
                return response.list
        }
    }
}

extension APIClient {
    static private func buildRequest(method: String = "GET", pathComponent: String, params: [(String, String)]) -> Observable<Data> {
        let url = DustService.baseUrl.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "ServiceKey", value: DustService.apiKey)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if method == "GET" {
            var queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
            queryItems.append(keyQueryItem)
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems = [keyQueryItem]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.url = urlComponents.url!
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        return session.rx.data(request: request)
    }
}
