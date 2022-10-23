//
//  PlaceCell.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct PlaceCell: View {
    
    var place: Place
    let imageWidth: CGFloat = 140
    let imageHeight: CGFloat = 190
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        if let image = loadImageFromDocumentDirectory(imageName: "\(place.id).png") {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageHeight)
                .overlay(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6536279966)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .bottom, endPoint: .top))
                .overlay(
                    Text(place.name)
                        .foregroundColor(Color.white)
                        .font(.custom("NanumSquareEB", size: 17))
                        .frame(maxWidth: 100)
                    ,
                    alignment: .center
                )
                .cornerRadius(cornerRadius)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color("DividerColor"))
                    .frame(width: imageWidth, height: imageHeight)
                Text(place.name)
                    .foregroundColor(Color("LabelColor"))
                    .font(.custom("NanumSquareB", size: 18))
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
