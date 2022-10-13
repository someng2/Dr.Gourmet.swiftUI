//
//  NewPlaceModel.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

final class NewPlaceModel: ObservableObject {
    @Published var places: Binding<[Place]>
    @Published var place: Place = Place()
    
    @Published var name: String = "" // 상호명
    @Published var area: String  = ""// 지역
    @Published var address: String  = ""// 주소
    @Published var imageID: String = ""//사진
    @Published var star: Int  = 0// 별점 (1 ~ 5)
    @Published var review: String  = ""// 한줄평
    @Published var menu: [String] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    init(places: Binding<[Place]>) {
        self.places = places
        
        $name.sink { name in
            self.update(name: name)
        }.store(in: &subscriptions)
        
        $area.sink { area in
            self.update(area: area)
        }.store(in: &subscriptions)
        
        $address.sink { address in
            self.update(address: address)
        }.store(in: &subscriptions)
        
        $star.sink { star in
            self.update(star: star)
        }.store(in: &subscriptions)
        
        $review.sink { review in
            self.update(review: review)
        }.store(in: &subscriptions)
        
        $menu.sink { menu in
            self.update(menu: menu)
        }.store(in: &subscriptions)
        
    }
    
    private func update(name: String) {
        self.place.name = name
    }
    
    private func update(area: String) {
        self.place.area = area
    }
    
    private func update(address: String) {
        self.place.address = address
    }
    
    private func update(star: Int) {
        self.place.star = star
    }
    
    private func update(review: String) {
        self.place.review = review
    }
    
    private func update(menu: [String]) {
        self.place.menu = menu
    }
    
    func save() {
        guard place.name.isEmpty == false else { return }
        
        places.wrappedValue.append(place)
        
        do {
            try realm.write{
                realm.add(place)
            }
        } catch let error{
            print("*** NewPlaceModel realm error: \(error)")
        }
        
        place = Place()
        eraseForm()
    }
    
    private func eraseForm() {
        name = ""
        area = ""
        address = ""
        imageID = ""
        star = 0
        review = ""
        menu = []
    }
}
