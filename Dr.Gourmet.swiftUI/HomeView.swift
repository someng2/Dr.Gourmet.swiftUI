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
//                        Text("홈")
                    }
                NewPlaceView(vm: NewPlaceModel(places: $vm.places))
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                    }
                Text("설정 페이지")
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
            }
            .accentColor(Color("NavigationBarColor"))
            .navigationTitle(("쩝쩝박사"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color("NavigationBarColor"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
                    
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: PlaceListViewModel())
    }
}
