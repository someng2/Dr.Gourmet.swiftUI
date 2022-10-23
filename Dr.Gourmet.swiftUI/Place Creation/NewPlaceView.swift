//
//  NewPlaceView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import RealmSwift
import PhotosUI
import AlertMessage

struct NewPlaceView: View {
    
    @StateObject var vm: NewPlaceModel
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @FocusState var nameFocused: Bool
    @FocusState var areaFocused: Bool
    @State var showNameSnackbar: Bool = false
    @State var showAreaSnackbar: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $vm.name)
                        .font(.custom("NanumSquareR", size: 15))
                } header: {
                    Text("상호명")
                        .font(.custom("NanumSquareB", size: 15))
                }
                .focused($nameFocused)
                Section {
                    TextField("", text: $vm.area)
                        .font(.custom("NanumSquareR", size: 15))
                } header: {
                    Text("지역 (ex: 서울, 대전)")
                        .font(.custom("NanumSquareB", size: 15))
                }.textCase(nil)
                    .focused($areaFocused)
                Section {
                    TextField("", text: $vm.address)
                        .font(.custom("NanumSquareR", size: 15))
                } header: {
                    Text("주소")
                        .font(.custom("NanumSquareB", size: 15))
                }
                
                Section {
                    TextField("", text: $vm.menu)
                        .font(.custom("NanumSquareR", size: 15))
                        .frame(height: 60, alignment: .top)
                    
                } header: {
                    Text("기억에 남는 메뉴")
                        .font(.custom("NanumSquareB", size: 15))
                }
                
                Section {
                    StarButton(star: $vm.star)
                } header: {
                    Text("별점")
                        .font(.custom("NanumSquareB", size: 15))
                }
                
                Section {
                    TextField("", text: $vm.review, axis: .vertical)
                        .font(.custom("NanumSquareR", size: 15))
                        .frame(height: 80, alignment: .top)
                        .multilineTextAlignment(.leading)
                    
                } header: {
                    Text("한줄평")
                        .font(.custom("NanumSquareB", size: 15))
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
                                    Text("갤러리에서 선택")
                                        .font(.custom("NanumSquareB", size: 13))
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
                        HStack {
                            Spacer()
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(height: 230, alignment: .center)
                            
                            Spacer()
                        }
                    }
                    
                } header: {
                    VStack(alignment: .leading) {
                        Text("맛있게 먹은 사진을 올려주세요!")
                            .font(.custom("NanumSquareB", size: 15))
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button{
                            if $vm.name.wrappedValue.isEmpty {
                                showNameSnackbar = true
                                areaFocused = false
                                nameFocused = true
                            }
                            else if $vm.area.wrappedValue.isEmpty {
                                showAreaSnackbar = true
                                nameFocused = false
                                areaFocused = true
                            }
                            else {
                                vm.save(imageData: selectedImageData ?? Data())
                                selectedImageData = Data()
                                nameFocused = true
                                //  self.tabSelection = 1
                            }
                            
                        } label: {
                            Text("저장")
                                .font(.custom("NanumSquareB", size: 17))
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 60)
                                .background(Color("SecondaryGreen"))
                                .cornerRadius(30)
                        }
                        Spacer()
                    }
                    
                }
                .listRowBackground(Color(UIColor.clear))
                .background(.clear)
                
                
            }
            .alertMessage(isPresented: $showNameSnackbar, type: .centered, autoHideIn: 1.5) {
                VStack {
                    Image(systemName: "exclamationmark.octagon")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                            
                    Text("상호명을 입력해주세요!")
                        .font(.custom("NanumSquareR", size: 16))
                         .foregroundColor(.white)
                    Spacer()
                 }
                
                .frame(width: 240, height: 90)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .background(Color("SecondaryOrange"))
                .cornerRadius(30)
            }
            .alertMessage(isPresented: $showAreaSnackbar, type: .centered, autoHideIn: 1.5) {
                VStack {
                    Image(systemName: "exclamationmark.octagon")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                            
                    Text("지역을 입력해주세요!")
                        .font(.custom("NanumSquareR", size: 16))
                         .foregroundColor(.white)
                    Spacer()
                 }
                
                .frame(width: 240, height: 90)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .background(Color("SecondaryOrange"))
                .cornerRadius(30)
            }
            .foregroundColor(Color("LabelColor"))
            .scrollContentBackground(.hidden)
            Spacer()
        }.onAppear{
            nameFocused = true
        }.background(Color.gray.opacity(0.2))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaceView(vm: NewPlaceModel(places: .constant([]), tabSelection: .constant(2)
                                      )
                     
        )
    }
}
