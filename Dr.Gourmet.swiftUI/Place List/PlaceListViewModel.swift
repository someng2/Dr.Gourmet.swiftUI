//
//  PlaceListViewModel.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import Foundation
import Combine
import Realm
import RealmSwift

final class PlaceListViewModel: ObservableObject {
    
    @Published var places: [Place] = []
    @Published var dic: [String: [Place]] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        getPlaceData()
        print("---> Realm Data File 위치: \(Realm.Configuration.defaultConfiguration.fileURL!)")
//        self.dic = Dictionary(grouping: places, by: { $0.area })
        bind()
    }
    
    var keys: [String] {
        return dic.keys.sorted { $0 < $1 }
    }
    
    private func toArray(_ before: Results<Place>) -> [Place] {
        return before.compactMap {
            $0
        }
    }
    
    func getPlaceData(){
        
        let savedPlace = realm.objects(Place.self)        
        
        try! realm.write {
//            print("---> getSavedData: \(savedPlace.compactMap({$0}))")
            self.places = savedPlace.compactMap({$0})
        }
    }
    
    private func bind() {
        $places.sink { items in
            print("---> List Changed: \(items)")
            self.dic = Dictionary(grouping: items, by: { $0.area })
            print("dic = \(self.dic)")
        }.store(in: &subscriptions)
    }
    
//    func addPlaceData(name: String, area: String, address: String, imageID: String, star: Int, menu: [String], review: String) {
//        let place = Place()
//        place.name = name
//        place.area = area
//        place.address = address
//        place.imageID = imageID
//        place.star = star
//        place.review = review
//        place.menu = menu
//        
//        try! realm.write {
//            realm.add(place)
//        }
//        
//        self.getPlaceData()
//    }
}
