//
//  PlaceDetailView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct PlaceDetailView: View {
    
    @StateObject var vm: PlaceDetailViewModel
    
    var body: some View {
        Text(vm.place.name)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(vm: PlaceDetailViewModel(places: .constant([]), place: Place()))
    }
}
