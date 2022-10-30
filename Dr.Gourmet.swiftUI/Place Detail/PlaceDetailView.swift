//
//  PlaceDetailView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import UniformTypeIdentifiers
import SSToastMessage

struct PlaceDetailView: View {
    
    @StateObject var vm: PlaceDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var presentPopup = false
    @State var showToast = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if (vm.loadImageFromDocumentDirectory(imageName: "\(vm.place.id).png") != nil) {
                        HStack {
                            Spacer()
                            Image(uiImage: vm.loadImageFromDocumentDirectory(imageName: "\(vm.place.id).png")!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(height: 230, alignment: .center)
                                .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
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
                        HStack(alignment: .center) {
                            Image("mapIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("LabelColor"))
                                .frame(width: 17)
                            
                            Spacer().frame(width: 15)
                            Text(vm.place.address)
                                .font(.custom("NanumSquareR", size: 15))
                                .foregroundColor(Color("LabelColor"))
                            
                            Spacer()
                            Text("복사")
                                .font(.custom("NanumSquareB", size: 13))
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .foregroundColor(.white)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(15)
                                .onTapGesture(count: 1) {
                                    UIPasteboard.general.string = vm.place.address
                                    showToast = true
                                }
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        Divider().foregroundColor(Color("DividerColor")).padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    }
                    VStack(alignment: .leading){
                        if vm.place.menu != "" {
                            HStack(alignment: .center) {
                                Image(systemName: "fork.knife.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("SecondaryOrange"))
                                    .frame(width: 23)
                                Spacer().frame(width: 13)
                                Text("추천 메뉴")
                                    .font(.custom("HancomMalangMalang-Bold", size: 17))
                                    .frame(alignment: .leading)
                            }
                            Spacer().frame(height: 15)
                            Text(vm.place.menu)
                                .font(.custom("NanumSquareR", size: 15))
                                .padding(.leading, 36)
                            Spacer().frame(height: 30)
                        }
                        if vm.place.review != "" {
                            HStack(alignment: .center) {
                                Image(systemName: "message.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("SecondaryOrange"))
                                    .frame(width: 23)
                                Spacer().frame(width: 13)
                                Text("리뷰")
                                    .font(.custom("HancomMalangMalang-Bold", size: 17))
                            }
                            
                            Spacer().frame(height: 15)
                            
                            Text(vm.place.review)
                                .font(.custom("NanumSquareR", size: 15))
                                .padding(.leading, 36)
                                .lineSpacing(5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }.foregroundColor(Color("LabelColor"))
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("📍 \(vm.place.name)")
                            .font(.custom("HancomMalangMalang-Bold", size: 19))
                            .foregroundColor(Color.black)
                    }
                }
            }
            Spacer()
            HStack {
                Spacer()
                Text("등록일:")
                Text(vm.filterDate(vm.place.regDate))
                Spacer()
                
            }.foregroundColor(Color("LightGray"))
                .frame(alignment: .center)
                .font(.custom("NanumSquareR", size: 12))
                .padding(.bottom, 10)
            
        }.toolbarBackground(
            Color("PrimaryColor"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: deleteButton)
        .present(isPresented: $showToast, type: .floater(), position: .bottom, autohideDuration: 1.3) {
            toastView()
        }
    }
    
    func toastView() -> some View {
        VStack {
            Text("클립보드에 복사되었습니다.")
                .font(.custom("NanumSquareB", size: 14))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(Color("LightGray"))
        .cornerRadius(10)
        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
    }
    
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(height: 40)
            }
    }
    
    var deleteButton: some View {
        Button("삭제") {
            presentPopup = true
        }
        .foregroundColor(.white)
        .font(.custom("NanumSquareB", size: 16))
        .sheet(isPresented: $presentPopup) {
            VStack {
                Spacer()
                Button {
                    vm.deletePlaceData()
                    presentPopup = false
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("삭제")
                        .font(.custom("NanumSquareB", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("SecondaryOrange"))
                )
                Spacer().frame(height: 10)
                Button {
                    presentPopup = false
                } label: {
                    Text("취소")
                        .font(.custom("NanumSquareB", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("LightGray"))
                )
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            .presentationDetents([.fraction(0.2)])     // bottom 20% of the screen:
        }
    }
}


struct PlaceDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaceDetailView(vm: PlaceDetailViewModel(places: .constant([]), place: Place()))
    }
}
