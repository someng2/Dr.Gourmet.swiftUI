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
import Photos

struct NewPlaceView: View {
    
    @StateObject var vm: NewPlaceModel
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    
    @State private var selectedImage = UIImage()
    @State private var showPhotoLibrary = false
    
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
                        Button {
                            if PhotoAuth() {
                                showPhotoLibrary = true
                                hideKeyboard()
                            } else {
                                AuthSettingOpen(AuthString: "앨범")
                            }
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 18)
                                Text("갤러리에서 선택")
                                    .font(.custom("NanumSquareB", size: 13))
                            }.foregroundColor(Color("SecondaryOrange"))
                        }
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Image(uiImage: self.selectedImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .frame(height: 230, alignment: .center)
                        Spacer()
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
                                vm.save(image: selectedImage)
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
                .cornerRadius(20)
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
                .cornerRadius(20)
            }
            .sheet(isPresented: $showPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)
            }
            .foregroundColor(Color("LabelColor"))
            .scrollContentBackground(.hidden)
            Spacer()
        }.onAppear{
            checkAlbumPermission()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nameFocused = true
            }
        }.background(Color.gray.opacity(0.2))
        
    }
    
    func checkAlbumPermission(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Album: 권한 허용")
            case .denied:
                print("Album: 권한 거부")
            case .restricted, .notDetermined:
                print("Album: 선택하지 않음")
            default:
                break
            }
        })
    }
    
    func PhotoAuth() -> Bool {
        // 포토 라이브러리 접근 권한
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        var isAuth = false
        
        switch authorizationStatus {
        case .authorized: return true // 사용자가 앱에 사진 라이브러리에 대한 액세스 권한을 명시 적으로 부여했습니다.
        case .denied: break // 사용자가 사진 라이브러리에 대한 앱 액세스를 명시 적으로 거부했습니다.
        case .limited: break // ?
        case .notDetermined: // 사진 라이브러리 액세스에는 명시적인 사용자 권한이 필요하지만 사용자가 아직 이러한 권한을 부여하거나 거부하지 않았습니다
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                }
            }
            return isAuth
        case .restricted: break // 앱이 사진 라이브러리에 액세스 할 수있는 권한이 없으며 사용자는 이러한 권한을 부여 할 수 없습니다.
        default: break
        }
        
        return false;
    }
    
    func AuthSettingOpen(AuthString: String) {
        if let AppName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
            let message = "\n\(AppName) 앱의 \(AuthString) 접근이 허용되어 있지않습니다. \r\n\n 설정 > 사진 > \"모든 사진\" 선택"
            let alert = UIAlertController(title: "앨범 접근 불가", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "설정", style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
            
            let viewController = UIApplication.shared.windows.first!.rootViewController!
            viewController.present(alert, animated: true) {

//                if PhotoAuth() {
//                    showPhotoLibrary = true
//                    hideKeyboard()
//                }
            }
            
        }
    }
}
    
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    struct NewPlaceView_Previews: PreviewProvider {
        static var previews: some View {
            NewPlaceView(vm: NewPlaceModel(places: .constant([]), tabSelection: .constant(2)))
        }
    }

