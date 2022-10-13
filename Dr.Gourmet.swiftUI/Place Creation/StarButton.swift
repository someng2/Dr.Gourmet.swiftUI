//
//  StarButton.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import RealmSwift

struct StarButton: View {
    @ObservedObject var vm: NewPlaceModel
    
    var index: Int
    
    var body: some View {
        
        Button {
            vm.star = index
        } label: {
            Image(systemName: vm.star > index ? "star.fill" : "star")
                .foregroundColor(vm.star > index ? Color.yellow : Color.gray.opacity(0.6))
        }
        

        
    }
}

struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(vm: NewPlaceModel(places: .constant([])), index: 0)
    }
}
