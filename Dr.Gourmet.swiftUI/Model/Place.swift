//
//  Place.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class Place: Object, Identifiable, Codable {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var name: String = "" // 상호명
    @objc dynamic var area: String  = ""// 지역
    @objc dynamic var address: String  = ""// 주소
//    @objc dynamic var imageID: String = ""//사진 ID (DB와 연결)
    @objc dynamic var menu: String = ""
    @objc dynamic var star: Int  = 0// 별점 (1 ~ 5)
    @objc dynamic var review: String  = ""// 한줄평
    @objc dynamic var regDate: String = ""     // 등록 날짜, 시간
    
//    var dataList: List<String> = List<String>()
//    var menu: [String] {        // 기억에 남는 메뉴
//        get {
//            return dataList.map{$0}
//        }
//        set {
//            dataList.removeAll()
//            dataList.append(objectsIn: newValue)
//        }
//    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


//extension Place {
//    
//    static let list: [Place] = [
//        Place(name: "난포", area: "서울", address: "서울시 성수동", imageID: "", star: 4, menu: ["묵은지말이회", "강된장"], review: "웨이팅이 엄청 길지만 맛있음"),
//        Place(name: "다운타우너", area: "서울", address: "서울시 이태원", imageID: "", star: 4, menu: ["아보카도버거", "칠리치킨버거"], review: "웨이팅이 있지만 기다려서 먹을만 하다. 햄버거 맛집!"),
//
//        Place(name: "회성각", area: "대구", address: "대구시 대명동", imageID: "", star: 4, menu: ["탕수육", "짜장면"], review: "탕수육이 겁나 크다.. 거의 치킨 수준! 짜장면도 굿굿"),
//        Place(name: "대쿠이", area: "대구", address: "대구시 대명동", imageID: "", star: 5, menu: ["돈가스정식"], review: "대구 돈가쓰 찐맛집..웨이팅이 있을 수 있다"),
//
//    ]
//}
