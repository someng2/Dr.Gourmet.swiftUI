//
//  NewPlaceView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/12.
//

import SwiftUI
import RealmSwift

struct NewPlaceView: View {
    
    @StateObject var vm: NewPlaceModel
    
    @State private var starClicked: [Bool] = [false, false, false, false, false]
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("이름", text: $vm.name)
                }
                .focused($focused)
                Section {
                    TextField("지역", text: $vm.area)
                }
                Section {
                    TextField("주소", text: $vm.address)
                }
                
//                Section {
//                    HStack(spacing: 4) {
//                        StarButton(vm: vm, index: 0)
//                        StarButton(vm: vm, index: 1)
//                        StarButton(vm: vm, index: 2)
//                        StarButton(vm: vm, index: 3)
//                        StarButton(vm: vm, index: 4)
//                    }
//                } header: {
//                    Text("별점")
//                }
                Section {
                    TextField("", text: $vm.review)
                        .frame(height: 100)
                } header: {
                    Text("한줄평")
                }
            }
            Button{
                vm.save()
                focused = true
            } label: {
                Text("저장")
                    .frame(width: 200, height: 60)
                    .foregroundColor(Color.white)
                    .background(Color.pink)
                    .cornerRadius(30)
            }
        }
        .onAppear{
            focused = true
        }
    }
    
//    struct StarView: View{
//
//        let index: Int
//        @Binding private var starClicked: [Bool]
//
//        var body: some View {Button {
//            print("---> star clicked: \(index)")
//            starClicked[index] = !starClicked[index]
//        } label: {
//            Image(systemName: starClicked[index] ? "star.fill": "star")
//        }
//        .foregroundColor(Color.yellow)
//        }
//    }
}

struct StarView: View{
    
    let index: Int
    @Binding private var starClicked: [Bool]
    
    var body: some View {Button {
        print("---> star clicked: \(index)")
        starClicked[index] = !starClicked[index]
    } label: {
        Image(systemName: starClicked[index] ? "star.fill": "star")
    }
    .foregroundColor(Color.yellow)
    }
}

struct NewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaceView(vm: NewPlaceModel(places: .constant([]))
                     
        )
    }
}
