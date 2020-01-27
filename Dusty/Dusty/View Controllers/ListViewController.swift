//
//  ListViewController.swift
//  Dusty
//
//  Created by HellSage on 2019/12/06.
//  Copyright © 2019 HellSage. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController {
    
    var dustInfos = BehaviorRelay<[(String, String)]>(value: [])
    private let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        tableView = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView = nil
    }
    
    private func setupRx() {
        segmentControl.rx.selectedSegmentIndex
            .asDriver()
            .drive(onNext: { [weak self] (index) in
                guard let self = self else { return }
                guard let title = self.segmentControl.titleForSegment(at: index) else { return }
                let itemCode: String
                if title == "PM2.5" {
                    itemCode = "PM25"
                } else {
                    itemCode = title
                }
                
                let result = APIClient.getDustInfoOfCityes(itemCode: itemCode)
                    .catchErrorJustReturn([])
                    .filter {!$0.isEmpty}
                
                let temp = Observable<AverageDustValueOfCities>.create { (observer) in
                    result.bind { (list) in
                        print(list)
                        observer.onNext(list.first!)
                    }.disposed(by: self.disposeBag)
                    return Disposables.create()
                }
                .asDriver(onErrorJustReturn: AverageDustValueOfCities.Empty())
                .map { (data) -> Observable<[(String, String)]> in
                        Observable.create { (observer) in
                            var array: [(String, String)] = []
                            for value in AverageDustValueOfCities.cities.allCases {
                                array.append((value.rawValue, data[value]))
                            }
                            observer.onNext(array)
                            return Disposables.create()
                        }
                }
                temp.drive(onNext: { (list) in
                    list.asDriver(onErrorJustReturn: [])
                        .drive(self.dustInfos)
                        .disposed(by: self.disposeBag)
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        dustInfos.bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { (index: Int, element: (String, String), cell: UITableViewCell) in
            cell.textLabel?.text = element.0
            cell.detailTextLabel?.text = element.1
        }.disposed(by: disposeBag)
        
    }
    
}
