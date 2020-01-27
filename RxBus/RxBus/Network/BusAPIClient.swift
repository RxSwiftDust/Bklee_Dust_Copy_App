//
//  BusAPIClient.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import XMLParsing

struct BusAPIClient {
    enum BusAPIError: Error {
        case invalidData
    }
    
    private static let shared = BusAPIClient()
    private init() {}
    
    static private let busRouteInfoProvider = MoyaProvider<BusRouteInfo>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static private let stationInfoProvider = MoyaProvider<BusStationInfo>()
    
    static func getBusRouteList(id: Int) -> Single<BusRouteListResponse> {
        return Single.create { (single) in
            busRouteInfoProvider.rx.request(.getBusRouteList(id: id))
                .mapString().subscribe(onSuccess: { (responseString) in
                    guard let data = responseString.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                        single(.error(BusAPIError.invalidData))
                        return
                    }
                    
                    let decoder = XMLDecoder()
                    
                    do {
                        let result = try decoder.decode(BusRouteListResponse.self, from: data)
                        single(.success(result))
                    } catch {
                        single(.error(error))
                    }
                    
                }) { (error) in
                    single(.error(error))
            }
        }
    }
    
    static func getRouteByStation(stationId: Int) -> Single<RouteByStationResponse> {
        return Single.create { (single) in
            stationInfoProvider.rx.request(.getRouteByStation(id: stationId))
                .mapString().subscribe(onSuccess: { (responseString) in
                    guard let data = responseString.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                        single(.error(BusAPIError.invalidData))
                        return
                    }
                    
                    let decoder = XMLDecoder()
                    
                    do {
                        let result = try decoder.decode(RouteByStationResponse.self, from: data)
                        single(.success(result))
                    } catch {
                        single(.error(error))
                    }
                    
                }) { (error) in
                    single(.error(error))
            }
        }
    }
}
