//
//  AddViewController.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddViewController: UIViewController {
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel = AddViewViewModel()
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var busInfosTableView: UITableView!
    @IBOutlet weak var busInfosByStationTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance) // 0.5초 기다림. 안 줄 경우, 모든 입력을 받음. (API의 과도한 호출을 방지)
            .distinctUntilChanged() // 새로운 값이 이전과 같은지 체크 (O -> Oc -> O 값이 이전과 같으므로 다음으로 안넘어감)
            .filter({ !$0.isEmpty })
            .subscribe(onNext: { [unowned self] query in
                self.query(with: query, type: self.searchBar.selectedScopeButtonIndex)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.selectedScopeButtonIndex
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] index in
                guard let query = self.searchBar.text else { return }
                self.query(with: query, type: index)
            }).disposed(by: disposeBag)
        
        viewModel.busInfos
            .subscribe(onNext: { [unowned self] (items) in
                self.busInfosTableView.isHidden = items.count == 0
            })
            .disposed(by: disposeBag)
        viewModel.busInfosByStation
            .subscribe(onNext: { [unowned self] (items) in
                self.busInfosByStationTableView.isHidden = items.count == 0
            })
            .disposed(by: disposeBag)
        
        viewModel.busInfos.bind(to: busInfosTableView.rx.items(cellIdentifier: "cell")) { (index: Int, element: BusRouteItem, cell: UITableViewCell) in
            cell.textLabel?.text = element.name
        }.disposed(by: disposeBag)
        
        viewModel.busInfosByStation.bind(to: busInfosByStationTableView.rx.items(cellIdentifier: "cell")) { (index: Int, element: BusInfo, cell: UITableViewCell) in
            cell.textLabel?.text = element.name
        }.disposed(by: disposeBag)
    }

    // MARK: - Private Methods
    
    private func query(with queryString: String, type: Int) {
        if type == 0 {
            guard let busNumber = Int(queryString) else { return }
            viewModel.busInfosByStation.accept([])
            // 버스 번호 검색
            viewModel.queryBusRouteInfo(queryId: busNumber)
                .subscribe()
                .disposed(by: self.disposeBag)
        } else if type == 1 {
            // 정류장 번호 검색
            viewModel.busInfos.accept([])
            guard let stationId = Int(queryString) else { return }
            viewModel.queryRouteByStation(stationId: stationId)
                .subscribe()
                .disposed(by: self.disposeBag)
        }
    }
    
}
