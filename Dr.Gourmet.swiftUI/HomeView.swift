//
//  HomeView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm: PlaceListViewModel
    @State private var tabSelection = 1
    
    var body: some View {
            TabView(selection: $tabSelection) {
                PlaceListView(vm: vm)
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(1)
                NewPlaceView(vm: NewPlaceModel(places: $vm.places, tabSelection: $tabSelection
//                                               , showingPopup: false)
                ))
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                    }
                    .tag(2)
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
                    .tag(3)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(alignment: .center) {
                        Text("쩝쩝").font(.custom("Jalnan", size: 20))
                            .foregroundColor(.black)
                        Image("circleAppLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity)
                        Text("박사").font(.custom("Jalnan", size: 20))
                            .foregroundColor(.black)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                }
            }
            .accentColor(Color("PrimaryColor"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color("PrimaryColor"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: PlaceListViewModel())
    }
}
