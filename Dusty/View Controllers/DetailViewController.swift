//
//  DetailViewController.swift
//  Dusty
//
//  Created by HellSage on 2019/11/28.
//  Copyright © 2019 HellSage. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    /// 측정소 이름 라벨
    @IBOutlet weak var stationNameLabel: UILabel!
    /// 측정 시간 라벨
    @IBOutlet weak var dateLabel: UILabel!
    /// 미세먼지 농도 라벨
    @IBOutlet weak var pm25ValueLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var progressValueLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    private let disposeBag = DisposeBag()
    
    var stationName = BehaviorRelay<String>(value: "관악구")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        requestDustInfo()
    }
    
    private func setupRx() {
        // 측정소 이름
        stationName
            //            .asDriver(onErrorJustReturn: "-")
            .map{ value -> String in
                print(value)
                return "(\(value) 측정소)"
        }
        .asDriver(onErrorJustReturn: "관악구")
        .drive(stationNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        let searchList = stationName
            .flatMapLatest { (stationName) ->  Observable<[MeasuredDustData]>  in
                return APIClient.getDustList(stationName: "관악구").catchErrorJustReturn([])
        }
        .filter {!$0.isEmpty}
        .asDriver(onErrorJustReturn: [])
        
 
        // 시간정보
        searchList.map { (datas) -> String in
            guard let data = datas.first else { return "정보없음" }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let date = formatter.date(from: data.dataTime) else {
                return "정보없음"
            }
            
            formatter.amSymbol = "오전"
            formatter.pmSymbol = "오후"
            formatter.dateFormat = "a hh:mm"
            return formatter.string(from: date)
        }.drive(dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 미세먼지 수치
         searchList.map { (datas) -> String in
             guard let data = datas.first else { return "-" }
             return data.pm25Value
         }.drive(pm25ValueLabel.rx.text)
             .disposed(by: disposeBag)
        
        // 미세먼지 등급
        searchList.map { (datas) -> String in
            guard let data = datas.first else { return "-" }
            return MeasuredDustData.gradeString(from: data.pm25Grade1h)
        }.drive(gradeLabel.rx.text)
            .disposed(by: disposeBag)
        
        searchList.map { (datas) -> Float in
            guard let data = datas.first, let value = Float(data.pm25Value) else { return 0 }
            return  value / 50
        }.drive(progressView.rx.progress)
            .disposed(by: disposeBag)
        
        searchList.map { (datas) -> String in
            guard let data = datas.first else { return "0/50" }
            return "\(data.pm25Value)/50"
        }.drive(progressValueLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func requestDustInfo() {
        stationName.accept("관악구")
    }
}

