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
                            HStack(spacing: 8) {
                                Image("sharpFlagIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 25)
                                    .foregroundColor(Color("SecondaryOrange"))
                                    .fontWeight(.bold)
                                Text(key)
                                    .font(.custom("HancomMalangMalang-Bold", size: 20))
                            }.foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
//                            Button {
//                                print("---> header clicked: \(key)")
//                            } label: {
//                                HStack(spacing: 0) {
//                                    Text(key)
//                                        .font(.custom("HancomMalangMalang-Bold", size: 19))
//                                        .padding(10)
//                                    Image(systemName: "chevron.right")
//                                }.foregroundColor(Color.black)
//                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                        Divider()
                        
                    }
                    .onAppear{
                        vm.getPlaceData()
                    }
                }
            }
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(vm: PlaceListViewModel())
    }
}
