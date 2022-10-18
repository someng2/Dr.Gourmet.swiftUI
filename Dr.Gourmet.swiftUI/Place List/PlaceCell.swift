//
//  PlaceCell.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct PlaceCell: View {
    
    var place: Place
    
    var body: some View {
        if let image = loadImageFromDocumentDirectory(imageName: "\(place.id).png") {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 180)
                .blur(radius: 1)
                .cornerRadius(20.0)
                .clipped()
                .opacity(0.8)
                .overlay(
                    Text(place.name)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black),
                    alignment: .center
                )
        } else {

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .frame(width: 120, height: 180)

                Text(place.name)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
            
        }
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
}

struct PlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCell(place: Place())
    }
}
