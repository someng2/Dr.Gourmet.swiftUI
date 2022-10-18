//
//  NewPlaceView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct NewPlaceView: View {
    
    @StateObject var vm: NewPlaceModel
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var starClicked: [Bool] = [false, false, false, false, false]
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $vm.name)
                } header: {
                    Text("상호명")
                }
                .focused($focused)
                Section {
                    TextField("", text: $vm.area)
                } header: {
                    Text("지역 (ex: 서울, 대전)")
                }.textCase(nil)
                Section {
                    TextField("", text: $vm.address)
                } header: {
                    Text("주소")
                }
                
                Section {
                    TextField("", text: $vm.menu)
                        .frame(height: 60)
                } header: {
                    Text("추천메뉴")
                }
                
                Section {
                    StarButton(star: $vm.star)
                } header: {
                    Text("별점")
                }
                
                Section {
                    TextField("", text: $vm.review, axis: .vertical)
                        .frame(height: 80, alignment: .top)
                        .multilineTextAlignment(.leading)
                    
                } header: {
                    Text("한줄평")
                }
                
                
                Section {
                    HStack {
                        Spacer()
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                HStack(alignment: .center) {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 18)
                                    Text("갤러리에서 선택하기")
                                        .font(.system(
                                            size: 13))
                                }.foregroundColor(Color("SecondaryGreen"))
                            }.onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                        hideKeyboard()
                                    }
                                }
                            }
                        Spacer()
                    }
                    
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 230, alignment: .center)
                    }
                    
                } header: {
                    VStack(alignment: .leading) {
                        Text("맛있게 먹은 사진을 올려주세요! ")
                            .font(.system(
                                size: 13, weight: .semibold))
                        
                    }
                }
                
            }
            .foregroundColor(Color("LabelColor"))
            .scrollContentBackground(.hidden)
            Spacer()
            Button{
                vm.save(imageData: selectedImageData ?? Data())
                selectedImageData = Data()
                focused = true
                
            } label: {
                Text("저장")
                    .frame(width: 200, height: 60)
                    .foregroundColor(Color.white)
                    .background(Color.pink)
                    .cornerRadius(30)
            }.padding(0)
            Spacer()
        }
        .onAppear{
            focused = true
            
        }
        .background(Color.gray.opacity(0.2))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaceView(vm: NewPlaceModel(places: .constant([]))
                     
        )
    }
}
