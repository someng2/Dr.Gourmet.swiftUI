//
//  Dr_Gourmet_swiftUIApp.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI


@main
struct Dr_Gourmet_swiftUIApp: App {
    @UIApplicationDelegateAdaptor var delegate: MyAppDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView(vm: PlaceListViewModel())
//            PlaceListView(vm: PlaceListViewModel(places: []))
        }
    }
}
