//
//  PlaceListView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI


struct PlaceListView: View {
    
    @ObservedObject var vm: PlaceListViewModel
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    
    var body: some View {
//        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(vm.keys, id:\.self) { key in
                            Section {
                                let items = vm.dic[key] ?? []
                                //                            let orderedItems = items.sorted(by: {$0.name < $1.name})
                                
                                ForEach(items) { item in
                                    NavigationLink {
                                        let vm = PlaceDetailViewModel(
                                            places: $vm.places, place: item)
                                        PlaceDetailView(vm: vm)
                                    } label: {
                                        PlaceCell(place: item)
                                            .frame(height: 200)
                                    }
                                }
                            } header: {
                                Text(key)
                                    .font(.system(size: 20, weight: .black))
                                    .padding(10)
                            }
                        }
                        .onAppear{
                            vm.getPlaceData()
                        }
                    }
                }
            }
//            .navigationTitle(("쩝쩝박사"))
        }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(vm: PlaceListViewModel())
    }
}
