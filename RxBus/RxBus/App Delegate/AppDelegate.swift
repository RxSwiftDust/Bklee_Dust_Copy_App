//
//  AppDelegate.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import UIKit
import XMLParsing

struct ServiceResult: Codable {
//    var comMsgHeader: ComMsgHeader
    let msgHeader: MsgHeader
    let msgBody: MsgBody
    
}

struct ComMsgHeader: Codable {}
struct MsgHeader: Codable {
    var headerCd: Int
    var headerMsg: String
    var itemCount: Int
}

struct MsgBody: Codable {
    var itemList: [ItemList]
}

struct ItemList: Codable {
    var arsId: Int
    var dist: Int
    var gpsX: Double
    var gpsY: Double
    var posX: Double
    var posY: Double
    var stationId: Int
    var stationNm: String
    var stationTp: Int
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        var temp = """
//                <ServiceResult><comMsgHeader/><msgHeader><headerCd>0</headerCd><headerMsg>정상적으로 처리되었습니다.</headerMsg><itemCount>0</itemCount></msgHeader><msgBody><itemList><arsId>16841</arsId><dist>30</dist><gpsX>126.8621434783</gpsX><gpsY>37.5451836495</gpsY><posX>187818.88615376633</posX><posY>449533.28090741765</posY><stationId>115000540</stationId><stationNm>강서구의회</stationNm><stationTp>1</stationTp></itemList><itemList><arsId>16174</arsId><dist>32</dist><gpsX>126.8621412863</gpsX><gpsY>37.5451448999</gpsY><posX>187818.6861613982</posX><posY>449528.98091222206</posY><stationId>115000077</stationId><stationNm>아이파크아파트.백석중학교.실로암안과</stationNm><stationTp>1</stationTp></itemList><itemList><arsId>15127</arsId><dist>51</dist><gpsX>126.8624010187</gpsX><gpsY>37.5448325228</gpsY><posX>187841.58561549036</posX><posY>449494.2809046828</posY><stationId>114000027</stationId><stationNm>목3동주민센터.현대아이파크.실로암안과</stationNm><stationTp>1</stationTp></itemList></msgBody></ServiceResult>
//        """.data(using: .utf8)!
//        var temp = """
//        <ServiceResult><comMsgHeader/><msgHeader><headerCd>0</headerCd><headerMsg>정상적으로 처리되었습니다.</headerMsg><itemCount>0</itemCount></msgHeader><msgBody><itemList><busRouteId>100100250</busRouteId><busRouteNm>5511</busRouteNm><corpNm>한남여객  02-873-8730</corpNm><edStationNm>중앙대학교</edStationNm><firstBusTm>20200118053000</firstBusTm><firstLowTm>20190130000000</firstLowTm><lastBusTm>20200118233000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>20190130000000</lastLowTm><length>18.147</length><routeType>4</routeType><stStationNm>서울대학교</stStationNm><term>8</term></itemList><itemList><busRouteId>100100251</busRouteId><busRouteNm>5513</busRouteNm><corpNm>한남여객  02-873-8730</corpNm><edStationNm>벽산블루밍아파트</edStationNm><firstBusTm>20200118053000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118233000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>15.155</length><routeType>4</routeType><stStationNm>서울대학교</stStationNm><term>11</term></itemList><itemList><busRouteId>100100252</busRouteId><busRouteNm>5515</busRouteNm><corpNm>관악교통  02-877-1112</corpNm><edStationNm>청림동현대아파트</edStationNm><firstBusTm>20200118053000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118233000</lastBusTm><lastBusYn>0</lastBusYn><lastLowTm>              </lastLowTm><length>10.8</length><routeType>4</routeType><stStationNm>금호타운아파트</stStationNm><term>7</term></itemList><itemList><busRouteId>100100253</busRouteId><busRouteNm>5516</busRouteNm><corpNm>한남여객  02-873-8730</corpNm><edStationNm>노량진역</edStationNm><firstBusTm>20200118050000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118230000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>23.8</length><routeType>4</routeType><stStationNm>신림2동차고지</stStationNm><term>8</term></itemList><itemList><busRouteId>100100254</busRouteId><busRouteNm>5517</busRouteNm><corpNm>한남여객  02-873-8730</corpNm><edStationNm>중앙대학교</edStationNm><firstBusTm>20200118043000</firstBusTm><firstLowTm>20151125043000</firstLowTm><lastBusTm>20200118223000</lastBusTm><lastBusYn>0</lastBusYn><lastLowTm>20150717043000</lastLowTm><length>37.279</length><routeType>4</routeType><stStationNm>한남운수대학동차고지</stStationNm><term>13</term></itemList><itemList><busRouteId>100100255</busRouteId><busRouteNm>5519</busRouteNm><corpNm>관악교통  02-877-1112</corpNm><edStationNm>우방아파트</edStationNm><firstBusTm>20200118060000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118232500</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>7.7</length><routeType>4</routeType><stStationNm>용천사</stStationNm><term>14</term></itemList><itemList><busRouteId>108000001</busRouteId><busRouteNm>8551</busRouteNm><corpNm>한성운수  02-981-9001</corpNm><edStationNm>노량진역</edStationNm><firstBusTm>20200118070000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118090000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>12.3</length><routeType>4</routeType><stStationNm>봉천역</stStationNm><term>11</term></itemList><itemList><busRouteId>234001290</busRouteId><busRouteNm>1551B광주</busRouteNm><corpNm>경기</corpNm><edStationNm>신분당선강남역</edStationNm><firstBusTm>20200118053000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118221000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>0</length><routeType>8</routeType><stStationNm>수원대학교</stStationNm><term>65</term></itemList><itemList><busRouteId>234001138</busRouteId><busRouteNm>1551광주</busRouteNm><corpNm>경기</corpNm><edStationNm>양재역.서초문화예술회관</edStationNm><firstBusTm>20200118051000</firstBusTm><firstLowTm>              </firstLowTm><lastBusTm>20200118223000</lastBusTm><lastBusYn> </lastBusYn><lastLowTm>              </lastLowTm><length>0</length><routeType>8</routeType><stStationNm>수원대학교</stStationNm><term>60</term></itemList></msgBody></ServiceResult>
//        """.data(using: .utf8)!
//
//        let decoder = XMLDecoder()
//
//        do {
//           let result = try decoder.decode(BusRouteListResponse.self, from: temp)
//            print(result)
//        } catch {
//           print(error)
//        }
//
//        BusAPIClient.getBusRouteList(id: 551).subscribe(onSuccess: { (response) in
//            print(response)
//        }) { (error) in
//            print(error)
//        }
        return true
    }

}

