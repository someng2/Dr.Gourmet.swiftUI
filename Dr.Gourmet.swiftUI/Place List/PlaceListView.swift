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
    ]
    
    var body: some View {
        //        NavigationView {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, alignment: .leading) {
                    ForEach(vm.keys, id:\.self) { key in
                        Divider()
                        Section {
                            let items = vm.dic[key] ?? []
                            let orderedItems = items.sorted(by: {$0.regDate > $1.regDate})
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(orderedItems) { item in
                                        NavigationLink {
                                            let vm = PlaceDetailViewModel(
                                                places: $vm.places, place: item)
                                            PlaceDetailView(vm: vm)
                                        } label: {
                                            PlaceCell(place: item)
                                                
                                        }
                                    }
                                }
                            }
                        } header: {
                            Button {
                                print("---> header clicked: \(key)")
                            } label: {
                                HStack(spacing: 0) {
                                    Text(key)
                                        .font(.system(size: 17, weight: .black))
                                        .padding(10)
                                    Image(systemName: "chevron.right")
                                }.foregroundColor(Color.black)
                            }
                        }
                    }
                    .onAppear{
                        vm.getPlaceData()
                    }
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        
        //            .navigationTitle(("쩝쩝박사"))
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(vm: PlaceListViewModel())
    }
}
