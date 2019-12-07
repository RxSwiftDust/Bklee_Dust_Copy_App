//
//  MeasuredDustData.swift
//  Dusty
//
//  Created by HellSage on 2019/11/29.
//  Copyright © 2019 HellSage. All rights reserved.
//

import Foundation

struct MeasuredDustData: Codable {
    /// 일산화탄소 지수
    let coGrade: String
    /// 일산화탄소 농도.일산화탄소 농도(단위 : ppm)
    let coValue: String
//    let dataTerm: String
    /// 측정일. 오염도 측정 연-월일 시간:분
    let dataTime: String
    /// 통합대기환경지수
    let khaiGrade: String
    /// 통합대기환경수치
    let khaiValue: String
    /// 측정망 정보. 측정망 정보(국가배경, 교외대기,도시대기, 도로변대기)
    let mangName: String
    /// 이산화질소 지수
    let no2Grade: String
    /// 이산화질소 농도. 이산화질소 농도(단위 : ppm)
    let no2Value: String
    let numOfRows: String
    /// 오존 지수
    let o3Grade: String
    /// 오존 농도. 오존 농도(단위 : ppm)
    let o3Value: String
    let pageNo: String
    /// 미세먼지(PM10)24시간 등급. 미세먼지(PM10)24시간 등급자료
    let pm10Grade: String
    /// 미세먼지(PM10)1시간 등급
    let pm10Grade1h: String
    /// 미세먼지(PM10) 농도. 미세먼지(PM10) 농도 (단위 : ㎍/㎥)
    let pm10Value: String
    /// 미세먼지(PM10)24시간예측이동농도. 미세먼지(PM10)24시간예측이동농도(단위 : ㎍/㎥)
    let pm10Value24: String
    /// 미세먼지(PM10)24시간 등급
    let pm25Grade: String
    /// 미세먼지(PM2.5)1시간 등급
    let pm25Grade1h: String
    /// 미세먼지(PM2.5) 농도. 미세먼지(PM2.5)  농도(단위 : ㎍/㎥)
    let pm25Value: String
    /// 미세먼지(PM2.5)24시간예측이동농도. 미세먼지(PM2.5)24시간예측이동농도(단위 : ㎍/㎥)
    let pm25Value24: String
//    let resultCode: String
//    let resultMsg: String
//    let rnum: Int
//    let serviceKey: String
//    let sidoName: String
    /// 아황산가스 지수
    let so2Grade: String
    /// 아황산가스 농도.아황산가스 농도(단위 : ppm)
    let so2Value: String
//    let stationCode: String
//    let stationName: String
//    let totalCount: String
//    let ver: String
    
    static func gradeString(from valueString: String) -> String {
        switch valueString {
        case "1":
            return "좋음"
        case "2":
            return "보통"
        case "3":
            return "나쁨"
        default:
            return "매우나쁨"
        }
    }
}

struct DustInfoResponse: Codable {
    let list: [MeasuredDustData]
}

struct DustInfoOfCitiesResponse: Codable {
    let list: [AverageDustValueOfCities]
}

struct AverageDustValueOfCities: Codable {
    enum cities: String, CaseIterable {
        case daegu = "대구"
        case daejeon = "대전"
        case gangwon = "강원"
        case gwangju = "광주"
        case gyeongbuk = "경북"
        case gyeonggi = "경기도"
        case gyeongnam = "경남"
        case incheon = "인천"
        case jeju = "제주"
        case jeonbuk = "전북"
        case jeonnam = "전남"
        case sejong = "세종"
        case seoul = "서울"
        case ulsan = "울산"
    }
    
    var dataTime: String?
    var daegu: String?
    var daejeon: String?
    var gangwon: String?
    var gwangju: String?
    var gyeongbuk: String?
    var gyeonggi: String?
    var gyeongnam: String?
    var incheon: String?
    var jeju: String?
    var jeonbuk: String?
    var jeonnam: String?
    var sejong: String?
    var seoul: String?
    var ulsan: String?
    
    static func Empty() -> AverageDustValueOfCities {
        return AverageDustValueOfCities()
    }
    
    subscript(city: cities) -> String {
        switch city {
        case .daegu:
            return daegu ?? "0"
        case .daejeon:
            return daejeon ?? "0"
        case .gangwon:
            return gangwon ?? "0"
        case .gwangju:
            return gwangju ?? "0"
        case .gyeongbuk:
            return gyeongbuk ?? "0"
        case .gyeonggi:
            return gyeonggi ?? "0"
        case .gyeongnam:
            return gyeongnam ?? "0"
        case .incheon:
            return incheon ?? "0"
        case .jeju:
            return jeju ?? "0"
        case .jeonbuk:
            return jeonbuk ?? "0"
        case .jeonnam:
            return jeonnam ?? "0"
        case .sejong:
            return sejong ?? "0"
        case .seoul:
            return seoul ?? "0"
        case .ulsan:
            return ulsan ?? "0"
        @unknown default:
            return "0"
        }
    }
}
