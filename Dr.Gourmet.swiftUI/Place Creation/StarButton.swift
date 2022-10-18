//
//  StarButton.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import RealmSwift

struct StarButton: View {
    @Binding var star: Int
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var body: some View {
        
        HStack {
            ForEach(1..<6, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > star ? Color.gray.opacity(0.8) : Color.yellow)
                    .onTapGesture {
                        star = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > star {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(star: .constant(1))
    }
}
