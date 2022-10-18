//
//  PlaceDetailView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI

struct PlaceDetailView: View {
    
    @StateObject var vm: PlaceDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var presentPopup = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if (vm.loadImageFromDocumentDirectory(imageName: "\(vm.place.id).png") != nil) {
                        Image(uiImage: vm.loadImageFromDocumentDirectory(imageName: "\(vm.place.id).png")!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .frame(height: 230)
                            .padding(EdgeInsets(top: 35, leading: 35, bottom: 0, trailing: 35))
                    }
                    else {
                        // TODO: 이미지 없을 경우
                    }
                    Spacer().frame(height: 15)
                    HStack(alignment: .center, spacing: 3) {
                        Spacer()
                        ForEach (0..<vm.place.star) {_ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                                .shadow(color: Color.yellow, radius: 4, x: -3, y: 2)
                        }
                        ForEach (vm.place.star..<5) {_ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.gray.opacity(0.8))
                                .shadow(color: Color("StarDisabledColor"), radius: 4, x: -3, y: 2)
                        }
                        Spacer()
                    }
                    Divider().foregroundColor(Color("DividerColor")).padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    if vm.place.address != "" {
                        HStack {
                            Image("mapIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("LabelColor"))
                                .frame(width: 17)
                            
                            Spacer().frame(width: 10)
                            Text(vm.place.address)
                                .font(.system(size: 15))
                                .foregroundColor(Color("LabelColor"))
                        }.padding(.leading, 20)
                        Divider().foregroundColor(Color("DividerColor")).padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    }
                    VStack(alignment: .leading){
                        if vm.place.menu != "" {
                            HStack {
                                Image(systemName: "fork.knife.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("SecondaryOrange"))
                                    .frame(width: 22)
                                Text("추천 메뉴")
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(alignment: .leading)
                            }
                            Spacer().frame(height: 15)
                            Text(vm.place.menu)
                                .font(.system(size: 15))
                                .padding(.leading, 30)
                            Spacer().frame(height: 30)
                        }
                        if vm.place.review != "" {
                            HStack {
                                Image(systemName: "message.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("SecondaryOrange"))
                                    .frame(width: 22)
                                Text("리뷰")
                                    .font(.system(size: 18, weight: .bold))
                            }
                            
                            Spacer().frame(height: 15)
                            
                            Text("이거슨 리뷰~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                                .font(.system(size: 15))
                                .padding(.leading, 30)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 30))
                }.foregroundColor(Color("LabelColor"))
                
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(vm.place.name)
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
            }
            Spacer()
            HStack {
                Spacer()
                Text("최근 수정일:")
                Text(vm.filterDate(vm.place.regDate))
                Spacer()
                
            }.foregroundColor(Color("LightGray"))
                .frame(alignment: .center)
                .font(.system(size: 12))
            
        }.toolbarBackground(
            Color("NavigationBarColor"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: deleteButton)
    }
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                
            }
    }
    
    var deleteButton: some View {
        Button("삭제") {
            presentPopup = true
        }
        .foregroundColor(.white)
        .font(.system(size: 18))
        .sheet(isPresented: $presentPopup) {
            VStack {
                Spacer()
                Button {
                    

//                    DispatchQueue.main.async {
                        vm.deletePlaceData()
//                    }
                    presentPopup = false
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("삭제")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryOrange"))
                        .frame(maxWidth: .infinity, maxHeight: 45)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 1, y: 2))
                Spacer().frame(height: 10)
                Button {
                    presentPopup = false
                } label: {
                    Text("취소")
                        .font(.system(size: 16))
                        .foregroundColor(Color("LightGray"))
                        .frame(maxWidth: .infinity, maxHeight: 45)
                }
                
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 1, y: 2))
                Spacer()
            }
            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
            .presentationDetents([.fraction(0.18)])     // bottom 15% of the screen:
            
        }
        
    }
}


struct PlaceDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaceDetailView(vm: PlaceDetailViewModel(places: .constant([]), place: Place()))
    }
}
