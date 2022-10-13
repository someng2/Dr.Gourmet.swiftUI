//
//  HomeView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: PlaceListViewModel
    
    var body: some View {
        NavigationView {
            TabView {
                PlaceListView(vm: vm)
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                NewPlaceView(vm: NewPlaceModel(places: $vm.places))
                    .tabItem {
                        Image(systemName: "plus")
                    }
            }
            .navigationTitle(("쩝쩝박사"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: PlaceListViewModel())
    }
}
