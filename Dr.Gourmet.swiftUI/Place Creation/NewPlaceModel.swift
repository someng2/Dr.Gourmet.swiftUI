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
    @Published var star: Int  = 1// 별점 (1 ~ 5)
    @Published var review: String  = ""// 한줄평
    @Published var menu: String = ""
    
//    @Published var showingPopup: Bool = false
    @Binding var tabSelection: Int
    
    var subscriptions = Set<AnyCancellable>()
    
    init(places: Binding<[Place]>, tabSelection: Binding<Int>) {
        self.places = places
        self._tabSelection = tabSelection
        
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
        
//        $showingPopup.sink { showingPopup in
//            self.showingPopup = showingPopup
//            print("---> showingPopup = \(showingPopup)")
//        }.store(in: &subscriptions)
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
    
    private func update(menu: String) {
        self.place.menu = menu
    }
    
    // 세로 이미지 회전 문제로 인한 함수
    
    func fixOrientation(img: UIImage) -> UIImage {
        
        if (img.imageOrientation == .up) {
            return img
        }

        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
        
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        let fixedImage = fixOrientation(img: image)
        
        // 1. 이미지를 저장할 경로를 설정해줘야함 - 도큐먼트 폴더,File 관련된건 Filemanager가 관리함(싱글톤 패턴)
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축(image.pngData())
        // 압축할거면 jpegData로~(0~1 사이 값)
        guard let data = fixedImage.pngData() else {
            print("압축이 실패했습니다.")
            return
        }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기하는 경우
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            // 4-2. 이미지가 존재한다면 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        
        // 5. 이미지를 도큐먼트에 저장
        // 파일을 저장하는 등의 행위는 조심스러워야하기 때문에 do try catch 문을 사용하는 편임
        do {
            try data.write(to: imageURL)
            print("이미지 저장완료")
        } catch {
            print("이미지를 저장하지 못했습니다.")
        }
    }
    
    func save(image: UIImage) {
        if place.name.isEmpty {
//            showingPopup = true
           
            return
        }
//        guard place.name.isEmpty == false else { return }
        guard place.area.isEmpty == false else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.place.regDate = formatter.string(from: Date())
        print("---> current time: \(place.regDate)")
        places.wrappedValue.append(place)
        
        do {
            try realm.write{
                realm.add(place)
                if image != UIImage() {
                    saveImageToDocumentDirectory(imageName: "\(place.id).png", image: image)
                }
            }
        } catch let error{
            print("*** NewPlaceModel realm error: \(error)")
        }
        
        place = Place()
        eraseForm()
        tabSelection = 1
    }
    
    private func eraseForm() {
        name = ""
        area = ""
        address = ""
        star = 1
        review = ""
        menu = ""
    }
}
