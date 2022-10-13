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
        Text(place.name)
    }
}

struct PlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCell(place: Place())
    }
}
