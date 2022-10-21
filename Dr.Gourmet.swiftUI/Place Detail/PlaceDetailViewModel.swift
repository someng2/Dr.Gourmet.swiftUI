//
//  PlaceDetailViewModel.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import Foundation
import SwiftUI
import RealmSwift

final class PlaceDetailViewModel: ObservableObject {
    @Published var places: Binding<[Place]>
    @Published var place: Place
    
    init(places: Binding<[Place]>, place: Place) {
        self.places = places
        self.place = place
    }
    
    func filterDate(_ origin: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: origin) ?? Date()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        // 1. 도큐먼트 폴더 경로가져오기
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            // 2. 이미지 URL 찾기
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            // 3. UIImage로 불러오기
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func deletePlaceData() {
        let predicate = NSPredicate(format: "id == %@", place.id as CVarArg)
        if let filteredData = realm.objects(Place.self).filter(predicate).first {
//            print("---> filteredData: \(filteredData)")
            try! realm.write{
                realm.delete(filteredData)
            }
        }
        
        // place instance 초기화 -> 에러 해결
        place = Place()
        
    }
    
    func getPlaceData(){
        let savedPlace = realm.objects(Place.self)
        
        try! realm.write {
            print("---> getSavedData: \(savedPlace.compactMap({$0}))")
            places.wrappedValue = savedPlace.compactMap({$0})
        }
    }
    
}
