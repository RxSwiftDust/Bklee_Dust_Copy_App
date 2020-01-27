//
//  AddViewViewModel.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AddViewViewModel {
    var busInfos: BehaviorRelay<[BusRouteItem]> = BehaviorRelay(value: [])
    var busInfosByStation: BehaviorRelay<[BusInfo]> = BehaviorRelay(value: [])
    
    func queryBusRouteInfo(queryId: Int) -> Completable {
        return Completable.create { [weak self] (completeable) in
            BusAPIClient.getBusRouteList(id: queryId)
                .subscribe(onSuccess: { (response) in
                    let result = response.body?.itemList ?? []
                    print(result)
                    self?.busInfos.accept(result)
                    completeable(.completed)
                }) { (error) in
                    completeable(.error(error))
            }
        }
    }
    
    func queryRouteByStation(stationId: Int) -> Completable {
        return Completable.create { [weak self] (completeable) in
            BusAPIClient.getRouteByStation(stationId: stationId)
                .subscribe(onSuccess: { (response) in
                    let result = response.body?.itemList ?? []
                    print(result)
                    self?.busInfosByStation.accept(result)
                    completeable(.completed)
                }) { (error) in
                    completeable(.error(error))
            }
        }
    }
    
}
