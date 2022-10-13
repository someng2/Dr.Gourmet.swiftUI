//
//  PlaceDetailViewModel.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import Foundation
import SwiftUI

final class PlaceDetailViewModel: ObservableObject {
    @Published var places: Binding<[Place]>
    @Published var place: Place
    
    init(places: Binding<[Place]>, place: Place) {
        self.places = places
        self.place = place
    }
}
